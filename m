From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Call to_utf8() on input string in chop_and_escape_str()
Date: Tue, 29 Nov 2011 22:50:03 +0100
Message-ID: <201111292250.04800.jnareb@gmail.com>
References: <CAKD0Uuy8y7Dc6gfvYVe-FJ=Reiu0M3wOY4r4VVPtEYmahZcdwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Nov 29 22:50:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVVZA-0005sL-1K
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 22:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab1K2VuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Nov 2011 16:50:10 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62929 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1K2VuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 16:50:07 -0500
Received: by bkas6 with SMTP id s6so1079474bka.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 13:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=CJcsOGG0WCGaxL41K7GWAEZ3wD371iFnEQbyeBtBCuc=;
        b=POoKhqhPM1G5pVRouEYU1vYfqu6Y5FRzpdFcm7EjkjX47UZf5qOTNJhMgV/SWXf86W
         4WWZPHM+dD6DsCJx8aion9mm1NDhyvZTglCwscbSb4fBZ0WOjmfAtXVYEXNBSuRIx1aX
         eEe14zdG0loUaSoy4DFTBcDrbBV59SeKf+YSs=
Received: by 10.204.152.87 with SMTP id f23mr52353521bkw.18.1322603405966;
        Tue, 29 Nov 2011 13:50:05 -0800 (PST)
Received: from [192.168.1.13] (abvz161.neoplus.adsl.tpnet.pl. [83.8.223.161])
        by mx.google.com with ESMTPS id h7sm39850515bkw.12.2011.11.29.13.50.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 13:50:05 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CAKD0Uuy8y7Dc6gfvYVe-FJ=Reiu0M3wOY4r4VVPtEYmahZcdwA@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186089>

J=C3=BCrgen Kreileder wrote:

> a) To fix the comparison with the chopped string
> b) To give the title attribute correct encoding
>=20
> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 4f0c3bd..4237ea6 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1695,11 +1695,11 @@ sub chop_and_escape_str {
>  	my ($str) =3D @_;

Why not simply

  	my $str =3D to_utf8(shift);
=20
>  	my $chopped =3D chop_str(@_);
> -	if ($chopped eq $str) {
> +	if ($chopped eq to_utf8($str)) {
>  		return esc_html($chopped);
>  	} else {
>  		$str =3D~ s/[[:cntrl:]]/?/g;
> -		return $cgi->span({-title=3D>$str}, esc_html($chopped));
> +		return $cgi->span({-title =3D> to_utf8($str)}, esc_html($chopped))=
;
>  	}
>  }
>=20
> --=20
> 1.7.5.4
>=20

--=20
Jakub Narebski
Poland
