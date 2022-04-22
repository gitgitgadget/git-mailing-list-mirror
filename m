Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCEE3C43219
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 07:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445407AbiDVIAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 04:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445411AbiDVIAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 04:00:01 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF1F52B19
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 00:56:40 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C9D773204B2E;
        Fri, 22 Apr 2022 03:56:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 22 Apr 2022 03:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1650614196; x=1650700596; bh=M90Rzue1xV
        uT3rXT53C0/ATRWJfEEGW2yJcWy42bqhI=; b=YT23FbGca63lYm9JzK94s8Cr4X
        R8b1aPMjG0dET7KbhJEc8C/+Yx4i3QAN1yWVaAN5dOHy/3qK4RH2Z5NYe1Qhk0kg
        eqbdiPvXS77SXjRAsh+j60eQbs0tCiubSmg2ZeBQ3TtyQoKEGF9jjMOqmoV+gg5w
        pugKaeNbL8lrNSKyJX6ngf97zb5NT+/pdOrMWuRhd9mULsesRPc2taMmmetYqST+
        2DoEjoXvNajdCDD2Np0c6BPlvxhpDmZwxG0m7BkOBf3wUN++YF5PDvh9JJrPSxiW
        cYwPaSVdsWF3PZQpC457/Ope7DShJdH8VXpvUcZoy1ZbJv9NJZ6jN9USYiZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1650614196; x=
        1650700596; bh=M90Rzue1xVuT3rXT53C0/ATRWJfEEGW2yJcWy42bqhI=; b=n
        +ofrICzD6tszOJXCW+v+rmMlmdwn1U6PZMem6k7b/ciyrz83NGgjzoZUFec9PZaY
        WwfvT5Xfd9t2DS/DEi2WBm+SmYs27Mzw9r5c1aw8HpqmaW91mkuXROUpr/fWkEpD
        RtmskkohgQN7zJYBqB87qsWSOJkKzYAC1UbF7RV2ue8Gpei0ShA1VOuFAYk2pQMj
        zXEFTMpzMpmUR4/xcm5xS+gtSFMqMKEHSsmhauBqesFrqsNKz3c9elFqxL8cFKeV
        ukWck+7+Ea6RM3h5IaRP57fFyBm0EmDHHRJ1bRmXea1xrLVUik/Yl+8ohEFBJq6I
        9jvuUBrF3FZXVgEVVBKGA==
X-ME-Sender: <xms:tF9iYghBqx050pphz-H45eVcfoW1d4KcfMBpFje3Bq8tQZ8WZvkCQQ>
    <xme:tF9iYpD8ralYI_P7zpRB4rqzFiwOelmBA9zCcXdYaJ18rL2FnxTkkkoQJLcByAu4R
    Xly9BRavLBGstinLA>
X-ME-Received: <xmr:tF9iYoFBHjwjOqo__FArQ99a8XAH0Tb3QVgVbHK82v43ANi1viw_44GhxPx8XFTifg8HxF080gXAVqy8kChHTqRDWVLC2ok>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdefgdduvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpeetlhihshhsrgcutfhoshhsuceohhhisegrlhihshhsrgdr
    ihhsqeenucggtffrrghtthgvrhhnpedvgeeifeffkeejhfdvhfdtffelteehjeelueehhf
    dvudeiueeugeeujefgtdetvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehqhihlihhsshesvghvvgdrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:tF9iYhQ2i006mwMlnqiDPZMus00CGRKTUEKhsZfIW0g1lrWUDfl0wQ>
    <xmx:tF9iYtzCj4XEhIwY0VvIbIAVb_bBQ6KxoN2AB2gap8ToeS_dphmTXg>
    <xmx:tF9iYv47_vIIhvxpu_ISrP4MMXffWhRH_21ul8lOpQVxyonI7n38yA>
    <xmx:tF9iYupvw82SILGfdS4Gc_IR28UXLho6qvByFcp7Ao12RuJfKFmMgQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 03:56:35 -0400 (EDT)
Received: by eve.qyliss.net (Postfix, from userid 1000)
        id DEA55484; Fri, 22 Apr 2022 07:56:33 +0000 (UTC)
