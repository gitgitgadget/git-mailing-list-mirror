Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 325301F424
	for <e@80x24.org>; Mon, 23 Apr 2018 04:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeDWEwe (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 00:52:34 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:44327 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750915AbeDWEwd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 00:52:33 -0400
Received: by mail-qt0-f179.google.com with SMTP id j26-v6so16263635qtl.11
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 21:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2r/ykE2jkInUCEoq3JxIWoU9ef6PbYoZU7Z0FPbnOC8=;
        b=XnlBo25Q2ddW3sRegNx5MNqlH1uE4RO2YbFSZHZf87cpGP9dtqynOtop7m+XPQUvvq
         vYya1GNsX75SNfaRrJv+1sg5JT5DYq4r8pJe1hGRerdbtr/otNWMmY/V/poiQzs5JGOl
         jK+Zn4+tcXVMfRbLIsIS9u41j2el5/UyzArNixjj1QxJiPb7Lpc2h9TyMX4BovULrJX3
         ki7AwnyVYK1JMdLJZwZKN2KDB3//T89FfdkNPJ3+j2KoFLlwJZ4QJiDOvPYQkxmvWW1L
         HgNvilBaw77MZiuoempljMXzNMiiyVmolJ0vubdllZtrsOBKSGBYXCV02dGqwn4Lz+Gm
         cpug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=2r/ykE2jkInUCEoq3JxIWoU9ef6PbYoZU7Z0FPbnOC8=;
        b=hZCjxmr42r6d1Pahr+Q1q2EX90sVzVhv2V3KXTQFCobmIhNaxF/ioMU/P6kYWqEwD6
         VftMDxz42/45ZRN1NkbbJ5LLUqcnPkEDhfwgBdLQMyu88SMQTfu+G1cFPwL9pJwYXIiX
         i1efpgpmn6P7MBCF3Igtw+PsjANXHYhDOZ5gNKVX8XWhrgfuV0LPC4AIFrm9APZ3whm1
         ZtTu2Yb07dC9Korg2HVnBfSwXV+JltekHlq01XbIHCwJQO09GRMji8Jtst39BYeRP/g2
         ZTO76FDMJOAIWyJNKFi6BwCP857CPeTXJCRFRWysiaqf3AY+8v24LBQQMmTjiu03dm5J
         2Rkg==
X-Gm-Message-State: ALQs6tC7Ftg2g+LQx94woj8jVDDhk6fghpy7LqWVibzM91Lqa2COxHCu
        SSqLb7bsmcW5T1Z/p+jhaNel+Qg/ppPMpDVXD0Q=
X-Google-Smtp-Source: AB8JxZpXMM0lTx+EyPDKjJzrXJZ/NkwlN+EhLtH7FV4AAWUHyPfIW56dcv7PbDFrt4JQVxfnJ8NZ3gDgbKSxKPbzTvw=
X-Received: by 2002:ac8:1204:: with SMTP id x4-v6mr8408598qti.35.1524459152711;
 Sun, 22 Apr 2018 21:52:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 22 Apr 2018 21:52:32 -0700 (PDT)
In-Reply-To: <20180415202917.4360-1-t.gummerer@gmail.com>
References: <20180331151804.30380-1-t.gummerer@gmail.com> <20180415202917.4360-1-t.gummerer@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 23 Apr 2018 00:52:32 -0400
X-Google-Sender-Auth: IFRk1EiK3G0n5rR7yy6YvNVOdIM
Message-ID: <CAPig+cS=8na1Rm-DkZANez_kitU_WFQAbsqLxYe5dWUtsfdO8g@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] worktree: teach "add" to check out existing branches
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 15, 2018 at 4:29 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> The main change once again in this series is the user interface.  It
> feels like we went in a complete circle here now, as this iteration is
> bringing the "Preparing ..." line back (although in a slightly
> different form than the original), and is moving away from printing
> it's own "HEAD is now at..." line again.  This also means we don't
> need the new hidden option to 'git reset' anymore, which is nice.

I'm glad to see the proposed hidden git-reset option go away, and am
likewise happy to see that worktree no longer wants to print "HEAD is
now at" itself. I'm much more pleased with the direction this series
is now taking than in earlier rounds. It's also much simpler, which is
a nice plus.

> I do like the new UI more than what we had in the last round (which I
> already liked more than the original UI) :)
>
> To demonstrate the UI updates, let's compare the new UI and the old UI
> again.  This is the same commands as used for the demonstration in the
> last iteration, so please have a look at <20180331151804.30380-1-t.gummerer@gmail.com>
> for an example of what it looked like after the last round.

Thanks for presenting examples of the new UI under various conditions.
Like you, I find the new "Preparing..." message superior to and much
more useful than the original.

Aside from the problem pointed out in my review of 2/4 in which it
incorrectly shows "detached HEAD" for "git worktree add wt
existing-local-branch", I think this series is just about ready, and
hope to see it land with the next re-roll.

Thanks for working on it.
