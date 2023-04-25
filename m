Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B8AC6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 17:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234687AbjDYRz6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 13:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjDYRz4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 13:55:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C62CC1F
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 10:55:54 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id BC1A8320090F;
        Tue, 25 Apr 2023 13:55:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 25 Apr 2023 13:55:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1682445351; x=1682531751; bh=Ce
        hVDW3feiGAM5F0lCnd2gItNox2tKmBK6O6iJuIVrQ=; b=q5IoHXch1QvV8tg03m
        2Zm1oHFd/5M1DQecD7XXGHO9UH+JZ7QFXpGLipds1SB0O+EwSVHsTVO9s256alyM
        bFw4G+Q5a8yMmriFgady0CUJgSQxwRCN01uC8ME0kmKwKCTgMoovvfSq+RNeblXP
        kYCm8/Aq5tXB83xhdrJSK6CtFt1TS/8zL3N43yZtCcs4rc6+l4B6JvxctR2mfET9
        cN3Q8QV4uyOVNmF5CZAHnIRmZmLDOb7m/8WvG+OxYKqdQhuiGf8od83/oFiBr/Nv
        m2YtJqroZkDY+sUsgp7U+25h8x9fojookNZqAo+OrnXpXWf5LWCdRx2cgizRUX/8
        pS9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1682445351; x=1682531751; bh=CehVDW3feiGAM
        5F0lCnd2gItNox2tKmBK6O6iJuIVrQ=; b=IiRRI9LzoMTnqjK0SfUGmibFf1DQn
        X35u553xC/lGXK6Tze21PIxCknwGzOLwi3Xs+zWAssTZCF1cwolWE2T4llAVszeb
        R4qwLhWl1m79op0RbUV7V0T6x0ATOCWgCrKqiG6lSm2If5hiL8PoJ7VLtED1BKX5
        Btp705QX9vX7gK6jFaspJOP/rIRZApGnTCnrjFMiSpLKC8nUYEpCXBGVqRfnbcAi
        qK9KNBZAPokLmhaPtUOBuaaabBJQtiAqwqpZR7rFEcvR212wY/hz7ivmZSkT1Ppc
        5/x/mxZcp9B7hpup7bpKPQzX0zSAgxn8gk3Z3kZHdAcXMYACMpUoBzqoQ==
X-ME-Sender: <xms:JxRIZFwPn36QO14zNsEUg5x0Ky44o3wQWamVhhw3o0KUn7doks7kBQ>
    <xme:JxRIZFROTAoIaYDkuJkPn2yavdaS16psmNsorCeqwHRMIuiQ8l06mA3sXrYJnp07U
    ph1ZoKWHsmodf_SVA>
X-ME-Received: <xmr:JxRIZPUprfVxHtitSG_-A4O9mQnHujbJ52yUv9Fw9IkKBXUmijFau8s5YFy9XiCkR_RikThpL0NzbG-6ZG5fMz-nMqLpvegXOD5MwX0bCXQr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeduvddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeehfefhuedtvedtfeeiteeugefgfeelgeelveehffeukeelfefhieekteevudfh
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:JxRIZHhnLJcOsiy5IgRm5-tciX-JydU0OuDjS003rKN96D6o6yNG7A>
    <xmx:JxRIZHCiwfFFf9QlnWWrjEjL5JlZ0IU11pIsrq0KbBHy4eBa_HpBlg>
    <xmx:JxRIZAJmiUdmhqGS79vO2HmmjELk9LRVt_b_nu3YI5W4kgdUsSdXWg>
    <xmx:JxRIZKqwF5wBOqhZ7worE3T4EbF4CVzHC943FKjyNVv9C4EV2jDOPQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Apr 2023 13:55:50 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ca225566 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 25 Apr 2023 17:55:23 +0000 (UTC)
Date:   Tue, 25 Apr 2023 19:55:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: Join us for Review Club
Message-ID: <ZEgUIiLgrTJWNFlo@ncase>
References: <kl6lv8hk997v.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="K9auflCHvJn8wHwB"
Content-Disposition: inline
In-Reply-To: <kl6lv8hk997v.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--K9auflCHvJn8wHwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2023 at 04:00:36PM -0700, Glen Choo wrote:
[snip]
> This week, we'll be discussing Patrick Steinhardt's "machine parseable
> git fetch" topic [3]. Let me know if you're interested and would like to
> join (off-list is fine), and I'll send you an invite.

Thanks for the interest in this patch series. Unfortunately I will not
be able to join, but I'm looking forward to any feedback!

Patrick

--K9auflCHvJn8wHwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRIFCEACgkQVbJhu7ck
PpQXyQ//VJNdtDXJWiKXcBS5u2M5Ne8vIXsG1HLD1aeZg5SFZ6JuPEUaPa5ri99m
hucB1R1gHYwKCGHMdYOi+Tp28hnLO3d26DrGqQDiYM6/C83ulZpOIio0gpKW2rQ8
1EaCmQD9/7qsq88cIxFiXkW1xUCq/PsZHwcRvctJF3Nqj8GwhsvnVClil4o9ZkWn
M9FJs9O+ndJ9p/pu52/5A9HjUm5RKmMB6sq/PWVEo9h3QYBOeBehybQ9oNrJbCJD
JiHcfCS/nt0SrM6uDQGjL16FWe4xdz2vZCyFsiqAWSGZa/EIoIQQWQ/jYI4Ei9sa
qTAUQBDOUMkKOGPjCye9XGXzi23REZrvqvxpcuALltDhQ2P8VGoPHjmneOwkf79o
ztfVL/nl7flBmizR6KOsTNQnqI4rT6dKCbYO0eE93/ZrqonrENRWx0g0KfF7vMBI
Wu5R0rjcQ+VvGP0CAexH8loZdV4umSriSK34otAMLO/Ds48VtPrtBrtoVir8y/vl
+SPDE/HtodGucqaSJqPqnSmvfTu8w3QHgJwLQy5jV0btBDfae17OtNF2RnOgo1eU
rc7DXEp7k6sY7UZ1sF7yQTRmTWtqV9+TNk17s6NH0rre4rN5k0qLMAqBEdIAhUBl
PYO4mvRtzNycrxkp3An5pBHlV11wveG4s7ttahWBkkqE3wfdDUs=
=IjXs
-----END PGP SIGNATURE-----

--K9auflCHvJn8wHwB--
