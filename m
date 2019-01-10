Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04C941F803
	for <e@80x24.org>; Thu, 10 Jan 2019 21:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbfAJVst (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 16:48:49 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:45901 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729265AbfAJVss (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 16:48:48 -0500
Received: by mail-wr1-f42.google.com with SMTP id t6so13023840wrr.12
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 13:48:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ANmYpFB0zgexBNVbP+gyw5qJKqjnXih5O1SUPaLFYvw=;
        b=S9hjpgS8c0mUgRNB89TZPOZuGaZQZgxLlxdl0Fp0jYdRMWFMXU2iey8MFCV3iB1gqW
         f6U8X2e9kdqfDe4Aw1HO2qswCsEjWGb67P/lOo3AtfCPzuroiZfLiCzQf6iHHnU+QTbA
         QpI93WzCDyyYBBtQ2pzp5O4TIuDBRXD9+60eQlF7EJPNVqxYyDXrovR6oUk59SD6sXFH
         TSTx1DzqBhhqzRxf/meZCZJAQVboca7+54OLszMa82qfRfMA8pIoa0yNdjmMjNTKbrCW
         N8elNonNVOja5/4gwLBg75/arhyGoG2hK0QpNdBk4i9iexJtVP0cmdSPwpfSz6/k2Qhp
         T1uw==
X-Gm-Message-State: AJcUukeYa92BYv41kQpn/UJAqzZM9SOrrdoIF1tGhHBYn2ah8dZW21+A
        V0nGjD9OTW5CwaWYbGVeFtWEF3zr
X-Google-Smtp-Source: ALg8bN4hMNTWeFd5+kdymBcNrhEFtzhAl1B0yB5M/vdw3w/Cb3Q/4uFDIhYrXpK7b7394WK2ZDXtYg==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr10882332wrh.148.1547156927141;
        Thu, 10 Jan 2019 13:48:47 -0800 (PST)
Received: from localhost ([94.2.230.122])
        by smtp.gmail.com with ESMTPSA id h62sm15604524wmf.11.2019.01.10.13.48.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 13:48:46 -0800 (PST)
Date:   Thu, 10 Jan 2019 21:48:42 +0000
From:   Samir Benmendil <me@rmz.io>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Git rebase --exec cannot run git commands affecting other repos
Message-ID: <20190110214842.dfisujzv7psx2jqe@hactar.rmz.io>
References: <20190110161904.23fwbrgg7blyx3nj@uh-nuc001>
 <xmqqlg3s2wu8.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bwqprbeaxfngcd3b"
Content-Disposition: inline
In-Reply-To: <xmqqlg3s2wu8.fsf@gitster-ct.c.googlers.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bwqprbeaxfngcd3b
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 10, 2019 at 10:26, Junio C Hamano wrote:
> Samir Benmendil <me@rmz.io> writes:
>=20
>> It is impossible to run git commands affecting a different repo from
>> within a `git rebase --exec` because in that environment the `GIT_DIR`
>> and `GIT_WORK_TREE` variables are set and inherited by any commands
>> run as part of `git rebase --exec`.
>=20
> If the user wants to work in a different repository, the
> environments that tells Git about the original repository can be
> unset to do so, which is a very much deliberately designed
> behaviour, primarily to help those who run "git rebase" from a
> subdirectory of the project.

When run in a directory that does not have ".git" repository directory,=20
Git tries to find such a directory in the parent directories to find the=20
top of the working tree.

That should be the case as well for `git rebase`, is it not?


Rummaging through release notes to find out when this was added, I found=20
the following in `RelNotes/2.19.0.txt`.

 * "git rebase" started exporting GIT_DIR environment variable and
   exposing it to hook scripts when part of it got rewritten in C.
   Instead of matching the old scripted Porcelains' behaviour,
   compensate by also exporting GIT_WORK_TREE environment as well to
   lessen the damage.  This can harm existing hooks that want to
   operate on different repository, but the current behaviour is
   already broken for them anyway.
   (merge ab5e67d751 bc/sequencer-export-work-tree-as-well later to maint).

To me it seems to be more of a regression introduced by porting rebase=20
to C that was deemed to be acceptable at the time (only a few months=20
ago).

I would argue that it is not.

The behaviour is also inconsistent with running these --exec commands=20
=66rom the command line while doing an interactive rebase, i.e. when=20
changing one of the lines to "edit" and being dropped into the terminal=20
for the edit, these env variables are not set.

--bwqprbeaxfngcd3b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEO8iRpJat6BxHTtT0gmAAVevIWpMFAlw3vbcACgkQgmAAVevI
WpMKvxAAlg5lIX4xfOuL6rJDk0TXKnijQ4me20mkAEnXSPAOEL1BPfp4a/oGXnDF
HlyVmhZbHtohdbOgidvPn3WlddTcA1AusC67sjvFB0F6lcQqhBx0UjD6yykTP2Cb
JSjL+ZZh7Ky7VmyzP4tBdU+G9nRcKZRnS3rCKPrx1xKYnDBch+3qB/cDRDRGZJVq
4El+A6xf30O3IyrGkn/Qvb1fox57RR2F5/zlilx9Y8aROKo8ME3TfCaD/K5j7M98
CXU6zW9XkJioeRRHFo7Ojru9I8zFIok40r6aDqDcbd4ZHmwWHwBmZrIL7E5Yntci
qwTsn/ml02FOyyx+Bb4S1CJLZzpYIh9Zj1REFSzy61mi4IlYhhz9eXkfqe0GHQvw
WoHi5ZooqvhgdVMgui89BuXMDhdYsOJ0X6VzP0iRZwpdQH9r5LOhD51ad8RMIQia
qMF3385NlD5rZdM4DmVHVk3YVUQOMSGokxVsZYKEfqSW/fLQITiuVKX8T+0P99be
vwJxBMboJLWH5ZMloZpfm30HGDerDY215ampFiTv6N+PSs5gnmYjKJSloFqE1t6b
4PoVP/HS2r6qHq0nKE0WB5QnIqz+Zx9+MRWEmxeaErq0tKy3/LWn4tlI21QrQZO3
xRRyajMoe3E7BIuRRKseLYavtkTQg558LAScEZEAenrBC79aH8E=
=HrfX
-----END PGP SIGNATURE-----

--bwqprbeaxfngcd3b--
