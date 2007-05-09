From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Tue, 08 May 2007 19:43:49 -0700
Message-ID: <46413565.3090503@zytor.com>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 04:44:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlcAJ-0008Hl-ID
	for gcvg-git@gmane.org; Wed, 09 May 2007 04:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S970019AbXEICoB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 22:44:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754045AbXEICn7
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 22:43:59 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42112 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S970032AbXEICnw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 22:43:52 -0400
Received: from tazenda.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l492hntM024505
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 8 May 2007 19:43:50 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <20070508215009.GA2670@steel.home>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3223/Tue May  8 16:17:59 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.8 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_96_XX,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no
	version=3.1.8
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46652>

Alex Riesen wrote:

> 
> What kind of manual fixup did you do? I tried to reproduce it, and did
> the following:
> 
>     git clone --reference ~/linux.git git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-2.6-newsetup.git
>     cd linux-2.6-newsetup.git
>     git rebase a989705c4cf6e6c1a339c95f9daf658b4ba88ca8
> 
> It stopped at 'Revert "x86-64: Make arch/x86-64/boot a symlink to
> arch/i386/boot"' aka cd312503f8e8a88895b12bf810677406284142e6.
> I went on:
> 
>     rm arch/x86-64/boot
>     git checkout cd312503f8e8a88895b12bf810677406284142e6 arch/x86-64/boot
>     git rebase --continue
> 
> And then it just continued until all commits were rebased.
> I have a very recent git, so maybe that's why it worked.
> 

Mine stops already at the directory -> symlink checkin (the above is the
symlink -> directory one), but your trick of using "git checkout" as a
trick to resolve things helped for both... eventually :-/

Either way, it's still a bug that it stops for either checkin, but it's
not blocking my work anymore.

	-hpa
