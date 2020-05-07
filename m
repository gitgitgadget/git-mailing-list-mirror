Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27008C54E4A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC75F207DD
	for <git@archiver.kernel.org>; Thu,  7 May 2020 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC0k3mN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgEGOCf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 10:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgEGOCe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 10:02:34 -0400
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com [IPv6:2607:f8b0:4864:20::a2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBBAAC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 07:02:33 -0700 (PDT)
Received: by mail-vk1-xa2d.google.com with SMTP id b14so1507111vkk.10
        for <git@vger.kernel.org>; Thu, 07 May 2020 07:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TaUOTAX80o/mFE835NGxU9j3KWRHgvL23SMNwlQK5F4=;
        b=iC0k3mN7D0xa+r43QvszbCZRhGyehD1dprwyeYJNSzANahbZaeQFSZqAWDfqaWrbAZ
         s0YXlQj/Agf9n+PqO1WcNiO9JKObE7gZ/Ayfod3eJwXUdQA9rhAh2FO+YKq6GwQlOzua
         KThBAUxMo3kseY9kGgTDirdeqGZY8w9/27iZdgG5kMOx/IQoz6zoZf4720BhbeFCCaWh
         hu9tpQGTaVpTM/wwpPKmyl29H8P/1xkJt9I3q4hwXRVyvBvJ2brYIHhlwwxI4Y8LkS2B
         GgILAdrdYy0cA2lTN0n45FB6HhP3CP9Wiv1zyK2Q7W2sTIR7OIxxio4N9xqvZa1jI1Jh
         1MyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TaUOTAX80o/mFE835NGxU9j3KWRHgvL23SMNwlQK5F4=;
        b=MfYiotKpkdQ/DzPqprKQ2pe8PKyDZkNziFNElAU+FZHpjamzbhBtF+7bodwP3QQLEd
         XmxBt8ECe7dUsVQM0UILpKOL9s95C4Bv/Of2FuW8z1hf8SSQXNcQ1tC6Qz1mNoNFh9ym
         PrQht6yX2kUsTTqg1rzNZbWKjcxXace6T/2+11vv2xvrziPddXRjx2PCzpyQmG0vFk6l
         tC8g6HT2qzzw1e6x5A23v8Xhi6V9lh96FvM3rSv1YNwB7Mk3FXAdmtHt+Pf2v7wcL17j
         43/RJZBu3sIt2vSrzj8tMrRaCXsLMIfb3zi0pRMdzQuIep08fzZ1c1al1uXyjuxl/OI4
         iWEA==
X-Gm-Message-State: AGi0PuY8RmHb5C+VzMJ0Qor912N1xvsk2+vpQWrOsEDVPaD4+IPmLOVV
        MJqK0rpRHj0nfJU4Uoca9OMqN5ZhzpZtfvttxi87n2oy
X-Google-Smtp-Source: APiQypI9eBf9LEF6ylLSVcqqj5VPIp8Na9iM3n+8Kpy9dhp9WTDBWARDpG5AId3LTRMqIR3yV0jYhvv/2TDbY/w1LK8=
X-Received: by 2002:a1f:9605:: with SMTP id y5mr11435613vkd.75.1588860152951;
 Thu, 07 May 2020 07:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <CANtMP6oKN6Ueu=fqFYv2VhUP5S-ifbSzPTARvbEg4eV0pcRcHw@mail.gmail.com>
 <xmqqzhak4a9o.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzhak4a9o.fsf@gitster.c.googlers.com>
From:   Solomon Ucko <solly.ucko@gmail.com>
Date:   Thu, 7 May 2020 10:01:55 -0400
Message-ID: <CANtMP6pSgU2WfuHVug-dj=10LNOL-mLL-5rTio=q3GjUs5MrgQ@mail.gmail.com>
Subject: Re: rebase -i: quick/inline reword
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 12:52 AM Junio C Hamano <gitster@pobox.com> wrote:
> It is probably a bad idea, as it encourages a single-liner commit
> message without any body.

You could modify the title and keep the rest of the message. You could display
the modified message similarly to how `reword` does, to allow modifying the
rest of the message.

> Besides, neither is really workable, as the single line text after
> the abbreviated commit object name in the todo list is meant as an
> output only "informational" comment on each step, and there are
> plans to add more than just the squashed title paragraph there
> (cf. *1* for an example).  Even without such a future change, the
> material there may not be just the commit title, if I am reading
> the code correctly, when rebase.instructionFormat is in use.

You could have some sort of separator between the title and the rest of the
info. You could disable the extra info when using this mode, if it's a
command-line flag. You could require the title to be at the end to use this
feature, possibly after some sort of start marker.

Solomon Ucko
