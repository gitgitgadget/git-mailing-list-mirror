Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1780F1F516
	for <e@80x24.org>; Thu, 21 Jun 2018 20:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932879AbeFUU3r (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 16:29:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40487 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932670AbeFUU3q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 16:29:46 -0400
Received: by mail-wr0-f195.google.com with SMTP id g18-v6so4468780wro.7
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 13:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=vBmCoRZJP59kh6yvF3kbHrsiSE2HFT0g+nSftR4dTD4=;
        b=hZCJQf/1q4pS1JGHu8qJ9LziriRDdTBMI9fY6Uc0KOeTOFnpj6Vo12OrFAfZpBtOhE
         6FiCMDQUUPnt/4uh93yOUazLaNgKCXfyvKVvgKQcJkQdLmsocJsxa+Yd6ALE9PJmMrih
         cgTi9QGDkcqy2b3FcuSwSnpwpxHh9eN50xkleED0slO+C4uQ3YvtJ7LSQujNr7ZeZM6U
         K+FgpQX7J1oCmxp6oIASOjbScxGyFeMKknSTltZtyFqQu/j6mGAuMRGlRWS6mCWK7Ay8
         imatIN3ZwSj3l1Ba9I5xzqWz4B1e/GRbR21KJBy72CqSIrI0NEeh2zluXKnqky6Njeww
         X0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=vBmCoRZJP59kh6yvF3kbHrsiSE2HFT0g+nSftR4dTD4=;
        b=GKKjNXGzG7erRitKbfoERsfAWeOE58zvONsrqu+METKutnOzTAKPLKO4HKaQvW4ez7
         P3/hK3GlnHV1g0YSSVx8zR5o3bKABNzgrR72RC6mqDIvIWPASSGm9CFhC7+dQ2yLYdNr
         88UughrjIusI47mtxy3Dp8bnQc60RwHw/PG0cktl2Z9bpmmbqWOeicHoiiYGuB0TgU6K
         oGiozNXXiRHeo4zP0JKpIIAed/sFg8qLw8gSPNNpOHWHEbWVtJLUZ6+J7FLW6a8wdogN
         1hyRU3U2PrLkESXcxWVn0XvJBjCD4I/sD6LadrvhNv5dFRgVXun0zJdSQdEWoFrskVX5
         v++A==
X-Gm-Message-State: APt69E2KtcitGsaJtXKkGRNHO3mJjnVW8244mgmUFuJwVuG5EadHPJF9
        KyycLihNfDenXAAHb0SAaabaQd0Y
X-Google-Smtp-Source: ADUXVKLq1OvTymabGrP+V41Q5SFJSMh2oVwdJA+LVWGlbj7qiQU4NFeROvGqSl3Ga7GmJ+eximfvlA==
X-Received: by 2002:adf:cd85:: with SMTP id q5-v6mr21948706wrj.275.1529612985333;
        Thu, 21 Jun 2018 13:29:45 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x11-v6sm2929246wrl.80.2018.06.21.13.29.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Jun 2018 13:29:43 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, sunshine@sunshineco.com
Subject: Re: [PATCH v3 4/7] git-rebase: error out when incompatible options passed
References: <20180617055856.22838-1-newren@gmail.com>
        <20180621150023.23533-1-newren@gmail.com>
        <20180621150023.23533-5-newren@gmail.com>
Date:   Thu, 21 Jun 2018 13:29:42 -0700
In-Reply-To: <20180621150023.23533-5-newren@gmail.com> (Elijah Newren's
        message of "Thu, 21 Jun 2018 08:00:20 -0700")
Message-ID: <xmqqr2kzsx1l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +if test -n "$git_am_opt"; then
> +	incompatible_opts=$(echo "$git_am_opt" | sed -e 's/ -q//')

This is probably just a taste-thing, but I'd probably prefer to see
the "sed" filter out "-q" alone, and make an effort to leave future
things like "-qx" alone, e.g.

    $(echo " $git_am_opt " | sed -e 's/ -q / /g' -e 's/^ \(.*\) $/\1/')

or something like that.

> +	if test -n "$interactive_rebase"
> +	then
> +		if test -n "$incompatible_opts"
> +		then
> +			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> +		fi
> +	fi
> +	if test -n "$do_merge"; then
> +		if test -n "$incompatible_opts"
> +		then
> +			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> +		fi
> +	fi
> +fi

Not making --merge and --interactive incompatible as the proposed
log message said makes this hunk at manageable complexity, I guess
;-)
