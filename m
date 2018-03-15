Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F319D1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752659AbeCOR6E (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:58:04 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33361 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbeCOR6D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:58:03 -0400
Received: by mail-wm0-f52.google.com with SMTP id s206so24220098wme.0
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=flcFQNjvJ+8JtDS6URYKz8fyb1dtPDKbL0yv36SepEU=;
        b=VeSZzCoSR42ewDRZmg0JFJ8waBGIPaVMpgIexrLKSHNq+p3cBs1ArCVe4bJ4r3KG+e
         0cZClE83VBJC0nzwjpWuZX/rxu2a/ClMGuQlE7CYN5UsWt2aw/kofNtwu5NrzNUHc9k+
         kP/dUmOf7J2HVdsgF8EFL0Fj5ZJ6ygf/3KnE9vvyUZTQ2fr9W/hpk16yA7uFXjKcrqJ2
         p9TuHjpprPwwEr6WSI8Xs7CQlPSHPtuApv7xZjOrDHRzJotfMqiVCe4wGjDUnBoeynrj
         sZun6+5Nw1ypy2b8altOi4zKFIX1gCf4MrgiSCKfdH7BPJ7Mg2V+8RSW2HQvlOXG18mv
         1DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=flcFQNjvJ+8JtDS6URYKz8fyb1dtPDKbL0yv36SepEU=;
        b=bhRDIvuZW/5nLD9j1qyfxe0wxy7Z/OnxXjotO1aso1zxEtbRymAJG+xt+pJ9Tc2BXc
         Ihe7pTsyoOrUaT4etICKSuLMwepo+bgMo9GYfyrxKXsKN3R+NPbta6GCTqKCOWyUn3iY
         YJ9WPz/3vkRyA3qCJyfbzZiOLGIthnRGUz+PVQmK36mHzRR750umC3yOal0nR8xWMFCC
         FWncIQyIzMNBnVCIII8hqMMgbtdPZHwytvzT8LwydeXoYk/1A6ntI0WutJMq1xvmvIgA
         506muxGT8/Yl0Xj+0TAjQB/Ptqb0OCeiRbkl5QI4Tl0PsXbS05Bi3Ty2OTWBcZSCELOY
         AiRw==
X-Gm-Message-State: AElRT7Gv0hBygUbmqI7JruYeBSpyvy//y0lE9hn3g5ppgeg5DMsS2SsV
        AykcuwX7JG5CAC1sb513YYs=
X-Google-Smtp-Source: AG47ELteSf6yWEs1Ql8O2NIUCgcSFf0xTRF8Zap1a74jf8Orl6Qjzd95C58qVxNAsYdaOVOc81TY5A==
X-Received: by 10.28.8.9 with SMTP id 9mr5284553wmi.54.1521136682160;
        Thu, 15 Mar 2018 10:58:02 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a63sm7142809wrc.22.2018.03.15.10.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Mar 2018 10:58:01 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com, blees@dcon.de
Subject: Re: [PATCH v1] Fix bugs preventing adding updated cache entries to the name hash
References: <20180315152520.23264-1-benpeart@microsoft.com>
Date:   Thu, 15 Mar 2018 10:58:00 -0700
In-Reply-To: <20180315152520.23264-1-benpeart@microsoft.com> (Ben Peart's
        message of "Thu, 15 Mar 2018 11:25:20 -0400")
Message-ID: <xmqqfu515ihj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> Update replace_index_entry() to clear the CE_HASHED flag from the new cache
> entry so that it can add it to the name hash in set_index_entry()

OK.  

> diff --git a/read-cache.c b/read-cache.c
> index 977921d90c..bdfa552861 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -62,6 +62,7 @@ static void replace_index_entry(struct index_state *istate, int nr, struct cache
>  	replace_index_entry_in_base(istate, old, ce);
>  	remove_name_hash(istate, old);
>  	free(old);
> +	ce->ce_flags &= ~CE_HASHED;
>  	set_index_entry(istate, nr, ce);
>  	ce->ce_flags |= CE_UPDATE_IN_BASE;
>  	mark_fsmonitor_invalid(istate, ce);

As we are removing "old" that is not "ce", an earlier call to
remove_name_hash() that clears the CE_HASHED bit from the cache
entry does not help us at all.  We need to clear the bit from "ce"
ourselves before calling set_index_entry() on it, otherwise the call
would become a no-op wrt the name hash.  Makes sense.

Makes me wonder why "ce" which is a replacement for what is in the
index already has the hashed bit, though.  Is that the failure to
use copy_cache_entry() in the caller the other part of this patch
fixes?  To me it looks like copy_cache_entry() is designed for
copying an entry's data to another one that has a different name,
but in the refresh codepath, we _know_ we are replacing an old entry
with an entry with the same name, so it somehow feels a bit strange
to use copy_cache_entry(), instead of doing memcpy() (and possibly
dropping the HASHED bit from the new copy--but wouldn't that become
unnecessary with the fix to replace_index_entry() we saw above?)

Is this fix something we can demonstrate in a new test, by the way?

Thanks.
