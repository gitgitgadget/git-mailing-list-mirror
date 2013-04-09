From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 2/4] gitweb: Make feed title valid utf8
Date: Tue, 09 Apr 2013 17:10:31 +0200
Message-ID: <51642F67.5010501@gmail.com>
References: <m2y5csbx91.fsf@blackdown.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Apr 09 17:10:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPaC1-00018z-A4
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 17:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762362Ab3DIPKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 11:10:37 -0400
Received: from mail-ee0-f42.google.com ([74.125.83.42]:50291 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760644Ab3DIPKf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 11:10:35 -0400
Received: by mail-ee0-f42.google.com with SMTP id d4so2258826eek.29
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 08:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fXNo7LK+5NCM9sbkYGf9EBk/IumV9FFM1AyasdrAi8g=;
        b=TMavjMOdc3jPY+o4Go5aPeFfSy6Slo3BOqtiY1c1Ete+pHfacNESOr0kjAWCcq3JOW
         ju1AISiAML5RZ8C9Ok6Z7yHcldSX7DA7hzznu06anABibM4iM3zp/uXthmxMh0cvKqtt
         HoUYBHAz2QCWgacVv56Ebch73Ah26uCD/sZ+TZNUts+CAXeaNdqZxbapxcxUcLPw5A6K
         UujiWAdSn9yFrbsLhqt/TcNEvOWls9NpcF67/hJwvsTH7OwbpuH8Z6rcmxrE8f8x0/5r
         veYt8KkFWASCvkKDKRAOT088gFT+dbMdabtL0Ob4UoxW98uOW1iwr87tDdZ2/R8VkOS2
         ABqw==
X-Received: by 10.14.179.201 with SMTP id h49mr60460655eem.26.1365520234707;
        Tue, 09 Apr 2013 08:10:34 -0700 (PDT)
Received: from [192.168.1.14] (eis221.neoplus.adsl.tpnet.pl. [83.21.134.221])
        by mx.google.com with ESMTPS id d47sm38534678eem.9.2013.04.09.08.10.32
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 08:10:33 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <m2y5csbx91.fsf@blackdown.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220574>

J=C3=BCrgen Kreileder wrote:

> Properly encode site and project names for RSS and Atom feeds.
>=20
> Signed-off-by: J=C3=BCrgen Kreileder <jk@blackdown.de>
> ---
>  gitweb/gitweb.perl |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 9cfe5b5..09294eb 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -8056,7 +8056,7 @@ sub git_feed {
>  	return if ($cgi->request_method() eq 'HEAD');
> =20
>  	# header variables
> -	my $title =3D "$site_name - $project/$action";
> +	my $title =3D to_utf8($site_name) . " - " . to_utf8($project) . "/$=
action";
>  	my $feed_type =3D 'log';
>  	if (defined $hash) {
>  		$title .=3D " - '$hash'";
>=20

Was this patch triggered by some bug?

Because the above is not necessary, as git_feed() has

	$title =3D esc_html($title);

a bit later, which does to_utf8() internally.
--=20
Jakub Nar=C4=99bski
