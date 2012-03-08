From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] i18n: parseopt: lookup help and argument
 translations when showing usage
Date: Thu, 8 Mar 2012 16:07:24 -0600
Message-ID: <20120308220724.GA10270@burratino>
References: <1331198198-22409-1-git-send-email-pclouds@gmail.com>
 <1331198198-22409-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 23:07:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5lUp-00047g-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 23:07:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758739Ab2CHWHf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 17:07:35 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:59396 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757993Ab2CHWHe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 17:07:34 -0500
Received: by obbuo6 with SMTP id uo6so1220568obb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 14:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=i9xhz2HM48vvURhaZC9t0eOtjA1+hiJArUjprAFg+4c=;
        b=b81+9upZyemNFvK5DAzB/ARpjNpqk6wKxWYzaxKwcoUj7nYR96btoFcTgtawwpAfvD
         3dksYiZycj0bHE4KW4g6CspaByP2qeV48zH3R5MttwQL/lygF3LCPa+/pH80bU69gWQR
         x4+b1caHFYaVEd96c4Pxq9JRG6K8lhUQqR2CbHwZWmSDbxQL33vvQn0u8ShkOkn77iND
         edWIK6DFcyR7OMZhWhYDr2YaxBksgX8dMzmIaoQX/uXtxLiZKYA6QVWQAx02W4QBF03O
         5Iv7JU9V9htpp/UjBsHaAqBUrLIfW8cXiRSVKS4dxGImWVD9CVfqckxCOr50pVovLKGY
         cF0g==
Received: by 10.60.30.66 with SMTP id q2mr3202157oeh.25.1331244454187;
        Thu, 08 Mar 2012 14:07:34 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id 4sm1605090oex.0.2012.03.08.14.07.33
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 14:07:33 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1331198198-22409-4-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192658>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -490,7 +490,7 @@ static int usage_argh(const struct option *opts, =
=46ILE *outfile)
>  			s =3D literal ? "[%s]" : "[<%s>]";
>  	else
>  		s =3D literal ? " %s" : " <%s>";
> -	return fprintf(outfile, s, opts->argh ? opts->argh : "...");
> +	return fprintf(outfile, s, opts->argh ? gettext(opts->argh) : "..."=
);

It is ok to use _() with an argument that is not a string literal, and
in fact it is needed if the argument is to be poisoned.

Maybe it would be worth resending the patch to make the gettext()
identifier not available in NO_GETTEXT builds, so this kind of thing
is easier to catch.

Thanks and hope that helps,
Jonathan
