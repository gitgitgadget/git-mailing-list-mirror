Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C77C77B70
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 05:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjDNFmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 01:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjDNFm3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 01:42:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49774271E
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 22:42:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id ACF3D5C014D;
        Fri, 14 Apr 2023 01:42:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 14 Apr 2023 01:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681450947; x=1681537347; bh=6J
        yWEQ8cPla0lp1rJiAWdU3l40S5na1R4GqAUMx58Gw=; b=IIgpT1Lqqmlku4RLOQ
        hmkDI8Amd0bb49IVSIF9XYN+9EOuUlTP5z1uJW7Q2E4qoh4q4juPcyZyEEfkACcv
        qwobOToBPAS1i4Hb/SKBdf1NHFXxGBJlszjSHYXzHmmOsrsoQGW0IFikW+fwknug
        DkhcC9lAzVirtl9NaKt0f9KOAEEJs/XcSIovylZhS/slNxKCvzWZe7sILRRYla70
        2iiqeOxvSM11htQxBlPSA8dfO98vZvFEqRgPnK+0abTOkT24wc7gg6k4YR0X+L4K
        j/C15XeJ8vGRgGiTitRrFDrNwctfQib2lWMnXAL14xr6ryOBvXfjPRicEcdWgxvy
        Z4jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681450947; x=1681537347; bh=6JyWEQ8cPla0l
        p1rJiAWdU3l40S5na1R4GqAUMx58Gw=; b=cdtRf/+iTnYVO5twrt+2ga85GYQGW
        1F/iocEJslLR33AehmqdT7titlk7NgYHWUfzl3/ZyQ6WcHrg5W1m2yCEkVs2L+9D
        RZTl5tFozqKcseferzBUYzDCK818QGR+20l4JViH6BdIWJCUAD+YOqDrIxtvzZr7
        zfYnNzZK4TpaaiXnOk3fVlUti+OkpV1HtRCWmJIbsu6xw7/IXtS1HHZ9dtBEJe/h
        pRWtXViQdR3KC6JJUKxXMMUWruzOmdmV8njG1KDbgr8D2hy0HcBqXnOcAR9PP8bk
        VeS/C3wpVuGk4taN6kEpv6IM6lR16nDvqIFHxks1KkEnJbDHzstbrv2gQ==
X-ME-Sender: <xms:w-c4ZA9UyEh4y_qBsyzdxxAJXISStKs3MiZn5o-PO-kPR0vSikfpbQ>
    <xme:w-c4ZItgm8B0kGAYTNkEmskHTsJtPYY5HvTEputNaW4pXJ0y_yRtLrHBF7IY-Swdf
    L8UJQ04Os0zUeX46w>
X-ME-Received: <xmr:w-c4ZGBVaRy_yCMZdHBp3zYSqgZxq9Nox9clTwHuEXNXx8CITJ_TGzLLQPczT4We1EOiDWdmFIyPXiu3oEUJBr7emcnGp3b-1ttdnW0HBFUioLU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:w-c4ZAcG8fSu8SrpoC83QGiDJBEpN7YCWkZpEII3xgQa8KtIgp-HcA>
    <xmx:w-c4ZFOfwbIqpNdM8CvYsiUCIbob9ISJ-o9n5WRfoqpPnD91UDNrVw>
    <xmx:w-c4ZKkEAG3SgpJHA8jfdTDjzkGJtzfaXYFPfZexa1kn7TlW-pZOVA>
    <xmx:w-c4ZGr2-pgM0UZY__zso-7DMUR5aCL0OP3l5bkLQ8xpwn9juOg3ow>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 01:42:26 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3e917a3e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 05:42:22 +0000 (UTC)
Date:   Fri, 14 Apr 2023 07:42:22 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH v3 00/10] repack: fix geometric repacking with
 gitalternates
Message-ID: <ZDjnvgFyDZb9VZ8u@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
 <xmqqv8hzusmz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PCT/DEdqhsoWLIyg"
