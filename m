Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB1DC76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 17:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC0RkK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjC0RkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 13:40:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3B21BCE
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:40:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bn14so5618304pgb.11
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679938804;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXIv8z5HZsiLeSCGqsGtI2BZAtKpd4bxtpVKB4ZnxYg=;
        b=gA3JQYTgf2biuXoPNivO6QUITwfIzGqdFKg1kJVidLDrWSNxiSBSx6B7/H3JrVX61x
         +DkjyAEDx0OEnDCE3jnTU2gq/KaIUJqF3q6vGcAE0iuP0y1f5OkfBvXx1ThSifaTMzaG
         jUlBAfBl2ApeI9L0bP9FiMRwRfSO+1KVRBYMog4SR/4fBG8jkl5vnoxD+lDbeWI7xtv8
         KgzXPxPNo5Ecdn/FHKiXl2GRbHu3HMdj7DuViOw6s3V7bCBsy3ru2wQd2iUJRIPWoHNC
         ytE7+gOjMAkOFOYM2hmy5Pq7abfmsNCvnVUqFexXQbKFj/w49nzgMnFzasz8QQAudYvS
         FF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679938804;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SXIv8z5HZsiLeSCGqsGtI2BZAtKpd4bxtpVKB4ZnxYg=;
        b=HO+pZeTwCacv/w1crrBRUOkzHmvZUKQAmy3kaSDieODmiYmdKtfSLdZ03g3cYYeV2v
         vQnAhQ4rdIGAy2Sr5yeM3r514zWR6FhsR3RX/YwmyE1s0V1ry5B6AC0jp3jxx95rpSDd
         bn8w2ujWRFw6Rc92eURkLNuiHBSz4E7w5MdbNfrK5NZteap88BPyFDX6APnSSk8Cg6Ya
         QN8cxyfUAOnmlD102LHQDCrmmhYsumdbSlh2TpGrZODS2N5s15FeI/QcKOeZpsDIwGyD
         YXW1eM1tGqTzuOPsJ7j6/v98JhEkjVVYErZaP6Cnn5XLllo+aMgLynwKL/ol8FDt1Hom
         v4pQ==
X-Gm-Message-State: AAQBX9f95E+dccdFZYaMXRMLZo80C9h9F0y9mKK0Sw/w1roJMlOwdUe3
        roOLCahpbqwYhe47pHdzQVA=
X-Google-Smtp-Source: AKy350YVH1CqoHikNDPhCG8ETqwjiKnm63zoJx0o5joEFi6SPd0U1blhSpBR5pmv0vHNlGH/eaJfQg==
X-Received: by 2002:a62:7bce:0:b0:625:e051:e462 with SMTP id w197-20020a627bce000000b00625e051e462mr12326245pfc.15.1679938803775;
        Mon, 27 Mar 2023 10:40:03 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id c8-20020a62e808000000b005cdbd9c8825sm19335643pfi.195.2023.03.27.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:40:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] t3701: we don't need no Perl for `add -i` anymore
References: <pull.1504.git.1679898996492.gitgitgadget@gmail.com>
Date:   Mon, 27 Mar 2023 10:40:03 -0700
In-Reply-To: <pull.1504.git.1679898996492.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Mon, 27 Mar 2023 06:36:36
        +0000")
Message-ID: <xmqqzg7yaya4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> -if test_have_prereq !PERL
> -then
> -	skip_all='skipping add -i (scripted) tests, perl not available'
> -	test_done
> -fi
> -

The version before ab/retire-scripted-add-p partially touched this
line used to use !ADD_I_USE_BUILTIN,!PERL as the prerequisites, i.e.
"When we are not testing the built-in version, skip this script if
we do not have a working Perl".  Now we no longer have the scripted
one, the former half of the prerequisite is never satisified (i.e.
we are always testing the built-in version, and there is no reason
to see if Perl is available).

With this the topic becomes complete.  Very nice.

I read the changes other test scripts touched by the topic just to
double check, and it seems this was the only misconversion.  t2016
and t6132 had the same logic but spelled in different ways, and
there were converted correctly back then.

Will queue.  Thanks.
