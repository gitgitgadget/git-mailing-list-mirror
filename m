Return-Path: <SRS0=XLsf=DH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3EBC4727D
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 02:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3F720773
	for <git@archiver.kernel.org>; Wed, 30 Sep 2020 02:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgI3CTd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Sep 2020 22:19:33 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:40920 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbgI3CTd (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Sep 2020 22:19:33 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id C6CAE6046C;
        Wed, 30 Sep 2020 02:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1601432372;
        bh=4MnLJwdxTipkgHOVuGV2GGOOGVkgMzi5R9t9ULfEZXo=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=d78LhuhoZJkSbRlxtQYKps0IF41UKyGTezrg1E9Hw6T373hiqq6HjvtdBctAC/cK1
         1u3B/K0rBUQRgoMfSTbjCFSrcR233iHQiCJqpq/6fpD6hgkBrf4eObj6vGNvMNyvUW
         bfw0EiURcTH3RnJrd/q6WXMPNZlHTB7KkpvUq2n9b6dQvoyTRiwimj3+/D33E8LW+y
         wMxdrgXRP8LhkrYVfFNN0V5FhnUSy+bectwrCYsTY+Bx/FsRQCXX3iqVeMzkQyxHnx
         iE85ul+lvJPaZ7MXfKb5IGQIw1v02MjOn+STNjZpW29cO8s6nrViUgJ9wkWxscmd8F
         Had47AMNB/inGTv/TESp+9cAQCblw0Xr7UIJb95V0HfRca0pzfZ8LHRdtYtQV0OeTW
         vHVzBcZjjg8emPRmb+DTUJvvMKoxkefOuee3sCPxJsXPp+0CRfUzU8PG7znjuZTmF2
         ASnUmjz8EGDDnQKcGyVpuDtrIW+vn0ElD2fx5O5LYN1lBcdhFYL
Date:   Wed, 30 Sep 2020 02:19:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question About Git V2 Protocol & SHA256
Message-ID: <20200930021925.GI1392312@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, "Wu, Zhichen" <zhwu@amazon.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <9FC3DDB4-DE6F-45B3-95F9-1048991713A4@amazon.com>
 <20200929221311.GA15129@coredump.intra.peff.net>
 <20200929224356.GH1392312@camp.crustytoothpaste.net>
 <20200930004630.GA623061@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PMULwz+zIGJzpDN9"
Content-Disposition: inline
In-Reply-To: <20200930004630.GA623061@coredump.intra.peff.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PMULwz+zIGJzpDN9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-09-30 at 00:46:30, Jeff King wrote:
> I agree that we _could_ just dump sha256 within a v1 protocol and wait
> for the client to choke. But that seems like an awfully lousy user
> experience. By contrast, assuming that the client wants sha1 means that
> either:
>=20
>   - we can reject it with a sensible ERR message that tells the user
>     what is going on
>=20
>   - we can serve them by talking in terms of sha1 if we're willing to
>     do the extra conversion work server-side (and/or have a cache of
>     sha1-format objects)

If you have a suitably new Git, it will fail with an appropriate
message on both sides.  The client will complain that you are trying to
use a remote that uses the wrong hash algorithm and the server will
complain that you have failed to pass a suitable object-format
extension.  That will look like this:

  fatal: mismatched object format: server sha256; client sha1
  fatal: expected flush after ref listing

That's true if you're using protocol v2 at all, or a suitably new Git
with protocol v1, although the messages may differ slightly.  However,
if you're using an older Git with v1, then you'll get this:

  fatal: protocol error: unexpected '304c98b4860fa40b3e04f3e2e24db1a13ab959=
922a63209685813908c4fabc83 HEAD'
  fatal: the remote end hung up unexpectedly

That's because, as you pointed out, we don't get to the point where the
client fails to send the value.

> The only thing we lose is that a recent client who understands sha256
> wouldn't be able to contact us and do a sha256-over-v1 transaction. But
> why would they want to do so?

Because v2 isn't implemented for pushes yet.  The testsuite does not
even come close to passing unless you have a fully functional remote
system.  That's why I implemented protocol support, even though it
wasn't originally planned.

That was mentioned in the cover letter of the series that introduced
protocol support.

I should also point out that v2 SSH support doesn't work at all with
OpenSSH unless the server is specifically configured to allow the
GIT_PROTOCOL environment variable.  Since there are many use cases for
people to push Git data over SSH to servers they do not control, there
is a valid and viable use case for v1 support.  I personally know people
with shell accounts who could not use v2 over SSH but could viably use
v1.  Heck, that's even true for our shell host at work.

Absent a significant outreach campaign to all major operating system
vendors to get this environment variable added to all supported versions
of their OpenSSH packages, I don't see how restricting SHA-256 to
protocol v2 is acceptable.  Even then, many systems would still fail to
work correctly due to local config file modifications.

In retrospect, we probably should have sent "GIT_PROTOCOL=3Dversion=3D2" as
part of the shell command and let implementers deal with the fact that
their SSH servers would need to adequately parse and interpret shell
commands to function properly.  But it's probably too late to do that
now without bumping the protocol to v3.

> This is all hypothetical at this point, though, right? I tried finding
> details in the hash transition document, but protocol changes are listed
> as out of scope there. It does say that sha256 servers may just reject
> sha1 clients; but even so I'd prefer if we could do it with a nice
> message (i.e., my bullet one above).

It is not hypothetical.  Git in master has a fully functional SHA-256
implementation that fully interoperates with other SHA-256 repositories.
As I mentioned above and elsewhere, that is a prerequisite for a fully
functional testsuite.  I would not have shipped user-visible SHA-256
support with a testsuite as broken as it would be without protocol
support.

> My suggestion does also require that we have a v2 receive-pack protocol,
> which does not yet exist (but following the blueprint for fetch, I don't
> expect it to be a big deal).

If someone would like to implement protocol v2 for push in time for
2.29, then that could be a viable approach if we can address the serious
problem of the SSH situation in that time frame as well.

I don't plan to implement v2 push support because that is a substantial
amount of work and I have even less time to work on Git than normal due
to taking classes multiple nights a week.  As I know you are aware,
working on Git is not my day job.

I will admit to being a bit annoyed that we're discussing changes like
this at this point.  I've tried to be open about the design and
implementation, answering questions and providing complete branches and
reasonably thorough cover letters that people can peruse to know what's
going on even if they aren't interested in the full series themselves.
LWN has even summarized some of the later work.  It's fine if folks
don't want to participate in that process, but it's hard to incorporate
feedback that comes in well after the fact.  I certainly hope the nature
and content of my SHA-256 work isn't a surprise to regulars on the list,
because I've clearly failed to communicate effectively if that's the
case.

I am at this point not planning any other major changes to SHA-256
support before the interop work starts to land.  I am of course happy to
address any bug reports that come up, and if others would like to send
in patches related to SHA-256, I will review them and provide feedback
as my time allows.
--=20
brian m. carlson: Houston, Texas, US

--PMULwz+zIGJzpDN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCX3PrLQAKCRB8DEliiIei
gQvJAP0XcoyaQzxI7EuznPOLbnNaLXrNtPpZTRNBrB+BQGQ4wgD/UtMoJJEoQ5kk
nI3TzOGJis1dQrpmWi0b7hY9w8wqfwU=
=5gU5
-----END PGP SIGNATURE-----

--PMULwz+zIGJzpDN9--
