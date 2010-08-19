From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/3] {fetch,upload}-pack: allow --depth=0 to deepen into full repo again
Date: Thu, 19 Aug 2010 14:22:14 -0700 (PDT)
Message-ID: <m362z6pact.fsf@localhost.localdomain>
References: <201008180854.18474.ComputerDruid@gmail.com>
	<1282214437-16384-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, computerdruid@gmail.com, joey@kitenet.net
To: =?utf-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?utf-8?b?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 19 23:22:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmCZ5-0002Tb-KQ
	for gcvg-git-2@lo.gmane.org; Thu, 19 Aug 2010 23:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752507Ab0HSVWS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Aug 2010 17:22:18 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40115 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab0HSVWR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Aug 2010 17:22:17 -0400
Received: by bwz11 with SMTP id 11so1558840bwz.19
        for <git@vger.kernel.org>; Thu, 19 Aug 2010 14:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=9RoLlqBOp2CPlTbmBo5v+SvTpbwoAJRDImVAN858New=;
        b=ZWFcYK74Au9kLv4r5AySH7b4gx0tgf6yLv/Jh+ltHQgTLkTr0cclZqWg9XFeQUIhK5
         KFCQs5/1OvgGFSjj28Z5JY5mWd7wUWm2C+jB7SLW3/ETRLT3eZvMz185AaIn3vLAGO8f
         nxBxxVNSMAWsKsMKb7PskTsu0z+Y3st1zWo9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=vRkmtochnJCsRtgUDcekK/gMyOQPgWj4W6SRL4BXIIFrr6kkevWP4wzdn1sYCgJ+LN
         2CLOppQr2ztYfDiEtyCp/ttzGpTfhYaDI60HA7o55ZujwybPYKw9gcO9e+uQigT9uRfJ
         q9GuWALn1PSe4/w1pOAgk8c9hkmUxMgC33K74=
Received: by 10.204.119.134 with SMTP id z6mr219407bkq.193.1282252935810;
        Thu, 19 Aug 2010 14:22:15 -0700 (PDT)
Received: from localhost.localdomain (abvr199.neoplus.adsl.tpnet.pl [83.8.215.199])
        by mx.google.com with ESMTPS id f18sm1420167bkf.15.2010.08.19.14.22.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Aug 2010 14:22:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7JLLfY8006439;
	Thu, 19 Aug 2010 23:21:51 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7JLLNOk006429;
	Thu, 19 Aug 2010 23:21:23 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1282214437-16384-3-git-send-email-pclouds@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153960>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  The funny thing is, even with --depth=3D0, I still have two commit g=
rafts
>  in $GIT_DIR/shallow, which are grafts of tags. I think there is a bu=
g somewhere..
>=20
>  builtin/fetch-pack.c |    2 +-
>  shallow.c            |    2 +-
>  upload-pack.c        |    8 ++++----
>  3 files changed, 6 insertions(+), 6 deletions(-)
>=20

=46ist, it lacks documentation update that --depth=3D0 means infinite
depth (making repository not-shallow).

Second, it would be nice (though probably not easy with parseopt, as
it would require hacks/extensions) to be able to use --depth=3Dinf
(like wget supports '-l inf') to mean infinite depth...

--=20
Jakub Narebski
Poland
ShadeHawk on #git