Date:   Fri, 22 Apr 2022 07:56:33 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     rsbecker@nexbridge.com
Cc:     =?utf-8?B?J8OGdmFyIEFybmZqw7Zyw7A=?= Bjarmason' 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: Failures in t9001-send-email
Message-ID: <20220422075633.rpiteai4uwdd6jvr@eve>
References: <20220421194832.lshqkl3bogy2f2hy@eve>
 <220421.86tuam5hoi.gmgdl@evledraar.gmail.com>
 <20220421223843.6z3y4bnrbu76erhk@eve>
 <024e01d855d6$35003d00$9f00b700$@nexbridge.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d56e2vfhxhreblwg"
Content-Disposition: inline
In-Reply-To: <024e01d855d6$35003d00$9f00b700$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--d56e2vfhxhreblwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 21, 2022 at 07:19:04PM -0400, rsbecker@nexbridge.com wrote:
> On April 21, 2022 6:39 PM, Alyssa Ross wrote:
> >I thought I'd have a go at a patch, but I wasn't able to get the tests
> >running:
> >
> >    prove ./t9001-send-email.sh
> >    ./t9001-send-email.sh .. Dubious, test returned 1 (wstat 256, 0x100)
> >    Failed 15/188 subtests
> >      (less 1 skipped subtest: 172 okay)
> >
> >    Test Summary Report
> >    -------------------
> >    ./t9001-send-email.sh (Wstat: 256 Tests: 188 Failed: 15)
> >      Failed tests:  27, 51, 78-84, 123, 147-150, 185
> >      Non-zero exit status: 1
> >    Files=1, Tests=188, 17 wallclock secs ( 0.06 usr  0.01 sys + 11.66 cusr
> 5.37 csys =
> >17.10 CPU)
> >    Result: FAIL
> >
> >I had a look at the tests to try to guess what was wrong, but I didn't come
> up with
> >anything.  Any ideas?  When I run make test, every other test is fine, it's
> just the
> >send-email tests that are problematic.
>
> I have the same issue on NonStop. Not sure why, other than our sendmail is
> massively broken.
> --Randall

For me the solution was to make Term::ReadLine available in my
development environment.  I hope that helps you too!

--d56e2vfhxhreblwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmJiX6sACgkQ+dvtSFmy
ccAaxg//VE8uFVMO2wLQyC9rPrH6UVAEqxxNsl3h7xN911wW1zTApvcl3rczCAg5
a8oA/H9gyFw6HrZYqPFLMGWhOyjEBdARlvc6cG+lYdNdos2Eace5k0riPCALPGYn
gEOcrvC/3KkGA6xt9ORK+ufW+Sxk5y7axv5DCasKTn3aQeHaAwiPppc6mWDHWrXv
CDodqkdvuWxDtD9bTTsKE+qLSAgEJwRiJXRsn97mLfaf3aEzAT69NMg7oIRrRSio
gvG8VbxpSo3bYb7fmJnp8Z0Gf9k0NbTqnEwPiDFHA7I4XcrZr/rkuh0y7NM38Uis
qudUYUa0r+tkTGtFydzZ7heqaxf4Wv1EPlbYMWaHeIwkNXQOUVC9RB08/9Iggvf2
uDZndsXU3mECVXLHgsQLCr5ap9TTZjrZFv2tjjvOc7+XSs6huxt7QYfLJ6/1fCOm
DCQOVSAt6TrLgQJ5xIGEAkoNeoXTspZSZvt8YF/rHDpoDFkYxcWOOSRRdHBW1qJT
mhxXnKCefRafg2RlZM5Bk1ixOmQXT8+L3DIPjzrbSel4wLmY4WuChLCfmpE7VOsH
24qrDBvv16nsAPl/aK0X4Tw2xSGJm+hgACgihAc67/9MzoDHUriCUpYy6KM7pAhn
O7/O2o+CzlCaXCbV9GmmoK5/UtAEFJd96qAd/O4T7R6vJ7Ep6Vc=
=m9vP
-----END PGP SIGNATURE-----

--d56e2vfhxhreblwg--
