Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76570208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 19:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbeHGVrF (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 17:47:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38888 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389002AbeHGVrF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 17:47:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id v14-v6so16829819wro.5
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 12:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=y5iQOt3UiZgJ7WikElXO18ankAQ5NuIPInZVjpDNvhk=;
        b=tFIbpFjX6hvZvSMvDUVWM4MRDD7Xe0MF3rUTmTUxA2c0GJ7bh5lhshEp2bsG5SeTPs
         ZWYFg3neRoaQpC0dKgx4zsjT+Tjxmhi0DLOQi+x1sScnXHimq+BwFjDzIkEDQ920mO6d
         d4CjYX+bkB9eL4a1UFY629l96NpjNELUox0cNbugIfEeHKyNggOY4dt3WUtF/4OQC/jQ
         sUxcTQVOT728TUjO5afgcw1yD1Y96zu+P/WsZX/6o7p/7Fk3/3xmNWUuozblA/SpoFCz
         dfpd2mukwM9uM9FXW9st9NLVGKEkQ1uF5y21niQY6b5wjEVDz5k7UFTPUCIrprdQDkO7
         6yyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=y5iQOt3UiZgJ7WikElXO18ankAQ5NuIPInZVjpDNvhk=;
        b=LILBGktCCcNJlpFyp7g10yO7CrpVAtL3dj+c+vl6ulM8kNEydQmeDrMunkg2qD/iAs
         s+5JalT3dz6edmW3V1xZ6URliPmrtH8sNjP2AHLirVDAZafJoDJgV69L9FqBPjhF8oWN
         RTGKGX8LctAG/c9KkVwKDIT51YCKLpFjzZ5kPmGUqV1LJLXtKZ5r70SqvyGiHCim4yrc
         0zNSpmTvjT3zdTu6vMXXC9i4G2HVCLaX5cOR4hJxRjzSrQDgg5s3v3zsyETHM7Pvf6pB
         28fPTGBSZcpd3zp60WRk+X9pTW2L9Q6p2f7sypuYFMTSW1soq9DDLDVFqB8AdxG9LyDI
         57rw==
X-Gm-Message-State: AOUpUlHrRysAW/FhRK/yS4MZZR0XTAIfG41v82tyRzJKOihAytamQhXt
        D3S0Na+5biDAJDcAp1O40+U=
X-Google-Smtp-Source: AAOMgpcdT010KfIUaALD4U9JBqt3WWz31JYySn4mGFCL/y+XqJbgH2Rogc+xYuylg5FgowU31mH/7Q==
X-Received: by 2002:adf:e887:: with SMTP id d7-v6mr13976506wrm.43.1533670270498;
        Tue, 07 Aug 2018 12:31:10 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p14-v6sm3337870wru.0.2018.08.07.12.31.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 12:31:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Elijah Newren <newren@gmail.com>,
        tboegi@web.de, git@jeffhostetler.com
Subject: Re: [PATCH v2] clone: report duplicate entries on case-insensitive filesystems
References: <20180730152756.15012-1-pclouds@gmail.com>
        <20180807190110.16216-1-pclouds@gmail.com>
Date:   Tue, 07 Aug 2018 12:31:09 -0700
In-Reply-To: <20180807190110.16216-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Tue, 7 Aug 2018 21:01:10 +0200")
Message-ID: <xmqq7el2km82.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

>  One nice thing about this is we don't need platform specific code for
>  detecting the duplicate entries. I think ce_match_stat() works even
>  on Windows. And it's now equally expensive on all platforms :D

ce_match_stat() may not be a very good measure to see if two paths
refer to the same file, though.  After a fresh checkout, I would not
be surprised if two completely unrelated paths have the same size
and have same mtime/ctime.  In its original use case, i.e. "I have
one specific path in mind and took a snapshot of its metadata
earlier.  Is it still the same, or has it been touched?", that may
be sufficient to detect that the path has been _modified_, but
without reliable inum, it may be a poor measure to say two paths
refer to the same.

>  builtin/clone.c |  1 +
>  cache.h         |  2 ++
>  entry.c         | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  unpack-trees.c  | 23 +++++++++++++++++++++++
>  unpack-trees.h  |  1 +
>  5 files changed, 71 insertions(+)

Having said that, it is pleasing to see that this can be achieved
with so little additional code.

> +static void mark_duplicate_entries(const struct checkout *state,
> +				   struct cache_entry *ce, struct stat *st)
> +{
> +	int i;
> +	int *count = state->nr_duplicates;
> +
> +	if (!count)
> +		BUG("state->nr_duplicates must not be NULL");
> +
> +	ce->ce_flags |= CE_MATCHED;
> +	(*count)++;
> +
> +	if (!state->refresh_cache)
> +		BUG("We need this to narrow down the set of updated entries");
> +
> +	for (i = 0; i < state->istate->cache_nr; i++) {
> +		struct cache_entry *dup = state->istate->cache[i];
> +
> +		/*
> +		 * This entry has not been checked out yet, otherwise
> +		 * its stat info must have been updated. And since we
> +		 * check out from top to bottom, the rest is guaranteed
> +		 * not checked out. Stop now.
> +		 */
> +		if (!ce_uptodate(dup))
> +			break;
> +
> +		if (dup->ce_flags & CE_MATCHED)
> +			continue;
> +
> +		if (ce_match_stat(dup, st,
> +				  CE_MATCH_IGNORE_VALID |
> +				  CE_MATCH_IGNORE_SKIP_WORKTREE))
> +			continue;
> +
> +		dup->ce_flags |= CE_MATCHED;
> +		(*count)++;
> +		break;
> +	}
> +}
> +

Hmph.  If there is only one true collision, then all its aliases
will be marked with CE_MATCHED bit every time the second and the
subsequent alias is checked out (as the caller calls this function
when it noticed that something already is at the path ce wants to
go).  But if there are two sets of colliding paths, because there is
only one bit used, we do not group the paths into these two sets and
report, e.g. "blue.txt, BLUE.txt and BLUE.TXT collide.  red.txt and
RED.txt also collide."  I am not sure if computing that is too much
work for too little gain, but because this is in an error codepath,
it may be worth doing.  I dunno.

> +
> +	if (o->clone && state.nr_duplicates) {
> +		warning(_("the following paths in this repository only differ in case\n"
> +			  "from another path and will cause problems because you have cloned\n"
> +			  "it on an case-insensitive filesytem:\n"));

With the new approach, we no longer preemptively detect that the
project will be harmed by a case smashing filesystems before it
happens.  This instead reports that the project has already been
harmed on _this_ system by such a filesystem after the fact.

So from the end-user's point of view, "will cause problems" may be a
message that came a bit too late.  "have collided and only one from
the same colliding group is in the working tree; others failed to be
checked out" is probably closer to the truth.

