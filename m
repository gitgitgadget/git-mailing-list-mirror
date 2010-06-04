From: Steven Michalske <smichalske@gmail.com>
Subject: Re: How do I ignore the changes made by CVS keyword substitution efficiently?
Date: Fri, 4 Jun 2010 00:13:41 -0700
Message-ID: <9461742A-69F6-4220-9FAC-CB07AB2293B8@gmail.com>
References: <AANLkTilhvjn1ypRoKs2CxJdA1zDkaT5i64vh0ZtfjwMk@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1068)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	linux-kernel@vger.kernel.org
To: Lin Mac <mkl0301@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Fri Jun 04 09:14:07 2010
connect(): No such file or directory
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1OKR6U-0005fz-I7
	for glk-linux-kernel-3@lo.gmane.org; Fri, 04 Jun 2010 09:14:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573Ab0FDHNr (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Fri, 4 Jun 2010 03:13:47 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52200 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409Ab0FDHNp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2010 03:13:45 -0400
Received: by pwi3 with SMTP id 3so29721pwi.19
        for <multiple recipients>; Fri, 04 Jun 2010 00:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:references:in-reply-to
         :mime-version:content-type:message-id:content-transfer-encoding:cc
         :from:subject:date:to:x-mailer;
        bh=nxVESiGaV98GCHvR2yhb0rSjn0ampGuLTwjxS4DYG34=;
        b=m/hDIwGmkc+uWhm8da6kyF3wBkr/NDFBZC4TQBbpauWG9GDxkajClue1PkPDV3qTtq
         B5gC+3nHqpSxoBHk9BL4z7vDbF2QmRyIixIvd/oQynQMkYNWJddiFCxY/37ZnQ6R3OME
         B9BVdbzdklN8LGSYUpEEJONOlCCOo7t0VOhNo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:in-reply-to:mime-version:content-type:message-id
         :content-transfer-encoding:cc:from:subject:date:to:x-mailer;
        b=o3KXwS1RpfFvgFgyt3U5PxltBvWnRBNCUkh5RJhbhQ4Y1dRWd3WtC05aJMV/xys8M5
         v+Emj3okvIi0qnBYW8t/5UCcm0qn8kg+5TR/YYojzJN95proYErEGugdL8FcFoC6MvQz
         ndvc6nHfqAQi2n2wyAqaBLBCsxVESDC9yTuIQ=
Received: by 10.115.80.7 with SMTP id h7mr8175192wal.159.1275635624649;
        Fri, 04 Jun 2010 00:13:44 -0700 (PDT)
Received: from [192.168.1.105] (c-98-234-104-87.hsd1.ca.comcast.net [98.234.104.87])
        by mx.google.com with ESMTPS id f11sm6221781wai.23.2010.06.04.00.13.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 00:13:43 -0700 (PDT)
In-Reply-To: <AANLkTilhvjn1ypRoKs2CxJdA1zDkaT5i64vh0ZtfjwMk@mail.gmail.com>
X-Mailer: Apple Mail (2.1068)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148380>

Look into the git attributes and filters, make a clean command that  
strips out the cvs/svn keywords.

On Jun 3, 2010, at 12:13 PM, Lin Mac wrote:

> Hi,
>
> I'm merging kernel from others, and they used CVS to manage their
> code, and so do some part of linux kernel. Unfortunatly CVS would
> substitude the keywords in the source, result in unecessary changes in
> the code, like the one in the following diff. In fact, there are
> around 1174 of CVS keywords in the kernel source. I don't want those
> useless changes to get into my tree.
>
> Currently I use the attached scripts to as a basic filter, which could
> filter out 1-line changes by CVS keyword in a patch. But I still have
> to handle other cases (multi-line changes, $Log, which would result in
> log of latest commit) myself.
>
> Do you have better idea to get this task done?
>
> diff --git a/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
> b/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
> index d9b0868..c7bb74b 100644
> --- a/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
> +++ b/kernels/linux-2.6.31.1-cavm1/Documentation/cris/README
> @@ -1,6 +1,6 @@
> Linux 2.4 on the CRIS architecture
> ==================================
> -$Id: README,v 1.7 2001/04/19 12:38:32 bjornw Exp $
> +$Id: README,v 1.1 2010-05-14 09:47:54 XXXXXXXX Exp $
>
> This is a port of Linux 2.4 to Axis Communications ETRAX 100LX  
> embedded
> network CPU. For more information about CRIS and ETRAX please see  
> further
> @@ -103,7 +103,7 @@ block: queued sectors max/low 9109kB/3036kB, 64
> slots per queue
> ETRAX 100LX 10/100MBit ethernet v2.0 (c) 2000 Axis Communications AB
> eth0 initialized
> eth0: changed MAC to 00:40:8C:CD:00:00
> -ETRAX 100LX serial-driver $Revision: 1.7 $, (c) 2000 Axis  
> Communications AB
> +ETRAX 100LX serial-driver $Revision: 1.1 $, (c) 2000 Axis  
> Communications AB
> ttyS0 at 0xb0000060 is a builtin UART with DMA
> ttyS1 at 0xb0000068 is a builtin UART with DMA
> ttyS2 at 0xb0000070 is a builtin UART with DMA
> @@ -133,7 +133,7 @@ Default gateway is 10.13.9.1
> Hostname is bbox1
> Telnetd starting, using port 23.
>   using /bin/sash as shell.
> -sftpd[15]: sftpd $Revision: 1.7 $ starting up
> +sftpd[15]: sftpd $Revision: 1.1 $ starting up
> <undo-cvs-tag-one-line-chage.pl><refine.sh>
