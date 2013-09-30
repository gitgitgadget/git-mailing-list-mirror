From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: [PATCH] Makefile: suppress false positive warnings of empty format
 string.
Date: Mon, 30 Sep 2013 23:38:33 +0200
Message-ID: <5249EF59.4080607@googlemail.com>
References: <7vfvvkpt2k.fsf@alter.siamese.dyndns.org> <1380456534-7582-1-git-send-email-stefanbeller@googlemail.com> <20130929190017.GA2482@elie.Belkin> <20130930201429.GA14433@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IiHKTtAuRWlNeAglIM4xHgs2bQXKsmqwD"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 30 23:38:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VQlAk-00082g-4e
	for gcvg-git-2@plane.gmane.org; Mon, 30 Sep 2013 23:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab3I3Vi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Sep 2013 17:38:26 -0400
Received: from mail-ea0-f177.google.com ([209.85.215.177]:49265 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755663Ab3I3ViZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Sep 2013 17:38:25 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so2983299eak.36
        for <git@vger.kernel.org>; Mon, 30 Sep 2013 14:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type;
        bh=UT7YPpOL42JeeJNu8jdmgHOa5KQ8bHCjE8qXSyi10jM=;
        b=UBUYa++zF6IZX/LIpCjC0VGtoT61PnhRAAbpRu3r0NXdVKcJnqdh6zqSrtQZuazkJA
         3Os4ZTzfWPWXnw81phw919cV17+0/tmjS0I7kymCPeLolApzatmsJZj3LMhOHPWrRtPK
         QLKEefoi7Q0A3SGe2XghZ9fVDvI0IkuQZ38iP3PLp2rHhl4Sz2yrKJMyd9myCQ0GZF2d
         weFdMyWM9zxfCz0E1u4aH0wAFsa/hOES2799/0UBxXqy3I9csMeil8eGy1ApxPnTgXaN
         grOpUii3RdnJVUN9n7/poU+G5rJbtgtsP6KFf2z74gZL3+DG3MfOQfZa57qUpDKiZ4cE
         rpkA==
X-Received: by 10.15.94.201 with SMTP id bb49mr40869459eeb.23.1380577104309;
        Mon, 30 Sep 2013 14:38:24 -0700 (PDT)
Received: from [192.168.1.3] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id z12sm5513307eev.6.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 14:38:23 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
In-Reply-To: <20130930201429.GA14433@sigill.intra.peff.net>
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235631>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IiHKTtAuRWlNeAglIM4xHgs2bQXKsmqwD
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/30/2013 10:14 PM, Jeff King wrote:
> On Sun, Sep 29, 2013 at 12:00:17PM -0700, Jonathan Nieder wrote:
>=20
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -349,7 +349,7 @@ GIT-VERSION-FILE: FORCE
>>> =20
>>>  # CFLAGS and LDFLAGS are for the users to override from the command =
line.
>>> =20
>>> -CFLAGS =3D -g -O2 -Wall
>>> +CFLAGS =3D -g -O2 -Wall -Wno-format-zero-length
>>
>> Thanks for taking this on.  Two thoughts:
>>
>>  1) As Felipe mentioned, this isn't portable.  Would it make sense to
>>     make it conditional on the value of $(CC) or the output of
>>     "$(CC) --version"?
>=20
> I'm not sure checking just "$(CC)" would help. Our default is "cc",
> which encompasses quite a wide variety of compilers, gcc and otherwise.=

>=20
> To be honest, I'm surprised that "-Wall" doesn't create problems for
> older "cc" implementations. We've had patches for compiling with
> antique SUNWspro and MIPSpro compilers, and I sort of assumed that thos=
e
> don't handle "-Wall". But maybe they do. Or maybe people doing that jus=
t
> set CFLAGS themselves.

Well actually I do think people are encouraged to play around with their
CFLAGS as much as they like. I do add link time optimisation usually.

However I do have the strong opinion that any serious project should
compile without any warning/error with the standard compilers of
the current time. That's why I started an attempt again to have
-Wno-format-zero-length in there by default. Most of the people (I
assume so) are using gcc. So it should build fine there without any
warnings.

Sure it should build without errors as well on other architectures, so I
do understand the issue to check if we're really
using gcc and can omit this flag if using another compiler.


>=20
> I think the original discussion ended with "well, maybe it's not too ba=
d
> for people to just turn on -Wno-format-zero-length". But if it is
> creating a cognitive burden on people (it's not hard to do, but you hav=
e
> to figure out that you need to do it), and especially if we are looking=

