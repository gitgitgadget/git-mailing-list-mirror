Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C823C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 20:36:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiIHUgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 16:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIHUgX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 16:36:23 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA631017F1
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 13:36:22 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 145so19121492pfw.4
        for <git@vger.kernel.org>; Thu, 08 Sep 2022 13:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=NvwWFL3WSomZHERnGXY9eJk6psd8dUQ6ba/C6yMu2zE=;
        b=bGOooQWZSz6ISaQdAkRkDgCqDNk4yux4TQlc/h6R0eVLZC1PYxqtzp75Vfh6stJNnq
         6Ud7lXOr270hBSuJyj1cZzlIZBz1DLX5lzGkXNwSB/M4OfvvlZv+49WNB/GCMjrzwCqs
         sEFh9wu7MoZk8dVc+V/t3tQREZhq0wkA6/PX0LlMGpUVBF4u9SOKXHk3ymZD3hgDRdnY
         E8ESlGhnbkpvI0ot4GaSWcWzciDkvWOO7a70W66QVlvPfI5HuSn0XJwVO9Tc2YGd/eyl
         81ndYYOpEophXXfX6VAtoPySJmazaZnpTtLHI/GnMgefXEZ54gSYMo/AUjtzo8hXh3VJ
         PxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date;
        bh=NvwWFL3WSomZHERnGXY9eJk6psd8dUQ6ba/C6yMu2zE=;
        b=zKMrIcIpuKT+tYq7Wk2NM7K8xplAaH25a26Uv+PBUnqsiDTdNf51l/Tg/yiGw+uWGX
         cfvT8YO5jUpsJpQx8Jo4FkPjuk35m5UW8CnIGi2jy9ORycDHr0jrh0vSSOBu54g21xWA
         iYvToKW/zdJ2SehtkrL7EnMDAutg3v/AIbx6vn3VQnw8WSANsICL8a5YFAKdF3Q0dG+L
         idBbEdMltRcN3RZTUJvQNNUBD+jpd4pnnNMZ0oLSK3v3gglYm/EJgvQDShr2geJdJi2L
         AVfOWn2dkvWhUaZ4V8mV5ouA4aqMKljd/X2aOYYiZNet6dZYQB5b8jPsbcHoeafOw2Jk
         XGmQ==
X-Gm-Message-State: ACgBeo0/Nc4/HZUSP/ZQ8Ys4sNmKAI6BL/GEFz4zfGMFHm1pNKIbRVAs
        TC1xjz6i2S79RUru4a96ES4=
X-Google-Smtp-Source: AA6agR5yet/v2cxDjXi0bX2+tNL8XoRq7+iXoxbInrI50VeNZjJTlbMy4BaKERo7eLFg+0ZjLqN9UA==
X-Received: by 2002:a05:6a00:a19:b0:535:49ee:da43 with SMTP id p25-20020a056a000a1900b0053549eeda43mr10767846pfh.53.1662669381392;
        Thu, 08 Sep 2022 13:36:21 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id c38-20020a631c26000000b0042a55fb60bbsm13220519pgc.28.2022.09.08.13.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 13:36:20 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lana Deere <lana.deere@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] fetch: add branch.*.merge to default ref-prefix
 extension
References: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
        <YxpB0dbFTKp5L94k@coredump.intra.peff.net>
Date:   Thu, 08 Sep 2022 13:36:20 -0700
In-Reply-To: <YxpB0dbFTKp5L94k@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 8 Sep 2022 15:26:09 -0400")
Message-ID: <xmqq1qslpprv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When running "git pull" with no arguments, we'll do a default "git
> fetch" and then try to merge the branch specified by the branch.*.merge
> config. There's code in get_ref_map() to treat that "merge" branch as
> something we want to fetch, even if it is not otherwise covered by the
> default refspec.
>
> This works fine with the v0 protocol, as the server tells us about all
> of the refs, and get_ref_map() is the ultimate decider of what we fetch.

Correct.

> But in the v2 protocol, we send the ref-prefix extension to the server,
> asking it to limit the ref advertisement. And we only tell it about the
> default refspec for the remote; we don't mention the branch.*.merge
> config at all.

Yikes.  But unfortunately it is not at all surprising that v2 is
still buggy like this.  It tries to do things in much fancier way to
"optimize" and this is an example of such.

