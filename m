From: David Kastrup <dak@gnu.org>
Subject: Re: git and larger trees, not so fast?
Date: Sun, 12 Aug 2007 01:26:48 +0200
Message-ID: <85k5s1sldz.fsf@lola.goethe.zz>
References: <20070809163026.GD568@mbox.bz>
	<alpine.LFD.0.999.0708111137250.30176@woody.linux-foundation.org>
	<20070811190201.GB4710@ferdyx.org>
	<alpine.LFD.0.999.0708111337280.30176@woody.linux-foundation.org>
	<20070811205137.GC4710@ferdyx.org>
	<alpine.LFD.0.999.0708111522570.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Fernando J. Pereda" <ferdy@gentoo.org>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Aug 12 01:26:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK0MC-0004jL-5w
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 01:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752423AbXHKX0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 19:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752236AbXHKX0x
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 19:26:53 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:48072 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665AbXHKX0w (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Aug 2007 19:26:52 -0400
Received: from mail-in-08-z2.arcor-online.net (mail-in-08-z2.arcor-online.net [151.189.8.20])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 89CEB1F5A58;
	Sun, 12 Aug 2007 01:26:50 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-08-z2.arcor-online.net (Postfix) with ESMTP id 7312A212FAE;
	Sun, 12 Aug 2007 01:26:50 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-066.pools.arcor-ip.net [84.61.49.66])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id 3E7113425E3;
	Sun, 12 Aug 2007 01:26:50 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2F5BC1C3C79D; Sun, 12 Aug 2007 01:26:48 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0708111522570.30176@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 11 Aug 2007 15\:27\:20 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3928/Sat Aug 11 23:32:12 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55648>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 11 Aug 2007, Fernando J. Pereda wrote:
>> > 
>> > What does "usable" mean? Is it still slow ("barely usable") or is it 
>> > actually fast enough to be truly _nice_ to use?
>> 
>> Very nice to use considering my hardware is rather old. git status used
>> to take >1m and it now takes ~3s and git commit takes ~7s while it used
>> to take >1m too. So it makes things nice to use and I guess things are
>> MUCH better on faster hardware.
>
> Oh, ok. Having a 7s commit sounds fine - certainly not instantaneous, but 
> it doesn't sound too painful. Certainly not compared to what people live 
> with normally in some other environments, at least.
>
> Thanks go to moe for just giving a trivial script to reproduce the 
> performance anomaly. It wasn't that hard to fix once there was a trivial 
> and unambiguous test case.

Since one of the problems is git sorting stuff inefficiently, it might
make for an interesting test case to create the test files in reverse
alphabetic order so that readdir is more likely to deliver them in
reverse order, too.

Or in random order, by something like

dc -e '2 32^sb69069sc100000sd1se[rlc*le+lb%prle+dld!=a]sa42 0lax'|
while read i;do echo $i > $i;done

(change the 100000 to get a different number of files, change the
42 to get a different seed).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
