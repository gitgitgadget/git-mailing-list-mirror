Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787541F597
	for <e@80x24.org>; Tue, 17 Jul 2018 19:52:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbeGQU0L (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 16:26:11 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44837 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbeGQU0K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 16:26:10 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so2365316wrt.11
        for <git@vger.kernel.org>; Tue, 17 Jul 2018 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jkdVow07maKRhay+FOoVfN7RplZVeu/iWvpFDgVPRHg=;
        b=LIr5dtluGg2qS6eT2Us0hp6Q+tKOHpsGkXAjMy11UNXOjSmdDwgi2teohi0jVelYwx
         REtvwLkUytpqrrb553FFKhRkXanyYWptiMSp5XP/ebk0iEXSCDTdUZTG2wvfvQYnA1ni
         2tKTUrx4sbb0tFKCD+BkKyPSRogkqRCts836opCkIQ5Jf+5viSgkNCfCC4LBJC1eTit6
         A9XFH/Qi/unlL2JXnMZS7MjF2VGKObf04KIJxVCHfqn9hVJ6v4YmJ7K6Fefsem/DlcE9
         cb/0vsr22X2zOsChC+dtLx8Xr0tEZL/sWuFolQvxr/RU3pdxxjMBT6cVwc2tI2nrnSSP
         kZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jkdVow07maKRhay+FOoVfN7RplZVeu/iWvpFDgVPRHg=;
        b=cN8bW81w9D+b5n4dz00pHe+8AUDvJXQWmmZO8rbTNdionFVLNl3b8Ji0i2UkfMQ6+M
         LNacgkCHdbCcYZGJesxR3AbeadYW5w4HI/6f/NE7HmMAzNH6kMsFC0+skO9zQAXabHOM
         Ad41JIXl+Oiq3awheDNmC9XdgkLJXPc4GEuEH++O08Ua9r1q5xgEkWsNuA1/qN1U4q9R
         w/cN5QqT8FlT5PkFzKt6VDjjkAcwF3d/PYlKHxT55PcIXgk7Tb+iVCCw5YF30qbtdEyL
         wBpsbV+ud1mj54+bWGe2XUu+qC8b9Cc3KY8RGfIIOBpeJxfUrIgxbWIxO6XYSM/YxhaW
         /tdA==
X-Gm-Message-State: AOUpUlH30Ox14AYCpl0sn2sVYnXfJvlo2jx1U5hNqpPqE5AFYNI+uniE
        3qbSiZPl1RBRf/1LPu7f+eE=
X-Google-Smtp-Source: AAOMgpfR3HtfoyUTRjOb+fX+sfIMp0MUVofiZOFCIAuVasuCNvaRpRiML9RqUO0HS6rL3TR5c/TO4w==
X-Received: by 2002:adf:eec9:: with SMTP id a9-v6mr2456521wrp.21.1531857119732;
        Tue, 17 Jul 2018 12:51:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y11-v6sm3136552wrr.84.2018.07.17.12.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Jul 2018 12:51:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] git-submodule.sh: convert part of cmd_update to C
References: <20180717002654.120375-1-sbeller@google.com>
        <xmqqmuupogei.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
Date:   Tue, 17 Jul 2018 12:51:58 -0700
In-Reply-To: <CAGZ79kZtrmjODGi1j-HRbchZYuALHnms22=wWBV1AF+zUBru_g@mail.gmail.com>
        (Stefan Beller's message of "Tue, 17 Jul 2018 11:53:29 -0700")
Message-ID: <xmqqa7qpod29.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Actually I thought it was really cool, i.e. when using your queued branch
> instead of my last sent branch, I can see any edits *you* did
> (including fixing up typos or applying at slightly different bases).

Absolutely.  I did not say that there needs a mode to ignore log
message.

> The sign offs are a bit unfortunate as they are repetitive.
> I have two conflicting points of view on that:
>
> (A) This sign off is inherent to the workflow. So we could
> change the workflow, i.e. you pull series instead of applying them.
> I think this "more in git, less in email" workflow would find supporters,
> such as DScho (cc'd).

Sign-off is inherent to the project, in the sense that we want to
see how the change flowed recorded in the commits.

With a pull-request based workflow, until Git is somehow improved so
that a "pull" becomes "fetch and rebase what got fetched on top of
my stuff, and add my sign-off while at it" (which is the opposite of
the usual "pull --rebase"), we would lose the ability to fully "use"
Git to run this project, as we would lose most sign-offs, unlike the
e-mail based workflow, which we can use Git fully to have it do its
job of recording necessary information.

And much more importantly, when "pull-request" based workflow is
improved enough so that your original without my sign-off (and you
shouldn't, unless you are relaying my changes) becomes what I
pulled, which does have my sign-off, range-diff that compares both
histories does need to deal with a pair of commits with only one
side having a sign-off.  So switching the tool is not a proper
solution to work around the "sign-off noise" we observed.  One side
having a sign-off while the other side does not is inherent to what
we actively want, and you are letting your tail wag your dog by
suggesting to discard it, which is disappointing.

> The other (2) downside is that everyone else (authors, reviewers) have
> to adapt as well. For authors this might be easy to adapt (push instead
> of sending email sounds like a win).

As I most often edit the log message and material below three-dash
lines (long) _after_ format-patch produced files, I do not think it
is a win to force me to push and ask to pull.

> (B) The other point of view that I can offer is that we teach range-diff
> to ignore certain patterns. Maybe in combination with interpret-trailers
> this can be an easy configurable thing, or even a default to ignore
> all sign offs?

That indicates the same direction as I alluded to in the message you
are responding to, I guess, which is a good thing.

