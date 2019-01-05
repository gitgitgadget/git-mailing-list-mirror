Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB2D71F6A9
	for <e@80x24.org>; Sat,  5 Jan 2019 04:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfAEEqe (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 23:46:34 -0500
Received: from mail-io1-f42.google.com ([209.85.166.42]:46635 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfAEEqe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 23:46:34 -0500
Received: by mail-io1-f42.google.com with SMTP id v10so31087333ios.13
        for <git@vger.kernel.org>; Fri, 04 Jan 2019 20:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzX3YKfx2vnMTvlzSRrhOS5AsEfApIjyKOMjm7e7tPo=;
        b=TSawu/8MWVnx3Gj6dMDoJJzRK3WjNO2R7o6p+Nq+kFhALcIe5s7xYIs0DNYpi6mIPd
         pXbGLdlYydyeviEyZL1+hDRYIHGYIsAuZRnf7Ihi90q7/aJuo0g0I6SYwohJOSk/bA0W
         DERoYBZRLkFZHafLy4/iA73LehycKpGCnEsfjTlr9cYbTkyKYoqDeuzbZr7syhNtaQXU
         hFFqB3MOqtDgruRUMa3azD/BfKjjeNGIV6STx+ND2YAig0G5n5B6YwpvvP3+f/zMXCLr
         aUwtyMhvtnQI6Z//dJ2ibPumQK04jYmWDRRGEGOzkfC3iKnpmD9fNp+xvk5PEt2EoRSD
         AhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzX3YKfx2vnMTvlzSRrhOS5AsEfApIjyKOMjm7e7tPo=;
        b=rDXvE6DdT+QdEM3siC1KRFGhCyVy5g5ED7C5fWofxZwk96jtG+4QlyZzEFKQdJ1HB4
         k9Dqn7x1fDLz5nU7fLvL0p0S7fm4pAF/P7++Uz+GdCnLl9SakUizJrmqfqZP7kvF99Nb
         JN5n7gu7r7AbwEpmiI3mNuDaZCTfmDUmWvOEecIEIJLcAZ+VsgCkFH6W5KJhCg/LVob0
         tm4cR4DtHMYbh1tsA+33n0YykifqZeFVEteRvp7aqqFNQhlXxRpSU63XZpsQvNFOE3bM
         kbzOaKSCnzYr6WPN7tP0GMdAS+7aUHjUEk4Yd5U6+ee69iM8eIZ7SrHS4AMphmvzm63E
         DpOw==
X-Gm-Message-State: AJcUukceF/LMz1OwCzF8EDFqPOdE4CZzkNdZmMbrfdeJlihBruEySk/i
        RDMLukMcvtVnu0GhhFP01XEjKMVPiI2G+vkMrBWYa5S5uZw=
X-Google-Smtp-Source: ALg8bN6+rqH23673M/FOC4Xs+MZiSr9Bvyb3GlXYTcc2+MP+Xq6gfzlSu+TEOaP21pvgDcYZ4fhyHj/tVX7WE9XXp9c=
X-Received: by 2002:a5d:9456:: with SMTP id x22mr10970730ior.282.1546663593048;
 Fri, 04 Jan 2019 20:46:33 -0800 (PST)
MIME-Version: 1.0
References: <CAFd4kYBX+HrLxbga=VJgC5WjyeDZEznm2UCL+HF8A1YKVo3Trw@mail.gmail.com>
In-Reply-To: <CAFd4kYBX+HrLxbga=VJgC5WjyeDZEznm2UCL+HF8A1YKVo3Trw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 5 Jan 2019 11:46:07 +0700
Message-ID: <CACsJy8Da7+sNfxvTRz1DRn27TjvBXNAipKB=eumA6q+sVsVjcA@mail.gmail.com>
Subject: Re: How DELTA objects values work and are calculated
To:     Farhan Khan <khanzf@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 5, 2019 at 9:49 AM Farhan Khan <khanzf@gmail.com> wrote:
>
> Hi all,
>
> I'm having trouble understanding how OBJ_REF_DELTA and OBJ_REF_DELTA
> (deltas) work in git. Where does git calculate the sha1 hash values
> when doing "git index-pack" in builtin/index-pack.c. I think my lack
> of understanding of the code is compounded the fact that I do not
> understand what the two object types are.
>
> From tracing the code starting from index-pack, all non-delta object
> type hashes are calculated in index-pack.c:1131 (parse_pack_objects).
> However, when the function ends, the delta objects hash values are set
> to all 0's.

Delta objects depend on other objects (and even delta ones). To
calculate its sha1 values we may need to recursively calculate sha1
values of its base objects. This is why we do it in a separate phase
because the calculation is more complicated than non-delta objects.

> My questions are:
> A) How do Delta objects work?

A delta object consists of a reference to the base object (either an
sha1 value, or the offset to where the object is) and a "delta" to be
applied on (it's basically a binary diff).

> B) Where and how are the sha1 values calculated?

Start at threaded_second_pass() in index-pack.c, we go through all
delta objects here and try to calculate their sha1 values. Eventually
you'll hit resolve_delta(), where the delta is actually applied to the
base object in the patch_delta() call, and the sha1 value calculated
in the following hash_object_file() call.

>
> I have read Documentation/technical/pack-format.txt, but am still not clear.
>
> Thank you!
> --
> Farhan Khan
> PGP Fingerprint: B28D 2726 E2BC A97E 3854 5ABE 9A9F 00BC D525 16EE



-- 
Duy
