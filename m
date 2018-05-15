Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8310E1F406
	for <e@80x24.org>; Tue, 15 May 2018 01:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752162AbeEOBqA (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 21:46:00 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:45979 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeEOBp7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 21:45:59 -0400
Received: by mail-yw0-f196.google.com with SMTP id g9-v6so4195936ywb.12
        for <git@vger.kernel.org>; Mon, 14 May 2018 18:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1O7qBTqKRtnuWy1QmDlvFxZCQl6pyzWTMcHIczJvSbU=;
        b=WlDDCUcMixOgwb2R6CjdTrA7B9zS5O7igOB4p9gUpmMFJ086dAOeyVh6T32VDMNXRT
         owttUJPVc3l4+4Hg2wY0ps2g9gsFck9Ll4tEXqzDjLidVrHHle77OvQF3XAcrkeFmuHT
         OxVWj06HAkPjMorQfHQPWNr7wvcJQXLFPR+QOYSujd3ZxGzaQLUR6B7ZeujtD0TH1v3b
         S6rseJp4sNBS4dkX7NXcOBOo9rnKpv3VuFass/3gHLhXLwprNfjaLGCIIeF0Oy9L90+U
         7zdnRVPxIvuQRY5QUP0Hp9pUID/Hj7WliO4WtRuyvZtBxk31XIjISZygOc6bkFRbheXX
         MMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1O7qBTqKRtnuWy1QmDlvFxZCQl6pyzWTMcHIczJvSbU=;
        b=uCr7vjCJFjoEItGUbIQcKoWqVtlE4nkLlrGpfPP12hwnkgzletBMwM1tX9A9jkJEU5
         iZNiqYM3u2lRS7Q6EOB0rq3Rumf9ziJZnYNYsWVIpoTzNMyi/vj2WICQdxPvxtKA6HPi
         0pD0iy4fB5lkzZjox91Pyc5ogaJtWH49dRPDrRehdFNEgrX24MJDgz5IjFdLLOAZ/7Ca
         k5vKdh/TuMqOoZYUgewpaC4FvlIIE7JbJLPT8OFz3Oyb4eqVPCHZBtkdyOmnGToLmzHu
         /eMw9sv/G+hHk3k/ksLxYvbtshPqAKetLv1B/Sncoy1+2/jSgY7SjSlzhqK1lfx9ukjj
         rgog==
X-Gm-Message-State: ALKqPwcPTVTQQtpfpFWxfqfRWk/EzfPJr8ZUYXN7ebbg2YCO4hMu9e9a
        PsgoDZuHMsdf5z4DyPGZx3nr1nbJqggFmiaj8FtIr4tz5tA=
X-Google-Smtp-Source: AB8JxZqZJuer3H42I7EvhtM2Xa9mrI8pD0XR3q2DnYOpcp8GqyhdcKcnH4hLmpqNTVIvL7KdKPdGtYYt+z31rOsm9j8=
X-Received: by 2002:a81:37ce:: with SMTP id e197-v6mr5694779ywa.340.1526348758710;
 Mon, 14 May 2018 18:45:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cfd8:0:0:0:0:0 with HTTP; Mon, 14 May 2018 18:45:58
 -0700 (PDT)
In-Reply-To: <20180514105823.8378-10-ao2@ao2.it>
References: <20180514105823.8378-1-ao2@ao2.it> <20180514105823.8378-10-ao2@ao2.it>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 May 2018 18:45:58 -0700
Message-ID: <CAGZ79kYP_ensQR6caaxCwabvcLDdvJNLu2C8DT-jzy+oP7BpJw@mail.gmail.com>
Subject: Re: [RFC PATCH 09/10] submodule: support reading .gitmodules even
 when it's not checked out
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>,
        =?UTF-8?Q?Daniel_Gra=C3=B1a?= <dangra@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Richard Hartmann <richih.mailinglist@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 14, 2018 at 3:58 AM, Antonio Ospite <ao2@ao2.it> wrote:
> When the .gitmodules file is not available in the working directory, try
> using HEAD:.gitmodules from the index.

I think HEAD:.gitmodules is different than the index (the former is
part of the latest commit, whereas the index could have changed via
git-add, that is not committed yet).

> This covers the case when the
> file is part of the repository but for some reason it is not checked
> out, for example because of a sparse checkout.
>
> This makes it possible to use at least the 'git submodule' commands
> which *read* the gitmodules configuration file without fully populating
> the work dir.

Instead of checking for an explicit sparse "hidden" could we just rely on
the file missing? Then I could continue using submodules if I just
"rm .gitmodules".

>
> Writing to .gitmodules wills still require that the file is checked out,
> so check for that in config_gitmodules_set.

That makes sense!

>
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> ---
>
> I am doing the is_gitmodules_hidden() check in the open for now, I am not sure
> whether it is approprate to do that inside stage_updated_gitmodules.

Why do we need that check at all?

In your use case, you want to checkout *a* .gitmodules file, not necessarily
the .gitmodules file of that repo you're currently working on. So it
sort of makes
sense to prevent cross-repo changes (i.e. committing the .gitmodules
accidentally
into the wrong repo)

Stefan
