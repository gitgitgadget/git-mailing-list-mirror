Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018AA20248
	for <e@80x24.org>; Tue, 26 Mar 2019 17:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732007AbfCZRgD (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Mar 2019 13:36:03 -0400
Received: from che.mayfirst.org ([162.247.75.118]:36695 "EHLO che.mayfirst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbfCZRgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Mar 2019 13:36:03 -0400
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/simple; 
 d=fifthhorseman.net; i=@fifthhorseman.net; q=dns/txt; 
 s=2019; t=1553621761; h=from : to : cc : subject : 
 in-reply-to : references : date : message-id : 
 mime-version : content-type : from; 
 bh=zwmQUN+n6WOeYXwSpp0PZnPIuyMwOe1fRmOOrY6S6gU=; 
 b=/sRgT5JhjDLpvKznD35ltpTJrVVLaAk9ly/gIABP3nX7LTold6LIwAuM
 XWiDwqtMErpQ9v0y90wrd8pGnDTMDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fifthhorseman.net; 
 i=@fifthhorseman.net; q=dns/txt; s=2019rsa; t=1553621761; 
 h=from : to : cc : subject : in-reply-to : references : 
 date : message-id : mime-version : content-type : from; 
 bh=zwmQUN+n6WOeYXwSpp0PZnPIuyMwOe1fRmOOrY6S6gU=; 
 b=AcQizPJ3fwlWH3H3hF+NXjdwaExYZwWwrlCQfKt/vGzJvnjTpzw0PcIy
 j/BzHo5HC04tiy0iKnsfwa2TJsbUcnWq54AGFKziilBdrRCGgkVFhwF0y/
 75OGn1wm8i1yCoNmlhtjy/Z+4eLoehbyD7ecaU0miupK2JLzxZlGQlIutl
 l+HL+93KEGrvoz2AlLj7lXq2DL8eCxFMuHhy/7UpCvXcIPLSptEes8YJwv
 RoJWBWUdBxj2kx9PREPGceg3pE/Qhx6Ck+6M5W5iJlR3RsvJ+kLIp6Qpda
 qo5aNhzXmaQ0QhiWgY47iNtvsukl/hp4IOpnDCRdIROb4je0082XCg==
Received: from fifthhorseman.net (dhcp-8363.meeting.ietf.org [31.133.131.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by che.mayfirst.org (Postfix) with ESMTPSA id 98166F99D;
        Tue, 26 Mar 2019 13:36:01 -0400 (EDT)
Received: by fifthhorseman.net (Postfix, from userid 1000)
        id 804BA20707; Tue, 26 Mar 2019 13:35:57 -0400 (EDT)
From:   Daniel Kahn Gillmor <dkg@fifthhorseman.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git tag -v should verify that the tag signer intended the same tag name as the user is verifying
In-Reply-To: <xmqqh8brofid.fsf@gitster-ct.c.googlers.com>
References: <875zsdu41d.fsf@fifthhorseman.net> <xmqq5zsduinf.fsf@gitster-ct.c.googlers.com> <xmqq1s31ui5s.fsf@gitster-ct.c.googlers.com> <87imwbmqpg.fsf@fifthhorseman.net> <xmqqpnqgpifu.fsf@gitster-ct.c.googlers.com> <87k1goia52.fsf@fifthhorseman.net> <xmqqh8brofid.fsf@gitster-ct.c.googlers.com>
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
Date:   Tue, 26 Mar 2019 18:35:57 +0100
Message-ID: <87ftr9h72a.fsf@fifthhorseman.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon 2019-03-25 11:27:06 +0900, Junio C Hamano wrote:
> Daniel Kahn Gillmor <dkg@fifthhorseman.net> writes:
>
>> What do you think of my updated proposal for tag.verifyNameMatch ?
>
> Meh to slightly negative for hard-coding project-specific preference
> to the core tools.  "We give you --format so go wild in your project
> to do verification your project likes." I think was the conclusion of
> the previous round of discussions, and I do not think we saw any new
> arguments in this round to rethink it in a different way.

Hm, maybe --format is all that's necessary to resolve the concerns about
errors affecting scenario (a) ?  If that's the case, then maybe the path
forward is a warning on tagname mismatch (and maybe i can convince you
later than an actual error could be acceptable :P)

But I don't see how to use --format with "git tag -v" at all.  Can you
show me what i'm doing wrong?  git-tag(1) says that --format defaults to
'%(refname:strip=3D2)', but git tag -v behaves differently when i specify
that same default explicitly:

    0 dkg@alice:~/src/pkg-gnupg/gnupg2$ git tag -v gnupg-2.2.13
    object 7922e2dd1c7eee48a8a2cf4799827942489ddd0f
    type commit
    tag gnupg-2.2.13
    tagger Werner Koch <wk@gnupg.org> 1549985965 +0100

    You may want to watch the Ellsberg/Chomsky discussion
    at <https://riseuptimes.org/2018/04/25/daniel-ellsberg-and-noam-chomsky=
-discuss-nuclear-war/>
    or at <https://theintercept.com/chomsky-ellsberg/>
    gpg: Signature made Tue 12 Feb 2019 04:41:32 PM CET
    gpg:                using RSA key D8692123C4065DEA5E0F3AB5249B39D24F25E=
3B6
    gpg: Good signature from "Werner Koch (dist sig)" [full]
    Primary key fingerprint: D869 2123 C406 5DEA 5E0F  3AB5 249B 39D2 4F25 =
E3B6
    0 dkg@alice:~/src/pkg-gnupg/gnupg2$ git tag -v --format=3D'%(refname:st=
rip=3D2)' gnupg-2.2.13

    0 dkg@alice:~/src/pkg-gnupg/gnupg2$=20

What am i missing?

     --dkg

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQTJDm02IAobkioVCed2GBllKa5f+AUCXJpi/QAKCRB2GBllKa5f
+Fn8AQCR/mq7k89e43//3L96rz4GjXnLB5gPQ8IDqeyvc/LTNwEAxKjhQLBtHDZG
kUw/uDbEhneSJRuCfqkTIT5WcWwGegc=
=H2C3
-----END PGP SIGNATURE-----
--=-=-=--
