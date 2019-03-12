Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7F99202BB
	for <e@80x24.org>; Tue, 12 Mar 2019 09:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfCLJH0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 05:07:26 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37790 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfCLJH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 05:07:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15so1777566wro.4
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YFwN++5JDwW6kVh3mZ9N2buG8o6ktJlrchRut4j84t8=;
        b=qdNCyXdNmx2LhegobDpyqqCmRwlM5Ctohz96ecAvzlsv8BUpOHIKN2FIiw2fPjr7k6
         pKI1ozG14SQijDj0bITrQgHgatFSd+xvyS3ZTWDX7eultX/wBJn9q5LnW1PgItnSmLhy
         NkXVPWlQPxFWBH3EQTuPXIWGDzV4caibUYpOQumo3381nl5Iaq5Yg+Qkfz1i/ap00y1l
         drLAV37Xjw/koy3KS+VYorRvNDCff7OaIJTAunSoqgfjaD6biMTlARQeosk3PeLdmW8s
         cPG8j4KdnpzhGn3blZq05CvsPSu3W8onOIwMny+5rb4BeDjZow35ErYQpRcF4QVLG57Q
         6/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YFwN++5JDwW6kVh3mZ9N2buG8o6ktJlrchRut4j84t8=;
        b=i6ZWcfH2TyTA/vgtCguVMGaK/Fp/eeP0Wvf7v1CqWpb/XpJS0mi13CTAX/c5n57+Nt
         pc2Q6l+JT2x0i+m7PKOrwHVlO8+7n8/XfbyDCc26nNM3MbsX+w7tcHe/0e9jtBaiQ+46
         tGsczrr9/6NwYxsxhJldAfnBF03j35cs41J6ge+Lm33/XoRAxb5k7ir62K9k6OCxfXYU
         de3CUBgU7mt6Jbwk+Q002Sy3g4LGiGcx2dT/6um6xxuCfzshugbXHCLPnp49MiCs99AL
         8/XAdrqv1XD1dIFoxLwTuDN4xXo93nqJvUy3Tnjq5vr7j4V7fewEihzyL63LDkDT6aaf
         ARlw==
X-Gm-Message-State: APjAAAV4gpDSYVGJX7pEThDz1utzqRsOR502c4IsYiN9tSDPA7caFbvF
        b2DXqOJDi1aDQ9nKq947XblcRIYh
X-Google-Smtp-Source: APXvYqzADmUBpeA8IYioIIBUY/zUXbX/pW6Jyun4kAsFR2m0Fvmq46HjGHI3dz8PWWItEO81IIIz8Q==
X-Received: by 2002:a5d:5111:: with SMTP id s17mr22704690wrt.183.1552381644490;
        Tue, 12 Mar 2019 02:07:24 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id i13sm16741537wrm.86.2019.03.12.02.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Mar 2019 02:07:23 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] repack: enable bitmaps by default on bare repos
References: <20190214043127.GA19019@sigill.intra.peff.net> <20190214043743.GB19183@sigill.intra.peff.net> <20190309024944.zcbwgvn52jsw2a2e@dcvr> <20190310233956.GB3059@sigill.intra.peff.net> <20190312031303.5tutut7zzvxne5dw@dcvr>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190312031303.5tutut7zzvxne5dw@dcvr>
Date:   Tue, 12 Mar 2019 10:07:22 +0100
Message-ID: <871s3ccvg5.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 12 2019, Eric Wong wrote:

> Jeff King <peff@peff.net> wrote:
>> On Sat, Mar 09, 2019 at 02:49:44AM +0000, Eric Wong wrote:
>> > It would make life easier for people new to hosting git servers
>> > (and hopefully reduce centralization :)
>>
>> I do think they're a net win for people hosting git servers. But if
>> that's the goal, I think at most you'd want to make bitmaps the default
>> for bare repos. They're really not much help for normal end-user repos
>> at this point.
>
> Fair enough, hopefully this can make life easier for admins
> new to hosting git:
>
> ----------8<---------
> Subject: [PATCH] repack: enable bitmaps by default on bare repos
>
> A typical use case for bare repos is for serving clones and
> fetches to clients.  Enable bitmaps by default on bare repos to
> make it easier for admins to host git repos in a performant way.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/repack.c  | 16 ++++++++++------
>  t/t7700-repack.sh | 14 +++++++++++++-
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 67f8978043..5d4758b515 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -14,7 +14,7 @@
>
>  static int delta_base_offset = 1;
>  static int pack_kept_objects = -1;
> -static int write_bitmaps;
> +static int write_bitmaps = -1;
>  static int use_delta_islands;
>  static char *packdir, *packtmp;
>
> @@ -343,11 +343,15 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
>  		die(_("--keep-unreachable and -A are incompatible"));
>
> +	if (!(pack_everything & ALL_INTO_ONE)) {
> +		if (write_bitmaps > 0)
> +			die(_(incremental_bitmap_conflict_error));
> +	} else if (write_bitmaps < 0) {
> +		write_bitmaps = is_bare_repository();
> +	}
> +
>  	if (pack_kept_objects < 0)
> -		pack_kept_objects = write_bitmaps;
> -
> -	if (write_bitmaps && !(pack_everything & ALL_INTO_ONE))
> -		die(_(incremental_bitmap_conflict_error));
> +		pack_kept_objects = write_bitmaps > 0;
>
>  	packdir = mkpathdup("%s/pack", get_object_directory());
>  	packtmp = mkpathdup("%s/.tmp-%d-pack", packdir, (int)getpid());
> @@ -368,7 +372,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>  	argv_array_push(&cmd.args, "--indexed-objects");
>  	if (repository_format_partial_clone)
>  		argv_array_push(&cmd.args, "--exclude-promisor-objects");
> -	if (write_bitmaps)
> +	if (write_bitmaps > 0)
>  		argv_array_push(&cmd.args, "--write-bitmap-index");
>  	if (use_delta_islands)
>  		argv_array_push(&cmd.args, "--delta-islands");
> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 6162e2a8e6..3e0b5c40e4 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -221,5 +221,17 @@ test_expect_success 'repack --keep-pack' '
>  	)
>  '
>
> +test_expect_success 'bitmaps are created by default in bare repos' '
> +	git clone --bare .git bare.git &&
> +	cd bare.git &&
> +	mkdir old &&
> +	mv objects/pack/* old &&
> +	pack=$(ls old/*.pack) &&
> +	test_path_is_file "$pack" &&
> +	git unpack-objects -q <"$pack" &&
> +	git repack -ad &&
> +	bitmap=$(ls objects/pack/*.bitmap) &&
> +	test_path_is_file "$bitmap"
> +'
> +
>  test_done
> -

Looks sensible in principle, but now the git-repack and git-config docs
talking about repack.writeBitmaps are out-of-date. A v2 should update
those.

Also worth testing that -c repack.writeBitmaps=false on a bare
repository still overrides it, even though glancing at the code it looks
like that case is handled, but without being tested for.
