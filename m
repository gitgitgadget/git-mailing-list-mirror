Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00D90202AA
	for <e@80x24.org>; Sat,  2 Mar 2019 22:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbfCBWPg (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 17:15:36 -0500
Received: from mail.farhan.codes ([155.138.165.43]:58361 "EHLO
        mail.farhan.codes" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbfCBWPg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 17:15:36 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Mar 2019 17:15:36 EST
Received: from pc.farhan.codes (pool-96-241-220-104.washdc.fios.verizon.net [96.241.220.104])
        by mail.farhan.codes (Postfix) with ESMTPSA id 906199CBF
        for <git@vger.kernel.org>; Sat,  2 Mar 2019 17:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=farhan.codes; s=mail;
        t=1551564515; bh=YiyYk4PY5abbaYNkftC9a/HCdSvTqFJNsU7G8aRA2g4=;
        h=Date:From:To:Subject;
        b=eGI9FtE9FdhOIh8SzfoUUVgVPR2laLCc5uMFcXH9RLawIZ8+XqsnJASwX8ipZyUB7
         Sxt7XJpxDclGmGq0EZQCkkRRQaNA2mECAwOEMFqCaQ+v9a78ul9sZo31XnPogBKPyc
         LloNYUCbab5Y8zAq4X5COZkmbWcsKWxGf1HUw13c=
Date:   Sat, 2 Mar 2019 17:08:35 -0500
From:   Farhan Khan <farhan@farhan.codes>
To:     git@vger.kernel.org
Subject: How crc32 value is calculated for deltified objects
Message-ID: <20190302220835.GA12793@pc.farhan.codes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I am trying to figure out how the crc32 value is calculated for deltified
objects.

It appears that the crc32 value is updated in the use() function. After
calculating the header, the unpack_raw_entry() function will call
unpack_entry_data(). This function inflates the delta object and calls use().

My question is, does it update the crc32 value with the deltas or just the
undeltified object? And if my question implies I do not understand how this
process works, can you please explain to me how the crc32 value is constructed?

Thank you.
---
Farhan Khan
PGP Fingerprint: 1312 89CE 663E 1EB2 179C  1C83 C41D 2281 F8DA C0DE

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEG8zEBbZbSkdr8t3eZNYqKtDTorUFAlx6/tkACgkQZNYqKtDT
orUCXQv/a+AytY9wLnTusovyIDrYWyCWg03B81lWyMJbybSZz4tJxu0RUs8z1rmQ
NbIM+aAiXg4IAOr4JtsryGDfs6qfSXhbzRqJoTIwPsmJAeSymZC7vLJ9sL5ubuz0
atlKqun1r7jgvZslL94QTtToJgy19PrMnKJIXDO1fzFpY0Ii0WbUnPk3K5nc768N
0dqrh39UaiPJ6YkCxxpX7wE5FdTJh0987c/mV07123EzFh4p1h7mH91Cb+AKYTDY
LnVQv9EXRrh6/bZ6PdEOYpvtFE13giguUqT3cM3+H2w8CWagjSlxGJUTylXRZArM
qeVeKsdcXBA5/rg1MrQi2bBJ8g/YSvkMwPsPNFRQIavW9lUp31uTF+og6SQ9CuGT
AzX3dEXx9f2n7t4Pa4V7bnZKwbQArYuUUeumu+ezzxracbPwFU/jJBMUCfybrxVX
U74VOmkCkYhACUeFk2fLCnoLYbFL+SdTKQ+wnRX3cndNLVhHe7xbg2SA7WP4jlkD
VXbHwcuR
=ztfN
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
