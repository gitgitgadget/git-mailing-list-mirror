From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 14:02:30 +0700
Message-ID: <CACsJy8A6iLzW8ZtV97Fvat_e=Totzuh-hQ8mDyf9c5a=JC3u9Q@mail.gmail.com>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net>
 <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net> <4F8FB4A0.7090403@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 09:03:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKlOW-00037J-HJ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 09:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416Ab2DSHDE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 03:03:04 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54112 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751087Ab2DSHDB (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 03:03:01 -0400
Received: by lahj13 with SMTP id j13so6356135lah.19
        for <git@vger.kernel.org>; Thu, 19 Apr 2012 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=I2/Ac0+RSeXx6rJftCLbvl70rCCTqmaVoW0xlcj8qmo=;
        b=NiCeyAGjz/8nNBXSrljAOuQaUrVTEYDRh++Qv5NjP/zu/1Cg8Yt86P7jyPbShodskU
         c60MYRofuEtxogfAKnIUVdb+HmpA/z0doNLjQetwmVgIhA/sSW4RVI6t/QEM06whBzdo
         O48GxbHGbHCcr127HYR8lir7vslGul1RSK5hBYXokbexjcs3ayHaKaG1Pfpp07fiK4FS
         1BGx2PVXwJMrMCDtHJjfx0nSoNwVMmCoPtXdwkJYIPl5sBCgk4AJvdxDCmq69kbnj6HC
         i2pEMzOLmE85IkeFN+TEwBi4LRfSJcYKz1M4qI2VamRoL1llu+IFJ30DOfwYrNpqEi5j
         1hrg==
Received: by 10.112.49.35 with SMTP id r3mr407249lbn.71.1334818980204; Thu, 19
 Apr 2012 00:03:00 -0700 (PDT)
Received: by 10.112.97.148 with HTTP; Thu, 19 Apr 2012 00:02:30 -0700 (PDT)
In-Reply-To: <4F8FB4A0.7090403@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195929>

Hi,

I've been busy and have not had time to look into this yet...

2012/4/19 Johannes Sixt <j.sixt@viscovery.net>:
> I don't see any mutual exclusion happening in this chain. Perhaps it is
> not needed, provided that the pread() call in get_data_from_pack is
> atomic. But our git_pread() from compat/pread.c, which we use on Windows,
> is not atomic.
>
> :-(
>
> I don't think that it is possible to make git_pread() atomic because it
> would have to be protected against all file accesses that can modify the
> file position.
>
> Is get_data_from_pack() the only function that accesses the pack data?
> Then we could add some mutual exclusion there.

I believe so. And index-pack only accesses the pack via pread, no other means.
-- 
Duy
