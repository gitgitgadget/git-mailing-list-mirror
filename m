Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A037C433E2
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE4420675
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 09:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729244AbgGAJZj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 05:25:39 -0400
Received: from tschil.ethgen.ch ([5.9.7.51]:41236 "EHLO tschil.ethgen.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGAJZi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 05:25:38 -0400
X-Greylist: delayed 2542 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Jul 2020 05:25:36 EDT
Received: from [192.168.17.4] (helo=ikki.ket)
        by tschil.ethgen.ch with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <klaus@ethgen.ch>)
        id 1jqYKl-0002rH-8Z
        for git@vger.kernel.org; Wed, 01 Jul 2020 08:43:11 +0000
Received: from klaus by ikki.ket with local (Exim 4.94)
        (envelope-from <klaus@ethgen.ch>)
        id 1jqYKk-0005qm-QT
        for git@vger.kernel.org; Wed, 01 Jul 2020 10:43:10 +0200
Date:   Wed, 1 Jul 2020 09:43:10 +0100
From:   Klaus Ethgen <Klaus@Ethgen.ch>
To:     git@vger.kernel.org
Subject: Bug when pulling subtree changes
Message-ID: <20200701084310.GC7618@ikki.ethgen.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
Content-Disposition: inline
OpenPGP: id=79D0B06F4E20AF1C;
 url=http://www.ethgen.ch/~klaus/79D0B06F4E20AF1C.txt; preference=signencrypt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline

Hello,

currently I suffer of a strange bug with subtree.

Long ago, I did the following:
   git subtree add --prefix=stdlib https://github.com/puppetlabs/puppetlabs-stdlib 4.12.0
   git subtree pull --squash --prefix=stdlib https://github.com/puppetlabs/puppetlabs-stdlib 4.19.0
   git subtree pull --squash --prefix=stdlib https://github.com/puppetlabs/puppetlabs-stdlib 4.20.0

Today I wanted to do the following:
   git subtree pull --squash --prefix=stdlib https://github.com/puppetlabs/puppetlabs-stdlib v6.3.0

But got the following error:
   From https://github.com/puppetlabs/puppetlabs-stdlib
    * tag                   v6.3.0     -> FETCH_HEAD
   fatal: ambiguous argument '3a4414eb087da0dafa147df047f6bf8f18a6a621^0': unknown revision or path not in the working tree.
   Use '--' to separate paths from revisions, like this:
   'git <command> [<revision>...] -- [<file>...]'
   could not rev-parse split hash 3a4414eb087da0dafa147df047f6bf8f18a6a621 from commit c1118a27ef27c1fd4df7877f0b0fb606ea30f0fd
   Can't squash-merge: 'stdlib' was never added.

The revisions are fully valid:
- c1118a27ef27c1fd4df7877f0b0fb606ea30f0fd: The last squash revision in
  the private repository
- 3a4414eb087da0dafa147df047f6bf8f18a6a621: Tag 4.20.0 in
  puppetlabs-stdlib repository
- Tag v6.3.0 pointing to 990cd99 in puppetlabs-stdlib repository

The current git version is 2.27.0. I have no record about the revision
used for the pulls in past.

Anyone an idea why this doesn't work anymore?

Please keep me in Cc as I am not subscribed to the mailing list.

Regards
   Klaus
-- 
Klaus Ethgen                                       http://www.ethgen.ch/
pub  4096R/4E20AF1C 2011-05-16            Klaus Ethgen <Klaus@Ethgen.ch>
Fingerprint: 85D4 CA42 952C 949B 1753  62B3 79D0 B06F 4E20 AF1C

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Charset: ISO-8859-1

iQGzBAABCgAdFiEEMWF28vh4/UMJJLQEpnwKsYAZ9qwFAl78TJoACgkQpnwKsYAZ
9qyl7AwAvB6noq/sy6+0H5Ndihxn+kehxyllk7GjPxRyUC2VCIFywTqde1xAllE+
Mt8NMoECEZS+NBKOk1IfTTNOPrkQdiwRPexaPTYG0A/0UJUFjYgZBro8nD/yVfsQ
Tdlp/Bg1K37DKRZeggOMOwus4wg6l7IlCNSln6kqJqdNoZH/SS0Ai3m5CNgjWfyx
spisqdOuTph0keDGMl76LLyKeJOSPEA/whcFnNDNgJPPW2MwynWYk90A/rHS+N6y
848e1Kj3fNmY8JJss8yct4PRCsW50ZOWfHwLraHpYPMGjpFvaqJrmIkM++fcl1mk
1wL5lHb8YylcIs6Q9+HvW3YlAd+317QbN0gjp3gG37mcGaEV8mjruobFX2KxGzfZ
wucZnLm5xHJQY6UgC5bJpAHqD4M8h1AQFRghqay8CHrjspDy8owPMw33BpSFu0Zn
QpFLWRwjw12Y+xVtgfr97NYob3YZXv7Gbi/pw6sp5Hqifbv21BfIMVN7ubN0Jqh1
65pGqqA4
=LwEM
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
