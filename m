Return-Path: <SRS0=8LOk=DA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F82DC4727D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 297F22220D
	for <git@archiver.kernel.org>; Wed, 23 Sep 2020 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSlrOtVK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIWS0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Sep 2020 14:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgIWS0J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Sep 2020 14:26:09 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D66C0613CE
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 11:26:09 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w11so996827lfn.2
        for <git@vger.kernel.org>; Wed, 23 Sep 2020 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOVjvPjBG2BlYmgWQHqbtEFYkMqSG/Smtn3Y8Di9tQA=;
        b=TSlrOtVKPZ0UYwRCUlJTL7BTYBMwSEtwPR9sOZGjgzvURCr4gqvCuLGRee7rxLFswi
         9lyqAWzPZ+t4NmFp5YFQU2WJ8sZECk5FrC6UYOm8ZpjKAZLaxSPR5GW964q4Vf6pYXQq
         vlANuT0dLhOEKK/rp/uFOMZM8GbcEjngIKV2CfOnwWKHr7hcGmAqzznTjwOR0hZmvV3h
         JDubrlfQ++9Q9TELllYIZthZ5ep8xQqYuRrMdDAk3055efGYX1HJRhOv6zC0iO8C5huu
         DK1sX6+93AsMm01nib3MlU9lL7i9Y9g3j4VyvVGgO+Df/6NfJ+g3g5utLW738oRajK4w
         Rp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOVjvPjBG2BlYmgWQHqbtEFYkMqSG/Smtn3Y8Di9tQA=;
        b=tvHmsJIjmk5GYJz4FMnXurYgMwfSTQI3HPKMJ6qCFpIBhx43qM8mbL1l8lQBBVQpVV
         8RznMkCIbTF3RKDnxi47H0wp7iyX+2F971Z+tsGEHQn4TnJU2+BLQ4Hd/mK4N8enYYVp
         ZpMTZBnVY0u+w9y355OdvUbonbeJfW1Ew/Fak/oYc/S2An/XIMp4KIdqyKSssUAfOCiR
         MqH9HO3w8hip4q61nxVMzo7Bjf8t4PgOAMdodjELj7jwjC65bjXLC8mc4ozPoz7CzkfL
         xiqQ5VESNYbs+6aff3wIkoqbKNrTuDG51jgIfHAb6uSDOUCAFtJHVYJeEguzjY/992B2
         OS4g==
X-Gm-Message-State: AOAM5321UOwsPelEuj2pdCKOZp3GZIFpvHiw8uwJ56yp/t3W/cE5uO72
        t34AbdCuY7XT78dqfwfTcRUJd+gyXdy3/BoU9HVcGBwMKcaO4g==
X-Google-Smtp-Source: ABdhPJwNj3kHwHOUqPBKeVlfewyMhK7lTp0ZCzVWAtszOooh0KWSR24W083klOXK9Gb5VLzUN9s97X8UZlisdGFy318=
X-Received: by 2002:ac2:4433:: with SMTP id w19mr391966lfl.548.1600885567726;
 Wed, 23 Sep 2020 11:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <1093128c646b154a14d89321454f5361c0e616b4.1600854717.git.liu.denton@gmail.com>
In-Reply-To: <1093128c646b154a14d89321454f5361c0e616b4.1600854717.git.liu.denton@gmail.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 23 Sep 2020 12:25:55 -0600
Message-ID: <CAMMLpeRD6hKuAHjHh2AXrx1PVXHx7m9haUPAR_uNHR=YuT5xbQ@mail.gmail.com>
Subject: Re: [PATCH] pull: do not warn when opt_ff is explicitly specified
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 23, 2020 at 3:56 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> In d18c950a69 (pull: warn if the user didn't say whether to rebase or to
> merge, 2020-03-09), `git pull` was taught to warn users if they
> have `pull.rebase` unset or `pull.ff != "only"`. However, this warning
> is a little too eager about happening.
>
> If the warning is silenced by specifying `pull.ff = "only"`, as
> instructed, the warning will arise again if the user runs
> something like `git pull --no-ff`. However, the warning should not
> happen as the user clearly knows what they're doing.
>
> Don't display the warning if opt_ff is explicitly set by a command-line
> option given by a user.

Hi Denton, thanks for working on this! We can also assume that the
user knows what they are doing and does not need a warning if they
have run `git config --global pull.ff no`. So really, we can just get
rid of the check for strcmp(opt_ff, "--ff-only") altogether and
instead only check !opt_ff. Could you do that and add some more tests
to t5521-pull-options.sh?

-Alex
