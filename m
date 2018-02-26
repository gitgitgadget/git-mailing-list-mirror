Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E861F404
	for <e@80x24.org>; Mon, 26 Feb 2018 14:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753980AbeBZOqg (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 09:46:36 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33742 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753976AbeBZOqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 09:46:34 -0500
Received: by mail-lf0-f65.google.com with SMTP id o145so19360697lff.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 06:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KRZUxVf6TaKLG/WqpCKEhNJezd/c3dbIEpFMzTVe+QQ=;
        b=n490RyLqjJop6FXZG4SWI6JBG6ygio1PxQwtdFdX/XkcGiBGG1J6xxFBKdlpB5U0bc
         +V2DZVsPRX4CrinjFyT2D1fXEGxeNp1DUGOD2e97WcNZPrf5HAnWd0YhgDiTjd1WZ8J/
         YVHsuDrd+rF5ytFBaCCbWJMME6MxeGSDe+7KqjZFmt8PWoJViPH/w8cn05q2uvW7jsYV
         g21KISrNr94/QUfDpy2+qm5oFWHtPwlYW+gBiXvpYs+yMSzl2N5nbTuF7h1sgpnub5xW
         tE/3PSiutNqA3CeFqzCqLoSWt/SWBxVFYd+8FyScer6f84PGqhgxkfdUDypuk13XCQp/
         VrzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KRZUxVf6TaKLG/WqpCKEhNJezd/c3dbIEpFMzTVe+QQ=;
        b=SlmaLHrbXw/WyJ57qvVc451Vs3EpT4b5T5ucUl+I1D+dmDNLFU2NI8rphjt2TplWBO
         Eus3gcZLXZbnkLllNYxhlIk6UTpLxTsdM9QvgQXHWoKMBh7Z+jMSvVjziVCPYqCauQua
         aQPBxfaJiS+YsYmVeToygXJDKGS+M5MT7RzwVog7E7ylYqeiaHCyafatyucbYSqh9Crl
         Nv4SM8GGEnT9LtwbtnS4XUQHXA3XzaINo6ngg1DHKrX1BifnWEyo2qUPXU219hfxPEZD
         gSjnEL3Dp/XSogiPxAYP+33HC9tpDGEgV9DWcto4vc9xVoBZ1LHBUpxofFxxlipa1ia7
         XnGA==
X-Gm-Message-State: APf1xPAf84n59O+BASwOLrBEpbn13BKAwPx05JmfcOVk4K6RXun0XF+0
        AtXP3o0RxQ1neVWOG/RpOluV8dTW/c/usd2X9pI=
X-Google-Smtp-Source: AG47ELsM36vlL9pH14J0weldmFTxHxnG9MyhNWsk9VZTMF1jwFhyIC8tQGHB3sop2npbvGmL+SKWXjs+dS0cqrBZQso=
X-Received: by 10.25.232.17 with SMTP id f17mr8433934lfh.55.1519656393278;
 Mon, 26 Feb 2018 06:46:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.85.134 with HTTP; Mon, 26 Feb 2018 06:46:32 -0800 (PST)
In-Reply-To: <xmqq7er3s4t7.fsf@gitster-ct.c.googlers.com>
References: <CADfK3RVJ9pYtpX9x2=CZSKLVy2qxBKeyyGA_S=jo8K-Fa4FOqA@mail.gmail.com>
 <xmqq7er3s4t7.fsf@gitster-ct.c.googlers.com>
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Mon, 26 Feb 2018 09:46:32 -0500
Message-ID: <CADfK3RXa9wngOZ9YmurThm=Xu8J=nq0tK5yaMOMT4T0be2sUZA@mail.gmail.com>
Subject: Re: [PATCH v2] subtree: fix add and pull for GPG-signed commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
        Avery Pennarun <apenwarr@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 5:45 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stephen R Guglielmo <srguglielmo@gmail.com> writes:
>
>> If log.showsignature is true (or --show-signature is passed) while
>> performing a `subtree add` or `subtree pull`, the command fails.
>>
>> toptree_for_commit() calls `log` and passes the output to `commit-tree`.
>> If this output shows the GPG signature data, `commit-tree` throws a
>> fatal error.
>>
>> This commit fixes the issue by adding --no-show-signature to `log` calls
>> in a few places, as well as using the more appropriate `rev-parse`
>> instead where possible.
>>
>> Signed-off-by: Stephen R Guglielmo <srg@guglielmo.us>
>> ---
>>  contrib/subtree/git-subtree.sh | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> This was too heavily whitespace damaged so I recreated your patch
> manually from scratch and queued, during which time I may have made
> silly and simple mistakes.  Please double check what appears on the
> 'pu' branch in a few hours.
>
> Thanks.
>
> I am however starting to feel that
>
>  (1) add gitlog="git log" and then do s/git log/$gitlog/; to the
>      remainder of the whole script in patch 1/2; and
>
>  (2) turn the variable definition to gitlog="git log --no-show-signature"
>      in patch 2/2
>
> may be a better approach.  After all, this script is not prepared to
> be used by any group of people who use signed commits, and showing
> commit signature in any of its use of 'git log', either present or
> in the future, will not be useful to it, I suspect.


Hi Junio,

I can confirm the changes to the pu branch looks good. I apologize for
the whitespace issue; Gmail must've mangled it.

I'm happy to develop a new patch based on your recommendations. Should
it be on top of the previous patch I sent or should it replace the
previous patch?

Thanks,
Steve
