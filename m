From: David Kastrup <dak@gnu.org>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 22:04:51 +0200
Message-ID: <85sl7b6ie4.fsf@lola.goethe.zz>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
	<f329bf540707260002p117937tc9bc70050ef87838@mail.gmail.com>
	<fcaeb9bf0707260429l327f446bq73a8a0a13cd77cf1@mail.gmail.com>
	<46d6db660707260521u15c2bd85j806d48e0f51a3b9@mail.gmail.com>
	<fcaeb9bf0707260537y4233abaamadf4cb6190ea0eeb@mail.gmail.com>
	<Pine.LNX.4.64.0707261534550.14781@racer.site>
	<fcaeb9bf0707260807u476719e3rec2dcf5f780013c0@mail.gmail.com>
	<Pine.LNX.4.64.0707261638100.14781@racer.site>
	<fcaeb9bf0707260911y4091b525kc6b89beb82ec7dc7@mail.gmail.com>
	<8564478243.fsf@lola.goethe.zz>
	<fcaeb9bf0707261239t6479a4f4j6dedfbaef7206535@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 26 22:05:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE9a9-0004Zh-3F
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 22:05:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936163AbXGZUFE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 16:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936127AbXGZUFD
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 16:05:03 -0400
Received: from mail-in-15.arcor-online.net ([151.189.21.55]:42064 "EHLO
	mail-in-15.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S935793AbXGZUFB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2007 16:05:01 -0400
Received: from mail-in-03-z2.arcor-online.net (mail-in-03-z2.arcor-online.net [151.189.8.15])
	by mail-in-15.arcor-online.net (Postfix) with ESMTP id 8147044F1F;
	Thu, 26 Jul 2007 22:04:59 +0200 (CEST)
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net [151.189.21.43])
	by mail-in-03-z2.arcor-online.net (Postfix) with ESMTP id 69E822D3B2C;
	Thu, 26 Jul 2007 22:04:59 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-079-089.pools.arcor-ip.net [84.61.79.89])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id 40F5B30AA26;
	Thu, 26 Jul 2007 22:04:59 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 06CBC1C39595; Thu, 26 Jul 2007 22:04:52 +0200 (CEST)
In-Reply-To: <fcaeb9bf0707261239t6479a4f4j6dedfbaef7206535@mail.gmail.com> (Nguyen Thai Ngoc Duy's message of "Thu\, 26 Jul 2007 15\:39\:21 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3778/Thu Jul 26 19:57:13 2007 on mail-in-03.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53865>

"Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:

> On 7/26/07, David Kastrup <dak@gnu.org> wrote:
>> "Nguyen Thai Ngoc Duy" <pclouds@gmail.com> writes:
>
>> > No it's not. With a couple of ifdefs you can compile it fine. Then
>> > there goes fork(), fcntl(F_DUPFD), /dev/*, job/signal handling...
>> > Fortunately Git does not use lots of features. It only needs
>> > /dev/null (and /dev/zero for tests), SIGEXIT and no job usage.. That
>> > cuts down the effort porting ash.
>>
>> And here I was tempted to multithread builtin-update-index.c: it is
>> actually quite natural to let one process scan directories
>> non-recursively, stat the files, sort them on a per-directory grain
>> and feed a sorted pseudo-index into a pipeline (recursing to scanning
>> whenever hitting a directory), then let another process/thread do a
>> merge-pass of pseudo-index and real index, immediately writing the
>> output to a new index-to-be.  When this is finished and another
>> process invalidated the old index already, reuse the index-to-be as
>> pseudo-index and merge it with the new-index-which-got-in-ahead-of-me.
>>
> (snip)
>
> If you are going to do it. I suggest to base on official mingw
> branch.

Why would I do that?  I am not using Windows.  Since Windows NT was
flaunting threads big style years before Linux, I should not think
this implementation approach really to be a major porting hurdle, at
least if one indeed uses pipes for the IPC.

It should actually be doable with a clone system call or
pthread_create, whatever is easier to translate into Windows
semantics.  The latter probably is more portable nowadays.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
