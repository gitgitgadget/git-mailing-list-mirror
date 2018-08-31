Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FC201F404
	for <e@80x24.org>; Fri, 31 Aug 2018 07:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbeHaL3z (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 07:29:55 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:42427 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHaL3y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 07:29:54 -0400
Received: by mail-ed1-f68.google.com with SMTP id l5so5690238edw.9
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 00:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=pNBdjVLh2HFTpoSBfa7RVK5KRW1MAsx42VLaFgfbXqE=;
        b=vJfQdMxMTsnB23nMtuSx6CxpVmxIbM1Qf3ameGwqf47SRzWiQl2lgMuWTW2PMMuDDo
         L2zqrg7jrdq8tQ/QkOFDKegaLEV8C4DSOYCkxyx5RL2IrZan/L4zfjhqQF73LMfpELA6
         DRxUV0AYBAKn+CROsAsr3E7LESqksCbifc1M13QUqwnZjWZfgMU3ERLoyWwjxDKlXfwQ
         w9rUVcMcdTX9mqvHezVsoGwfF28s+6mQTnZrRGi/7ad+sVd/eHSM6wPBXU87ctle4dZg
         YJ1fMyMVOc5DpgW4QbsJfs3xDbInMT1Ctj3ZPaTyP9liUUJpzaUkEWeBD8jhck176ogc
         +kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=pNBdjVLh2HFTpoSBfa7RVK5KRW1MAsx42VLaFgfbXqE=;
        b=jyPgmn4kP3lAFp87ifRwq/UrUP/9SF1goAYZi3wyVHlMYNQDOdLYn1cTeyscjUI+9G
         OimXGk++1b1WF92gq/Z7Yqg+QWUL2VAe5fjzk6NGScYD5NmG8jeIlnwmMSxEi4IY1wcT
         598DbBEYYJ2hBD8ZZsfmmFRuQbKBMB1kD8jWvpSao56s2eQw2/oLLsr6xZC6wqC2epTk
         TNdiZx2z+KbBYv2sgZSsEwzzgtmdXwiLEvemPc12lbFQiraws1xphoby3aTR4qmLl2UT
         F60V1dyEuensjq1MzH/NEMHlzaAVsyZQ64kQMV69o7Kdmd7Q/20Av39tgSBPx7eYKOvd
         K8qQ==
X-Gm-Message-State: APzg51DMltxHkRtcZxhLOmKO+b+UnP3WmWjXP3BEy4Lg4ET5xi81Pm0V
        D2A+HWynR2Lo6EqCrFEMo1Q=
X-Google-Smtp-Source: ANB0VdbEeDl+ctnPJ+yCItNFCwZO4yLp65Bzg+X+uaQOOaze9del2Yq3iD6BSnuQuPSRBriyX1RIhQ==
X-Received: by 2002:a05:6402:1545:: with SMTP id p5mr14621663edx.104.1535700229037;
        Fri, 31 Aug 2018 00:23:49 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id r2-v6sm4517399eda.89.2018.08.31.00.23.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 00:23:48 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Stephen P. Smith" <ischis2@cox.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 3/3] wt-status.c: Set the commitable flag in the collect phase.
References: <20180831053921.8083-1-ischis2@cox.net> <20180831053921.8083-4-ischis2@cox.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180831053921.8083-4-ischis2@cox.net>
Date:   Fri, 31 Aug 2018 09:23:47 +0200
Message-ID: <87a7p3c83g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 31 2018, Stephen P. Smith wrote:

> In an update to fix a bug with "commit --dry-run" it was found that
> the commitable flag was broken.  The update was, at the time,
> accepted as it was better than the previous version.

What update is this? I.e. git.git commit id? See the "or this invocation
of `git show`" part of SubmittingPatches for how to quote it in the
commit message.

> Since the set of the flag had been done in wt_longstatus_print_updated,
> set the flag in wt_status_collect_updated_cb.
>
> Set the commitable flag in wt_status_collect_changes_initial to keep
> from introducing a rebase regression.
>
> Leave the setting of the commitable flag in show_merge_in_progress. If
> a check for merged commits is moved to the collect phase then other
> --dry-run tests fail.
>
> Signed-off-by: Stephen P. Smith <ischis2@cox.net>
> ---
>  wt-status.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/wt-status.c b/wt-status.c
> index 5ffab6101..d50798425 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -540,10 +540,12 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
>  			/* Leave {mode,oid}_head zero for an add. */
>  			d->mode_index = p->two->mode;
>  			oidcpy(&d->oid_index, &p->two->oid);
> +			s->commitable = 1;
>  			break;
>  		case DIFF_STATUS_DELETED:
>  			d->mode_head = p->one->mode;
>  			oidcpy(&d->oid_head, &p->one->oid);
> +			s->commitable = 1;
>  			/* Leave {mode,oid}_index zero for a delete. */
>  			break;
>
> @@ -561,6 +563,7 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
>  			d->mode_index = p->two->mode;
>  			oidcpy(&d->oid_head, &p->one->oid);
>  			oidcpy(&d->oid_index, &p->two->oid);
> +			s->commitable = 1;
>  			break;
>  		case DIFF_STATUS_UNMERGED:
>  			d->stagemask = unmerged_mask(p->two->path);
> @@ -665,11 +668,13 @@ static void wt_status_collect_changes_initial(struct wt_status *s)
>  			 * code will output the stage values directly and not use the
>  			 * values in these fields.
>  			 */
> +			s->commitable = 1;
>  		} else {
>  			d->index_status = DIFF_STATUS_ADDED;
>  			/* Leave {mode,oid}_head zero for adds. */
>  			d->mode_index = ce->ce_mode;
>  			oidcpy(&d->oid_index, &ce->oid);
> +			s->commitable = 1;
>  		}
>  	}
>  }
> @@ -773,7 +778,6 @@ static void wt_longstatus_print_updated(struct wt_status *s)
>  			continue;
>  		if (!shown_header) {
>  			wt_longstatus_print_cached_header(s);
> -			s->commitable = 1;
>  			shown_header = 1;
>  		}
>  		wt_longstatus_print_change_data(s, WT_STATUS_UPDATED, it);

This looks sensible, but I'm not familiar with the status code.

Structurally, re: my comment on 1/3 and 2/3, it would make sense to make
this a two-part series. In 1/2 you add the test you're adding in 2/3 as
a test_expect_failure test, and in 2/2 (this commit) you tweak all the
"test_expect_failure" that now pass to "test_expect_success".
