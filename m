Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 859FFC433E0
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 22:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54B90207D3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 22:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlGgm3j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgFPWcC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPWcB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 18:32:01 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E018C061573
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 15:32:00 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id g5so55445otg.6
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=le3qfX3py9rdoQEqkOB2Ui5dsPii7OGyjRFtfpSAIHY=;
        b=KlGgm3j4H6RJidDxYZDVHqZtBvQfxEcTgW2o6JpjUoP+GzzO9Y9hk0uYJ0VuDY1cit
         ZmQ9KZHMush2/FGvl5Ux35YiZBD62nliWD+Pv0Anhb1523B+9xlkubvrEYDV4q8Xy8J8
         QAqL0QExj8ldLt6XqZOGru5kLjrnfUtzPjuY78sE6kayem0smsUfzVrfc3nebrqKDY3B
         y2ae/+uXHjk8xCz/2BJ+hQXN6QgKFwSr3et7V9yRqZX4Ze5sOQAAN1uQMRjLKeuZxj78
         OPl5B0+2Z0iiCqsyMJAxcDKDOVl9/boz0ny3+hv6HtyHQJu/duImuEeQzIyPcX0gLbdF
         aOwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=le3qfX3py9rdoQEqkOB2Ui5dsPii7OGyjRFtfpSAIHY=;
        b=YfaaFkrohhr/DoFDxtyEIQohL7sMtYUSTCgjC48VzMeUjjeYbbaIaRqawlNH7pS9fF
         yJDsJlgjbwKfwtlFbK//b9ZSYOeL4ECtTJyaLtWFFOVCUQS+gS+mb2RSTCtIsLBRs5LV
         x1KTsSYw/Gx9PaSE3+bazlouqRwdWqBW4+facQ54Nhq3oAbCB6I0cb1hulenXHrwZzrg
         MaVFyYYYcZojUlw8g/q9IVit5QsRDJSym8szSDH0q8zVYxCtKiEyhwGZ/cPQGpiTe+Po
         Dz7rdAiMB4rm2yX+HGtKs/ozbJVzDIiy7rkV45WBIgjCVjx+GdiYmDTyFq+YEsk5Udkd
         TQQg==
X-Gm-Message-State: AOAM533zanMAKqiP90naGfHg3gMTuy5LH2tRTbClXzzB8bVu16Mj8phR
        ++2lERekcVcKF60G/Qz+dk+39DXGgLo+SR4yMpk=
X-Google-Smtp-Source: ABdhPJyVAXYvwFZc9vtP3UphQ5850RQknOHeMIm64oyiwoxLp6lTE66PO2v1T8jsxm9TF6TexIsjaNn5LJNJmFyQ8gk=
X-Received: by 2002:a05:6830:1d8c:: with SMTP id y12mr4421188oti.162.1592346719764;
 Tue, 16 Jun 2020 15:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590627264.git.matheus.bernardino@usp.br> <cover.1591974940.git.matheus.bernardino@usp.br>
In-Reply-To: <cover.1591974940.git.matheus.bernardino@usp.br>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Jun 2020 15:31:48 -0700
Message-ID: <CABPp-BEJsY6ut0Xqk+vD++0wuqgu=oG_xRA-D7tO4Fsu-piujg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] grep: honor sparse checkout and add option to
 ignore it
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 12, 2020 at 8:45 AM Matheus Tavares
<matheus.bernardino@usp.br> wrote:
>
> This series makes git-grep restrict its output to the present sparsity
> patterns. A new global option is added to toggle this behavior in grep
> and hopefully more commands in the future.

You've cleaned up all the issues (or corrected my understanding) from
my comments in the previous iterations of this series; I didn't spot
any additional issues in reading over this latest version of the
series.

However, I would like someone more familiar with submodules and/or
config to take a look at the changes to do_git_config_sequence() in
patch 4, as I commented on there, if we can find someone to do so.

Thanks for working on this; nice work!

Elijah
