Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4130C3815B
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 20:14:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C5820736
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 20:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDTUOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:14:09 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44751 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbgDTUOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Apr 2020 16:14:09 -0400
Received: by mail-wr1-f67.google.com with SMTP id d17so13760294wrg.11
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 13:14:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iBQ5IIe1wk2jmbJ3akvvDM8mcgXM0zLdLxq1Hy2WUR8=;
        b=I1VZjHMFx1/ba5wLlCtn/T6WkIplL1o6JBZfYMCNwutM2M52lrcSxaSpPjcCJdQ65J
         sJWoZRmY81hPR8TfjCZoDD2pt02M4K3Ydvwcg3sVEgU6xGN6E/ilhMOuVH85JnQARy6m
         hgXRs84C1qbYzL3qDqNamEAaJ1Ds6TfCKLmBx2zRuT3OFNjEUzSVrSnRGKyVLyFWb6iX
         hWZ0zdoxlm/Nud9YfEKatJWJ/PK/Eu0rrLikkRMZA+ssBgPvYZrMLPcbZX1g+NNRdcp+
         VDYMkmU+gJHj4skBiWBjB1B3Zc7WOG1sv7tXrYDNlMZjQSfcQI0NUB3no/RFaFj/nbEQ
         JH9Q==
X-Gm-Message-State: AGi0PuapiP0n+eFFbhj8cuD2IQn2N8XfiXdIU2FcEu1J09teEm5FWYg0
        HqnCcQVV5qzczoW1qBxBxAITpBAYTjc73KfeObs=
X-Google-Smtp-Source: APiQypIXd0rqQyj5O4Ej9JOH4pSJ4VR04HKKoLBn19u1JYg5+NfQ+qQg/XhgInXB6tzw7ceG8i379hfx34b6CVuiXpw=
X-Received: by 2002:a5d:4ecf:: with SMTP id s15mr21905930wrv.226.1587413648171;
 Mon, 20 Apr 2020 13:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587372771.git.liu.denton@gmail.com> <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
 <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com> <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Apr 2020 16:13:57 -0400
Message-ID: <CAPig+cTdwZjSVePSPTj4GxJm9CvGXppRNxjvsCTdU8TA1NRDkg@mail.gmail.com>
Subject: Re: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 4:09 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Hmm, this doesn't look like 'test_cmp' mentioned in the commit message.
>
> Yeah, the other hunk is about test_cmp and this hunk is about
> svn_cmd.  The stated rationale applies to both wrappers, I think.
>
>     Subject: [PATCH 6/8] t9164: use test_must_fail only on git
>
>     The `test_must_fail` function should only be used for git commands;
>     we are not in the business of catching segmentation fault by external
>     commands.  Shell helper functions test_cmp and svn_cmd used in this
>     script are wrappers around external commands, so just use `! cmd`
>     instead of `test_must_fail cmd`
>
> perhaps, without any change to the code?

That sounds fine.
