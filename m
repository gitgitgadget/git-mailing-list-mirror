Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 715AD20248
	for <e@80x24.org>; Fri, 22 Mar 2019 17:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbfCVRXC (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 13:23:02 -0400
Received: from che.mayfirst.org ([162.247.75.118]:41851 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728286AbfCVRXB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 13:23:01 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; 
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; 
 s=2019; t=1553275380; h=from : to : cc : subject : 
 in-reply-to : references : date : message-id : 
 mime-version : content-type : from; 
 bh=ciVUXCpH61wY0UPdT5VXHkeKXKXP8kXVd3Dn3iebwqI=; 
 b=WaUw4GypDWrJxJaSfyvR197rbIpZTkW9Wv9pIB7VdwIuXYk1ScptNx8H
 Drjp6/kS1iO7BLwLISWbXmyBVmTPBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net; 
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1553275380; 
 h=from : to : cc : subject : in-reply-to : references : 
 date : message-id : mime-version : content-type : from; 
 bh=ciVUXCpH61wY0UPdT5VXHkeKXKXP8kXVd3Dn3iebwqI=; 
 b=P5u6n+sydvzKGsy2HGanIbyR6zKl/n+bTL6xMamMkB+GAm04pIXqlYGA
 S2pdBC63MM3ZM902L8umKfAozumRdblx5s0DFslKjznKtb6ZdehCgGl7VB
 VxaC/z7/1E0ll/iurb1Wjdc38SInz+xII+WbiGRzuvxmNgwMdTt7cUFPPM
 BUdNTQY2mmMOXGwOqgUszEaii/ZqWa2NdXw0nHIwq3rB2GVtj5S0lNWlLJ
 4r59ANtbEPNxD+PsytEF42gDtn+GqptAhnvaMLAT0XNcOV8tWoeYE4LddS
 aiLCqt53QK9Jj/r3a0Mb0FmD/NiIwr5KlT63LUVWJWTORLMlbycRWQ==
Received: from fifthhorseman.net (ip-78-45-46-183.net.upcbroadband.cz [78.45.46.183])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id 3C4FCF9A2;
        Fri, 22 Mar 2019 13:23:00 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id 456F5206B9; Fri, 22 Mar 2019 00:00:38 -0400 (EDT)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Santiago Torres <santiago@nyu.edu>
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
In-Reply-To: <8736nhdvi3.fsf@evledraar.gmail.com>
References: <875zsdu41d.fsf@fifthhorseman.net> <8736nhdvi3.fsf@evledraar.gmail.com>
Autocrypt: addr=dkg@fifthhorseman.net; prefer-encrypt=mutual; keydata=
 mDMEXEK/AhYJKwYBBAHaRw8BAQdAr/gSROcn+6m8ijTN0DV9AahoHGafy52RRkhCZVwxhEe0K0Rh
 bmllbCBLYWhuIEdpbGxtb3IgPGRrZ0BmaWZ0aGhvcnNlbWFuLm5ldD6ImQQTFggAQQIbAQUJA8Jn
 AAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBMS8Lds4zOlkhevpwvIGkReQOOXGBQJcQsbzAhkB
 AAoJEPIGkReQOOXG4fkBAO1joRxqAZY57PjdzGieXLpluk9RkWa3ufkt3YUVEpH/AP9c+pgIxtyW
 +FwMQRjlqljuj8amdN4zuEqaCy4hhz/1DbgzBFxCv4sWCSsGAQQB2kcPAQEHQERSZxSPmgtdw6nN
 u7uxY7bzb9TnPrGAOp9kClBLRwGfiPUEGBYIACYWIQTEvC3bOMzpZIXr6cLyBpEXkDjlxgUCXEK/
 iwIbAgUJAeEzgACBCRDyBpEXkDjlxnYgBBkWCAAdFiEEyQ5tNiAKG5IqFQnndhgZZSmuX/gFAlxC
 v4sACgkQdhgZZSmuX/iVWgD/fCU4ONzgy8w8UCHGmrmIZfDvdhg512NIBfx+Mz9ls5kA/Rq97vz4
 z48MFuBdCuu0W/fVqVjnY7LN5n+CQJwGC0MIA7QA/RyY7Sz2gFIOcrns0RpoHr+3WI+won3xCD8+
 sVXSHZvCAP98HCjDnw/b0lGuCR7coTXKLIM44/LFWgXAdZjm1wjODbg4BFxCv50SCisGAQQBl1UB
 BQEBB0BG4iXnHX/fs35NWKMWQTQoRI7oiAUt0wJHFFJbomxXbAMBCAeIfgQYFggAJhYhBMS8Lds4
 zOlkhevpwvIGkReQOOXGBQJcQr+dAhsMBQkB4TOAAAoJEPIGkReQOOXGe/cBAPlek5d9xzcXUn/D
 kY6jKmxe26CTws3ZkbK6Aa5Ey/qKAP0VuPQSCRxA7RKfcB/XrEphfUFkraL06Xn/xGwJ+D0hCw==
Date:   Fri, 22 Mar 2019 00:00:37 -0400
Message-ID: <87lg17muca.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed 2019-03-20 23:35:48 +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wr=
ote:
> But e.g. if you've signed a v1.00 in foo.git, but also maintain bar.git
> and have a v2.00 there, I can be fooled in foo.git with your proposed
> change by having the v2.00 bar.git tag pushed to it (just, with the
> proposed change, not the other way around).

Presumably the tool looking for the "most interesting new tag" already
has some sort of pattern that it looks for in a tag name (to avoid
accidentally ingesting some development-specific, non-release tag).

So yes, this is true for upstreams which issue signed release tags on
multiple projects named with the generic form v1.2.3, but it is *not*
true of projects which name their tags the way that (for example)
GnuPG's upstream does (e.g. gnupg-2.2.14 and libgpg-error-1.36).

In that case, and the matching pattern itself will exclude tags from
other repositories.

> It *does* help with the "pass of an old tag [from the same repository]"
> problem, which I'd expect would realistically be the only threat model
> that matters (forcing a downgrade to an old buggy version), whereas some
> entirely different project is likely going to be next fed to some
> project-specific build infrastructure and then won't even build.

I agree that a cross-project tag substitution attack is more exotic than
an in-project downgrade or freeze attack, but i'm not inclined to wager
on it never being exploitable.  Why take that gamble?

> I wonder if there's a more general fix to be found here that'll have
> nothing to do with GPG or signed tags per-se. A lot of people have this
> "given tags in the repo, what's the latest one?" problem. I think
> they'll mostly use the --sort option now, maybe some variant of that
> which for each <older>/<newer> tag in the chain also checked:
>
>     git merge-base --is-ancestor <older> <newer>
>
> That would serve as a check for such rouge tags, even if none of them
> were signed, and a "they must be signed" option could be added, along
> with "start walking from here".

I agree that this is a common tag verification use case, and i've seen
probably a dozen different attempts to do it which all fail in some
curious ways if you assume that the repository being pulled from is
malicious.

I like the idea you're describing here, and would be happy to see some
reasonable, easy-to-use git subcommand that says something like "find
the most interesting tag that derives from the current HEAD".  for some
version of "interesting", of course :) It would probably be a good start
to have "interesting" mean:

 * the tag name matches some particular pattern
=20
 * the tag is cryptographically signed by at least one member of a
   specific curated keyring
=20=20=20
 * the tag is the "most recent" or "farthest descendant" (these are
   subtly different, i'm not sure which one makes more sense)

Anyway, the fact that there isn't an obvious perfect answer for how to
do this shouldn't stop git from offering a reasonable, well-vetted,
*good* answer.  Because the current situation just means that every
project that cares about verifying signed tags makes up their own
approach, and i would happily bet that most of them get it wrong in some
corner case.

And if there's a tool that does a sensible verification of some workflow
that we think is reasonable, that tool will also help to encourgae
projects to adopt that reasonable workflow.  This is a good thing!

       --dkg

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTJDm02IAobkioVCed2GBllKa5f+AUCXJRd5QAKCRB2GBllKa5f
+GbfAP0YiEYt0JQdu6w9YpPIQcqPuYJ1ftlkra3NsdWxbdPSvgD9HmYdEaWUCY1H
/YTUAC4a624Fm/YlUlsObRj3gDt8LAU=
=v0/S
-----END PGP SIGNATURE-----
--=-=-=--
