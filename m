Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CABEC433E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 17:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D456A223E4
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 17:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgLaROP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 12:14:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgLaROP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 12:14:15 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 397CEC06179E
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 09:13:16 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id d8so18450336otq.6
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 09:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7OzHu5uCniTbjQGCoqzMkr1qpOe6++ntD7KY5iwByRA=;
        b=safu6acbsAY9AwDOxZSTgmK9A5jsfaSDBP9Hp61J4KeIt/03lAkqIKtLEDQvP3SOYI
         UCekpAGSZnPVxkOmWCRsv5GHxxXs7PG11WyjrlJhxgA3v+V0MiTi+y/vj4XaLxLcparW
         NqQlyupA4dpU+m1BVEclKnzLlItF0kmfI97WZOW1ZePMqxv1HpdXevkXGuAcvlkVi5US
         TEym7Qm6Q89EhQT2Td+2G9VQ+SPocXYXTXgvDDB0UwtkOrBldOU+fWoobZQ3ZeY2vEmV
         aDUgv0FpjZDSPTn9o5fCCTl+2JYFUT1DIo/Myl+irhNdLcP/sdxbcBYLBb4dI2VJZ6Rx
         pxng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7OzHu5uCniTbjQGCoqzMkr1qpOe6++ntD7KY5iwByRA=;
        b=jH/il5rWeiFLJz4C+KtycH1dkuLNfGL+OwGcRKP8W2R7RzjaGq4lYXGMnglF+7+6Sf
         0VkEa+oi4EU0FO/1w9scwzpAW0N/R5wGFpich79Lz+Gu0X2PDvdyNsQnNBy2ih/p5NAr
         Yu5N0EGRPHFlwrfWhtHysXYckEJcCZKVzR2N70leEk3sZ/RW5rwjptMmtMizcrUHG8AC
         LaO4l1LpFwUHQl3tSqCPLVA8HEmKmbyuUFDkePVHJ5nC1SdvJyIOJhFQZq82qaPzdl6Q
         vyDwJ2L/ua4emClQb+Db3k1Xxl2kB1HLod1u+oP6sOI9bZBuM2erJXcm/n5ZMts5YJCi
         GtXA==
X-Gm-Message-State: AOAM531pa0HoSBKNTuCoe7KfTfP9AJ/uEym2sI3/cvOJU8k36B85VEEl
        /WL0mFw5QE2KCaro1xbg1v0dUtBbJCKZEUlZ9sg=
X-Google-Smtp-Source: ABdhPJwcZXcSPynZDkR+6IopGW65iIc2kxwoFn3Bj5eOwfazwWH9esk0wKA05zQqGvJPsZrquHNIXjqfMljwvmG7WxM=
X-Received: by 2002:a05:6830:1610:: with SMTP id g16mr42608596otr.345.1609434795648;
 Thu, 31 Dec 2020 09:13:15 -0800 (PST)
MIME-Version: 1.0
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <382a009c18efc8a46a9c0210754f2266c3116ee4.1608270687.git.gitgitgadget@gmail.com>
 <cb08fd8a-b4e1-77d6-7d8d-9f0431db2404@gmail.com> <CABPp-BFrct6hZW8bh5hhRpGSPhjeGO9viCjpO02gUyTqNnrAgg@mail.gmail.com>
 <41ac7d44-e32b-99ed-c928-6325a02ba62c@gmail.com>
In-Reply-To: <41ac7d44-e32b-99ed-c928-6325a02ba62c@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 31 Dec 2020 09:13:04 -0800
Message-ID: <CABPp-BH6RPiTzmVM50HrOyq_Myyyuh_yQO3xwHv0vi-yZbw1Zg@mail.gmail.com>
Subject: Re: [PATCH 01/10] merge-ort: handle D/F conflict where directory
 disappears due to merge
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 31, 2020 at 3:17 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 12/30/2020 10:13 AM, Elijah Newren wrote:
> > On Wed, Dec 30, 2020 at 6:06 AM Derrick Stolee <stolee@gmail.com> wrote:
> >>
> >> On 12/18/2020 12:51 AM, Elijah Newren via GitGitGadget wrote:
> >>> +     } else if (ci->df_conflict && ci->merged.result.mode != 0) {
> >>>               die("Not yet implemented.");
> >>>       }
> >>>
> >>>       /*
> >>>        * NOTE: Below there is a long switch-like if-elseif-elseif... block
> >>>        *       which the code goes through even for the df_conflict cases
> >>> -      *       above.  Well, it will once we don't die-not-implemented above.
> >>> +      *       above.
> >>>        */
> >>
> >> This comment change might be a bit premature.
> >
> > Or perhaps it should have been squashed into an earlier series that
> > was already merged to next.
>
> I think it works with the next patch, which removes the die() from the
> if-elseif-elseif from immediately before the comment.

Oh, right, it's been long enough that I forgot the details and then I
read the patch backwards thinking it was adding the message.  Yeah, it
should go with the next patch.  I'll fix it up.
