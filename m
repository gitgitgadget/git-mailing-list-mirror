From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] ls-tree: show size of trees with -l
Date: Sat, 14 Aug 2010 16:40:11 +0200
Message-ID: <201008141640.14745.jnareb@gmail.com>
References: <1281730823-10797-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 14 16:39:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkHto-0001fI-R1
	for gcvg-git-2@lo.gmane.org; Sat, 14 Aug 2010 16:39:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab0HNOjr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 10:39:47 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64933 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756662Ab0HNOjq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Aug 2010 10:39:46 -0400
Received: by fxm13 with SMTP id 13so2284486fxm.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 07:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=o5qr0WrUbmYQuFOXzedSLr8uCv5r2iBOw0WXAukFxJs=;
        b=Hb4WYNk3arjXIpgB413xPFV8Zvyyal90TK9DKUCyHwCrCax7hL62nTWQen8m2yJFM8
         kmGdn7ZK3QZ/HVrYetOB2CqxwyA+JvXst8thZztgI+44rpxwD2SJpuTKTscEmjDmkXLn
         kuP0aksCxfEmGugsWOdvXnYziufjuCVKTLQtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KcLT9rmkj3DIenMiISm+2+Qe1k8dNSnsEHMiI3+4pulm4YkX0W2CP0DbVAUTsRD+Zp
         OW17bIqzrlgxwZwVFJ1lAPgpcwlahMnNocqDUgZZ6I7hlfekDAS6ZSGiE8EPMePnUNML
         W/MgKmXFz86JDntaDL+bS1wNrqasiW+j/wfe0=
Received: by 10.223.121.133 with SMTP id h5mr3249223far.74.1281796785058;
        Sat, 14 Aug 2010 07:39:45 -0700 (PDT)
Received: from [192.168.1.13] (abvh53.neoplus.adsl.tpnet.pl [83.8.205.53])
        by mx.google.com with ESMTPS id b9sm1590921faq.31.2010.08.14.07.39.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 07:39:44 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1281730823-10797-1-git-send-email-pclouds@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153561>

On Fri, 13 Apr 2010, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> In commit a5bbda8 (Add an option to git-ls-tree to display also the
> size of blob), Jakub said that size of non-blob entries had no
> meaning therefore dashes were printed instead.

I wrote that?

>=20
> I would say tree size, along with blob size, helps estimate bandwidth
> needed to transfer a single commit, for example. Of course it's not
> completely accurate as all objects will be compressed. But it gives a
> rough figure to compare.
>=20
> Pack v4 has not come yet (and it's been three years, I truely hope it
> will come next year). When it comes, I will gladly send a revert patc=
h
> of this one if it proves too expensive to compute tree size.
>=20
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Actually "git ls-tree -l <tree-ish>" doesn't show size of tree objects
because packv4 was to be ready soon, and in packv4 trees would be store=
d
decomposed, so getting size of tree object (e.g. using git-cat-file) is
would be costly because git would have to re-generate tree object just=20
to get its size (if it is in packfile).

But we don't have packv4 yet, even though it is 3 years since a5bbda8.
It looks like packv4 development moves with the speed of Perl 6=20
development.  But if Rakudo * (Perl 6 implementation) could have get=20
released (even if it is developers release), then there is hope for=20
packv4 yet... I hope...

--=20
Jakub Narebski
Poland
