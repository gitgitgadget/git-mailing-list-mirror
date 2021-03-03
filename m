Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9767C433E0
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 891F464DDA
	for <git@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355297AbhCDAWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581590AbhCCHeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Mar 2021 02:34:09 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4474EC06178A
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 23:33:27 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id w3so2942177oti.8
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 23:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpXRqi4/vSjcUEJS6JoAcbau4uddP+IV4FfyhhGUop0=;
        b=cMVOx9zZJRp1gmlZFw4opDhVmczq0vY+N995r9N/bfXghtlGO6Z79fFekNr+wxyOwI
         H5UXw/ibhIQZHZSxiQksrKuJb1u062Vndltx2VvAiBLYaF+WJTMd3hacMSzya7ZmVFNn
         O4zg6ZVDcC+8K4o54ilas6TXEqXkUuIkIrgl0Mz9+mR5+aRy7bL3IFqOb9k8vlukII1b
         Kf0+nGXBOVT9rH6/xSMQSNXf4/dZQs7jdqzJrmskibrkTbm/CyXWY3wZ0gbusAiQ+r/u
         GI1ZAwaAZ3LOJd/LK6oykw7RPSsLpxIao6MRmsTTOLQgyt8GVBtXLRjkIhZyr69E8fqQ
         J96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpXRqi4/vSjcUEJS6JoAcbau4uddP+IV4FfyhhGUop0=;
        b=hkehUAZpMUdreooUqx5/YQgUII+njGivMSoj3ovYz3Oe7d5Ky4mkrFwx2h+B1RsBgS
         GiwoL32T1Lh3fCPxJfBtFAMbc8zbEG1cZw7NhjuZHutfzR4JucCIVxUWn8oCfCTO0FQM
         T/1pfG+IY1tQ7Jb8cdTR7QM0d3umf2+MRhBoI1fHSWjwyLVxUX5bl9Uvbau6Ee+utH4h
         5Fy8QuCD8+sc2W3rHDhzrIqc/321U7KD+L8rfFL8QJu/voIAV9wq6plFdM8KYScces5D
         Az8enl+OJ7k+TOzVCBs8Rc2grtaQF1zOTrc1H//Ln4/pYY3CJ7XGRa48OpEiAbdSYYN3
         nhGw==
X-Gm-Message-State: AOAM531cw80XRGFqseDOuFAfDS9szStr9ZZp6B6Ts/ebWbOF/dmDieZo
        M0Jhp72MWVjETpSmLfVBIlnL3Hv7Q+XaoGk664U=
X-Google-Smtp-Source: ABdhPJwutATokC4q9hqRCDcrxI0iQ+OAn4+wO2/007hcD/dT3ZPquv4kg1iC6mVJULKbE9xGYDWmshhVJEWwXPTN8Nk=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr21640933oth.184.1614756806693;
 Tue, 02 Mar 2021 23:33:26 -0800 (PST)
MIME-Version: 1.0
References: <20210301084512.27170-1-charvi077@gmail.com> <20210301084512.27170-7-charvi077@gmail.com>
 <xmqqczwir9wx.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqczwir9wx.fsf@gitster.c.googlers.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 3 Mar 2021 13:03:15 +0530
Message-ID: <CAPSFM5feuZ99qM1M9sxeX3hvbvcu3OXHhcQWhJZc1_PZJHH8tQ@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] doc/git-commit: add documentation for
 fixup=[amend|reword] options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2 Mar 2021 at 00:14, Junio C Hamano <gitster@pobox.com> wrote:
>
> Charvi Mendiratta <charvi077@gmail.com> writes:
>
> > +--fixup=[(amend|reword):]<commit>::
> > +     Without `amend:` or `reword:`, create a `fixup!` commit where
> > +     the commit message will be the subject line from the specified
> > +     commit with a prefix of "fixup!'". The resulting "fixup!" commit
>
> What's the single quote in "fixup!'"???  We also have an "amend!'"
> below.

I think I mistook it from the previous discussion and used a single
quote instead of space, as earlier it was "fixup " and "amend " which
was technically correct. But I will fix it and replace it with
"fixup!"  and "amend!".
