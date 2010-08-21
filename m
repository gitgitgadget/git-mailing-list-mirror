From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] log: Non-zero exit code?
Date: Sat, 21 Aug 2010 13:16:36 +0530
Message-ID: <20100821074633.GA31130@kytes>
References: <20100821062158.GJ6211@kytes>
 <4C6F8164.3020005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
To: =?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sat Aug 21 09:48:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omiof-0000aO-08
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 09:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477Ab0HUHsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Aug 2010 03:48:32 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:61193 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381Ab0HUHsa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 03:48:30 -0400
Received: by pzk26 with SMTP id 26so1555513pzk.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=9cp83Q1Hs/XWGhDMslGKz0g2dN6PARwm7B0UtV34BlU=;
        b=jQ1cgA7SgUjpSV0zrrNpUzcJAxwExk35QEE5/aLUKuVGXU01TYq9rZVtxaifICbSWo
         /FVCgh/BFRiGFDl+7Fymez6BsKvvtXQERU7ci/Idqm4SUtN9ncBJiwPFkRmD32U8Ge63
         CE3jKe117BzlexFEpi5pqvsNYvbV0Z3ijvJBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PzlnScAPEgLU0uf/CFMfkYHxSsXU44WYAJHseYChHl4xsVe5PoSHdVfitN5BC6b+57
         LBW6Vvcfu9BPhTA4JwclHyc2EH7cVGOsqFnKrI3Pxyv0WsnOdT6frKoGnC3+9JhWH7Np
         j1m08K47JFDJ8ReKYc0CDAAlZ0hODYIaKnVwI=
Received: by 10.114.130.13 with SMTP id c13mr2764045wad.68.1282376909895;
        Sat, 21 Aug 2010 00:48:29 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id q6sm6649383waj.10.2010.08.21.00.48.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 00:48:28 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6F8164.3020005@lsrfire.ath.cx>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154120>

Hi Ren=E9,

Ren=E9 Scharfe writes:
> You can leave out the test line entirely, as test_expect_success alre=
ady
> checks for an exit code of zero.

Right. I should have actually read test-lib.sh before submitting a
test :p

> The test passes for me with 1.7.2.2, next and pu.  Which version of g=
it
> do you use?

I can reproduce this on the latest `master` and `pu`.

> Error code 141 smells like the pager.  Can you reproduce the problem
> without the pager, i.e. like this?
>=20
> 	git --no-pager log

Indeed, it's a pager problem as =C6var pointed out on IRC. $(git
--no-pager log) and $(GIT_PAGER=3D'perl -pe ""' git log) return
0. Something in `less` changed?

-- Ram
