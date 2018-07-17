Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855AF1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 17:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeGQSGy (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 14:06:54 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38798 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729934AbeGQSGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 14:06:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so182971wmf.3
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 10:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1dTXufLqzu/fgdBAT6qkJmbK47LWnLZ+RFJ+nZx6Zbw=;
        b=cAWRd2dhVVVohOxtjQJTlwZmiUwRVPDdP+/mXbt0BMqT9hKjkJGgmzt6GpiqDIGX0J
         M1PSOGMKvsVQ6zUklga2G898JGbhalRSaJF7l9irjrIV92VXO8ux9pzG8qACnCbDGtik
         uVGgLvSVNkzE24d0KPM52LBIuU/rIzBv54LDeufi1pQhyDdJdAYPMZmBRX40ZZSonX3M
         netyg2qON6r837x/ess2IdY3+ya6vvLOzj8evr27ZsPCXx2j9OzbVOmi0Z4BLs61JnAA
         AgjUxi30c1z3PfG1dIcj7iG/gMkgL0rgo1CoHByFTwQls26RT/l1/ldYBTPpmTzp5NQ2
         zhGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1dTXufLqzu/fgdBAT6qkJmbK47LWnLZ+RFJ+nZx6Zbw=;
        b=eux/NWXAcHWsS2nbR6EiY0HSFAi4reLO5p/33GxW7VNeiEGAwtcTFo28OXfU8By1KS
         7pJbwZ/oOvFZELEiG9AqMy71moz/IAYEfEn+2xUgM6My588DOqG1WB5gP1Lb7PC6hlE/
         CQ47Zy7irdSloTSG7zGGw4wP2DdApWTMx7SxrMzl+uF+qTa/1vmPE1MsS07R3FX+yjRP
         +T3RlPcBnS8cUV+wpcUKRPkywsap/8KRMYcmWIPMbfDCDre4HH6g84dimM8Mlmcprjy+
         gPm95fZKzIC7lYMWgkHPXjfzh9c3Vk5m2GcTPTs2z4UFDMNV6QNP+j7TDLHIr3A15/27
         ag4w==
X-Gm-Message-State: AOUpUlE7jq0A0pi7Z894Ok1Wif5dd48Y7jJZaXREDnDlET0YXKxJVcau
        dhAkLoc+CRoU44fiTHCcl8w=
X-Google-Smtp-Source: AAOMgpeiquGZ3I4q6EpyAkk9zzmbbL/dTb51yOiqMwfOJQEy99tHhQGGRSuLXrObkFviyti2m3JynA==
X-Received: by 2002:a1c:3411:: with SMTP id b17-v6mr1890033wma.85.1531848791433;
        Tue, 17 Jul 2018 10:33:11 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z1-v6sm141898wmf.5.2018.07.17.10.33.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 10:33:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 3/3] commit: fix exit code for --short/--porcelain
References: <20180426092524.25264-1-sxlijin@gmail.com>
        <20180715110807.25544-4-sxlijin@gmail.com>
Date:   Tue, 17 Jul 2018 10:33:10 -0700
In-Reply-To: <20180715110807.25544-4-sxlijin@gmail.com> (Samuel Lijin's
        message of "Sun, 15 Jul 2018 07:08:07 -0400")
Message-ID: <xmqqh8kxpy21.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> diff --git a/wt-status.c b/wt-status.c
> index 75d389944..4ba657978 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -718,6 +718,39 @@ static void wt_status_collect_untracked(struct wt_status *s)
>  		s->untracked_in_ms = (getnanotime() - t_begin) / 1000000;
>  }
>  
> +static int has_unmerged(const struct wt_status *s)
> +{
> +	int i;
> +
> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d;
> +		d = s->change.items[i].util;
> +		if (d->stagemask)
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static void wt_status_mark_committable(
> +		struct wt_status *s, const struct wt_status_state *state)
> +{
> +	int i;
> +
> +	if (state->merge_in_progress && !has_unmerged(s)) {
> +		s->committable = 1;
> +		return;
> +	}

Is this trying to say:

	During/after a merge, if there is no higher stage entry in
	the index, we can commit.

I am wondering if we also should say:

	During/after a merge, if there is any unresolved conflict in
	the index, we cannot commit.
	
in which case the above becomes more like this:

	if (state->merge_in_progress) {
		s->committable = !has_unmerged(s);
		return;
	}

But with your patch, with no remaining conflict in the index during
a merge, the control comes here and goes into the next loop.

> +	for (i = 0; i < s->change.nr; i++) {
> +		struct wt_status_change_data *d = (s->change.items[i]).util;
> +
> +		if (d->index_status && d->index_status != DIFF_STATUS_UNMERGED) {
> +			s->committable = 1;
> +			return;
> +		}
> +	}

The loop seems to say "As long as there is one entry in the index
that is not in conflict and is different from the HEAD, then we can
commit".  Is that correct?  

Imagine there are two paths A and B in the branches involved in a
merge, and A cleanly resolves (say, we take their version because
our history did not touch it since we diverged) while B has
conflict.  We'll come to this loop (because we are in a merge but
have some unmerged paths) and we find that A is different from HEAD,
happily set committable bit and return.

I _think_ with the change to "what happens during merge" above that
I suggested, this loop automatically becomes correct, but I didn't
think it through.  If there are ways other than .merge_in_progress
that place conflicted entries in the index, then this loop is still
incorrect and would want to be more like:

	for (i = 0; i < s->change.nr; i++) {
		struct wt_status_change_data *d = (s->change.items[i]).util;

		if (d->index_status == DIFF_STATUS_UNMERGED) {
			s->committable = 0;
			return;
		}
		if (d->index_status)
			s->committable = 1;
	}

i.e. we declare "not ready to commit" if there is *any* conflicted
entry, but otherwise set committable to 1 if we see any entry that
is different from HEAD (to declare succcess once we successfully
loop through to the last entry without seeing any conflict).

>  void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
>  {
>  	wt_status_collect_changes_worktree(s);
> @@ -728,6 +761,8 @@ void wt_status_collect(struct wt_status *s, const struct wt_status_state *state)
>  		wt_status_collect_changes_index(s);
>  
>  	wt_status_collect_untracked(s);
> +
> +	wt_status_mark_committable(s, state);
>  }
>  
>  static void wt_longstatus_print_unmerged(const struct wt_status *s)
> @@ -753,28 +788,28 @@ static void wt_longstatus_print_unmerged(const struct wt_status *s)
>  
>  }
>  
> -static void wt_longstatus_print_updated(struct wt_status *s)
> +static void wt_longstatus_print_updated(const struct wt_status *s)
>  {
> -	int shown_header = 0;
>  	int i;
>  
> +	if (!s->committable) {
> +		return;
> +	}

No need to have {} around a single statement.  Especially when you
know you won't be touching the line (e.g. to later add more
statements in the block) in this last patch in a series.

> +	wt_longstatus_print_cached_header(s);
> +
