From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 06/12] apply: run setup_git_directory_gently() sooner
Date: Sun, 15 Aug 2010 20:13:26 +0000
Message-ID: <AANLkTi=pAvJ=R9XVvo9fJqo6RPa+hn3dMfj2UGqTFCbU@mail.gmail.com>
References: <20100626192203.GA19973@burratino>
	<7vpqzacs3h.fsf@alter.siamese.dyndns.org>
	<7v630hyf5r.fsf@alter.siamese.dyndns.org>
	<20100806023529.GB22369@burratino>
	<20100806030844.GJ22369@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 15 22:13:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkjaI-0008ED-Ss
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 22:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751515Ab0HOUN2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 15 Aug 2010 16:13:28 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48177 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab0HOUN1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Aug 2010 16:13:27 -0400
Received: by iwn7 with SMTP id 7so933836iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 13:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+P9AkvpbymnIgwiW/rSHdlGAPu/vC2ukDYr0XZFqyok=;
        b=u3pGtBx2TMDok+ZZV+8HtGhKjXyWsC35mFXV//8yS7ZtFy9aBvyh/k0wPbcs+IRATe
         L4ZyLnwtvaZ9xiOrQ6XIFlob86o4wfo+3qcm3iN/nUiGm0pG/qxuTFFVBaKCNpjGmfHI
         6mJGUeIFbze11MIbf9OBpprW07NtLj2uu+IiE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=RSYGbidxdtWhKdiIDW9cRhQJI5B5mKwa+TbPsKKYxOLkKYrAMHDxhoDWR09bj67YaQ
         bPTmeJvWDOkOpqHFahh9hm84ixjVo4UcNkJjH4QwcofcpIz8JXBpNak6iB2NOBGW6iAc
         aeqRpnveTvkoMk9lnXAz9u6M8eWA7b3ebQ/B4=
Received: by 10.231.40.9 with SMTP id i9mr4955773ibe.5.1281903206946; Sun, 15
 Aug 2010 13:13:26 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 13:13:26 -0700 (PDT)
In-Reply-To: <20100806030844.GJ22369@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153619>

2010/8/6 Jonathan Nieder <jrnieder@gmail.com>:
> From: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
>
> As v1.7.2~16^2 (2010-07-14) explains, without this change,
> =E2=80=9Cgit --paginate apply=E2=80=9D can ignore the repository-loca=
l
> =E2=80=9C[core] pager=E2=80=9D configuration.

Applying this patch broke the following tests:

    ./t4119-apply-config.sh ./t4111-apply-subdir.sh
=2E/t4131-apply-fake-ancestor.sh

I didn't look into why, they're breaking in pu now at 6ea3604. I
didn't look into why, see the smoke report at
http://smoke.git.nix.is/app/projects/report_details/33
