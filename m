Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3A81F404
	for <e@80x24.org>; Thu, 15 Feb 2018 23:09:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756495AbeBOXJv (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 18:09:51 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34753 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752872AbeBOXJu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 18:09:50 -0500
Received: by mail-qt0-f194.google.com with SMTP id d14so1803408qtg.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 15:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/Gn8EzvxICY74Geq2v8KjrWMntXlkrTICxQ6L62gpsQ=;
        b=FXX+AQEZdCdrHv7Y7k+r3718dr9XkhcZJyiM0hGsuaXlAuYAJjcnKLMmJEIsw4/6nt
         N0BqozIGROHf3OHlEhJGHmfqM7SYJDiS46kbM/WzpF/NSZeIDpqA6jmdFDf7Q22eFrCV
         JKNAfj1gnLLrcWQfH48BkF/fPEQZljB2cA1LbODszQs080HIYCvdE/5uFMeBSKasjqUN
         wJf9CmwfELYsPud99nmbvGWzkSMam1rAMrR4b11fnQLltkPT/7bTnFzdP4Y3C6DbYzgM
         oliZ+kz3V0xwtr/QWlrE50xfS3x7KFM+4V8u3j98eAAcY75vIyFLIKPmgfyCHi62P4u6
         8XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=/Gn8EzvxICY74Geq2v8KjrWMntXlkrTICxQ6L62gpsQ=;
        b=WC2Csecd90xdrooA3iMm43XJt3fC7QMNd8rkLpI9jeJIleqCWiHkdpH3AKnrzBc9qr
         0vlzhmpHF5B8Qqe5IsboYGCJV9UUobkPBSnJgaAkmgdQzOL/CnO1ar/8jEV/yoM/8NNh
         8DUHKjcGgMEvHeaNJbnD0ypLnCrQ6gdA7NSEkmn33IB8ynZhng4Sf2jhmu11G7VAY2QN
         3o4rPFrGKuPDb41YEI1Odukf2WurswMg0w8ZmWasIEObzzJa0d9ZrLX1exEbLJMj3hta
         suZBpejOWU9+s/+EyKjW+ZUisofQmFUif19WVQ5fav1Pjnhi27I4DzS6uqesQnHXMJja
         7n1g==
X-Gm-Message-State: APf1xPB7G+KmBwzsoe9fV9k34mGiBxS6F3ON2vq5lrrzjzx8JlfQymCk
        meI+Il+aWKWgA4X1JZ/4cCDCVgfaPEh4pq35bYM=
X-Google-Smtp-Source: AH8x225w3FgH+scOqVFPb0VXEJ6fViL/eZdBKn3KLhvf2Isa3N3jsdPNityLIX/nlZW1WRopN1Ze2NkdEHhIMLBhMIk=
X-Received: by 10.200.55.81 with SMTP id p17mr7301784qtb.282.1518736189599;
 Thu, 15 Feb 2018 15:09:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.128.40 with HTTP; Thu, 15 Feb 2018 15:09:48 -0800 (PST)
In-Reply-To: <20180215212751.GA42108@flurp.local>
References: <20180212031526.40039-1-sunshine@sunshineco.com>
 <20180215191841.40848-1-sunshine@sunshineco.com> <xmqqh8qi7z7o.fsf@gitster-ct.c.googlers.com>
 <20180215212751.GA42108@flurp.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 15 Feb 2018 18:09:48 -0500
X-Google-Sender-Auth: p7SQBixxzLRV9hdyCCvEH2KFIkI
Message-ID: <CAPig+cTjGygRjy8Yagdd=U=5j7PqHqunbYVvm0dkq23QjLOaOQ@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: add: fix 'post-checkout' not knowing new
 worktree location
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "Gumbel, Matthew K" <matthew.k.gumbel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 4:27 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Feb 15, 2018 at 12:52:11PM -0800, Junio C Hamano wrote:
>> This seems to segfault on me, without leaving hook.actual anywhere.
>
> I'm unable to reproduce the segfault, but I'm guessing it's because
> I'm a dummy. Can you squash in the following and retry?
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> -                       const char *env[] = { "GIT_DIR", "GIT_WORK_TREE" };
> +                       const char *env[] = { "GIT_DIR", "GIT_WORK_TREE", NULL };
>
> If that fixes it, can you squash it locally or should I re-send?

Okay, I was able to reproduce the crash on FreeBSD (but not MacOS or
Linux), and the above change does indeed fix it. I'll send v3 in a
moment to address it.
