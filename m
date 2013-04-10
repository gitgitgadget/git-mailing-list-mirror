From: Magnus Therning <magnus@therning.org>
Subject: Re: git-http-backend: anonymous read, authenticated write
Date: Thu, 11 Apr 2013 01:19:19 +0200
Message-ID: <20130410231919.GA1315@mteis.lan>
References: <20130409054553.GA1537@mteis.lan>
 <20130409171247.GD21972@sigill.intra.peff.net>
 <5165DA13.8010100@gmail.com>
 <20130410214722.GA6215@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Cc: Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 11 01:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ4J9-0007xD-Iw
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 01:20:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078Ab3DJXT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 19:19:58 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:55633 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937220Ab3DJXTp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 19:19:45 -0400
Received: by mail-la0-f48.google.com with SMTP id fq12so948968lab.35
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 16:19:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent:x-gm-message-state;
        bh=wdYMMur/oZgBI9iYRckadGstsLMMu/9ZX4TZkJ5gdB4=;
        b=lAxjjoGdnKa7h54gjFHJ7L++sDgHOQ3FRyWZZWrcBmmUkarGhLIFXdp3qAM+/7eHsG
         YtqcndzJGRJ+8LAC9AujKTnW1eEEqLW7hBum5PKUi6OFgM5t4hYNFtq4Yak91FDt+pKX
         E0AGlY6YATwykp+qiQrfefnfeGUtLm9o+pEo1286Axc2oQX9HtCePC0SYsVQgZnzEaVh
         Fm+D8hdvRcUSpu2oDeEdJYknw3iYKSryR6zcSn83GNBOOEbR6Vg4sH+rZKQzSCYqXbFn
         JX2tcOogQYph2aOIoKc0OdmRaerrm5PRiM+3lWX2DZ6wSEe6NjJPQUNc4N+zK3n18Pnu
         UK0Q==
X-Received: by 10.112.155.233 with SMTP id vz9mr2178245lbb.63.1365635984038;
        Wed, 10 Apr 2013 16:19:44 -0700 (PDT)
Received: from mteis.lan (92-32-222-34.tn.glocalnet.net. [92.32.222.34])
        by mx.google.com with ESMTPS id f7sm809638lbj.13.2013.04.10.16.19.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 16:19:42 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130410214722.GA6215@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnjqxZ4CusXYiz6dGQa2CAeLy69uQrnUyR2LeQGDOMAQ4fXXbRbsgcpbylSfT1XBNHyoXFE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220793>


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2013 at 05:47:22PM -0400, Jeff King wrote:
> On Wed, Apr 10, 2013 at 11:30:59PM +0200, Jakub Nar=C4=99bski wrote:
>=20
>>>   1. GET $repo/info/refs?service=3Dgit-receive-pack
>>>=20
>>>      This makes initial contact and gets the ref information which
>>>      push uses to decide what it is going to push. So it is
>>>      read-only, and in an anonymous-read setup, does not need to
>>>      be protected.
>>=20
>> Yes, it doesn't need to be protected, but *git-receive-pack*
>> requires (or required) valid user even for above GET request for
>> getting refs.
>=20
> Right. But that is not anything receive-pack is doing; it is up to
> his webserver config, which is why I asked to see it.

Nope.  I'm pretty sure this had *nothing* to do with my config.  This
is the original config, which doesn't work:

$HTTP["url"] =3D~ "^/git" {
    cgi.assign =3D ( "" =3D> "" )
    setenv.add-environment =3D (
        "GIT_PROJECT_ROOT" =3D> "/srv/git",
        "GIT_HTTP_EXPORT_ALL" =3D> ""
    )
    $HTTP["url"] =3D~ "^/git/.*/git-receive-pack$" {
        include "trac-git-auth.conf"
    }
}

This will turn on authentication *only* for URLs matching
^/git/.*/git-receive-pack$, which AFAIU is *exactly* what the manpage state=
s is
all that is needed.

This is the configuration that actually works:

$HTTP["querystring"] =3D~ "service=3Dgit-receive-pack" {
    $HTTP["url"] =3D~ "^/git" {
        cgi.assign =3D ( "" =3D> "" )
        setenv.add-environment =3D (
            "GIT_PROJECT_ROOT" =3D> "/srv/git",
            "GIT_HTTP_EXPORT_ALL" =3D> ""
        )
        include "trac-git-auth.conf"
    }
} else $HTTP["url"] =3D~ "^/git" {
    cgi.assign =3D ( "" =3D> "" )
    setenv.add-environment =3D (
        "GIT_PROJECT_ROOT" =3D> "/srv/git",
        "GIT_HTTP_EXPORT_ALL" =3D> ""
    )
    $HTTP["url"] =3D~ "^/git/.*/git-receive-pack$" {
        include "trac-git-auth.conf"
    }
}

The top bit adds matching against the query string and ^/git which
forces authentication on the initial GET as well.

>>>   2. POST $repo/git-receive-pack
>>>=20
>>>      This actually pushes up the objects and updates the refs, and
>>>      must be protected.
>>>=20
>>> The setup listed above does work with apache; it is tested as part
>>> of our test suite (you can see the actual config in
>>> t/lib-httpd/apache.conf).  So what in lighttpd is giving us the
>>> 403? Can you share your whole config?
>>=20
>> I think I have seen a patch on git mailing list to correct this,
>> but I am not sure.
>>=20
>> Are you sure that we test this correctly?
>=20
> Perhaps you are thinking of the jk/maint-http-half-auth-push topic
> from last August/September. It explicitly tests the setup from the
> manpage.  The relevant commits are 4c71009 (t: test http access to
> "half-auth" repositories, 2012-08-27) which demonstrates the
> problem, and b81401c (http: prompt for credentials on failed POST,
> 2012-08-27).
>=20
> However, even before the fix, it never got a 403 on the GET of
> info/refs. It got a 401 on the later POST, but didn't prompt for
> credentials.

I know nothing about CGI, but surely the script signals the need for a
valid user to the server somehow, couldn't the web server then decide
to return 403 rather than 401 *if there's no configuration for
authentication*?

In any case it seems there is no fix in the version of git in Arch
Linux[1].

/M

[1]: The package I've been using is built from these unpatched
sources: http://git-core.googlecode.com/files/git-1.8.2.tar.gz

--=20
Magnus Therning                      OpenPGP: 0xAB4DFBA4=20
email: magnus@therning.org   jabber: magnus@therning.org
twitter: magthe               http://therning.org/magnus

I invented the term Object-Oriented, and I can tell you I did not have
C++ in mind.
     -- Alan Kay

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iF4EAREIAAYFAlFl83cACgkQxZ8oagHN9cGX9gD9G10u6wxvfG1yMEQGKBsxOGAG
SsAhmcfKJy0CHQl8k7gA/1ratB6NN9uUKBo5xgQFOVva+dkfn8HNw8imMNXxkGfg
=gD+c
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
