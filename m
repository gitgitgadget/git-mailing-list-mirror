From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 3/4] git-push: make git push --porcelain print "Done"
Date: Sat, 27 Feb 2010 12:19:20 +0800
Message-ID: <be6fef0d1002262019j2088d20dp89f1587e3921a1ba@mail.gmail.com>
References: <cover.1267243044.git.larry@elder-gods.org>
	 <cover.1267242789.git.larry@elder-gods.org>
	 <04fc63d0f8114f0cd721bcf3dff1f108e30b5308.1267243044.git.larry@elder-gods.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Larry D'Anna" <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Sat Feb 27 05:19:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlE9H-0000rR-D3
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 05:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967803Ab0B0ETW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 23:19:22 -0500
Received: from mail-iw0-f182.google.com ([209.85.223.182]:51575 "EHLO
	mail-iw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967774Ab0B0ETV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 23:19:21 -0500
Received: by iwn12 with SMTP id 12so837392iwn.21
        for <git@vger.kernel.org>; Fri, 26 Feb 2010 20:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LUM3u4QjAIvajyTuS/RZaISIijZ+NZwY9nj+uJqymtQ=;
        b=G4Pr60i3iL/cbstuF1V6Jnoo+GEowJEQmU+z1SN+JZMpmbZHT9vW+XkaiYLOfrTqk2
         Mm5PRkf0ig69mo/YgKZeAHUKXQ/VRYeH6V7FXE4bLlfsOQqJ9EE8oN1g0r26FDGHWsKs
         HuW+/qMrLfxg+FBUEmXpxpUIOzWvvlpQm493s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=p/BllIt0i0z1JG8Nb3PPQu9Cm1tcNaKP7bgRhbL9WZ7k881TyfX+Nwqy+wwO+gchBF
         +jqLm3+yefccgv1Ke6iFYcdr3lDwwQxNkeMcU+JG7vSaSmfHt9u+BTZmAw5FAShpdOtV
         9Q3kwXD4JeI0sfBWxxSbzWPyvcv6h1uBVOrFk=
Received: by 10.231.151.212 with SMTP id d20mr329347ibw.53.1267244360199; Fri, 
	26 Feb 2010 20:19:20 -0800 (PST)
In-Reply-To: <04fc63d0f8114f0cd721bcf3dff1f108e30b5308.1267243044.git.larry@elder-gods.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141177>

Hi,

On Sat, Feb 27, 2010 at 11:59 AM, Larry D'Anna <larry@elder-gods.org> w=
rote:
> diff --git a/transport.c b/transport.c
> index 32885f7..5b880d7 100644
> --- a/transport.c
> +++ b/transport.c
> [snip]

This hunk:

> @@ -1055,8 +1056,6 @@ int transport_push(struct transport *transport,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D transport->push_refs(transport=
, remote_refs, flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D push_had_errors(remote_refs);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D err;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!quiet || err)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print_push_status(tran=
sport->url, remote_refs,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0verbose | porcelain, porcelain,

and this hunk:

> @@ -1071,9 +1070,15 @@ int transport_push(struct transport *transport=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0update=
_tracking_ref(transport->remote, ref, verbose);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!quiet && !ret && !refs_pushed(remo=
te_refs))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf(stderr, "Everyt=
hing up-to-date\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (porcelain) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret=3D=3D0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf=
 (stdout, "Done\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!quiet && !ret && !=
refs_pushed(remote_refs))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fprintf=
(stderr, "Everything up-to-date\n");
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret | err;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return 1;
> =A0}

slightly changes the conditions under which "Everything up-to-date" is
printed, since you did away with "ret |=3D err". I guess you can
mitigate this by adding "!err" to the list of operands:

  if (!quiet && !ret && !err && !refs_pushed(remote_refs))
      ....

Even better, create yet another temporary variable:

  push_ret =3D transport->push_refs(transport, remote_refs, flags);
  err =3D push_had_errors(remote_refs);

  ret =3D push_ret | err;

That way, you can access transport->push_refs() status (what you
want), without messing with the other parts of the code and their
assumptions.

One last thing: could the if statements towards the end be "flattened"?

  if (porcelain && ret =3D=3D 0)
      fprintf(stdout, "Done\n");
  else if (!quiet && !ret && !refs_pushed(remote_refs))
      fprintf(stderr, "Everything up-to-date\n");

(sorry about the lack of tabs, gmail doesn't let me type those easily.)

--=20
Cheers,
Ray Chuan
