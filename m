Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5604D1F42D
	for <e@80x24.org>; Sat, 26 May 2018 23:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032428AbeEZXbT (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 19:31:19 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41380 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032407AbeEZXbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 19:31:18 -0400
Received: by mail-wr0-f195.google.com with SMTP id u12-v6so14695595wrn.8
        for <git@vger.kernel.org>; Sat, 26 May 2018 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GcwAuJBRUtm2/g4e0Wmch04cNqMLx91hg+sAL2jtu3s=;
        b=eoJqeNhu86GgknF4TTaPqDIjRgjF/dZ70Aai3oW6SvFddSsk++P6l1lAcd/NwMvzRE
         XR0YbsFLmIh+l7UByQfwz9Yaa0fdwhUWf8fcKmkN19u6gfJT3hHN7tw5MubEzaoo0F10
         8KB5Fza1Bk2cicXwToe46s8xV5kf5geOSsZFj/mPnyf+rafDICFl0eQ+R4q/n8u1Rb15
         11s1zqbuZcM09nkKkw714IYgZ9oU6riKpq9cDKKxODRic8eS3+JLs4P6/1SPQpWWEWcc
         4dhdshmgoFx9yVKaxXsStfgHrvEbVifMLyieVUx6s/lNQfSuiU5GsBfPSnsa18omtKEM
         OTRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GcwAuJBRUtm2/g4e0Wmch04cNqMLx91hg+sAL2jtu3s=;
        b=TTf+rHapumrpC2yEdbEYlY61IufUbxODAOsmtnMHOY+RsBngFjx1TabZRedLeS581G
         JFhO1YN7QF7NvuRXrGpuNvGtJU7LHPPt2l7cVVzeqd85dn5kue431kU9CF8pG1sxq9Af
         63KqRgFy9IIA2t3iiLUqIdSg7QW9ZhxuRrl3JOQoaHKAYSgd8xlqRYO1cDffkXdqrvcy
         c2xh1dC7zRxi0UbXrnfzGA/OAkmifnqHZjEydugqTZa+MTYQrArP2tg7i5itDHjvFMM+
         P76T9MZRsvSskMuWxLWX0gW49qx0gXu6vpm3AMpXD2PjVwrz8TtdGGQhMzEe8xeUdzju
         Td7w==
X-Gm-Message-State: ALKqPwfELiuCaZZqxecBnbQLMPb26Vmv3XHxk2F0p67hR9Nh/M4sV9Qg
        zMZKIkSvYOVjfMUxcKFu7SI=
X-Google-Smtp-Source: AB8JxZp57zteS6GzRujlD0N9KZ0x1lhvxjMGIH4MTTbxp61OMjEJo/9P5COFU6veYEHbqXew+aBW6g==
X-Received: by 2002:adf:8ab9:: with SMTP id y54-v6mr5899030wry.98.1527377477176;
        Sat, 26 May 2018 16:31:17 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q13-v6sm4237808wmc.29.2018.05.26.16.31.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 May 2018 16:31:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC] git gc "--prune=now" semantics considered harmful
References: <alpine.LFD.2.21.999.1805261449160.6211@i7.lan>
Date:   Sun, 27 May 2018 08:31:14 +0900
In-Reply-To: <alpine.LFD.2.21.999.1805261449160.6211@i7.lan> (Linus Torvalds's
        message of "Sat, 26 May 2018 14:49:25 -0700 (PDT)")
Message-ID: <xmqqd0xim1tp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Soes my use pattern of "git gc --prune=now" make sense? Maybe not. But 
> it's what I've gotten used to, and it's at least not entirely insane.

FWIW, my end-of-day ritual is to do repack -a -d -f with a large
window and a small depth, followed by prune, which boils down to
about the same.  So I'd hope that is not entirely insane.  I however
do not think I bother with an explicit --expire=now when running the
prune, though.

In any case, that makes two of us, and the suggested patch protects
only one of the two ;-)

> But at least once now, I've done that "git gc" at the end of the day, and 
> a new pull request comes in, so I do the "git pull" without even thinking 
> about the fact that "git gc" is still running.

*That* is something I don't do.  After all, I am fully aware that I
have started end-of-day ritual by that time, so I won't even look at
a new patch (or a pull request for that matter).

> So I actually would much prefer that foir git gc, "--prune=now" means
>
>  (a) "now"
>
>  (b) now at the _start_ of the "git gc" operation, not the time at
>      the _end_ of the operation when we've already spent a minute or
>      two doing repacking and are now doing the final pruning.
>
> anyway, with that explanation in mind, I'm appending a patch that is 
> pretty small and does that. It's a bit hacky, but I think it still makes 
> sense.
>
> Comments?

Closing the possiblity of racing a running "gc" and new object
creation like the above generally makes sense, I would think,
whether the creation is due to 'pull/fetch', 'add', or even 'push'.

I however have to wonder if there are opposite "oops" end-user
operation we also need to worry about, i.e. we are doing a large-ish
fetch, and get bored and run a gc fron another terminal.  Perhaps
*that* is a bit too stupid to worry about?  Auto-gc deliberately
does not use 'now' because it wants to leave a grace period to avoid
exactly that kind of race.

> diff --git a/builtin/gc.c b/builtin/gc.c
> index c4777b244..98368c8b5 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -535,8 +535,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
>  	if (argc > 0)
>  		usage_with_options(builtin_gc_usage, builtin_gc_options);
>  
> -	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
> -		die(_("failed to parse prune expiry value %s"), prune_expire);
> +	if (prune_expire) {
> +		if (!strcmp(prune_expire, "now"))
> +			prune_expire = show_date(time(NULL), 0, DATE_MODE(ISO8601));
> +		if (parse_expiry_date(prune_expire, &dummy))
> +			die(_("failed to parse prune expiry value %s"), prune_expire);
> +	}
>  
>  	if (aggressive) {
>  		argv_array_push(&repack, "-f");
