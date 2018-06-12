Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E56BE1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 20:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933713AbeFLUtW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 16:49:22 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:38058 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932744AbeFLUtW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 16:49:22 -0400
Received: by mail-wm0-f44.google.com with SMTP id 69-v6so1286735wmf.3
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 13:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EJC7B5e6D+kI7l93zY1gAe07DTSgtOHpDEXKLpoJy/U=;
        b=JHhbAcj4P4DNL+dXtLhvAJo2Uv/g3bo8GIoJk6uhjzet2quXWHudjGbiEL2gY0utEo
         JAZyGSpCuARc2CX2FdHLO2GdCl1hnX9BdKYUQNHSvPH57xQGZ0b9c/SjuJ0u23SEjtPm
         67nsRxJgfW8H77Ge1ivgIK0Cv/VPdAhMyoragDjjG5CVsjpxHaP+VZj3sM2B0hniafm5
         XahF3IsoCQuiSADbG9gzU75EAPQ6xGD0Ns4sYXo/t3xIt59ziJGGEvfn8AO32/pa91zY
         nwMalrJYsqIhMcdG6q/3+Nj3R+eStsOlI6jhrRobUacRn1gAnvEO7Fd6a1Wx31U36MOW
         58oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EJC7B5e6D+kI7l93zY1gAe07DTSgtOHpDEXKLpoJy/U=;
        b=ZXV/N/wmlcBFTpRHdhkod7lC9qMY1IDbiOAmFVfNfni5iOaI8yMjNwt1vjZr0BmRfn
         M4rI0iAvhlwWtIwoF95uzE4v5c8j0phlv3sGvRVI7gJ4IEZc0Rn5rSmATuv9GJSEY9tD
         vOqnV6Gjgfz9ZwpAzhRpy+Fa4SsxLuyQB62Se+9LKRJJB0WLF1favITxEMI+xeG+JUoL
         jjuQQ1CRzy4C7RBEh8I51zsVxAiLzhvIqn2TuMQRIuWU3B+91niTYUtvOF+ntZ+WjWJS
         kXWXq7ZsxlzhzDnGM8xvMtvQoWRU7Bl1p6nkfN8Q6ynBDXKdor71VZd4ID54J1GtzKWt
         ePDg==
X-Gm-Message-State: APt69E15Y/GAOSgKrWD1UGLqU4e9vDcI6ReFw3W0KTLIi6Q1DzmknvOs
        7REogQwIKmOtj3L3KDH6w+k=
X-Google-Smtp-Source: ADUXVKJ1Fgr8QnNiyGGgHpE1Yv0GvwNRpPYEAJuXy9r24aTZi2KudD/XnETlxGG50hFdc+Wo6qPEiA==
X-Received: by 2002:a1c:f906:: with SMTP id x6-v6mr1560466wmh.63.1528836560647;
        Tue, 12 Jun 2018 13:49:20 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 137-v6sm2159066wmv.28.2018.06.12.13.49.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 13:49:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v9] json_writer: new routines to create JSON data
References: <20180612202201.94733-1-git@jeffhostetler.com>
        <20180612202201.94733-2-git@jeffhostetler.com>
Date:   Tue, 12 Jun 2018 13:49:19 -0700
In-Reply-To: <20180612202201.94733-2-git@jeffhostetler.com> (git's message of
        "Tue, 12 Jun 2018 20:22:01 +0000")
Message-ID: <xmqqfu1r91dc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:


> +static void indent_pretty(struct json_writer *jw)
> +{
> +	int k;
> +
> +	if (!jw->pretty)
> +		return;
> +
> +	for (k = 0; k < jw->open_stack.len; k++)
> +		strbuf_addstr(&jw->json, "  ");
> +}

> +static void array_common(struct json_writer *jw)
> +{
> +	assert_in_array(jw);
> +	maybe_add_comma(jw);
> +
> +	if (jw->pretty)
> +		strbuf_addch(&jw->json, '\n');
> +	indent_pretty(jw);

Make it

	if (jw->pretty) {
		strbuf_addch(&jw->json, '\n');
		indent_pretty(jw);
	}

and lose "be noop unless jw->pretty" check from the indent function.

Most other codepaths that cares about pretty printing state use that
"I check and decide to (or not to) call helpers that unconditionally
do" pattern, and the way indent_pretty() is used in the patch stands
out like a sore thumb.

