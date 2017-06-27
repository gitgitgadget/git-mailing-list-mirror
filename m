Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC9620401
	for <e@80x24.org>; Tue, 27 Jun 2017 18:09:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752768AbdF0SJD (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 14:09:03 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36221 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752542AbdF0SJA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 14:09:00 -0400
Received: by mail-pg0-f67.google.com with SMTP id u36so5170459pgn.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 11:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=qE0vUorlui9Rz4nEZi0jXFpom4xJBnqDHjAj8Tp16h0=;
        b=bC3/P5q1QD/iC6lG4/wjA5SYQMUJmCaSAQ/KoteQ6wuWdhwwdBwlOF7CqVTX4iXdvo
         bOwmasldJwGnfKvkwFb8UuFz31X6O/bpUAjpl/AI6w7CMRrFUf6tgoBbRO2UwxMfDki6
         MlJQVp0WWkmSpNhVVP1cHO4aYtwyX0D2N0CXpIRYe3HY2IStx+h1GVfWevO7O4hXXeho
         hx2HPGgxBzjSLXDY1iG5PxtnLehnBrxfysk+l/NlEpowBpEXvHPhOtEdqQ71ORbremeW
         AodnURUrjB1NiZKh1gp/NEuj88lbGKmStFBaLCgyagllpM1kYE/KGSOFpKeYyK7lF5vT
         frIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=qE0vUorlui9Rz4nEZi0jXFpom4xJBnqDHjAj8Tp16h0=;
        b=sNrV1nfZ78kqmVcCi/sbcSr/YboiSjYjTePSYs3Ryz7JldvxmJVdsEs+xtGnRmCvpZ
         nIGihn9w2PtKrcjDZDSgpqwBgdW5VFlcJdtVUaN+wAUOtnn0XxKLo76tPpgF/5xBpo8U
         BavlA1JICST49+PLQPRWMvKwkZwPsbEAXoHWdw7NOrrqYl7KJLbGrT4LW5IQ8h0blfCR
         KhFc4G0VHQ2QgMB2WsmPcaNbMm9I4MHnucw0Qie1/tXMlbUGfwgtcPh7d7Yw+vipsm75
         ZkoWPzCBbH07uHtI663b90Lmh0smjsuHvxrdO0UiL/JsqvgD3C3lWULeH8eDgBTeZDr6
         qbfg==
X-Gm-Message-State: AKS2vOzRpw4Hdx5OGL6KoJKjoyumSHBJTfGs1q7EkbuLWN4Vdyuz/7gv
        omhTLuOc1aQ/w0J7jaU=
X-Received: by 10.99.9.131 with SMTP id 125mr6454762pgj.178.1498586939954;
        Tue, 27 Jun 2017 11:08:59 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id o6sm6373214pfb.110.2017.06.27.11.08.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 11:08:59 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Michal Zalewski <lcamtuf@google.com>
Subject: Re: [PATCH 2/2] apply: handle assertion failure gracefully
References: <20170225101307.24067-1-vegard.nossum@oracle.com>
        <20170225101307.24067-2-vegard.nossum@oracle.com>
        <a5626d97-e644-65b5-2fd3-41ce870f85a6@web.de>
        <xmqqmvd7wgc7.fsf@gitster.mtv.corp.google.com>
        <f191e3a8-a55b-7030-ebbb-3f46c74fdc94@web.de>
        <xmqq1sujnu1g.fsf@gitster.mtv.corp.google.com>
        <05fe5800-ebc0-76d7-579d-77f64a851fc1@web.de>
        <5128cdf1-39fc-59ca-5640-801777bac2fa@web.de>
Date:   Tue, 27 Jun 2017 11:08:58 -0700
In-Reply-To: <5128cdf1-39fc-59ca-5640-801777bac2fa@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 27 Jun 2017 19:03:39 +0200")
Message-ID: <xmqqshil1ex1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Thought a bit more about it, and as a result here's a simpler approach:
>
> -- >8 --
> Subject: [PATCH] apply: check git diffs for mutually exclusive header lines
>
> A file can either be added, removed, copied, or renamed, but no two of
> these actions can be done by the same patch.  Some of these combinations
> provoke error messages due to missing file names, and some are only
> caught by an assertion.  Check git patches already as they are parsed
> and report conflicting lines on sight.
>
> Found by Vegard Nossum using AFL.
>
> Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  apply.c                | 14 ++++++++++++++
>  apply.h                |  1 +
>  t/t4136-apply-check.sh | 18 ++++++++++++++++++
>  3 files changed, 33 insertions(+)
>
> diff --git a/apply.c b/apply.c
> index 8cd6435c74..8a5e44c474 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -1312,6 +1312,18 @@ static char *git_header_name(struct apply_state *state,
>  	}
>  }
>  
> +static int check_header_line(struct apply_state *state, struct patch *patch)
> +{
> +	int extensions = (patch->is_delete == 1) + (patch->is_new == 1) +
> +			 (patch->is_rename == 1) + (patch->is_copy == 1);
> +	if (extensions > 1)
> +		return error(_("inconsistent header lines %d and %d"),
> +			     state->extension_linenr, state->linenr);
> +	if (extensions && !state->extension_linenr)
> +		state->extension_linenr = state->linenr;

OK.  I wondered briefly what happens if the first git_header that
sets one of the extensions can be at line 0 (calusng
state->extension_linenr to be set to 0), but even in that case, the
second problematic one will correctly report the 0th and its own
line as culprit, so this is OK.  It makes me question if there is
any point checking !state->extension_linenr in the if() statement,
though.

