Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03A9C433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E07C65136
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbhCPSF0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 14:05:26 -0400
Received: from mail.archlinux.org ([95.216.189.61]:49510 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhCPSDx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 14:03:53 -0400
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1615917829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csJJlrhaVZ9+mq1xO3cnFRpUSaBfCoR5lQ+kH5YpcZY=;
        b=nfg5Cxyf+v5UhRjTjaNhnHLlRndpsFstyOc4RiqnMO6BrjOqbORdhSqcEGycn++ECQcyAW
        Kk4CGEnHlorQ3I8A+AcC+lMMZ5XiTsmd411+ZDCgYjcLYOgYFGo57MwrXKrwICE7qlCzZn
        IfwwWuz03fPtgIQc52XVq9RfyPOy+72DL7KZp6JG8b9q62pa8pQ0GbNcHKllFeXztt8dnG
        Xe3ikY+krkEfPLgmjmxXS+7QomnL9PQ1BPOBBIKSgj/3ZT8pvvFl9f0qpcfIuLjcT/V7pP
        u8VPKrOuspnPZZ0uA8wDm+Uik5c+YvmpHZfxtO98+8HG3nGs72TV3gaCi8X113mpmxPK9S
        MeX9IazKaVcoryuU4m/EXtwghPH6AjdOZFSqLrh9MZ8VvM6na49sYv+sH5EclBSem+LLiw
        4jtQIaBxGd/GtmGzDZA8j2Au3ptAYlOS1GOz1X15/+Fg4a6kfLTAnr3WJCxbptbUyj7uzL
        usXpLDIxFkFc4dzwu9Ap/i3njmp//svAPGdb/E0M2/+1aN8NhTnxoBapv6LMERx+rtigA6
        qYtkexyWwrk3Ng6LlKrc5yDtdsb0tF6jD6n17nh2mILyouOBrqn4lExOC00+iUxqIG2Sgj
        N80vmYy+ZorqETCwx+59l7+4JfUGhP04Xd0qhl0dxpo8QiY29lKkI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1615917829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csJJlrhaVZ9+mq1xO3cnFRpUSaBfCoR5lQ+kH5YpcZY=;
        b=oR1sXq0+fNYR5YRUYypapiPrxjW9B6J5avDtadicahzTUB17Z67LWkO+O2MopP0zvLRxXI
        jC0u65RahGHsfaDw==
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Drew DeVault <sir@cmpwn.com>, git@vger.kernel.org
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <8fed0d1f-a2bd-131c-5552-e95216b43474@archlinux.org>
Date:   Tue, 16 Mar 2021 14:03:46 -0400
MIME-Version: 1.0
In-Reply-To: <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j0bVLAYeqS7ubI4oUcOnX4eASLiur04JM"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j0bVLAYeqS7ubI4oUcOnX4eASLiur04JM
Content-Type: multipart/mixed; boundary="5x2wFrhXIfZVioFgY3vQ90mcgevgze7Dg";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
 Jonathan Nieder <jrnieder@gmail.com>, Drew DeVault <sir@cmpwn.com>,
 git@vger.kernel.org
Message-ID: <8fed0d1f-a2bd-131c-5552-e95216b43474@archlinux.org>
Subject: Re: Regarding the depreciation of ssh+git/git+ssh protocols
References: <C9Y2DPYH4XO1.3KFD8LT770P2@taiga> <YE+ftT2WaKDzc+45@google.com>
 <C9Y4NXXX6HRI.1IROIK8ZXK4S2@taiga>
 <YE/ZSiuIsMs3ucVM@camp.crustytoothpaste.net>
 <C9YD4AEUH84L.29FP64NJJ1BPU@taiga> <YFADuptwV7iR76g5@google.com>
 <40740478-8b3c-b33e-8bb4-a2d68b83d385@archlinux.org>
 <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>
In-Reply-To: <YFCckC8fHmEyOAnp@camp.crustytoothpaste.net>

--5x2wFrhXIfZVioFgY3vQ90mcgevgze7Dg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 3/16/21 7:54 AM, brian m. carlson wrote:
> On 2021-03-16 at 04:38:08, Eli Schwartz wrote:
>> Why does this even matter? Again, the point here is the assertion by
>> Drew that, for the purpose of listing a manifest of remotely fetchable=

>> resources, he sees a benefit to having some standard format for the UR=
I
>> itself, describing how it's intended to be fetched.
>>
>> - ftp:// -> use the `ftp` tool
>> - scp:// -> use the `scp` tool
>> - http:// -> use the `wget` tool
>> - git+http:// -> use the `git` tool
>>
>> But instead of needing every program with a git integration to
>> reimplement "recognize git+http and do substring prefix removal before=

>> passing to git", the suggestion is for git to do this.
>=20
> I believe this construct is nonstandard.  It is better to use standard
> URL syntax when possible because it makes it much, much easier for
> people to use standard tooling to parse and handle URLs.  Such tooling
> may have special cases for the HTTP syntax that it doesn't use in MAILT=
O
> syntax, so it's important to pick something that works automatically.
>=20
> It's difficult enough to handle parsing of SSH specifications and
> distinguish them uniformly from Windows paths (think of an alias named
> "c"), so I'd prefer we didn't add additional complexity to handle this
> case.
>=20
> Lest you think that only Git has to handle parsing these, the Git LFS
> project (and every other implementation compatible with Git) has to
> handle parsing them as well (and related things like url.*.insteadOf),
> and providing bug-for-bug compatible behavior is generally a hassle.
> We've run into numerous problems where things aren't exactly the same,
> and making things more complex by adding an esoteric syntax that few
> users are likely to use isn't helping.  Despite the fact that ssh+git i=
s
> specified as deprecated, we had people expect it to magically work and
> had to support it in Git LFS.
>=20
> So I'm very much opposed to adding, expanding, or giving any sort of
> official blessing to this syntax, especially when there are perfectly
> valid and equivalent schemes that are already blessed and registered
> with IANA.

Suddenly I'm hearing a much more reasonable response than "but it
doesn't give me content-type so I can't know which media application is
capable of opening it".

(I'm not especially attached to the proposal. I'm a maintainer for one
of these package managers that currently special-case git+https?:// and
rewrite the url that git sees, which has worked adequately for a long
time. However, I figured if you want to reject this proposal, reject it
for a good reason...)

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User


--5x2wFrhXIfZVioFgY3vQ90mcgevgze7Dg--

--j0bVLAYeqS7ubI4oUcOnX4eASLiur04JM
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmBQ8wIACgkQzrFn77Vy
K9YWPRAAs5fIb2XX+wpqepbK/gr0q6DDg3JuP8vR/fNCLl/vFzS1RFpU+r8iPxz5
CH5UrEMJKRthQu5FB5KsggwWD3zUdmbbLDak892+QjolG58YXMOWWn5deO7JcliN
x+7mqqAC2uZIqi7sDCm63s2GdRK4rbMLVpHYutaTqy1/C2fbseqaFpJEq8ouFeXN
obnIgU1vYq72biG+rqZf03MlQCyTRkz/5CkYC8i1kqbSa0l/Xq3w/kI8HmHiHxcN
2HUekPLSJYXuNfY0kh0qs4Xp92zwWwgC3HDHVF8egZyoGi4IzjUOkCy7i12+8FLC
9R7lbNgaDQvxHwAPcoNpOJ63o5CQDcNBDnll/gPk+3Yd+tOuTdvoBgb+lq4Lc7va
McBQImcHg2vovMDnsBR63Fr9i6Un16sK8lYJnmufmMVfHcaoLgCQvc2MsBH3CoOa
Oj2V1g43RmL9MfkFs9bJ0ucxdi02xAemNQq4q/dP8s4BFIg5uWLZfEhEmCBLSzgA
npAnAJ+uRM5KZt4gD9mAhET7DHRNJR5ekRiapC2iS3CMRyCbjQ0nWzouGhcLHZJD
tHAZUT9b/LLFiEN4M+4p6gQA8i6JdznaQDaQsY+qF8WSU0qpPyYEQHxLGHPkjxiq
ViEodExQZMcYmp85eWBxoG2u+ZYryejMsObwSd6e1jbTZiUrHZA=
=L6oz
-----END PGP SIGNATURE-----

--j0bVLAYeqS7ubI4oUcOnX4eASLiur04JM--
