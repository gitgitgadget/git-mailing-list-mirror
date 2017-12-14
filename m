Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF51B1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 21:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753634AbdLNVWm (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 16:22:42 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36282 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753357AbdLNVWi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 16:22:38 -0500
Received: by mail-it0-f66.google.com with SMTP id d16so14387703itj.1
        for <git@vger.kernel.org>; Thu, 14 Dec 2017 13:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iBbW1duGann8IO/rf129NIGJDhZ3WH9uAY86fQpnl6M=;
        b=SlUSuKm42q06BdlNIhJI3S4E7TePAtdOxm2Bl6oMTb0FfRJMbUoJeuv3t6CeKOrh4e
         97ohP3XSoXPH85cJH0aMwiyOj6CkxQhVeDoPw3PXvcoLNjpT4pJDUVhlEstLYKcY1awJ
         LhvZSCH64IyQKB4fsM0IsjU0cqIiwfUiYkKjInfktJjM+BQ4hliHAhh8hH/v6QdEVZc2
         x/HoSLRS+9BK70EjJWohoWaJo2q/rKi8xltwoykmY6gwQUutlxMkDhGAynBS9NuOGece
         xMCPlg/t4VFiYykicO591dBXJE9lyPNOOh9pqUC4eAH+fCpfeuV9b9BF1cysVrc6Tfwz
         02FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iBbW1duGann8IO/rf129NIGJDhZ3WH9uAY86fQpnl6M=;
        b=EO03LOeX/eLRpS5QyIpNX2Yi6Ut+w/uVJWngqbowH5+/tmQokgscL918BQMntKSk2G
         Roim06ulj77PzGOs/FoWfJ2IAEAMf6bTurnrcseggNXnBfrBHcxwamrD0ogFyeKVtYnY
         a5F1PR01uYFJKhnTLmCCZItpCPNw/Ado/FADFxNK4hF0z9G6E0rX0/GTPksg32ZRb44W
         2Zk+m2iq0Tvxy5yw16H/+vcP959WM0hNJ8JP/jqPNpxN2Cv2Oy/PPF0259jtbpOpKEI3
         QqFlqZLOcHLG7jwboze1ArDWP9yoTuATeVMmFZloho0NlSgyVbME2s0cwgjs8RrEIw+Y
         Fb1g==
X-Gm-Message-State: AKGB3mLcJjhNLIxzY0Q358OlLDUf7x4aarB01paL0G+X4QTSpXzFmWFu
        u92phCM94uv4YsLYjpx83AE=
X-Google-Smtp-Source: ACJfBou0dG2HQ/mb5Cn8OnVF/qt/+8GttDyI79mx9yXxS1eSfnB7ud6bB0fpS+dnltMgFu52mUQAeg==
X-Received: by 10.107.35.140 with SMTP id j134mr5623037ioj.166.1513286556998;
        Thu, 14 Dec 2017 13:22:36 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id y19sm2698921iod.46.2017.12.14.13.22.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Dec 2017 13:22:36 -0800 (PST)
Date:   Thu, 14 Dec 2017 13:22:34 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH] diffcore: add a filter to find a specific blob
Message-ID: <20171214212234.GC32842@aiede.mtv.corp.google.com>
References: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
 <20171212012422.123332-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171212012422.123332-1-sbeller@google.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Stefan Beller wrote:

> Junio hinted at a different approach of solving this problem, which this
> patch implements. Teach the diff machinery another flag for restricting
> the information to what is shown. For example:
>
>   $ ./git log --oneline --find-object=v2.0.0:Makefile
>   b2feb64309 Revert the whole "ask curl-config" topic for now
>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"
>
> we observe that the Makefile as shipped with 2.0 was appeared in
> v1.9.2-471-g47fbfded53 and in v2.0.0-rc1-5-gb2feb6430b.

Neat!

Nit: s/was appeared/appeared/ (not a big deal though, since this is
already in 'next').

From the above it's not clear to me whether this is about commits
where the object was added or where the object was removed.
Fortunately, the docs are a bit clearer:

                                 ... one side of the diff
       matches the given object id. The object can be a blob,
       gitlink entry or tree (when `-t` is given).

So this appears to be about both additions and removals.  Followup
questions:

- are copies and renames shown (if I am passing -M -C)?
- what about mode changes?  If the file became executable but the
  blob content didn't change, does that commit match?

Nit, not related to this change: it would be nice to have a long
option to go along with the short name '-t' --- e.g. --include-trees.

Another nit: s/gitlink entry/submodule commit/, perhaps.  The commit
object is not a gitlink entry: it is pointed to by a gitlink entry.

Another documentation idea: it may be nice to point out that this
is only about the preimage and postimage submodule commit and that
it doesn't look at the history in between.

>                                                          The
> reason why these commits both occur prior to v2.0.0 are evil
> merges that are not found using this new mechanism.

Would it be worth the doc mentioning that this doesn't look at merges
unless you use one of the -m/-c/--cc options, or does that go without
saying?

[...]
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -500,6 +500,12 @@ information.
>  --pickaxe-regex::
>  	Treat the <string> given to `-S` as an extended POSIX regular
>  	expression to match.
> +
> +--find-object=<object-id>::
> +	Restrict the output such that one side of the diff
> +	matches the given object id. The object can be a blob,
> +	gitlink entry or tree (when `-t` is given).

I like this name --find-object more than --blobfind!  I am not sure it
quite matches what the user is looking for, though.  We are not
looking for all occurences of the object; we only care about when the
object appears (was added or removed) in the diff.

Putting it in context, we have:

	pickaxe options:
	-S: detect changes in occurence count of a string
	-G: grep lines in diff for a string

	--pickaxe-all:
		do not filter the diff when the patch matches pickaxe
		conditions.

		kind of like log --full-diff, but restricted to pickaxe
		options.
	--pickaxe-regex: treat -S argument as a regex, not a string

Is this another kind of pickaxe option?  It feels similar to -S, but
at an object level instead of a substring level, so in a way it would
be appealing to call it --pickaxe-object.  Does --pickaxe-all affect
it like it affects -S and -G?

Another context to put it in is:

	--diff-filter:
		limit paths (but not commits?) to those with a change
		matching optarg

If I understand correctly, then --diff-filter does not interact with
--pickaxe-all, or in other words it is a different filtering
condition.  Is this another kind of diff filter?  In that context, it
may be appealing to call it something like --object-filter.

--diff-filter is an example where it seems appealing to have a
--full-diff option to diff-tree that could apply to all filters and
not just pickaxe.

[... implementation snipped ...]

The implementation looks lovely and I'm especially happy about the
tests.  Thanks for writing it.

Thoughts?
Jonathan
