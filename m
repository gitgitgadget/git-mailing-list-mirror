From: Geert Bosch <bosch@adacore.com>
Subject: Re: comparing file contents in is_exact_match?
Date: Mon, 17 Jul 2006 15:37:06 -0400
Message-ID: <1F90D448-5347-4CEB-80DE-3CC86C1CC16F@adacore.com>
References: <20060706055729.GA12512@admingilde.org> <87k66p8jee.fsf@mid.deneb.enyo.de> <Pine.LNX.4.63.0607080450100.29667@wbgn013.biozentrum.uni-wuerzburg.de> <87fyh1ncm0.fsf@mid.deneb.enyo.de> <f36b08ee0607160803s27dac6a6k476e3dd7742346fc@mail.gmail.com> <20060716223607.GA6023@steel.home> <87d5c4ajlu.fsf@mid.deneb.enyo.de> <Pine.LNX.4.63.0607171439270.29667@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0607170840280.15611@evo.osdl.org> <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Florian Weimer <fw@deneb.enyo.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 21:38:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2Yu6-0005Ul-M3
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 21:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWGQThI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 15:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWGQThI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 15:37:08 -0400
Received: from nile.gnat.com ([205.232.38.5]:22500 "EHLO nile.gnat.com")
	by vger.kernel.org with ESMTP id S1750721AbWGQThG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 15:37:06 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtered-nile.gnat.com (Postfix) with ESMTP id AB5E148CF18;
	Mon, 17 Jul 2006 15:37:05 -0400 (EDT)
Received: from nile.gnat.com ([127.0.0.1])
 by localhost (nile.gnat.com [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 02984-02-5; Mon, 17 Jul 2006 15:37:05 -0400 (EDT)
Received: from [205.232.38.124] (potomac.gnat.com [205.232.38.124])
	by nile.gnat.com (Postfix) with ESMTP id 57B3648CD95;
	Mon, 17 Jul 2006 15:37:05 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.63.0607171804030.29667@wbgn013.biozentrum.uni-wuerzburg.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23982>


On Jul 17, 2006, at 12:05, Johannes Schindelin wrote:
>> Not for pack-files, though. You may have a half-gigabyte pack- 
>> file, and
>> only use a small small fraction of it.
>
> Right.
>
>> (You also never really rename them, so windows should be fine for  
>> that
>> case)
>
> So we could introduce a second mmap() which is normally the same as
> mmap(), except for windows, where it is a rename() and unlink() safe
> version of mmap() by reading the thing into RAM. Not very pretty.

Or we can avoid doing an mmap of the entire pack file, and instead
try to be somewhat smart on limiting the size of the mmap's.
This might be sufficient to help Windows and also solve the
issue of finding contiguous address space for large packs on
32-bit systems.

   -Geert