Content-Disposition: inline
In-Reply-To: <xmqqv8hzusmz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PCT/DEdqhsoWLIyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 13, 2023 at 07:03:48PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
[snip]
> With a few fix-ups to the test script I sent to the thread for the
> review of [09/10] squashed in, this topic however seems to cause the
> linux-TEST-vars job fail when queued at the tip of 'seen' (bbfd3bf)
> [*1*].  When 'seen' is rewound by one merge to exclude this topic,
> the CI runs OK (c35f3cd)[*2*].  I dug only far enough to identify
> which topic among 40+ ones was causing the CI breakage.  Perhaps the
> code is operating correctly but the expectation in the test needs
> updating?  I dunno.

The issue is that linux-TEST-vars sets a bunch of environment variables
that change the way git-repack(1) operates. Important in this context
are GIT_TEST_MULTI_PACK_INDEX and GIT_TEST_MULTI_PACK_INDEX_GENERATE_BITMAP
as they change the assumptions that we're doing in our test. What is
interesting is that these cause us to write a multi-pack-index and in
fact a bitmap, but the warning that we're testing for is not printed.
And that's because of the following code snippet:

```
if (write_bitmaps < 0) {
        if (!write_midx &&
            (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
                write_bitmaps = 0;
} else if (write_bitmaps &&
           git_env_bool(GIT_TEST_MULTI_PACK_INDEX, 0) &&
           git_env_bool(GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP, 0)) {
        write_bitmaps = 0;
}
```

So if either of those environment variables is set we'll disable
generation of bitmaps in git-repack(1) in favor of enabling them in
git-multi-pack-index(1). And consequentially we don't see the expected
error message.

Anyway. I think what we should do here is to simply override the
mechanism with GIT_TEST_MULTI_PACK_INDEX=0. Other tests in this file do
the same already, and it does make sense as we explicitly want to test
the non-multi-pack-index scenario. And given that we already added a
test for the with-multi-pack-index scenario in the same commit we don't
really loose any test coverage there.

Patrick

--PCT/DEdqhsoWLIyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ4570ACgkQVbJhu7ck
PpRCqxAAonpBYr29PW+LovvkN3P+DeB1AokZRlbEMaM+weCDq2AIfmiykrKKpEZD
p7lL3CdbK61ZsEZIHMTeZ/54tNsmBtVFOBpfgBTKbkxaNfSNZRaVpdx62sdcK/gk
bubeypiTrhivkgh8PxrmUEj+vo32f2Z9lI7o9LYGlvcx3wcg6griw8q78DunQ1Ss
glvRvEf34rGluNYNpguE3bKUxVNAR0zBXExWb1w5kM/+dM9bJS9Nr+3GMZYluDE7
72yJbHb2Cd7NhtIqgLcvSx7cJwASD2o603zBmEubMa+3F1zIC4JilhTcJ63rRS/k
+ZWG7cyH1Mt20DUW/Sl0/ejr0FIoAMY59qNqP9mCxSU96eOuzzGUNAY4VCum8b0I
oXlB0Ie4pWEvxsln98t8JpUqzjRlpHbooiU7hhTD7LljFNSSKJpwYXaBOHzGEy9r
OCVtmfRN+sNg3NI+vvtN48IFQ58OiwRzMxdtkNr21SJKhBjOnp1J5z6wgFwWqEYM
+YSDdwni8UYMZZKCKS0pQinU7ueJ1WV1RL8nrudjq0Q03hcKYy3rmnA9tU0A085r
bjWuVKdU6Dyn9UDOiC0+nY+8+7+bjUJMfaLgvwhiU11PlePSK8Keo6FfNYpGReXR
gp+V/yKn+Dq/SQ9HHtwOfyD3oOcD0Q/zghfKfXdtCORJaq+CAcY=
=/okF
-----END PGP SIGNATURE-----

--PCT/DEdqhsoWLIyg--
