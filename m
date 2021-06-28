Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04946C2B9F4
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 15:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF082619B2
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 15:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235634AbhF1Pxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 11:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbhF1Pxr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jun 2021 11:53:47 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF4EC08ED87
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 08:35:11 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i13so33352454lfc.7
        for <git@vger.kernel.org>; Mon, 28 Jun 2021 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hBxdqn3LA4ZOz8MycUDmHrLZHOZ98cKZjaqGbA9ZTww=;
        b=H0QXrVSamAyIuqz7PTbNBEJ98ECkyFi55lMVj6jbhdpJ7WUow8aiB7HtB86PJW9SGM
         qyt1xUt14WzMAMSV4y3jGsz69MrBxQTdImdZF9xZTK/1y0BQYuItR+xEZ8QX/mJyzgFS
         IyuHvPlap/AIObUapOf4bT77IoLLyoj8M7HBIFn2R0HvTauYBhmW6EsWqTHOSzoycaW3
         9GN+xljPLOWfE9Bk7sLNzJIsWbfTI7CHoP3U9kDghEqyTI3sYZtKEzRxJtGw7oYyxpF5
         6ddAWepA+p3vacVP2MQmgUrffD6u5tRn8NjAK52hkGRR49MyZRgxT6c0tr7Aj5nO3qCt
         8voA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBxdqn3LA4ZOz8MycUDmHrLZHOZ98cKZjaqGbA9ZTww=;
        b=QWCtB/gQS3MDqa5WXB35W1gZhMgdV1xamYUTHUNfWN4p8m9gzgTriY1wmBjDoZa1D5
         qmJVozLdI0NEWy7o1vr+Uy+9eN8QjDWphdtrwgKJgNKLJNEVGoYxDK2YnFiQ4AUAUiAN
         AVqTAYqF8OGGNc/Pj2U9aQsdJTxuq2jbgbMJUC5xUtn6KtKoqOWg5wiYmhDsMQWuA5Cw
         Ip471MYt1Wv2S0VkfkOggkq3SGP8WQHqTndVR5EAp99nEXHrxtzLEyaqYeI5uGba0vgG
         pu2OPjVljssw2Qndxijco6hxX0WPZBoKZ9LS0mN07vwaBGoTkVhgcEFyym7ZsjDRZABc
         aaeg==
X-Gm-Message-State: AOAM530GmhEQtFt77KfdavQkNNVJFOOjkB5p2dNxvqKucJ+n4RLK4pBX
        J8LTBFtXA5u0oUo1LYSaYgC+/difijsB7izw+Cki0hnTIzk=
X-Google-Smtp-Source: ABdhPJweKpIxdN1N2xJSiRdEBFYdl5kHT+fJvIzRAIR9KjFkZmUJ7ge72H/D6CdegqehT4Id2/Dl3fBhAlrJA0nPP30=
X-Received: by 2002:ac2:5d2e:: with SMTP id i14mr18671104lfb.642.1624894509826;
 Mon, 28 Jun 2021 08:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <7dd55e85-38eb-7346-ff10-7124102cd22b@pawsey.org.au>
 <435b0150-cd9f-32ce-7a07-3057ef20662a@iee.email> <12dd4f05-456f-c763-441e-5bb16634306a@pawsey.org.au>
 <070e36dc-f126-661a-3af7-b44d47ef7861@iee.email>
In-Reply-To: <070e36dc-f126-661a-3af7-b44d47ef7861@iee.email>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Mon, 28 Jun 2021 08:34:58 -0700
Message-ID: <CAPx1Gvcu9XzZF_LbV8YFsiGhL1DPwki-BNp5-5ZeB9BeiRj1AQ@mail.gmail.com>
Subject: Re: Definition of "the Git repository"
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Kevin Buckley <Kevin.Buckley@pawsey.org.au>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 28, 2021 at 8:24 AM Philip Oakley <philipoakley@iee.email> wrote:
> My main point was that there is this creative tension between the
> different contexts and that beginners should be aware that it's not all
> cut and dried in the same way that language definitions tend to be.

Users should be aware that users are humans, and humans are
not consistent.  Nothing is as cut-and-dried as it might appear, ever.  Or,
as Kant put it: "Out of the crooked timber of humanity, no straight thing
was ever made." https://en.wikipedia.org/wiki/Crooked_Timber

(If you want to put fine distinctions on things, some parts of a repository
are repository-wide, and some parts are work-tree-specific.  The git
worktree command, when it adds a new work-tree, adds a new index
and HEAD and *_HEAD and other work-tree-specific refs, for instance.
That said, I still teach that .git mainly contains the repository proper,
with the rest being your working tree -- or, once we introduce git worktree,
your *main* working tree.)

Chris
