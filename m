Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B28320248
	for <e@80x24.org>; Wed, 20 Mar 2019 22:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfCTWAQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 18:00:16 -0400
Received: from che.mayfirst.org ([162.247.75.118]:39707 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbfCTWAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 18:00:15 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; 
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; 
 s=2019; t=1553119214; h=from : to : cc : subject : 
 in-reply-to : references : date : message-id : 
 mime-version : content-type : from; 
 bh=t/982jH0EkcSTlUA4S1mq9FVV6kJLe4jjwSy5D04A2w=; 
 b=HbkhzqyZs0l7cqsnfefTJKz1ScaEruDlw0b6xYid7QD1/H/MCb95O7hN
 shKmf4iUdEB5XFyCas3eZJ9oK/O4BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net; 
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1553119214; 
 h=from : to : cc : subject : in-reply-to : references : 
 date : message-id : mime-version : content-type : from; 
 bh=t/982jH0EkcSTlUA4S1mq9FVV6kJLe4jjwSy5D04A2w=; 
 b=C6EfVUOnhetwzJpFVHzXTl3o8aSlNMMFb19wmZcwGZ9KmGVDLHMQmEj6
 BQzuGR7vCTJp8zYOqj78IXQ3gqW2BQn6SqnvdqYmk5QFUuISLcYST8lgp3
 CW16iKuT8TvSU+x8WlB5Y9Vlv28iji7v4E/sQsWjNk+f3gGMjnmYpdRmy+
 /zTmCM1Mm5gKXT9ynQLcIlaaxMXI31cxlSLKU1u+IL1BxO/ev6QOy4qqhE
 Z3D1MPXW/AC5LaFMDPQ2/UKLf9RetLtVsi94tdEsTgYeX1ppTyYkrx3fH1
 nGlU1EBCKtD4WTsiw1S9jJiK5ALMoFskzUKGYqrY8nk2av48tJuwIA==
Received: from fifthhorseman.net (unknown [38.109.115.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id 4F93FF99F;
        Wed, 20 Mar 2019 18:00:14 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id A422420527; Wed, 20 Mar 2019 18:00:11 -0400 (EDT)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     Santiago Torres Arias <santiago@nyu.edu>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
In-Reply-To: <20190320142055.zlh5iby5pxs3fy3r@LykOS.localdomain>
References: <875zsdu41d.fsf@fifthhorseman.net> <20190320142055.zlh5iby5pxs3fy3r@LykOS.localdomain>
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
Date:   Wed, 20 Mar 2019 18:00:11 -0400
Message-ID: <87bm25rytw.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi Santiago--

On Wed 2019-03-20 10:20:57 -0400, Santiago Torres Arias wrote:
> This has been known for a whlie now[1]. The consensus back then was that
> this information was up to higher-level integrators to verify using
> means like e.g., --format.
>
> [1] https://public-inbox.org/git/xmqqk2hzldx8.fsf@gitster.mtv.corp.google.com/

Thanks for this pointer to the history!  Glad to see people have pushed
on it in the past, even if i don't think the place that conversation
wound down to is the right place to settle.

> This is implemented in for example pacman/devtools here[2].
>
> [2] https://lists.archlinux.org/pipermail/pacman-dev/2017-September/022123.html

Sigh.  This is exactly the kind of redundant implementation situation
that i'm afraid of getting into.  as the comment in that patch says:

    This really should be fixed in git itself, rather than forcing all
    downstream users of git verify-tag to implement their own checks,

Git gets to decide what choices to make here about what the default
verification process is, and the default verification step should be
sensible and narrowly aligned to the standard case associated with
revision control tag verification.

gpg and gpgv can both be used to confirm the validity of the signature,
but those tools don't (and architecturally can't) know that they're
being used in the context of git -- so it's important that git supplies
that domain-specific knowledge to the verification step.

fwiw, i'm pushing for comparable checks in the git-buildpackage

   https://bugs.debian.org/925118

but it seems pretty silly (and likely error-prone) to have to rewrite
the same check in every tool that uses "git tag -v".

> We published a paper with a more thorough security model here[3], and
> there's some stalled work into implementing this using push
> certificates...
>
> [3] https://www.usenix.org/conference/usenixsecurity16/technical-sessions/presentation/torres-arias

I'm not convinced that push certificates solves this problem, if i'm
understanding the work right.  push certificates have to do specifically
with the ability to push to a repository, but here we're talking about
arbitrary verifiers who have passive (read-only) access to a repository
wanting to verify a given tag.

If you're talking about using a push certificate as a substitute for a
signed tag itself, then that sounds like we're giving up on signed tags
meaning what everyone expects them to mean, all because we can't get the
verification process to work right.  That doesn't seem like a good
outcome.

Thanks for talking through this -- hopefully we can figure out a good
way forward.

       --dkg

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTJDm02IAobkioVCed2GBllKa5f+AUCXJK36wAKCRB2GBllKa5f
+LDDAP48HGCtEMxhWzssqQtTRdHr8c6ulPsuq+NS7mXQ7qLfQQEAjVrAwvtUhOEE
iTidrGN3jxYvvQf/6M5erYnI1evRJQ4=
=2AyP
-----END PGP SIGNATURE-----
--=-=-=--
