From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Sun, 22 Jul 2007 20:11:23 -0400
Message-ID: <9e4733910707221711u6e965e6cr29e06fa8fb09165@mail.gmail.com>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	 <Pine.LNX.4.64.0707221959100.14781@racer.site>
	 <9e4733910707221210t2b2896b5ob4ce7bf95d4a707a@mail.gmail.com>
	 <Pine.LNX.4.64.0707222013200.14781@racer.site>
	 <9e4733910707221248q45fb3aaala9c79afd4b09830e@mail.gmail.com>
	 <Pine.LNX.4.64.0707222238180.14781@racer.site>
	 <9e4733910707221645x21d74e70y3c43bc8c02a9d4ca@mail.gmail.com>
	 <Pine.LNX.4.64.0707230048570.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 23 02:11:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IClWK-0005jS-Hu
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 02:11:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758295AbXGWALZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 20:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757672AbXGWALZ
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 20:11:25 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:62189 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756673AbXGWALY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 20:11:24 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1795647wah
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 17:11:23 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EktfkB+GyyNNZPhxhx3H2UGU9sbKB0pEXVv71AeVo7ZzGCzPoimKh1u/P6BFOT7dg2/7wrH7znVylNXPjhcWFYcEjeOYRNpWkeO9qgZI9F3TsseST0WBxAM8P3BsZhCNY2j3zXBZph4X3jIRF79BjegD+lLcM7cG6jt5h0zwtRM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ayBX3FU//TmToZkvasJlVw1Jrd8uHZjgYs8+tOZ1Hy3OEILAc4be6PVlo6WhiixCmEdJu9wRK417TlcvuCSLmAjs0Zo54q2i9nelrvkp6rg9b9gvL6uEDkUMI6jjIENy/ls2bKsPEjKyglJ/JJGiZPFok6k/6IQpZLoXa1Fioak=
Received: by 10.114.76.1 with SMTP id y1mr2437482waa.1185149483541;
        Sun, 22 Jul 2007 17:11:23 -0700 (PDT)
Received: by 10.114.195.5 with HTTP; Sun, 22 Jul 2007 17:11:23 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0707230048570.14781@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53374>

On 7/22/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > This doesn't run on the two full kernel samples I sent you.
>
> You mean my script?  Or your C program?

Your script, I sent two big samples directly to you as attachments
three hours ago.
Script processes them for a few pages of output and then bails out.
I have more diffs,  but those two are representative of the sample

phytec patch has support for the NXP 3180 CPU which is not in the
kernel. I have a project interested in using this CPU so we are
looking at extracting the essence of 3180 support from the patch and
trying to apply it to the current kernel.

>From the phytec patch:
diff -uarN linux-2.6.10/arch/arm/vfp/entry.S
linux-2.6.10-lpc3180/arch/arm/vfp/entry.S
--- linux-2.6.10/arch/arm/vfp/entry.S   2004-12-25 05:35:27.000000000 +0800
+++ linux-2.6.10-lpc3180/arch/arm/vfp/entry.S   2006-11-20
15:49:30.000000000 +0800
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <asm/thread_info.h>
 #include <asm/vfpmacros.h>
+#include <asm/constants.h>

        .globl  do_vfp
 do_vfp:
Expected some changed $Revision line: +#define DRIVER_VERSION "$Revision: 1.2 $"
jonsmirl@jonsmirl:/extra/diffs$

>From the sonos one:
diff --git a/Documentation/cachetlb.txt b/Documentation/cachetlb.txt
index 127a661..02dec92 100644
--- a/Documentation/cachetlb.txt
+++ b/Documentation/cachetlb.txt
@@ -222,7 +222,7 @@
 this value.

 NOTE: This does not fix shared mmaps, check out the sparc64 port for
-one way to solve this (in particular SPARC_FLAG_MMAPSHARED).
+one way to solve this (in particular arch_get_unmapped_area).

 Next, you have two methods to solve the D-cache aliasing issue for all
 other cases.  Please keep in mind that fact that, for a given page
Expected some changed $Id line:            Readme-File
/usr/src/Documentation/cdrom/aztcd
jonsmirl@jonsmirl:/extra/diffs$


-- 
Jon Smirl
jonsmirl@gmail.com
