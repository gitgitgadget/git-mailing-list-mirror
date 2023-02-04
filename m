Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FE6C636D3
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 17:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjBDRqi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 12:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjBDRqg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 12:46:36 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620422658E
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 09:46:35 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 509055A1E1;
        Sat,  4 Feb 2023 17:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675532794;
        bh=z5iVgTvmQLbPD8Aa34Y7yw4lw14f9xZEWDe4xlcGayU=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=NnkmdYlKTbXd4r2Giu1UDcs7CRzvtUoF0ncrjq7z8zvUldjyWFhs53SFmNOR1K2d6
         iUp3HmAvk2YNL4W3NkNadOhdfaOIHa3gmPMGqC3XeSwuYRQbKoONCvjWGxcuJ57suQ
         NnGNppU8cAKZsZiL+XYXPc935L/wwpA6t0D9CVtTsiEHB/6gaeB+SVDqg/zrW3ozLP
         092PxVrExDCb+mmcQ+RoRzsWL/Y/LTSE5D9Wt3OFl/Kf80p2tHmSFD05zdlIi7hIH2
         b/oHTOIwZ5EfCrQXnAW0obV9JVG0lijBCPMcgrRrIz1MfJcdDaL9HKHkHp4UpDr/hV
         KmGC19hpJTRlxRv9bOUTfZL3m9eVCBWoVFhhpN6d4jUms6AMbGXKKwEoY4tbPb7KpU
         NoQU1DJw2UM7Kh3cltksAQIzHEyeVUcMSvgQoTJVaMUWg7/IaE/jheyISW5e8yu2r5
         I8CCE6BKPB35RbMmQKkR+f521GFGcXMzcL6dB7wjBcBAdTzRZr9
Date:   Sat, 4 Feb 2023 17:46:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH 9/9] git archive docs: document output non-stability
Message-ID: <Y96Zbttj+VzsSz+w@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Eli Schwartz <eschwartz93@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
 <patch-9.9-b40833b2168-20230202T093212Z-avarab@gmail.com>
 <Y9uPhPnNFlCju8Fo@tapette.crustytoothpaste.net>
 <xmqq1qn8vxej.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="funelK6qEA+qbHlG"
Content-Disposition: inline
In-Reply-To: <xmqq1qn8vxej.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--funelK6qEA+qbHlG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-02-02 at 16:34:44, Junio C Hamano wrote:
> There shouldn't be cross platform differences to break bit-for-bit
> stability at least for "tar" format, as we do not rely on any
> external library.  Can we say the same for "zip"?  I thought we
> throw the blob at git_deflate_*() so the exact bitstream is up to
> the libz implementation?

That's also true.  There, we can't use gzip, so we do whatever libz
does.  For Zip, I believe we embed a local timestamp, so the output is
also dependent on the time zone.  I don't know enough about the Zip
format to say if there are any other things that may vary.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--funelK6qEA+qbHlG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY96Z+QAKCRB8DEliiIei
gThIAP9tOClUT2QBOs/RtyBixA+71fUNc13309f8sWTfZl1z6AD/cUTY8W58rrC6
cfWG4nOM0+6qGgvsG4Ii3FmzNwN/qA4=
=SqT1
-----END PGP SIGNATURE-----

--funelK6qEA+qbHlG--
