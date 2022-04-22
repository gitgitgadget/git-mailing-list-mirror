Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFAA3C433F5
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 08:00:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388095AbiDVIDt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382557AbiDVIDs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 04:03:48 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E588D527CB
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 01:00:55 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id E1FC53201FC9;
        Fri, 22 Apr 2022 04:00:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 22 Apr 2022 04:00:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1650614454; x=1650700854; bh=d3bnGMEFFE
        nfmly81kyXWmpkyERo2UssD9+RAxTrEFY=; b=emiI4YsuEHzTWFweFrQYqQu+7s
        d6lY2QIMRILKZ3T7DqRtCsdsB5pTnwrYfhtIFivS+yHmd+jxpAfcr5r0zuejwrAr
        W0tSI+HounPnnZWrY/tCiTBdyQzz9ZyULlxk2HaW6rK3SNUsn41q3vm/tnlW+xIU
        32dgmZhdKN6Cy2cEwOzZR0uPSULHRa4mA7b34YpPg4IvyWweNaGxc2wtwms+K/Is
        JK9OQfE4U37ckSecrormBwlCwmMiXKo4qDPZdVCTScLobE32nDG8SthpncKURLa0
        ToN9+VnDqT10NJ92NDVwzl5SPHigfZQq1/Pbr/7UwbNZI1F/0B7ITEkVINQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650614454; x=
        1650700854; bh=d3bnGMEFFEnfmly81kyXWmpkyERo2UssD9+RAxTrEFY=; b=w
        jXMGFgbtdic8NSJEpr9MywEGQbm9v3AdUZ7OlfZREqF+tnb6chUPFcSA/9EQb+Kv
        H4GeAuNmOZrNNANMskOczyeADJldZxQcqOZOjvATTQEj8oOW12zIWp3cIBw+RjUQ
        9ZWKLHisoGFyZ9U1mu1hZ9S5d+VbYyNe3fdq8+cCf9/J3oYnzCDW/FF9xsz870V7
        L+z7RgU4g54jB3thkTTTaH2Xk62gpc5ntTovaeuzW+2OnDCjgl2A8TvYBpf1gb68
        a1bnPiC4rMwar210FH/2JbbakOhwsVSpnBkBlWfS+GQP/9CJiAHYKGKI7K/zqhFf
        1nlObDpDEDV68zJWOw+FA==
X-ME-Sender: <xms:tmBiYg8_DDR4aDIU-m34omDFxlq6JGcqWirmRUgk3D6Jh5lsJLt10A>
    <xme:tmBiYotvqJV23ihYtk27fSB8BM-Dsc41jCb405U6lsD8TZ6vKY-Ih5GxFZ5YQWmgp
    dvs3rYibhw6I2yYxA>
X-ME-Received: <xmr:tmBiYmC4cmIZ3RMwAzSUJtKdqLEZ2IIzsl1n8ScIgXGKn8oRN92jDQJWkL0WfDnHzKEc-ASelT6K5z2-GclBNc2TdjNf-A0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdefgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdr
    ihhsqeenucggtffrrghtthgvrhhnpedvgeeifeffkeejhfdvhfdtffelteehjeelueehhf
    dvudeiueeugeeujefgtdetvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehqhihlihhsshesvghvvgdrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:tmBiYgct4nkW53f3m9VTByKgaYTvWfdnhTWrguew6RCLHCbSqXcCUw>
    <xmx:tmBiYlM6eeorFxdZzmwBIPfNo1UrvCmRTti3eMku0Gjfg3LI2n93eg>
    <xmx:tmBiYqkDb_9onDed9H1Offm0Mzni3-JFh8UXhc-EZEivWNQU1TqYvw>
    <xmx:tmBiYuYepDwwHkDvG9_CMQRGk1zo0Hc9FKYJ8tR4E5AmFMGXhNxM1w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 04:00:53 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id 18F57316; Fri, 22 Apr 2022 08:00:52 +0000 (UTC)
