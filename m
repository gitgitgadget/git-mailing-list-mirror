Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDC821F453
	for <e@80x24.org>; Wed, 13 Feb 2019 12:15:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfBMMPD (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 07:15:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46378 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbfBMMPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 07:15:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so2178133wrt.13
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 04:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=Yox6ElR7baQpg9Gl+hxTio8XSa5IMgUYkKm8qaKyx7g=;
        b=EqLMgN5MfEPcyyr4klV4DP9TlIYzWXIbQSl8J2MrwkGQCreqTXiD3j/gBMHibkvVti
         Xd7v1MjghBK9/8P5yJppmrLZgXJfHtSQ5+evpR/IAJPxfteB0A9IeStqKY98S5fNYKmO
         t3G4VmAHnfPBqQNFN2MpCgeoBVVMluDYQ97I0CYppkALR4ljqzV7ZGUriZIGtPGKTdFd
         qInIcdshw/732A95miKGHKM4Wjrrpy4GM+7if43QQc59FWCaU1jpb21in2kFFMLea9Dw
         aC6JKNxj02hVENGtI/xXU6pCr+TyvW/IwK9//IV/vKm1DA/MT1UCQpsY9nEs1LBM38gO
         Thzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=Yox6ElR7baQpg9Gl+hxTio8XSa5IMgUYkKm8qaKyx7g=;
        b=M9J176MjrTRZ7TrlOJpXSYXO1KxchOfm3z5POFSAvAnVk4aEeuDFn1J9uPFK5slXQl
         s0bW5LCJE1U3OZgaZJC18EYQ4JDEA7ZRStnUXLyJg/j8oI8FqamZQ+m7WdlhtfCImCWa
         2evbPeAbF+7ExnS2SCJ623yHl5AEPXulr78x0YdHiFXSVfv1b3HvWchFZsjSFSWChcom
         8Uv3Ja1eo77NHVqIt4bZqCjcbKMRzD+Lyd7GsJ48Oqjn3Y2inzDGxDcnrRAlzJeHPKK5
         tfJT/vpCQETeH2m4tbRbjzOmlY7IG/QFU4gMAXLL0G+p/IQ3JLDaeKi37XSJQcwMLwaU
         7yDw==
X-Gm-Message-State: AHQUAuaSXDzq5UM7HXHdMsLntrRrzDN51uC9eTyZBclaUDbjE8h6zCDz
        OdbGHxajhUzuaIuLw5maweU9M8llOwk=
X-Google-Smtp-Source: AHgI3IYrcpirFGYIuQwHjj8fpZQRCIV9tOR0hlShyifdDTRn6GV2SXHVhY8zqCEXoQvqTGn0bGoRfg==
X-Received: by 2002:adf:ec8f:: with SMTP id z15mr171134wrn.290.1550060101182;
        Wed, 13 Feb 2019 04:15:01 -0800 (PST)
Received: from evledraar ([5.57.21.48])
        by smtp.gmail.com with ESMTPSA id h142sm4845738wme.33.2019.02.13.04.15.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 04:15:00 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        luke@diamand.org, newren@gmail.com
Subject: Re: [PATCH v2] read-cache.c: fix writing "link" index ext with null base oid
References: <20190209112328.26317-1-pclouds@gmail.com> <20190213095129.31272-1-pclouds@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190213095129.31272-1-pclouds@gmail.com>
Date:   Wed, 13 Feb 2019 13:14:52 +0100
Message-ID: <87imxnkhqb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 13 2019, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> Since commit 7db118303a (unpack_trees: fix breakage when o->src_index !=3D
> o->dst_index - 2018-04-23) and changes in merge code to use separate
> index_state for source and destination, when doing a merge with split
> index activated, we may run into this line in unpack_trees():
>
>     o->result.split_index =3D init_split_index(&o->result);
>
> This is by itself not wrong. But this split index information is not
> fully populated (and it's only so when move_cache_to_base_index() is
> called, aka force splitting the index, or loading index_state from a
> file). Both "base_oid" and "base" in this case remain null.
>
> So when writing the main index down, we link to this index with null
> oid (default value after init_split_index()), which also means "no split
> index" internally. This triggers an incorrect base index refresh:
>
>     warning: could not freshen shared index '.../sharedindex.0{40}'
>
> This patch makes sure we will not refresh null base_oid (because the
> file is never there). It also makes sure not to write "link" extension
> with null base_oid in the first place (no point having it at
> all). Read code already has protection against null base_oid.
>
> There is also another side fix in remove_split_index() that causes a
> crash when doing "git update-index --no-split-index" when base_oid in
> the index file is null. In this case we will not load
> istate->split_index->base but we dereference it anyway and are rewarded
> with a segfault. This should not happen anymore, but it's still wrong to
> dereference a potential NULL pointer, especially when we do check for
> NULL pointer in the next code.
>
> Reported-by: Luke Diamand <luke@diamand.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
> ---
>  v2 added a new test

This round looks good to me. Passes all tests with/without
GIT_TEST_SPLIT_INDEX=3Dtrue

>  read-cache.c           |  5 +++--
>  split-index.c          | 34 ++++++++++++++++++----------------
>  t/t1700-split-index.sh | 18 ++++++++++++++++++
>  3 files changed, 39 insertions(+), 18 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 8f644f68b4..d140b44f8f 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2520,7 +2520,8 @@ static int do_write_index(struct index_state *istat=
e, struct tempfile *tempfile,
>  		return err;
>
>  	/* Write extension data here */
> -	if (!strip_extensions && istate->split_index) {
> +	if (!strip_extensions && istate->split_index &&
> +	    !is_null_oid(&istate->split_index->base_oid)) {
>  		struct strbuf sb =3D STRBUF_INIT;
>
>  		err =3D write_link_extension(&sb, istate) < 0 ||

However, it looks like you based this on a pre-2.20.0 version of
git. This conflicts with read-cache.c earlier than 3b1d9e045e ("eoie:
add End of Index Entry (EOIE) extension", 2018-10-10).

I fixed that manually, and pushed it out to github.com/avar/git.git
duy-read-cache-null-split-index-fix, that's what I've tested on top of
current "master".
