Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A1081F462
	for <e@80x24.org>; Wed, 22 May 2019 10:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbfEVKeB (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 06:34:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46291 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfEVKeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 06:34:01 -0400
Received: by mail-wr1-f68.google.com with SMTP id r7so1651682wrr.13
        for <git@vger.kernel.org>; Wed, 22 May 2019 03:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=eQfxAS2RC2FKSRbD5/Wq0skonaWbIZ7AHN/yqBY5bLU=;
        b=hEqGsZzR5l0dTY87+9mqZIX4Qc/JqhFTqkxKDLtnst3tWJ3im8e6GCwlOpPnsxpjbi
         p0vCf47j4wWFv+vp/oc5YdPmJ4kcJRn0oaoEK4Yh0ZcW5EZXk7BTerRRPHpKmu2XZ5Qc
         uVyKA4zFpkOj8tntluUOzpllMbF+/Tem6WmM2n5GzP1YlSXF7cY9uDEoSSuv5sVub8bM
         VCmR0EK9a3ZP2+epgVsGuk/2xVq72Jt4c1VBzWZ1kqIMZdwYoWCjxyIgRgavnUvovRlK
         B90mgFneNL2px/810bv8p5leIJtRJT4tzKuk5qfpBtzVgYRLhGSjtCCxKMvsNWbWlnsw
         2xRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=eQfxAS2RC2FKSRbD5/Wq0skonaWbIZ7AHN/yqBY5bLU=;
        b=t34ejSIHYSoafsjmxx0RIisQJjA9X11w3GaFybS6br0ml7MMNLpqJ9PTrm8j3rrWn5
         AYSBPVc63yO3166jr712QcwGmQIPoCPxINSFdDihrFusMpAmKrKbJL9Y6f10JrYumlQk
         Shx4AQAM/5LjBCppWPDLJ0T15+xSt/StACImZE0UyjfjljT9wo/b0K69mraVHAFPSWaX
         eFWeGsW12d9JNWztBv354j9OAbNd1dGtBc+YHZWVNkieR5tCr/O1IMF6GKDp2wnig/K7
         gNPS4B5KKhr2ubGgh6kOy/UNTp2qK/xMFpCE3t1yVXlRpTeW1JWgwwexh+imxLUke+2x
         DR9w==
X-Gm-Message-State: APjAAAWUvLwecqvU4aeC1JgX6USxqLnp21/C2NKfxu4m0lxvxeT9x/X+
        uUf0GmsDb3pywZdEL7NW21URFGUU
X-Google-Smtp-Source: APXvYqzCCne494Wk+0UjP9kNmL15h117aL9Pu+/dmbIpnlgN/ppIPtgEHzG8kmMXZDfGYZ3h4pd3PQ==
X-Received: by 2002:a5d:4206:: with SMTP id n6mr61873wrq.58.1558521238914;
        Wed, 22 May 2019 03:33:58 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id g17sm21589358wrr.65.2019.05.22.03.33.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 May 2019 03:33:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] upload-pack: strip namespace from symref data
References: <CAGyf7-Ew8rS8n67Few9+dT6VXy9rQbaYLswuZkQ3-4j_T_d=qg@mail.gmail.com> <20190521214630.GD14807@sigill.intra.peff.net> <20190522043146.GA2563@sigill.intra.peff.net>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190522043146.GA2563@sigill.intra.peff.net>
Date:   Wed, 22 May 2019 12:33:56 +0200
Message-ID: <875zq2vkvf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 22 2019, Jeff King wrote:

> Since 7171d8c15f (upload-pack: send symbolic ref information as
> capability, 2013-09-17), we've sent cloning and fetching clients special
> information about which branch HEAD is pointing to, so that they don't
> have to guess based on matching up commit ids.

I'd add a 2nd paragraph here:

    The client will then use the corresponding code added in a45b5f0552
    ("connect: annotate refs with their symref information in
    get_remote_head()", 2013-09-17) to find the intended symref. See
    9907d1359c ("Merge branch 'jc/upload-pack-send-symref'", 2013-10-30)
    for the full set of changes related to this.

...because, see later...

> However, this feature has never worked properly with the GIT_NAMESPACE
> feature.  Because upload-pack uses head_ref_namespaced(find_symref), we
> do find and report on refs/namespaces/foo/HEAD instead of the actual
> HEAD of the repo. This makes sense, since the branch pointed to by the
> top-level HEAD may not be advertised at all. But we do two things wrong:
>
>   1. We report the full name refs/namespaces/foo/HEAD, instead of just
>      HEAD. Meaning no client is going to bother doing anything with that
>      symref, since we're not otherwise advertising it.
>
>   2. We report the symref destination using its full name (e.g.,
>      refs/namespaces/foo/refs/heads/master). That's similarly useless to
>      the client, who only saw "refs/heads/master" in the advertisement.
>
> We should be stripping the namespace prefix off of both places (which
> this patch fixes).
>
> Likely nobody noticed because bug (1) means that from the client's
> perspective, we did not report on HEAD at all. And thus it uses the
> pre-7171d8c15f fallback code to guess the correct HEAD, which is usually
> right. It only falls down in ambiguous cases (like the one laid out in
> the included test).

...because here you're talking about "the client's perspective" and "it
uses the pre-7171d8c15f [...] code", but this should say "the
pre-a45b5f0552 code", i.e. mention the commit that changed the *client*
logic.

Well, the client also "uses" the server-side code indirectly, but I
think it's easier to follow along if we note what both sides are (as I
dug up when reviewing this...).