> at workarounds like version-detecting gcc, I think we'd be better off t=
o
> simply mark up the few callsites. Workarounds are here:
>=20
>   http://article.gmane.org/gmane.comp.version-control.git/230026
>=20
> and here:
>=20
>   http://article.gmane.org/gmane.comp.version-control.git/230027

and here
http://thread.gmane.org/gmane.comp.version-control.git/230806

>=20
>>  2) I don't understand the value of -Wformat-zero-length at all.  What=

>>     bug is it meant to prevent?  Do you know if anyone has asked the
>>     GCC maintainers to disable it from the default set of warnings in
>>     -Wall, which would give us a bug number to point to?
>=20
> I don't think there is an open bug anywhere.  When this came up
> initially, I searched for other reports, but mostly found a handful of
> other people running into the same situation and adding
> -Wno-format-zero-length to their projects.
>=20
> As for the value of it, I think it is basically to detect that:
>=20
>   printf("");
>=20
> is a dead-code noop (bearing in mind that the "" may also be non-obviou=
s
> when reading the code due to preprocessing), and may indicate some kind=

> of logic error.  That's reasonable to warn about; the compiler knows
> that stdio formatting functions with an empty format are noops.
>=20
> But where we run into trouble is that the warning assumes that other
> formatting functions are also noops in that case, which is not
> necessarily true. They might have side effects, or the empty string
> might be formatted with extra decoration (adding a newline, wrapping th=
e
> empty string in quotes, etc).
>=20
> So I do not think the correct solution (from gcc's perspective) would b=
e
> to turn off -Wformat-zero-length by default. It would rather be to
> enhance the annotation for the format attribute to separate the two
> cases, and to annotate printf() and friends with some kind of
> "pure-format" attribute.

I do agree. :)

>=20
>>  3) Since we don't enable -Werror by default (which is really good ---=

>>     use of -Werror can be a fine development tool but is a terrible
>>     default), the warning does not actually do much harm.
>=20
> Yeah, I think the world is a better place if every developer of git
> should compiles with -Werror, but it is a terrible default for consumer=
s
> of the code.
>=20
>>     becomes harmful is when someone turns on -Werror for static
>>     analysis purposes and is unable to move forward from there.  Do we=

>>     document suggested pedantic compiler flags anywhere other than the=

>>     todo:Make script?  Should we?
>=20
> It should probably be somewhere in the actual git.git history, as very
> few people look at the todo branch. I guess INSTALL or CodingGuidelines=

> would be the most appropriate place.
>=20
> -Peff
>=20



--IiHKTtAuRWlNeAglIM4xHgs2bQXKsmqwD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSSe9ZAAoJEJQCPTzLflhqFUoQAMu0pdpAZRv2T+RqxMb2c0JY
JI1XFcXl4hyJBpE/BLEl0Erba1gX9q8KKtTCy/gYARApD3fQurhlWZz7y2TROev+
2yfeMrzjel31iPSfV0Q6XZgGoYXFC62AzyoRI9J67A2SOM+kTC9tLrzSW0iK7RLI
oaFD3VVtawdgpqF3Q5sjNQEgNivAZ4tKxCFRNKjjexm62CdyMGu6X/the2sXqNHU
CsIfKbxHwmhbjdqZ6SMQL4QVfRRObmhCgT+nPjNyxg5EYZOIiceXIgu9TRYm8NZz
g/9YH4zTcgS51zb0FIni0VnUX71Ous4IqiY8ajKY+VLstExWUf1PwepC4l3EYTfj
bawvEpLgVBzu/FmIYf89P+xjUIutmikJLYc4AtD8ztdy230/YktpkEJEnqrlyVcj
SZoC9fU8r2VZGXHR+y7/k3eJbWhesTb4IBiYqxH7Yi+n8GB+zN0boUY7DxonMntU
Q/tHRGoAu4Cjl1vLmb7Bzwtb8JMZIt2RyaCmpuE2sIAIyjahwNrOvK38IcvQMNOY
PxnXR8YeX92tow4XTrAp7yFKufRzi1vVi0kugRKiZlqOOR/6CGTg6ryzpWx9AH+R
vvu5AfrcLV1VVdLndlQ9mYb+Lrwy4LEf8wXsQXhzRiFs5Dqr59xoqQwrjdQ1gidB
KVFIMHHrbePpjn5erZur
=mbFC
-----END PGP SIGNATURE-----

--IiHKTtAuRWlNeAglIM4xHgs2bQXKsmqwD--
