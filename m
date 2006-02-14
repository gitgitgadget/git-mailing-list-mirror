From: Greg KH <greg@kroah.com>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Mon, 13 Feb 2006 21:56:48 -0800
Message-ID: <20060214055648.GA592@kroah.com>
References: <20060214055425.GA32261@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Feb 14 06:56:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8tBA-0007Ll-6V
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 06:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbWBNF4p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 00:56:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932347AbWBNF4p
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 00:56:45 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:44426
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S932256AbWBNF4o (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 00:56:44 -0500
Received: from press.kroah.org ([192.168.0.25] helo=localhost)
	by aria.kroah.org with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.54)
	id 1F8tB8-0001ue-Jg
	for git@vger.kernel.org; Mon, 13 Feb 2006 21:56:46 -0800
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060214055425.GA32261@kroah.com>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16115>

On Mon, Feb 13, 2006 at 09:54:25PM -0800, Greg KH wrote:
> I was trying to use the built-in git tools to send patches off, instead
> of my horribly hacked up scripts that use the git low-level stuff, when
> I noticed that git format-patch's output confuses diffstat a bit, and
> causes it to add another line to it's count.
> 
> This isn't good when I do a 'diffstat -p1 *.txt' of the output and add
> it to an email to send off for someone to pull from, as the result will
> be off from what is really there.
> 
> Here's what I get:
> 
>  $ git format-patch -n origin..HEAD
>  0001-USB-fix-up-the-usb-early-handoff-logic-for-EHCI.txt
>  0002-USB-add-new-device-ids-to-ldusb.txt
>  0003-USB-change-ldusb-s-experimental-state.txt
>  0004-USB-PL2303-Leadtek-9531-GPS-Mouse.txt
>  0005-USB-sl811_cs-needs-platform_device-conversion-too.txt
>  0006-usb-storage-new-unusual_devs-entry.txt
>  0007-usb-storage-unusual_devs-entry.txt
>  0008-USB-unusual_devs.h-entry-TrekStor-i.Beat.txt
>  0009-USB-unusual_devs.h-entry-iAUDIO-M5.txt
>  0010-USB-unusual-devs-bugfix.txt
> 
>  $ git log | head -n 1
>  commit 16f05be7be0bf121491d83bd97337fe179b3b323
> 
>  $ git show 16f05be7be0bf121491d83bd97337fe179b3b323 | diffstat -p1
>   drivers/usb/storage/unusual_devs.h |   25 ++++++++++++++++++-------
>   1 file changed, 18 insertions(+), 7 deletions(-)
> 
>  $ diffstat -p1 0010-USB-unusual-devs-bugfix.txt
>   drivers/usb/storage/unusual_devs.h |   26 ++++++++++++++++++--------
>   1 file changed, 18 insertions(+), 8 deletions(-)
> 
> Any thoughts?

Hm, in looking at it closer, it's probably the last two lines of the
file, the signature that git format-patch adds to the message:
	-- 
	1.2.0

Any way to suppress these?

thanks,

greg k-h

> 
> thanks,
> 
> greg k-h
