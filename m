Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF55F1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 19:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932740AbdBPTIc (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 14:08:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36649 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbdBPTIb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 14:08:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id 13so1759358pgd.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 11:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qcKF9/HDQ85W5h+3jZpFn5VudBSSecF59CJzv2HFvoY=;
        b=vO85oEN93oFY/VYsJRLJRdHtx9fUeSRpgG6eHfnRHb1ipBTOL91o9uf81utzBz8T05
         h3qmBDA+x4RyGvFSyR+wX/1AA6Xu4dpvkYoiTiB4MO0SzB1XKdPnpfeHhWz85pyYKgYa
         nugqhmteZcnLUDnIR6YaO9yiFhlZmwnB8yIMq4J7bGizdOxTsOEw4P36t1Gh6wWkqAmN
         3wnYhG/poIuWRLmvw/L7/aY5qBGyvw7S1kJAuuucG+gOlWp2XccjQO83elnKHxz6CElG
         SyedC879BntyTdySNl/i5PxOeBmGGiYt/hUk+x7oh1tmwHQTogW/NYt3joo1Uyt206TG
         YmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qcKF9/HDQ85W5h+3jZpFn5VudBSSecF59CJzv2HFvoY=;
        b=nEqF3kxBT8ynCUyjD2gxoSbSlwlgmbVBJZwSAGYD/sdtydmawlHIUVN74uxnb6pV1p
         mxy3c84APLW34LVECT/2tqLpAoKO8S4doX3I5EHJABEr4zXZS10wrZRBQMrVWx5my/Me
         jK6otWSfal3nRsVqfEpQGP2AvOcP0vNZniC2zl5EHDEvLb29dF5CDXU0fVnpRr+Qtkmv
         xFwhoa22T9d4PHt2JcQsXiv9+wUq4CoR8zFGdlD6svXWXz0EIqBWPmF6sZo2+s4ycutc
         1N+qqevf10LFq/FuU8RAGgznpL75/49HJi/af8EWWOsYwFA0cyfKQDSIphB1fJNalt0z
         YrZA==
X-Gm-Message-State: AMke39kiXiO2VXhbctuHknb3PfOXCdNT9ryHGdemASMHKR5VXrnvZ4L7x0P8EqjSdZXclg==
X-Received: by 10.98.63.210 with SMTP id z79mr4499918pfj.134.1487272110719;
        Thu, 16 Feb 2017 11:08:30 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id e4sm15120415pgc.45.2017.02.16.11.08.29
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 11:08:30 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Kannan <kannan.siddharth12@gmail.com>
Cc:     git@vger.kernel.org, Matthieu.Moy@imag.fr, pranit.bauva@gmail.com,
        peff@peff.net, pclouds@gmail.com, sandals@crustytoothpaste.ath.cx
Subject: Re: [PATCH 4/4 v4] sha1_name.c: teach get_sha1_1 "-" shorthand for "@{-1}"
References: <1487258054-32292-1-git-send-email-kannan.siddharth12@gmail.com>
        <1487258054-32292-5-git-send-email-kannan.siddharth12@gmail.com>
Date:   Thu, 16 Feb 2017 11:08:29 -0800
In-Reply-To: <1487258054-32292-5-git-send-email-kannan.siddharth12@gmail.com>
        (Siddharth Kannan's message of "Thu, 16 Feb 2017 15:14:14 +0000")
Message-ID: <xmqq8tp6x8b6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Kannan <kannan.siddharth12@gmail.com> writes:

> Instead of replacing the whole string, we would expand it accordingly using:
>
> if (*name == '-') {
>   if (len == 1) {
>     name = "@{-1}";
>     len = 5;
>   } else {
>     struct strbuf changed_argument = STRBUF_INIT;
>
>     strbuf_addstr(&changed_argument, "@{-1}");
>     strbuf_addstr(&changed_argument, name + 1);
>
>     strbuf_setlen(&changed_argument, strlen(name) + 4);
>
>     name = strbuf_detach(&changed_argument, NULL);
>   }
> }
>
> Junio's comments on a previous version of the patch which used this same
> approach but inside setup_revisions [1]
>
> [1]: <xmqqtw882n08.fsf@gitster.mtv.corp.google.com>

What I said is that when we know we got "-", there is no reason to
replace it with and textually parse "@{-1}".

> +	if (*name == '-' && len == 1) {
> +		name = "@{-1}";
> +		len = 5;
> +	}
> +
>  	ret = get_sha1_basic(name, len, sha1, lookup_flags);

If we look at get_sha1_basic(), it obviously is not prepared to
understand "-" as "@{-1}", and the primary obstacle is that the
underlying interpret_nth_prior_checkout() does two things.  It
expects to take "@{-<num>}" as a string, and the first half parses
the <num> into "long nth".  The latter half then finds the nth prior
checkout.  We probably should factor out the latter half into a
separate function find_nth_prior_checkout() that takes "long nth" as
input, and call it from interpret_nth_prior_checkout(), as a
preparatory step.  Once it is done, get_sha1_basic() can notice that
it was fed (len == 1 && str[0] == '-') and make a direct call to
find_nth_prior_checkout() without going through the "pass '@{-1}' as
text, have interpret_nth_prior_checkout() to parse it to recover 1",
which is a roundabout way to do what you want to do.

Having said all that, I do not think the remainder of the code is
prepared to take "-", not yet anyway [*1*], so turning "-" into
"@{-1}" this patch does before it calls get_sha1_basic(), while it
is not an ideal final state, is probably an acceptable milestone to
stop at.

It is a separate matter if this patch is sufficient to produce
correct results, though.  I haven't studied the callers of this
change to make sure yet, and may find bugs in this approach later.


[Footnote]

*1* For example, the existing callsite in get_sha1_basic() that
    calls interpret_nth_prior_checkout() does not replace "str" with
    what was returned when the HEAD is not detached.  The callpath
    then depends on dwim_ref() to also understand "@{-1}" it got
    from the caller.  If we really want to keep what came from the
    end user as-is so that error message can include it, we'd need
    to teach dwim_ref() about the new "-" convention.  The extent of
    necessary change will become a lot larger.  On the other hand,
    if we allow error messages and reports to use a real refname
    instead of parrotting exactly what the user gave us, I think we
    may be able to arrange to replace str/len in get_sha1_basic()
    when we call interpret/find_nth_prior_checkout() and get a ref,
    without having to teach the new "-" convention all over the
    place.
