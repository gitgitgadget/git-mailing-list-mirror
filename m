Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4418C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 07:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbiKYHLP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 02:11:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKYHLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 02:11:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78467193F8
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:11:08 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id b4so3372856pfb.9
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 23:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=uRZlNoOtCy2puii9p8qJdP82+nvzzjI/w3P320ifPM0=;
        b=jGAskP+2KnbMW8k6JElMV+iNyddbBikNZVAhfaw/34QdWeD4WW1LCuCqwjCQY14Iz4
         mDEm9FiIM5BuHWM67nqZem6ddVvYrnoCQTAXfX1kfq0dm8pHYuMu9Wv9wk/voNYFvYLX
         YTPdz9jklPwDRvr0wlIBpKPLbQZr7eRxwmi1SSjOjP3gAvv+pYFrgTbAI930QGUdmX7C
         s8ApJHfHds1J+1Diqmi+vb+HOyaLSWj5IBtp8ivQlSZ+fo1zlIi9gvyG6vg7wT94OJmq
         GGBwPokhc8QgoXdK/33ZWQOThHukvYifPu8OYC0fIRDiUq4HthuijtAKPBRVGQprzJgn
         DpcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uRZlNoOtCy2puii9p8qJdP82+nvzzjI/w3P320ifPM0=;
        b=iV6lhC5hesGLNzt2qy9ia+Sd7jd+/l8aRFRYHFlWBSCE+wTFWxl9Sk69HG7lfyDDtK
         kl//462T5rLqLnbiqU/DUCKmNxxTu7pCHZxevt4G56mg8dvhAMpO6FIj+rwFNLT9NbHc
         wJdktEjh+/VLaEGAI76F8JYo4BIsZL04v8/szaYhA/X+gGrAjA74tcDlKj+L6IPaTE8V
         Txk1IvxJNjrwrXlffmJT1qoL/haGFZezGXBlhL3Nn2MCh942yqVpzDIOp0GpK+EAlitv
         IXatXmHblEwwzwPeHovBEFEPjNhkhfNORY/kMePZTRyDPXTM9ZoRT88SjGaEZgrmy16v
         FrEA==
X-Gm-Message-State: ANoB5pliIF1OvVV8PGVJmYbdCWNKiAHYv1AX+FZPRYeyEYTWeI2ggi3V
        VIwc8DJUWyZi++cYiFEBHCc=
X-Google-Smtp-Source: AA0mqf4leW3Zlsu3TvAdePngwRFoGjYoapBZLWwP3/h5DypxkyF29D7AMSzvCFOTuXilRM6rRGIgCw==
X-Received: by 2002:a63:f408:0:b0:477:bb62:d3d7 with SMTP id g8-20020a63f408000000b00477bb62d3d7mr9758316pgi.375.1669360267821;
        Thu, 24 Nov 2022 23:11:07 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d18-20020a170903231200b001780e4e6b65sm2587313plh.114.2022.11.24.23.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 23:11:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Meyer <kyle@kyleam.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] send-email: disable option auto-abbreviation
References: <20221124020056.242185-1-kyle@kyleam.com>
Date:   Fri, 25 Nov 2022 16:11:06 +0900
Message-ID: <xmqqv8n3cxv9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kyle Meyer <kyle@kyleam.com> writes:

> send-email supports specifying format-patch options.  However, some
> valid format-patch short options trigger an error because Getopt's
> default auto-abbreviation is enabled.  For example, with
>
>   git send-email -v 3 @{u}
>
> the -v is consumed as send-email's --validate, and 3 is passed on to
> the format-patch call, leading to
>
>   fatal: ambiguous argument '3': unknown revision or path not in the
>   working tree.  [...]
>
> Disable Getopt's auto-abbreviation feature so that such options are
> properly relayed to format-patch.  With this change, there is some
> risk of breaking external scripts that rely on the abbreviation, but
> that is hopefully unlikely given that Git does not advertise support
> for auto-abbreviation and most subcommands do not support it.

I personally have no sympathy to those who drive "format-patch" from
inside "send-email".

Having said that.

Many subcommands of "git" do take uniquely abbreviated double-dashed
option names, but it is true that we do not allow --vanything to be
given as -v even when there is no other double-dashed option that
begins with 'v', so "git send-email -v" that stands for "git
send-email --validate" indeed is an odd thing.

But robbing "git send-email --val" that expands to "--validate" from
the users is going a bit too far, I am afraid.  The right solution
for allowing "-v 3" given to "format-patch" I think is to make
send-email understand it and pass that through.  The presence of
both ("validate" => \$validate) and ("v" => \$reroll_count) in the
GetOptions() argument would prevent "-v" to be taken as "--validate"
while still allowing "--val" to be used as an abbrevatiion, no?

By the way, do we advertise support for any and all options to
format-patch when the feature to drive it from send-email is used?
Some of the options (e.g. "-o <directory>") do not make any sense in
the context I would suspect.
