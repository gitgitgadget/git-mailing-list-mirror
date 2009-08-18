From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 15:17:33 +0200
Message-ID: <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
	 <4A8AA511.1060205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Artur Skawina <art.08.09@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 15:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOZx-00008s-MN
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 15:18:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758895AbZHRNRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 09:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753903AbZHRNRe
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 09:17:34 -0400
Received: from mail-bw0-f222.google.com ([209.85.218.222]:56648 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758626AbZHRNRd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 09:17:33 -0400
Received: by bwz22 with SMTP id 22so3006595bwz.18
        for <git@vger.kernel.org>; Tue, 18 Aug 2009 06:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZaKEu70/LOXr73dEBesboVX1x7W0WDOu5pqJQXw5a/U=;
        b=c2a6KVchx0ThIF90eS98pL72HGlBtdTa5Ert3js2j+764Tci8Q4kIbNKE8ol5SO28b
         FSWvwTH4/P7o46n8vJckmDAAbKTnPq510drg6yVVRgsNvhsxuja6spJT6oRKGUncM9Y9
         QGDJINJAN7M5k0+E3BOJwL8ubNUQI0YifNLsI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JMFv0xnMDlD9IyPTk8l6jjYamPcOdU7IjLcqbrGhg2VNKPneZKwEektS5Ax6kx/lzb
         XXnBVcbmtjPpv8LSn/k1jtisOVCZ8+48dm103jvLKUP0ed1xvEpaf6Tu1aHcKqIAg6XO
         Va4/GVox2rWytBiVndbSsh+SfaCt+nlDFqmOw=
Received: by 10.204.32.146 with SMTP id c18mr3797388bkd.88.1250601453428; Tue, 
	18 Aug 2009 06:17:33 -0700 (PDT)
In-Reply-To: <4A8AA511.1060205@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126397>

On Tue, Aug 18, 2009 at 14:56, Artur Skawina<art.08.09@gmail.com> wrote:

> I did try using __builtin_bswap32 directly and the result was a few
> (3 or 4, iirc) differently scheduled instructions, that's all, no
> performance difference.

[...]

> I'd limit it to windows and any other ia32 platform that doesn't pick the
> bswaps itself; as is, it just adds an unnecessary hidden gcc dependency.
>
> Hmm, it's actually a gcc-4.3+ dependency, so it won't even build w/ gcc 4.2;
> something like this would be required: "(__GNUC__>=4 && __GNUC_MINOR__>=3)" .

So, as you say the code makes no difference under Linux, would you be
OK with just testing for GCC 4.3+, and not for Windows? That would get
rid of the "hidden" GCC dependency and not make the preprocessor
checks overly complex. Moreover, limiting my patch to any "platform
that doesn't pick the bswaps itself" could possibly require
maintenance on compiler / CRT updates.

-- 
Sebastian Schuberth
