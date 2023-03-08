Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ADEC64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 20:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbjCHU7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjCHU7W (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 15:59:22 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EADC6A2D8
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 12:59:13 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id n5so48431pfv.11
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 12:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678309153;
        h=mime-version:user-agent:message-id:in-reply-to:date:importance
         :references:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKaLjQquxV9/T+5p5BvSahrs9ymEZ4Twg/4XYrUiaOg=;
        b=ne7DRwdHs1cum8dQ2nN7+Uyt+Vmw1eYLLWiYRks/vQKNkw1xrn9uiD+3IluRyIGBsi
         ZpbxJdTgotn/CxsF7lh0h7xatKic/hvH4re2dxpfbtKY7TAHbQ7r5nn1r7eyHMFv51c7
         IOfrpmMsq7EgFCsua2YwY5ZHJh4E3h3SbKQXijGh/D8L8P8F/gajCwDZ1bfkQ6ibsKQH
         spB7hXaiQJuNVYC00E03deRioGXN5aR+/B3s4I2FbH20emRZ6I5eSEzrA66wEvxleAz/
         4NjB2t7TOMsf1sUGUFXfTAu4vfv9E2DocSWq/P2kO9AJADAwV15BVyzQRUDIZN2PttiG
         wvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309153;
        h=mime-version:user-agent:message-id:in-reply-to:date:importance
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKaLjQquxV9/T+5p5BvSahrs9ymEZ4Twg/4XYrUiaOg=;
        b=1t2j9Id2mSgwZ3XHXFBdeVBeIZxjRJIuyLOsMHPK4O/p7iqetDEEZykKYIIABMtpRJ
         F78i38+gp8fmuxBhM0jFyyBB4+sy9DSVDIUInCOsf90aWkpNY5KJ93j9cVrg9RJtbeAo
         bzsbaq44OJG6UTKhHsdSwjs6zkdCU6OfHPcfmZbPpEcUrispLU8DmjFkL9Xzrpag0zcs
         VCglhfsa6SmLzROE7J/GnZMs8/WQTzBVWBWNzLY/OLAuNsQGRqGNKJLGt8zRghcJmbyE
         +h+miAkjsj+Kzxp3V1uTuvqK7grUwc3MBDelHllrnkUwMWulqKbUDs0yJedN5307gnJN
         iKog==
X-Gm-Message-State: AO0yUKU37vjCGK0wIq8FbXy5dD/ot78HhnhNf4mkgQFrlCvzj0pGEjnp
        rd5TGD2nwe31zaZRuaxPwTMRi2MilmM=
X-Google-Smtp-Source: AK7set+B8C1aVftrzOZN/a/juAsF/ooJ/uKmKgMcGQQ+BFlxL9S9IYdIfOXIkRxXB/Lu3dzW2tC6FA==
X-Received: by 2002:a62:e917:0:b0:5ee:7c9e:9afa with SMTP id j23-20020a62e917000000b005ee7c9e9afamr20039649pfh.0.1678309152663;
        Wed, 08 Mar 2023 12:59:12 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id i8-20020aa79088000000b00594235980e4sm9788352pfa.181.2023.03.08.12.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 12:59:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Fangyi Zhou <me@fangyi.io>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: fz/rebase-msg-update (2023-02-27)
References: <xmqqcz5snyxz.fsf@gitster.g>
        <007e6f051381d86da6881644ce300b6eea944194.camel@fangyi.io>
        <xmqqttyww9tl.fsf@gitster.g> <xmqqpm9kw9no.fsf@gitster.g>
        <37ed877d5927c7cebba7e47769be3a069eacd6c6.camel@fangyi.io>
        <xmqqa60ow7nr.fsf@gitster.g>
Importance: high
Date:   Wed, 08 Mar 2023 12:59:11 -0800
In-Reply-To: <xmqqa60ow7nr.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        07 Mar 2023 13:52:56 -0800")
Message-ID: <xmqqjzzrrmcg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> Besides, localizaiton teams are already working on what has been
>>> in 'master'; it disrupts their workflow to change end-user message
>>> under them.
>>
>> The patch fixes a newly added i18n string, not the option itself,
>> see
>> https://github.com/git-l10n/pot-changes/blob/pot/main/2023-02-04.diff
>> I found the issue while conducting the localisation for v2.40.0.
>
> Exactly.  That's not a regression.

During -rc period is when we are supposed to concentrate on
regression fixes, and I am not strongly inclined to merge it, but
merging it would not be _too_ bad, either.

If we ship the final without the patch, what happens to users in the
C locale is that they may see a message that says that the
rebase.autosquash variable is incompatible with use of 'rebase' via
the apply backend.  If they then inspect their configuration with
"git config rebase.autosquash", they will sure find it set, and
nobody gets hurt.  Users in locales other than C may get the same
message in their language, and again, there is no harm done.

If we ship the final with the patch, users will see the message
about rebase.autoSquash variable if they are in the C locale or
locale whose translation can be updated in time, and their
inspection of "git config rebase.autoSquash" would show that the
configuration is there.  But it would equally well worked if they
said "git config rebase.autosquash".  IOW, your "hotfix" may be
fixing something that is no big deal in practice, even though it
would have been much better if the original patch was done that way
for consistency.  The only losers if we merge the patch in the last
hour before the release are those users in locales whose translation
is not adjusted in time.  They will see the message about
rebase.autoSquash variable untranslated.

So, I dunno.  To me, merging the topic as part of the ~20 other
topics slated for 'master' post 2.40 release looks like much better
than hastily merging it down before the release.

Thanks.
