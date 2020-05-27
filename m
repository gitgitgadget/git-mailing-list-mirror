Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A48C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC9192071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 22:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvi+KMJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgE0Wyt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 18:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0Wys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 18:54:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884EC05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:54:48 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l10so3154779wrr.10
        for <git@vger.kernel.org>; Wed, 27 May 2020 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMLu4V6lDgmX1dGkJWw2HDIFTI9/IuEK07nxKryCbsA=;
        b=mvi+KMJFPEp+VBf961yS1vqTk/MB5R8eplRwep/Cwj3fQvLRGuNhBZSzJOoUp3Fc0S
         g0UcnIolrFpHClkQtrNPxU5pLZLX2+nvkTWk7AOl8neCdYJ3I8EYOaz5LgWzAMj8g5rM
         IK6AOJ0iHi/7iaFwO1uSXReABfO3BzNXRVV7rOiAX5iV08yX82xwAyRy9nMgFRYgPEFw
         CbVwvvz6UwBOQWsJQK7uOtTIVEib02v9zalgNtRfNvjS9kCAgPW/6YF6jL06hM3vuYj9
         bbrZHX/6EKXICLw2ihP6dBJYmgwdjfLZEm/YV5Dx6SGU356KUe0Q/pdhMpHMI+s9Monz
         JFiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMLu4V6lDgmX1dGkJWw2HDIFTI9/IuEK07nxKryCbsA=;
        b=paMc8ovSj8JVBKNsCG8a/9eU1JhQ546ZuhC9VVjwRL0wbd1+qr0cujxJMAkp5CAODT
         ldBOXhM7ubAC4lWfDz95BRKRDkE3LcCxY/KttP+pDP5AHB8Ou3xGT7sUHpvFJaAN7vi5
         ZCLHf7KNy3ZRFGFpRGEznkGm4SHPJglZUN7/HWWC7xSd9fl6B4j7NiaPNdypynbgoTKe
         n5txoNxEZoqfWY2kikfwy7/PAfbF1EeGFLAc9jWsjZc4bWlYAEY8vGifegevfoLZCuSh
         f6alQ0IA3F2RfEYKXulFr8sPM6YDosAAtzLBAiZnFEwtD7xj8KBgMXgS8N08C5hFwHyP
         YOmA==
X-Gm-Message-State: AOAM533MVeqLd47E0lkvy3otUJwRqCALRKioEwVXbhifyWnlXP56ee9c
        hiafzw9rGdTfN+8NGcKYOn3Pm0PIjvf0Q0i3I2tik0m2
X-Google-Smtp-Source: ABdhPJygnQojmo9c6auPhZc+zoLchjRRWJNY9WtFkd6szCE5F/lHKIV09yZHIPbT1K2IxI2r6350IinBcJ47AcVLfMg=
X-Received: by 2002:a5d:5384:: with SMTP id d4mr508485wrv.277.1590620085815;
 Wed, 27 May 2020 15:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAMP9c5k=Ci8eQyOdzW7a-sssgp9g9TJ+rxAAPF3YLDCr7t6wrg@mail.gmail.com>
 <20200527224824.GA546534@coredump.intra.peff.net>
In-Reply-To: <20200527224824.GA546534@coredump.intra.peff.net>
From:   Zach Riggle <zachriggle@gmail.com>
Date:   Wed, 27 May 2020 17:54:34 -0500
Message-ID: <CAMP9c5=kRAfKqfWL4AJg1m9c-3OwG1Vv=vBaiOhsD6abjtXH=A@mail.gmail.com>
Subject: Re: git grep --show-function treats GOTO labels as function names
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Awesome, thanks!


Zach Riggle

On Wed, May 27, 2020 at 5:48 PM Jeff King <peff@peff.net> wrote:
>
> On Wed, May 27, 2020 at 05:29:08PM -0500, Zach Riggle wrote:
>
> > It looks like there is an issue with how the parser handles "goto"
> > labels, as it treats them the same as a function name.
>
> By default, the function-finding isn't aware of the specific content in
> the file. But you can associate extensions with particular types, like:
>
>   $ echo '*.cpp diff=cpp' >~/.gitattributes
>   $ git config --global core.attributesFile ~/.gitattributes
>   $ git grep --no-index --show-function -e FOO test2.cpp
>   test2.cpp=int main() {
>   test2.cpp:    FOO
>   test2.cpp:    FOO
>
> Usually this is done in-repo, but since your example used --no-index, I
> showed how to set up a per-user attribute file. The "diff" attribute
> covers both diff and grep (for diff, the hunk headers will also show the
> function).
>
> The "cpp" diff regexes are built-in to the git binary. We just don't
> associate any filenames by default. You can also add your own; see the
> section "Defining a custom hunk-header" from "git help attributes".
>
> -Peff