> This also means that we don't have to worry about breaking anybody who
> was putting pre-stripped names into their namespace symrefs when we fix
> bug (2). Because of bug (1), nobody would have been using the symref we
> advertised in the first place (not to mention that those symrefs would
> have appeared broken for any non-namespaced access).
>
> Note that we have separate fixes here for the v0 and v2 protocols. The
> symref advertisement moved in v2 to be a part of the ls-refs command.
> This actually gets part (1) right, since the symref annotation
> piggy-backs on the existing ref advertisement, which is properly
> stripped. But it still needs a fix for part (2). The included tests
> cover both protocols.
>
> Reported-by: Bryan Turner <bturner@atlassian.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This is the same as my earlier fix, but with the v2 bit added, and of
> course tests and a commit message. Thanks (as usual) for a helpful bug
> report.
>
> I don't know if we have a general philosophy for testing v0 versus v2.
> Without specifying the protocol at all, we'd catch the former on a
> regular run and the latter under a GIT_TEST_PROTOCOL_VERSION=2 run. So
> we _could_ just rely on that, but since I had to do two separate fixes,
> it made sense to me to include explicit tests.

Yeah, we shouldn't rely on the GIT_TEST_* stuff for coverage, it should
just be used to find things that fall between the cracks.

>  ls-refs.c                        |  3 ++-
>  t/t5509-fetch-push-namespaces.sh | 28 ++++++++++++++++++++++++++++
>  upload-pack.c                    |  4 ++--
>  3 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/ls-refs.c b/ls-refs.c
> index 0a7dbc6442..818aef70a0 100644
> --- a/ls-refs.c
> +++ b/ls-refs.c
> @@ -57,7 +57,8 @@ static int send_ref(const char *refname, const struct object_id *oid,
>  		if (!symref_target)
>  			die("'%s' is a symref but it is not?", refname);
>
> -		strbuf_addf(&refline, " symref-target:%s", symref_target);
> +		strbuf_addf(&refline, " symref-target:%s",
> +			    strip_namespace(symref_target));
>  	}
>
>  	if (data->peel) {
> diff --git a/t/t5509-fetch-push-namespaces.sh b/t/t5509-fetch-push-namespaces.sh
> index c88df78c0b..75cbfcc392 100755
> --- a/t/t5509-fetch-push-namespaces.sh
> +++ b/t/t5509-fetch-push-namespaces.sh
> @@ -124,4 +124,32 @@ test_expect_success 'try to update a hidden full ref' '
>  	test_must_fail git -C original push pushee-namespaced master
>  '
>
> +test_expect_success 'set up ambiguous HEAD' '
> +	git init ambiguous &&
> +	(
> +		cd ambiguous &&
> +		git commit --allow-empty -m foo &&
> +		git update-ref refs/namespaces/ns/refs/heads/one HEAD &&
> +		git update-ref refs/namespaces/ns/refs/heads/two HEAD &&
> +		git symbolic-ref refs/namespaces/ns/HEAD \
> +			refs/namespaces/ns/refs/heads/two
> +	)
> +'
> +
> +test_expect_success 'clone chooses correct HEAD (v0)' '
> +	GIT_NAMESPACE=ns git -c protocol.version=0 \
> +		clone ambiguous ambiguous-v0 &&
> +	echo refs/heads/two >expect &&
> +	git -C ambiguous-v0 symbolic-ref HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'clone chooses correct HEAD (v2)' '
> +	GIT_NAMESPACE=ns git -c protocol.version=2 \
> +		clone ambiguous ambiguous-v2 &&
> +	echo refs/heads/two >expect &&
> +	git -C ambiguous-v2 symbolic-ref HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_done
> diff --git a/upload-pack.c b/upload-pack.c
> index 24298913c0..4d2129e7fc 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1037,8 +1037,8 @@ static int find_symref(const char *refname, const struct object_id *oid,
>  	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
>  	if (!symref_target || (flag & REF_ISSYMREF) == 0)
>  		die("'%s' is a symref but it is not?", refname);
> -	item = string_list_append(cb_data, refname);
> -	item->util = xstrdup(symref_target);
> +	item = string_list_append(cb_data, strip_namespace(refname));
> +	item->util = xstrdup(strip_namespace(symref_target));
>  	return 0;
>  }
