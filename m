Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F6C91F597
	for <e@80x24.org>; Wed, 25 Jul 2018 21:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbeGYWVE (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jul 2018 18:21:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33331 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730014AbeGYWVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jul 2018 18:21:03 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so8687713wrp.0
        for <git@vger.kernel.org>; Wed, 25 Jul 2018 14:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oPnz0tO9NuKRBYbIZtDwJMNbq8M5k+wM2YuCocnw4pA=;
        b=o+v1Z7n0d82T6A8AkBCHG/iuQQqLA6/j+QZhODeGKGFyo48vJEZUGCTNh/cfPu6Nv4
         7D5dEU+TjUr4JNGJlldFq/H6DpbKL0IPM4za9HNuHcYtbWBBK0zbf7wl3xnGd0d6i/NJ
         4M+QQZBL2mxdC1AcUn9M0bZbxIjc8n4vsI5cbBcViwmMrJ9lpRHWBUd7CURjOTJSjLMW
         Fdex5cx4RBi/U3JhVWgF3htrA9J9EU8ScwTmHWvgD8JiHBz11OU0CBVCWH3oIpp008pQ
         zd+dPnsVbszZGMZydQWMYL/x3niUBPeUF7w0LIiqTPFGazYzeS8HGdv/oeUixDo1TATe
         JtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=oPnz0tO9NuKRBYbIZtDwJMNbq8M5k+wM2YuCocnw4pA=;
        b=o/Fztnkj2uq4w5lr+KmU8kg+j9DT3y+xPoQfxVlSRo+ASZrYqk0h1HmCiSmQP2somv
         4wRALQBPdD3JHlIPd2MC2tx1I5GIUjsHup+KklhGRp7zOXWAJ+XIU8Cr1bXyjyGsls5R
         UVMUdTDSfQ/jIPrxBL+Pukk2UljmsnlPEqPwb74+JYR4krAVzQ31hR4bLtBcyioOzl/P
         cv8khu3G4WhDBrFz14oE2tCnrrccfgCNheEMmJ0Yc4SBlncynkMNVqYW1ZEzgvVjhtp+
         Z8fmJUsSfdNF6eL+CB36kGk43eWejvdOjLOEQLrYBFmdgZ+n6AslZnR//W3MH/8ie1cv
         OYZw==
X-Gm-Message-State: AOUpUlELixwxY7eK4eIec7dHjWP3G0ybffkOvIPYOPzWhejUQTvSyCea
        G72JEDOIg/RFKD5YzqUYQi8=
X-Google-Smtp-Source: AAOMgpcuOd/NuPvuBFgAKLVYzd6zt/QCxGlmjEc5xGh7Lx3eK/Rnwm6eZxcO0uJOrELGnE4qyGaQYQ==
X-Received: by 2002:adf:f390:: with SMTP id m16-v6mr15118362wro.279.1532552853573;
        Wed, 25 Jul 2018 14:07:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i125-v6sm10704299wmd.23.2018.07.25.14.07.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Jul 2018 14:07:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 14/14] format-patch: allow --range-diff to apply to a lone-patch
References: <20180722095717.17912-1-sunshine@sunshineco.com>
        <20180722095717.17912-15-sunshine@sunshineco.com>
Date:   Wed, 25 Jul 2018 14:07:32 -0700
In-Reply-To: <20180722095717.17912-15-sunshine@sunshineco.com> (Eric
        Sunshine's message of "Sun, 22 Jul 2018 05:57:17 -0400")
Message-ID: <xmqqr2jrt46j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> @@ -750,6 +751,20 @@ void show_log(struct rev_info *opt)
>  
>  		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
>  	}
> +
> +	if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
> +		struct diff_queue_struct dq;
> +
> +		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
> +		DIFF_QUEUE_CLEAR(&diff_queued_diff);
> +
> +		next_commentary_block(opt, NULL);
> +		fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
> +		show_range_diff(opt->rdiff1, opt->rdiff2,
> +				opt->creation_factor, 1, &opt->diffopt);
> +
> +		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
> +	}
>  }
>  
>  int log_tree_diff_flush(struct rev_info *opt)

This essentially repeats what is already done for "interdiff".

Does the global diff_queued_diff gets cleaned up when
show_interdiff() and show_range_diff() return, like diff_flush()
does?  Otherwise we'd be leaking the filepairs accumulated in the
diff_queued_diff.

