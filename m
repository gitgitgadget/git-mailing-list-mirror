Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 567E420248
	for <e@80x24.org>; Wed, 20 Mar 2019 12:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbfCTMda (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Mar 2019 08:33:30 -0400
Received: from che.mayfirst.org ([162.247.75.118]:58799 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfCTMd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Mar 2019 08:33:29 -0400
X-Greylist: delayed 503 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Mar 2019 08:33:29 EDT
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; 
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; 
 s=2019; t=1553084705; h=from : to : subject : date : 
 message-id : mime-version : content-type : from; 
 bh=ioCziOzqWC0rjOk6y0mjxVa698q5421dqd66R9DFgws=; 
 b=WvCcxAGFfWpXa4XUoZA8QIdlZJdg4SJ3rZ5DKV3tyM5B92t5gmaBeJhE
 V9v0G6xuqU4QZVy76LlckSA5r1aLCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net; 
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1553084705; 
 h=from : to : subject : date : message-id : mime-version 
 : content-type : from; 
 bh=ioCziOzqWC0rjOk6y0mjxVa698q5421dqd66R9DFgws=; 
 b=OJlRxVOpQ8MFJtVhr4X1dMwedefEz2im1r7ZsHrSlLc/gV6QG++tvAnu
 kkaf5Aijwlu1q8KkVzStguua5XSyMrzkLlg+j8dS48XJhzXNWifhAxQ35h
 izkTceMdz+pEfmZBUJWXRfOGoo4n5jKocbSS99sZlMx9UjlbDPA6rO8LU9
 Y8Jf55irs5pRIjVQRXvhhgmIv9zZKdOtQNhy716qQo7CGnOe2p2dvXGQYC
 Gf5juveQAbEmOUUw+13+XTzPRUFyAHbWmCwWsJRednfMnyp6VAKbrWilg3
 p2BYJh+gORFVLV6HOPi9cTtbHFc3tFgmGpVuCTgmEFIel/LYt2I2cA==
Received: from fifthhorseman.net (unknown [IPv6:2001:470:1f07:60d:20b6:84ff:fe8d:8441])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id 736D3F99D
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 08:25:04 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id C9AC220420; Wed, 20 Mar 2019 08:24:46 -0400 (EDT)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     git@vger.kernel.org
Subject: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
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
Date:   Wed, 20 Mar 2019 08:24:46 -0400
Message-ID: <875zsdu41d.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain

Hi git folks--

I understand that git tags can be easily renamed.  for example:

    git tag push origin refs/tags/v0.0.3:refs/tags/v2.3.4

However, for tags signed with any recent version of git, the tag name is
also included in the signed material:

    0 dkg@test:~$ git tag -v v0.0.3
    object 8ae6a246bef5b5eb0684e9fc1c933a4f8441dadd
    type commit
    tag v0.0.3
    tagger Daniel Kahn Gillmor <dkg@fifthhorseman.net> 1528706225 +0200

    this is my tag message
    gpg: Signature made Mon 11 Jun 2018 04:37:05 AM EDT
    gpg:                using Ed25519 key C90E6D36200A1B922A1509E77618196529AE5FF8
    gpg: Good signature from "Daniel Kahn Gillmor <dkg@fifthhorseman.net>" [ultimate]
    Primary key fingerprint: C4BC 2DDB 38CC E964 85EB  E9C2 F206 9117 9038 E5C6
    0 dkg@test:~$

But git tag doesn't verify that the internal name is the same as the
external name (note that it still returns an exit code of zero):

    0 dkg@test:~$ git tag -v v2.3.4
    object 8ae6a246bef5b5eb0684e9fc1c933a4f8441dadd
    type commit
    tag v0.0.3
    tagger Daniel Kahn Gillmor <dkg@fifthhorseman.net> 1528706225 +0200

    this is my tag message
    gpg: Signature made Mon 11 Jun 2018 04:37:05 AM EDT
    gpg:                using Ed25519 key C90E6D36200A1B922A1509E77618196529AE5FF8
    gpg: Good signature from "Daniel Kahn Gillmor <dkg@fifthhorseman.net>" [ultimate]
    Primary key fingerprint: C4BC 2DDB 38CC E964 85EB  E9C2 F206 9117 9038 E5C6
    0 dkg@test:~$

This seems troublesome, as I expect there are many scripts that rely on
the tag name and the return code of "git tag -v" to assert that this is
a correct tag.  Anyone in control of the above repository could pass off
an old tag (or indeed, a tag from an entirely different project that
happens to be signed by the same author) as whatever version they wanted
to, and convince automated scripts that work with new versions to
"upgrade".

I think "git tag -v" should be more strict about what it needs to "pass"
a verification.

At a minimum, if the internal tag name (the line matching "^tag " before
the first blank line) doesn't match the tag name being verified, "git
tag -v" should report a warning to stderr and return a non-zero error
code.

What do you think?

i'm not subscribed to git@vger.kernel.org, so please keep me in Cc on
this thread, thanks!

    --dkg

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTJDm02IAobkioVCed2GBllKa5f+AUCXJIxDgAKCRB2GBllKa5f
+EB4AP9GJY2SytVOEutt94u0Ls72CJlsMD3I2hT6g3xC3bcmIgD+LsB2Y7hoTYkw
THYEUqStfgGy0W+6LR3qPJN5m1GxWg4=
=yQbs
-----END PGP SIGNATURE-----
--=-=-=--
