Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 719EE2013E
	for <e@80x24.org>; Thu,  2 Mar 2017 23:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751373AbdCBXh6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 18:37:58 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34423 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbdCBXh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 18:37:56 -0500
Received: by mail-lf0-f45.google.com with SMTP id k202so40644345lfe.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 15:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=tjWJxnOuUsyVqkzVIEdJBvOvRneteCSIEyL9dTUBJiE=;
        b=TS/ap9BU3vU8cXDs6Pro7mOtlSOfYGa4ZGi1lXbG6JCnufXnb/ZtzkNx1XMGVNZof/
         fZlIdCHaSJATfhbyAsfTt4QmFHP+PqxxGQcteQACzsgnAaJ5QvewFb63TOyRvVJb+fKo
         punmN0Itay9sG/QdH0+MwAO5XpTiu4i6UeGNPRqu79gRn77F4Bi+vxhmVy48ZTy38SRL
         jHNXTWzz7n+lKskNYows+rCT92EnYbzB38q6LacC5eprqU7rXMNs0dgtyG5N1lb+QlL3
         P8ckThN3zwL9nt1+uwQYCDdSnfc5eOveKH/aHtXfe1M5iuZ+QY+Y3+105s+j1K99v1jm
         +iPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=tjWJxnOuUsyVqkzVIEdJBvOvRneteCSIEyL9dTUBJiE=;
        b=pKDrsfmXqflhlFWfHm6sgrU6+n8/A7cJb0/ctj+EEeuFIc6HHKrK1rFoILILoKzVM5
         UxEMa+qLICRnZr7f20g3m/ssHf/ade30of+7BKmJlcq/9dWJvAC9tO8BXZnSUTKwwjjI
         1aicqPWHIEeVUl+S9h3CZIMCLigGeUvQ2sW4EynKq94g3xLZlkP368ZH5g4EsMnI5Pbk
         U0UAW6dPJE8SnBYDe6mUODvMJx0vBBxlphadC63qc3k6MC8imesMOieTYRhP4sOlO3xF
         3BL7DtRUFwcobT1vWnXzJOV/3rU7TLLiBK58/rb6mT97IqGplYNPLWRlcT//IVxbOkrB
         4lBg==
X-Gm-Message-State: AMke39kiBPPHu9lDpW5kbmag6Hd6d16wlGn2exsaO2JuwY3LIZT5T8zxiFwbraIfKUsGLK2uewHTYVsXkQfA6Q==
X-Received: by 10.25.77.2 with SMTP id a2mr5390149lfb.143.1488497334015; Thu,
 02 Mar 2017 15:28:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.30 with HTTP; Thu, 2 Mar 2017 15:28:33 -0800 (PST)
In-Reply-To: <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
References: <20170223082736.31283-1-djpohly@gmail.com> <20170223082736.31283-3-djpohly@gmail.com>
 <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com> <20170223213333.GA3490@prospect.localdomain>
 <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 2 Mar 2017 15:28:33 -0800
Message-ID: <CA+P7+xpBA+JQbH1=yKL01-rL9z0GKtY1pxBa8feXV41ebOpAPQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless commits
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Devin J. Pohly" <djpohly@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Jeff King <peff@peff.net>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 11:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Devin J. Pohly" <djpohly@gmail.com> writes:
>
>> I think your point is interesting too, though.  If a commit is also
>> TREESAME to its parent(s?) in the _pre-filtered_ branch, it seems
>> reasonable that someone might want to leave it in the filtered branch as
>> an empty commit while pruning empt*ied* commits.  I would imagine that
>> as another option (--prune-newly-empty?).
>
> I was hoping to hear from others who may care about filter-branch to
> comment on this topic to help me decide, but I haven't heard
> anything, so here is my tentative thinking.
>
> I am leaning to:
>
>  * Take your series as-is, which would mean --prune-empty will
>    change the behaviour to unconditionally lose the empty root.
>

This new behavior is how I expected prune-empty to behave, so seeing
that it did not already behave this way was surprising.

Thanks,
Jake