> This usually doesn't matter, because the default refspec matches
> "refs/heads/*", which covers all branches. But if you explicitly use a
> narrow refspec, then "git pull" on some branches may fail. The server
> doesn't advertise the branch, so we don't fetch it, and "git pull"
> thinks that it went away upstream.

Nicely analysed.

> We can fix this by including any branch.*.merge entries for the current
> branch in the list of ref-prefixes we pass to the server. This only
> needs to happen when using the default configured refspec (since
> command-line refspecs are already added, and take precedence in deciding
> what we fetch). We don't otherwise need to replicate any of the "what to
> fetch" logic in get_ref_map(). These ref-prefixes are an optimization,
> so it's OK if we tell the server to advertise the branch.*.merge ref,
> even if we're not going to pull it. We'll just choose not to fetch it.

The solution does make sense.

> -	} else if (transport->remote->fetch.nr)
> -		refspec_ref_prefixes(&transport->remote->fetch,
> -				     &transport_ls_refs_options.ref_prefixes);
> +	} else {
> +		struct branch *branch = branch_get(NULL);
> +
> +		if (transport->remote->fetch.nr)
> +			refspec_ref_prefixes(&transport->remote->fetch,
> +					     &transport_ls_refs_options.ref_prefixes);

OK, this is what we add from remote.$there.fetch, just as before.

> +		if (branch_has_merge_config(branch) &&
> +		    !strcmp(branch->remote_name, transport->remote->name)) {
> +			int i;
> +			for (i = 0; i < branch->merge_nr; i++) {
> +				strvec_push(&transport_ls_refs_options.ref_prefixes,
> +					    branch->merge[i]->src);
> +			}
> +		}
> +	}

I am surprised strvec_push() is used here, not expand_ref_prefix().

refspec_ref_prefixes() takes refspec, inspects each item in it, and
munges the source side (i.e. the name the server side calls it) to
chomp at the first '*' and strvec_push the result for a pattern refspec,
or calls expand_ref_prefix(), to prefix all the possible rev-parse
dwim prefixes to given string.  So "remote.origin.fetch = a:something"
is turned into "a", which is not a pattern, and refs/a, refs/tags/a,
refs/heads/a, refs/remotes/a, and refs/remotes/a/HEAD are asked to
be advertised.

Here, branch->merge[i]->src is branch.<name>.merge for the branch
currently checked out, which is?  'master'?  'refs/heads/master'?

remote.c::branch_merge_matches() uses refname_match() on its value,
so it seems that we expect the branch name proper, without refs/heads
prefix, as its value.

So, is strvec_push() a correct thing to use here?  ref_prefixes will
receive something like 'master' here, without 'refs/heads/master'
getting pushed, when "branch.*.merge = master"?  Given that the
advertisement restriction is merely an optimization, I wouldn't be
surprised if 'master' in .ref_prefixes strvec is further expanded
by an unnecessary extra call to expand_ref_prefix() later to cause
the server side to advertise refs/heads/master and refs/tags/master
etc., but it smells, eh, bad.

>  	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
>  		must_list_refs = 1;
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 081808009b..0b72112fb1 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -218,6 +218,23 @@ test_expect_success 'fail if upstream branch does not exist' '
>  	test_cmp expect file
>  '
>  
> +test_expect_success 'fetch upstream branch even if refspec excludes it' '
> +	# the branch names are not important here except that
> +	# the first one must not be a prefix of the second,
> +	# since otherwise the ref-prefix protocol extension
> +	# would match both
> +	git branch in-refspec HEAD^ &&
> +	git branch not-in-refspec HEAD &&
> +	git init -b in-refspec downstream &&
> +	git -C downstream remote add -t in-refspec origin "file://$(pwd)/.git" &&
> +	git -C downstream config branch.in-refspec.remote origin &&
> +	git -C downstream config branch.in-refspec.merge refs/heads/not-in-refspec &&



> +	git -C downstream pull &&
> +	git rev-parse --verify not-in-refspec >expect &&
> +	git -C downstream rev-parse --verify HEAD >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'fail if the index has unresolved entries' '
>  	git checkout -b third second^ &&
>  	test_when_finished "git checkout -f copy && git branch -D third" &&
