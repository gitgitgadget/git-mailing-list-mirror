Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FCA1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 04:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbeHWHjm (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 03:39:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61936 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeHWHjm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 03:39:42 -0400
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Aug 2018 03:39:37 EDT
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 719DEEC640;
        Thu, 23 Aug 2018 00:04:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=S3J7hubopu5PzcGCF32DKiiKeVs=; b=oRdger
        mGK1CSj6dfyHu4TtHzNcJVjIsjEXYBSgcPVEx+gjYHB8/knTG7SAl9H7N3HTym+l
        HVR+4kT4BKUh8PMeXDj7Pvdsa4gSUW+L5hO44EYFeSvBxLVmiME58sWjIYC8FTR1
        LllRiL/kN4iZTSCctSIf5NXi+0/x6PndfLwNg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A82CEC63F;
        Thu, 23 Aug 2018 00:04:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=kyleam.com;
 h=from:to:cc:subject:in-reply-to:references:date:message-id:mime-version:content-type; s=mesmtp; bh=vuBDTO4yZpog5xJlUbHIj/bviuDLqFkTkJ5tseejC/o=; b=sDVuhsUozXqcdueugx2omuQuc34BKKUFgzpymnDJegUuLUa15nVdPBe7YZNjhSacMz7zLjgrle0HBGPufbfvtVP9vDQkvw/zXY8HuXq3bxnIHCLSxc8/dv79a5HAls3yA1ch+Bk4VyJcxGjKx4qn1PzNUnhbEKXTx2C9z0NDug4=
Received: from localhost (unknown [76.118.43.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D88F5EC63E;
        Thu, 23 Aug 2018 00:04:40 -0400 (EDT)
From:   Kyle Meyer <kyle@kyleam.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
In-Reply-To: <20180823032238.GI92374@aiede.svl.corp.google.com>
References: <20180823023955.12980-1-kyle@kyleam.com> <20180823024719.GG92374@aiede.svl.corp.google.com> <87wosh7pjj.fsf@kyleam.com> <20180823032238.GI92374@aiede.svl.corp.google.com>
Date:   Thu, 23 Aug 2018 00:04:39 -0400
Message-ID: <87d0u9ybhk.fsf@kyleam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A8E30158-A689-11E8-B0D7-BFB3E64BB12D-24757444!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>>>> -			    N_("color both diff and diff-between-diffs")),
>>>> +			    N_("restrict coloring to outer diff markers")),

[...]

> Aha: I think you're missing a few words (e.g. "color only according to
> outer diff markers").  Though based on the output, I'm not sure the
> focus on diff markers captures the difference.  (After all, some lines
> are multiple colors in --no-dual-color mode and have no diff markers.)
>
> "Restrict coloring to outer -/+ diff markers" would mean that
> everything will be in plain text, except for the minus or plus sign at
> the beginning of each line.  So you'd see a colorful strip on the left
> and everything else monochrome.

Eh, you're right, it would read like that.  Thanks.

> I think what you mean is something like "color only based on the
> diff-between-diffs".

Yeah, I that sounds OK to me.  I played around with a few different
summary lines and couldn't come up with anything that I thought was
particularly good, and then of course I ended up settling on a summary
line that didn't preserve my intended meaning :/

> Or it might be simpler to do something like
> the following.  What do you think?
>
> diff --git i/builtin/range-diff.c w/builtin/range-diff.c
> index f52d45d9d6..88c19f48d3 100644
> --- i/builtin/range-diff.c
> +++ w/builtin/range-diff.c
> @@ -20,12 +20,12 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>  {
>  	int creation_factor = 60;
>  	struct diff_options diffopt = { NULL };
> -	int simple_color = -1;
> +	int dual_color = -1;
>  	struct option options[] = {
>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>  			    N_("Percentage by which creation is weighted")),
> -		OPT_BOOL(0, "no-dual-color", &simple_color,
> -			    N_("color both diff and diff-between-diffs")),
> +		OPT_BOOL(0, "dual-color", &dual_color,
> +			    N_("color both diff and diff-between-diffs (default)")),

I don't have a strong preference, though I lean towards making 'git
range-diff -h' show --no-dual-color since it's not the default.
