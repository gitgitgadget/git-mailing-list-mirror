Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 916941F51C
	for <e@80x24.org>; Sat, 19 May 2018 15:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeESPjG (ORCPT <rfc822;e@80x24.org>);
        Sat, 19 May 2018 11:39:06 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40226 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeESPjF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 May 2018 11:39:05 -0400
Received: by mail-ua0-f194.google.com with SMTP id g9-v6so7320768uak.7
        for <git@vger.kernel.org>; Sat, 19 May 2018 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=e0BXokpG5DOGQDZmrjtiZReYVA2FPy4+3tJrLz7FzmI=;
        b=h5qyejUGG+uVGnvjZ7LjANq0BR3EG69BvUOre4EvsVQog84G8LZk1LDDvQfmyxp9WR
         Q1EwI5E56Vp/d4q4aJ14HyPRj/vhzoQ1n/MeCOjrB6FFazUkUnrV8+SvpKXxk/uT5Bap
         o9vMW1hcwInpaQ7H7ohLbI07YjyQyWzvf2rewU4Nm7qeFwEuUUX1Egtcl0MSFRmS5Tdh
         o0JN2W2/x96cDkzwtBSuqDAgi1Rjk8Ctv8sBISbnB5yuQqyrlJZLk/YDKj7GrWYj3E1o
         6+Qt8l+Axbp5OruiqTwx78XUbNhplNsJHvhShPFJQDWIJhP7PDq1w7m8rU+Fij38+tNN
         emuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=e0BXokpG5DOGQDZmrjtiZReYVA2FPy4+3tJrLz7FzmI=;
        b=UNz5TGj6nlY/Zi+/D+vEN3J2VY1tFCNpLLbe0arwm57kkbfYagLdzlwQc9pvr7RJLM
         ZZN2m+90LWWJiJQslsgcqpud//0iGskbCOUsndqvQ577i3vvWBNlbUjF5hzMe6buUdMH
         XgLS3JV0pLqxW+u6ie2/ir7KZEEi+Ovu15uH6e/jVNLvli9WwJ84iaEbTrVP34z7OstU
         QvHcbfoKldWFWyR1VHUU38zONUbx+SZ7cOKLP3pCnzUnSq4SqiVzBF1oEpqFN/2AnsPv
         wAvxaYmkBfxVUl1nCeHBkWJwAMd/t16Vvjf6NmmmdmiwgDKFynSWhjb5FHNRy99mzt2E
         /AXw==
X-Gm-Message-State: ALKqPwcRT0WSK9Reut2P/t5tE6lHY6J/FZ+pl9jpogaMLYsCrV1a8UAC
        v1QafwdnV6g+L3VK63BU5xvvitjuL+jsSF0eQok=
X-Google-Smtp-Source: AB8JxZpdqgKi+Yzn3FpChbCl4ZvPTCBlzj/Et5SjNYg+J0jsS/n+TM6dJOBXjX+fWbsdh+7a1PY6oPnGUx3PfjKWjf8=
X-Received: by 2002:a9f:380f:: with SMTP id p15-v6mr10473045uad.112.1526744344532;
 Sat, 19 May 2018 08:39:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Sat, 19 May 2018 08:39:04 -0700 (PDT)
In-Reply-To: <3b05f4b1-e236-989d-afe0-e85b28c2e278@kdbg.org>
References: <20180519020700.2241-1-newren@gmail.com> <20180519020700.2241-6-newren@gmail.com>
 <3b05f4b1-e236-989d-afe0-e85b28c2e278@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 19 May 2018 08:39:04 -0700
Message-ID: <CABPp-BFjF7ZAjqi79aRbT+0M+stPnrcEXwYoV75qCHTb2oLiXg@mail.gmail.com>
Subject: Re: [PATCH 5/5] merge-recursive: simplify handle_change_delete
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 19, 2018 at 12:32 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 19.05.2018 um 04:07 schrieb Elijah Newren:
>>
>> There is really no need for four branches of nearly identical messages
>> when we can store the differences into small variables before printing.
>
> Oh, there is a reason for the repeated message text: translations! Please do
> not play sentence Lego with translated strings. The original code is
> preferable.

Ah, translations; that makes sense now.  I'm still annoyed by the
code, but I retract patch 5 then.
