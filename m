From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] gitweb/README: About $base_url etc. and $per_request_config
Date: Mon, 29 Nov 2010 01:51:11 +0100
Message-ID: <201011290151.14341.jnareb@gmail.com>
References: <20101128081048.13668.67286.reportbug@sb74.startrek> <201011282305.39975.jnareb@gmail.com> <20101129001908.GA26358@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Reichelt <debian@nachtgeist.net>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 01:51:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PMrxw-00074o-Qa
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 01:51:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754303Ab0K2AvY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 28 Nov 2010 19:51:24 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39711 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754176Ab0K2AvX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Nov 2010 19:51:23 -0500
Received: by bwz15 with SMTP id 15so3436989bwz.19
        for <git@vger.kernel.org>; Sun, 28 Nov 2010 16:51:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=sdCExnH3OBviCoy5aFOhCEy6CURbEK48gMJdwMQ7fek=;
        b=ULqcwS4H0KBouSmrPTsgeNQ2mc4d1H1Sg6XSugzpCNnnyo/O607oOs+CX/HSnGahEU
         Vb2jE+/uO++nSKue4s1dzFEnuwewIWFrhcJcCS9+ibrRYuEaGCuFz6FXx2UHg0jqOv4y
         k7sRu5gI6GVAP/hUwHSQ4QeLZYj2MyzitOqes=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=pHj2kEp6QVCKPNEvB1qMcCA7doZQkgV7IjW3IP/yN3naR6YUfxTYmxfch1IiUco880
         bpMf8xfSxc8tZeZp/+v5mRCeWUAxekYn6p+mB+kh7Vb1HRzkJdHPbJvNwMta4PM2IVBk
         oI2nY2FMuSmgGLPt13f2LGN/gZIumS1syef7E=
Received: by 10.204.98.15 with SMTP id o15mr4210014bkn.136.1290991881884;
        Sun, 28 Nov 2010 16:51:21 -0800 (PST)
Received: from [192.168.1.13] (abwq157.neoplus.adsl.tpnet.pl [83.8.240.157])
        by mx.google.com with ESMTPS id 11sm1720699bkj.12.2010.11.28.16.51.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 28 Nov 2010 16:51:21 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20101129001908.GA26358@burratino>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162372>

Subject fixed.

On Mon, 29 Nov 2010, Jonathan Nieder wrote:
> Jakub Narebski wrote:
>=20
> > If $base_url was defined, then do not redefine it in evaluate_uri()=
=2E
>=20
> How about $my_uri and $my_url?
>=20
> What happens if $ENV{PATH_INFO} or $cgi->url(...) changes between
> requests?  This is partly my ignorance: perhaps FastCGI et al
> guarantee that such configuration changes can't happen within a singl=
e
> process?

I think that at least $ENV{PATH_INFO} can change with request, though
I guess that $base_url should not change from request to request...
though there might be some corner cases.

$my_uri and $my_url usually do change with each request...

>
> Maintaining backward compatibility while avoiding this last concern
> seems hard.  Since gitweb_config can contain something like
>=20
> 	$my_uri =3D~ s/foo/bar/;
>=20
> one would want to populate $my_uri in advance.  Meanwhile, if the
> default for $my_uri could change between requests, we would want to b=
e
> able to detect the case when $my_uri is not set.  But what if
> gitweb_config contains
>=20
> 	$my_uri =3D "something";
>=20
> where "something" happens to match the default value for $my_uri in
> the first request?
>=20
> It is tempting to change the documentation now and worry about code
> changes later.  Something like this?
>=20
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

=2E.therefore I think it is a better solution.

Acked-by: Jakub Narebski <jnareb@gmail.com>

> ---
> diff --git a/gitweb/README b/gitweb/README
> index 6646fda..a9421e0 100644
> --- a/gitweb/README
> +++ b/gitweb/README
> @@ -177,13 +177,15 @@ not include variables usually directly set duri=
ng build):
>   * $my_url, $my_uri
>     Full URL and absolute URL of gitweb script;
>     in earlier versions of gitweb you might have need to set those
> -   variables, now there should be no need to do it.
> +   variables, now there should be no need to do it.  See
> +   $per_request_config if you need to set them still.

Very minor nitpick: perhaps it would be better to use

      variables, now there should be no need to do it.
  +   See $per_request_config if you need to set them still.


>   * $base_url
>     Base URL for relative URLs in pages generated by gitweb,
>     (e.g. $logo, $favicon, @stylesheets if they are relative URLs),
>     needed and used only for URLs with nonempty PATH_INFO via
>     <base href=3D"$base_url">.  Usually gitweb sets its value correct=
ly,
>     and there is no need to set this variable, e.g. to $my_uri or "/"=
=2E
> +   See $per_request_config if you need to set it anyway.
>   * $home_link
>     Target of the home link on top of all pages (the first part of vi=
ew
>     "breadcrumbs").  By default set to absolute URI of a page ($my_ur=
i).
> @@ -252,7 +254,10 @@ not include variables usually directly set durin=
g build):
>       sub { $ENV{GL_USER} =3D $cgi->remote_user || "gitweb"; }
>     Otherwise it is treated as boolean value: if true gitweb would pr=
ocess
>     config file once per request, if false it would process config fi=
le only
> - =A0 once. =A0The default is true.
> + =A0 once. =A0Note: $my_url, $my_uri, and $base_url are overwritten =
with
> + =A0 their default values before every request, so if you want to ch=
ange
> + =A0 them, be sure to set this variable to true or a code reference =
effecting
> + =A0 the desired changes. =A0The default is true.=20

Perhaps:

      once.  The default is true.
  +   Note: $my_url, $my_uri, and $base_url are overwritten with
  +   their default values before every request, so if you want to chan=
ge
  +   them, be sure to set this variable to true or a code reference ef=
fecting
  +   the desired changes.
 =20

--=20
Jakub Narebski
Poland