Date:   Fri, 22 Apr 2022 08:00:52 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Failures in t9001-send-email
Message-ID: <20220422080052.diovj33bfnra62uv@eve>
References: <20220421194832.lshqkl3bogy2f2hy@eve>
 <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
 <20220421223843.6z3y4bnrbu76erhk@eve>
 <36a43fbb-92af-3718-f2fb-51645564a961@kdbg.org>
 <xmqq7d7hd31g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3svzkkkyzsxrvd7v"
Content-Disposition: inline
In-Reply-To: <xmqq7d7hd31g.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--3svzkkkyzsxrvd7v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2022 at 11:51:07PM -0700, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
>
> >> I had a look at the tests to try to guess what was wrong, but I didn't
> >> come up with anything.  Any ideas?
> >
> > You run ./t9001-send-email.sh (without `prove`). Add -v to see some
> > verbiage from the tests, throw in -i to have it stop at the first
> > failure (so you don't have to scroll back to find it), and add -x for
> > additional traces of commands that the shell executes (to see the exact
> > command that failed).
> >
> > IFAIC, I always go all in, i.e., either all or none of -v -i -x.
>
> Good suggestion.
>
> I rarely (if ever) use "-x" myself but another useful thing to know,
> while learning how the existing test works (i.e. studying a working
> test, not debugging a broken test) is to use "-d", possibly together
> with "-v", which refrains from removing the trash directory.  Then
> you can go in and examine the state of the test repository the tests
> left.

Thank you both for these tips.

I was able to determine the issue by running the test with -vixd,
noticing which command failed, and then trying to set up my shell
environment manually to match the test's (PATH, PERLLIB,
committer/author info, etc.), and ran the same command with the leftover
trash directory.  This produced error output that didn't show up when I
was running the test (not sure why) that gave me a line number in
git-send-email.perl.  I noticed that it was trying to load
Term::ReadLine near that line, and I didn't have that installed in my
development environment.

Now that I have that installed, all send-email tests pass.
Thanks again!

--3svzkkkyzsxrvd7v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmJiYLIACgkQ+dvtSFmy
ccC48g/+ITtNkeEarsYs1Vw0oP4mbu2SAMQGT0Qf3BLXwIWJgmWa8beKNqOX0VpT
0JRLfunSpXBY400unFzYFvZNZXMTTmqZi9tKEgaCc4wXn4N9zDs+zBnewPgLuqqu
KR/c42F069/Se8lXIxXDeciQCQNDO491lC8GbW4AN6EB9UWfS+PQypj23Fc+GtXb
diIppZNosh5rhvymyyYxv/pUWfgEB0PejKQDWn93zb90wLVDL06qoBRP5SEGu8Zr
7WQ2PhGRH6j6urcap/yUQV82pctMkSLCAqfDmnS7AD3PdOqbQO6jtmucJQmlZUgk
lt+shNcjCA7QrWe/xHE+YarI0SyT8feB455rn9xmwPqzOo1pi4xBM45ANiFOvJ8z
DjML80QVUd+ZyTktDYGE4Cc0ECfspsQR7u3q0Eos2p54PIwauQO5aX9qICrFfZWG
0eHJSujYYoGbt95xvTpmCbPZCbItiUCV2JgSQBTmxCLqnwWNEXCmCIvWI+eNI2EK
jdTft4eBODexP1PU+KGsGbslA3mlOQFVCdcLmJz77s58uecaZsr7siNUWu7sYU7S
F0jH6o12RiaPgn24qE8C0MZFHtY/azxV1c3Lluu+jEB3G+ECDT+SPDyHGLMGJHXi
05FmJ/Og2UBt6tNC0QhTuQ6azeshqz1ge5XlnJTHr8RaPjbPxLc=
=RJJ9
-----END PGP SIGNATURE-----

--3svzkkkyzsxrvd7v--
