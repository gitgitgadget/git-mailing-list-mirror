Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6B6C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 06:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiG2GcP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 02:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbiG2GcN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 02:32:13 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B137FE48
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 23:32:11 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id j22so6858247ejs.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 23:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc;
        bh=RZC0FXzHdJ3Jn3KUWPVzvSe/tnpXD5pB1Nk2m2VyaP0=;
        b=GaH7UBc8PLHKYl/hTcXBHZ4wDX/zEys88wdGLOuQNb2f+CiQjEyB4OLhkhXhJvWTz1
         aOFrTRH+yOzHbE9TvWUwDsUZJQuZya71wQxuFLRQSVOzGv3o5UG6Qn2SgxW+uzhWC6oG
         FXSsuw0LWwTIjrJ7t+ycUyHO9eayxd64XYKa+wPNH59/V8UQjBogR2tyFKf9GzMTmgto
         g+6R9c8fcPhoyqa/31Lfib6HpDPf9j8xrswncd0jAL1O8mYhczT6qhmz8vmX4a+mpkyr
         Grz8fQGLXQTnXx0eP449qo2Lzo++XHgs+/dQia+QaH4Pm1ZR4v5nu9RobmdNwC2vIVDw
         0cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RZC0FXzHdJ3Jn3KUWPVzvSe/tnpXD5pB1Nk2m2VyaP0=;
        b=KOnodSRdP1YcHbr4M+nc3rbIwnykYdRUtjM316PbYe2He50FjPNs8tf1HuYQXZDKuj
         97u4FyY2STPTnxmYeVgtZzvhGWNm4Xe2t6cryQgf7NPaW7adgyCfLrLM/OxOQL0vtQ3v
         V6ePSfFzNt9NncW9D4zTSytP725OPzcTxEYrTR4nyvnn2O8cjPprXXz+S6HBpr1bdOe5
         2GNQj82LObXjtNsTcvlQvcmnahoGk5RoYamxnlUkRCF+/HYSaTTM6rPb2tdBh0WCDYZ6
         6E6hEtSQtBCre3iYXujVulMynCBReMXYwxz+PqAhAHc4rEzrQ6aomme7Kg2Wip4NQhPb
         UqSQ==
X-Gm-Message-State: AJIora/3lKF0V+ssPtcvupgLceTpb7WTLmhebWn49VB3CebtjBJWlcQx
        8xelWlUqq+p/ryDh5cLq6D8Mpp+5UUqxcw==
X-Google-Smtp-Source: AGRyM1srkTOWxn2qeX8bPfsLdgbOHdvQ9fAy+ihUxhdrYBDOL4CBeM1m+UElS3LoWAVQy47xbrgyog==
X-Received: by 2002:a17:906:7949:b0:72f:d5ce:c242 with SMTP id l9-20020a170906794900b0072fd5cec242mr1859324ejo.207.1659076329735;
        Thu, 28 Jul 2022 23:32:09 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id o26-20020aa7c51a000000b0043bba5ed21csm1840791edq.15.2022.07.28.23.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 23:32:08 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oHJXc-007Mhq-2S;
        Fri, 29 Jul 2022 08:32:08 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        philipoakley@iee.email, johncai86@gmail.com
Subject: Re: [PATCH v5 6/6] cat-file: add remote-object-info to batch-command
Date:   Fri, 29 Jul 2022 08:25:17 +0200
References: <20220502170904.2770649-1-calvinwan@google.com>
 <20220728230210.2952731-7-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220728230210.2952731-7-calvinwan@google.com>
Message-ID: <220729.86tu70ig47.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, Calvin Wan wrote:

> Since the `info` command in cat-file --batch-command prints object info
> for a given object, it is natural to add another command in cat-file
> --batch-command to print object info for a given object from a remote.

Is it ?:)

> Add `remote-object-info` to cat-file --batch-command.

I realize this bit of implementation changed in v4, i.e. it used to be
in "fetch", and I'm happy to have it moved out of there, we don't need
to overload it more.

But I remember thinking (and perhaps commenting on-list, I can't
remember) that the "object-info" server verb was a bit odd at the time
that it was implemented. I understand the motivation, but surely it was
stumbling its way towards being something more generic, i.e. being able
to just expose cmd_cat_file() in some form.

Which is one of the goals I've had in mind with working on fixing memory
leaks in various places, i.e. once you get common commands to clean up
after themselves it usually becomes to have a "command server".

So (and I don't mind if this is longer term, just asking), is there a
reason for why we wouldn't want to do away with object-info and this
"cat-file talks to a remote", in favor of just having support for
invoking arbitrary commands from a remote.

Of course that set of allowed RCE commands would be zero by default, but
if we had some way to define tha "cat-file" was allowed to be called,
and only if you invoked:

	cat-file --batch="%(objectsize)"

Or whatever, but over the v2 protocol, wouldn't we basically have
object-info in a more roundabout way?
