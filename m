Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A311F404
	for <e@80x24.org>; Sat, 21 Apr 2018 03:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeDUDnd (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 23:43:33 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45169 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752552AbeDUDnc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 23:43:32 -0400
Received: by mail-wr0-f196.google.com with SMTP id u11-v6so27466986wri.12
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 20:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zwxfbGcib6BoSygbXQng21L4A8In5VPT+b/aczIk79Q=;
        b=eSMu00SGWqH1iz3eJWUgDywukxxvgk/IvGauGwnRMgQYjEqyjsprQGvTItT9vpE632
         fUQYBO9j7hv4JRTsr56JeuuLDnKvPe8VAzotFXHRIkcqoE8DNkphh5roynPwz4nY2an1
         2zYeAslsd2Bg4m0lAmE6wXzeRYGSbTVtbYv+I69T8vNL7yL2/U//Jt3YMhf7eKwlra7P
         H3zcUAliTj73aLiBq9Lvn+T+845Gl1jCkfdJrnwFkC+xca0ZloZ/dKjExeInT3V8+W5f
         OZWi6dupO6fXa95xkUZsHdBtBvrSkQ9sUAmlQKQm8woj/LX0c6SU5H3oSn+GPE01azXO
         AnVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=zwxfbGcib6BoSygbXQng21L4A8In5VPT+b/aczIk79Q=;
        b=h2qaruhphJxOporJbnR030SDcMbthdA4kj80fDPH9a+lKwqQGipY06pZPKdZ7OlenQ
         d+YL2CRfoV9jVF+IGFc/6lN+FZ4jy2SpAIzPTI/WlAuTPfRGj5KrCnSlOFD9M2dJ2Fww
         Bs0P2eKKXEJW2g+ne/wK0SGfq3QHn4Zp3UhZv3dLINHprhqUnDgQDsQLQvUU46N82IiB
         KrelhDpPvlLSOVMapxOSLWhUTHTuom7IS8TWixp2LQplTTPo5NZSqLUeuavkWOEe5jEj
         2Yqz+kGAaOK7/jtboxo7m6o+y5IrBpTQMYV1Ym+KCnLP+u/Ancndr9CjJ5qlJLZ1ywAN
         cqJQ==
X-Gm-Message-State: ALQs6tD/WQdmyD0ZSzlXgFo3Fq9R6bQqjcFLQgcf0MMWLsJHEPbu7vvr
        DZf6f6YcJxXj0iOe2uZnfhwKFbSi
X-Google-Smtp-Source: AIpwx4+kYi6CNb2E7fkCTsPGW0Ipq7pj8UzCzehWaPSIpmi/QkEmSFoF3G4Tg1nSBmfJZQraaxwiUg==
X-Received: by 10.28.58.81 with SMTP id h78mr3226259wma.110.1524282210939;
        Fri, 20 Apr 2018 20:43:30 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id m83sm3043745wma.17.2018.04.20.20.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 20:43:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Isaac Chou <Isaac.Chou@microfocus.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3] fast-export: fix regression skipping some merge-commits
References: <nycvar.QRO.7.76.6.1804202258071.4241@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <20180420221231.4131611-1-martin.agren@gmail.com>
Date:   Sat, 21 Apr 2018 12:43:27 +0900
In-Reply-To: <20180420221231.4131611-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Sat, 21 Apr 2018 00:12:31 +0200")
Message-ID: <xmqqh8o5b4ww.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> +test_expect_success 'merge commit gets exported with --import-marks' '
> +	test_create_repo merging &&
> +	(
> +		cd merging &&
> +		test_commit initial &&
> +		git checkout -b topic &&
> +		test_commit on-topic &&
> +		git checkout master &&
> +		test_commit on-master &&
> +		test_tick &&
> +		git merge --no-ff -m Yeah topic &&
> +
> +		echo ":1 $(git rev-parse HEAD^^)" >marks &&
> +		git fast-export --import-marks=marks master >out &&
> +		grep Yeah out
> +	)
> +'

This test looks much better than the one in the earlier iteration,
but I do not think the updated "fix" below is better.  It might be
just aesthetics and I suspect I won't find it as disturbing if we
could push with

	object_array_push(commits, (struct object *)commit);

or something that is more clearly symmetric to object_array_pop().
The "Queue again" comment is needed only because use of "add"
highlights the lack of symmetry.

With add_object_array(), it looks somewhat more odd than your
previous

	peek it to check;
	if (it should not be molested)
		return;
	pop to mark it consumed;
	consume it;

sequence, in which peek() and pop() were more obviously related
operations on the same "array" object.

And I do not think it is a good idea to introduce _push() only for
symmetry (it would merely be a less capable version of add whose
name is spelled differently).  Hence my preference for peek-check-pop
over pop-oops-push-again-but-push-spelled-as-add.

Not worth a reroll, though.  I just wanted to spread better design
sense to contributors ;-)

>  test_done
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 27b2cc138e..7b8dfc5af1 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -651,8 +651,11 @@ static void handle_tail(struct object_array *commits, struct rev_info *revs,
>  	struct commit *commit;
>  	while (commits->nr) {
>  		commit = (struct commit *)object_array_pop(commits);
> -		if (has_unshown_parent(commit))
> +		if (has_unshown_parent(commit)) {
> +			/* Queue again, to be handled later */
> +			add_object_array(&commit->object, NULL, commits);
>  			return;
> +		}
>  		handle_commit(commit, revs, paths_of_changed_objects);
>  	}
>  }
