Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08EE220248
	for <e@80x24.org>; Thu, 28 Mar 2019 18:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbfC1SiQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Mar 2019 14:38:16 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42560 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfC1SiQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Mar 2019 14:38:16 -0400
Received: by mail-qt1-f195.google.com with SMTP id p20so24290488qtc.9
        for <git@vger.kernel.org>; Thu, 28 Mar 2019 11:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aYmJEnGKrc4NRZ+cnnkeoiBgjrjuUU6bR+iKfNDtTfU=;
        b=tWmys9WbwubIkPzK0uRU8E+Vza573MMfmPJI8h1Sz2GxLOQeUDfEYn7rJZpbWHyUAm
         xzblrODIW7EQGsKUyNFJZI60+QsD0SUWNYXuH1qQeEPv3PRZRRtfTXcJL9vjfqzUk7zV
         r+45xqNJjQGPNahGx+ZZD4o5CMMKC7Pgy25Q2bGYAgcqi/MJ90pSSlyVq7UqDsFw7JVk
         bbZoJ7qKkkfuTxYoXkK3v6MZY6GqHA3UbgCucWQ/xKb1gpu58LiT9DQdGbV1Kgpjd3AT
         l3NyQbm3xK8BeEi+w1UDMd/CpFHg5XvVyO2tvg5UTy8XY7S6jEpYyHWUyvQeVBUPbfc4
         DRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aYmJEnGKrc4NRZ+cnnkeoiBgjrjuUU6bR+iKfNDtTfU=;
        b=MjymW9DlfX/4K5PdE8kY8heGGgKMhhDQkoM4iij3b9s4lzg+ttT2T0t9ci5a/Soil8
         tqxMq4esHBLH+Etd+ITR7W8eRRuyfsaTE3i9xrhrOsb6x1Bjq/YBnB1PgE8KU12m3RbV
         Vd1Oak46hxoX6gBXSkGKHHuB3uAq6UThnps23V+4jeMg0kV0RqyAdhRFyVpjYq3VbDGD
         hZO7n8iackehZfBp03qGcxBwTMrdOpXWyT+qDPMfURLiu192Z6lJcVujv4LBIx2FDX9I
         6Oswf/rMQ7eND0rBvr8BK6bR5sqGt7ImxuXkbrBKcQhs6oLjUFLlRrjzHZjGQ/8KE9Kn
         HgjA==
X-Gm-Message-State: APjAAAWt+eflxMkQbYS4FxGiKeNv5dMLPEyBv46Dic4EUnGn4qzVuC3C
        pJParTkV6pcPcEERDHehPej6Qw==
X-Google-Smtp-Source: APXvYqwEX7yLD9ao8iVu4zsHzAESuZMxsmQzRPSlTUsStxyMkRSrN7T+BHrbiJlDhtyyRwfamVFm4Q==
X-Received: by 2002:ac8:255d:: with SMTP id 29mr37272258qtn.36.1553798294895;
        Thu, 28 Mar 2019 11:38:14 -0700 (PDT)
Received: from localhost ([173.225.52.220])
        by smtp.gmail.com with ESMTPSA id v8sm17330099qtc.69.2019.03.28.11.38.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Mar 2019 11:38:14 -0700 (PDT)
Date:   Thu, 28 Mar 2019 14:38:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andreas Schwab <schwab@suse.de>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] replace: fix --graft when passing a tag
Message-ID: <20190328183812.GA24326@Taylors-MacBook-Pro.local>
References: <20190328171722.9753-1-chriscool@tuxfamily.org>
 <20190328171722.9753-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328171722.9753-3-chriscool@tuxfamily.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Thu, Mar 28, 2019 at 06:17:22PM +0100, Christian Couder wrote:
> When passing a tag as a parent argument to `git replace --graft`,
> it can be useful to accept it and use the underlying commit as a
> parent.
>
> This already works for lightweight tags, but unfortunately
> for annotated tags we have been using the hash of the tag object
> instead of the hash of the underlying commit as a parent in the
> replacement object we create.

Ah. If I interpret your description correctly, the issue is that Git
doesn't follow the annotated tag through to the commit it points to.
Makes sense.

> This created invalid objects, but the replace succeeded even if
> it showed an error like:
>
> error: object A is a tag, not a commit
>
> This patch fixes that by using the hash of the underlying commit
> when an annotated tag is passed.

This seems like the straightforward fix.

> While at it, let's also update an error message to make it
> clearer.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>
> This doesn't fix issues when an annotated tag is passed as the
> replaced object, that is when the tag is the first argument after
> `git replace --graft`. But this can be done in subsequent patches
> I already started to work on.
>
>  builtin/replace.c  |  9 ++++++---
>  t/t6050-replace.sh | 11 +++++++++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index f5701629a8..b0a9227f9a 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -370,16 +370,19 @@ static int replace_parents(struct strbuf *buf, int argc, const char **argv)
>  	/* prepare new parents */
>  	for (i = 0; i < argc; i++) {
>  		struct object_id oid;
> +		struct commit *commit;
> +
>  		if (get_oid(argv[i], &oid) < 0) {
>  			strbuf_release(&new_parents);
>  			return error(_("not a valid object name: '%s'"),
>  				     argv[i]);
>  		}
> -		if (!lookup_commit_reference(the_repository, &oid)) {
> +		commit = lookup_commit_reference(the_repository, &oid);
> +		if (!commit) {
>  			strbuf_release(&new_parents);
> -			return error(_("could not parse %s"), argv[i]);
> +			return error(_("could not parse %s as a commit"), argv[i]);

Good. After I read the commit message above, I was curious to see how
this worked if you provided an annotated tag that pointed to a
non-commit.

'lookup_commit_reference' should return NULL in that case, which you
handle here appropriately. (And thanks for improving the error message,
too ;-).)

>  		}
> -		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
> +		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&commit->object.oid));
>  	}
>
>  	/* replace existing parents with new ones */
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 5cb8281bab..72075983ac 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -405,6 +405,17 @@ test_expect_success '--graft with and without already replaced object' '
>  	git replace -d $HASH5
>  '
>
> +test_expect_success '--graft using a tag as the new parent' '
> +	git tag new_parent $HASH5 &&
> +	git replace --graft $HASH7 new_parent &&
> +	commit_has_parents $HASH7 $HASH5 &&
> +	git replace -d $HASH7 &&
> +	git tag -a -m "annotated new parent tag" annotated_new_parent $HASH5 &&
> +	git replace --graft $HASH7 annotated_new_parent &&
> +	commit_has_parents $HASH7 $HASH5 &&
> +	git replace -d $HASH7

Very nice. I would normally write at the beginning of the test instead:

  test_when_finished "git replace -d $HASH7"

But I think your choice here is much better, since you need to delete
the replacement a few lines above, too. I think it would be jarring to
have both the inline `git replace -d`, and another from
`test_when_finished`, so this makes much more sense.

> +'
> +
>  test_expect_success GPG 'set up a signed commit' '
>  	echo "line 17" >>hello &&
>  	echo "line 18" >>hello &&
> --
> 2.21.0.68.gd997bba285.dirty
>

The previous two look good as well.

Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
