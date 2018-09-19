Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F56B1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 18:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732702AbeITAN1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 20:13:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42755 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeITAN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Sep 2018 20:13:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id g23-v6so3061790plq.9
        for <git@vger.kernel.org>; Wed, 19 Sep 2018 11:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cajUU4bHyCOR2OUCCoSnrXw3TyRwTUQ0JbXZ9vwIS4=;
        b=Z+cWCV9Z/sLu8epupftYicIM1Mt4V3TrrqZeQDlmfICuzN4iQlDsarxrR6yBV6ZrPD
         vceLTWluPiuqrfM+Qyebph0NSPxzEvOngrudZgpynH0Scsv/RFLWk1aAJNz26sPAZisA
         X9EwLOocJk9vdz/ueXhmqc77K+eOhYHWaiIgOsuzOpLNLX7K+0mZdO25AJUOkXXd6gpA
         e2J0UO2Hdwt57jJ2YpjkQmKNWOhJn4aJUm7BB6Ye4mQ8NVRYarWmo7zIyruNtxr7Y/SY
         tlShP/yfyxyKpG/r1z6kpVO6uTmygExkFJWwRzZCuo2cEJoB6DeCYYrv3egiWL7MQBdW
         W0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cajUU4bHyCOR2OUCCoSnrXw3TyRwTUQ0JbXZ9vwIS4=;
        b=FbtIli2fzAPUAsIZb0gK8Fdan4/5fQUKRtHYptYQk5vVGpAorbiKqGmxTbsriPOL2j
         S6dg7hlaeucWaWH7hZZRsPiMNW33suyFbgb5S9REdsY4n9n1anPGK8rbSSR2lBRxotfm
         34LyR4cFCc8B40fdN8tjjMolTP8zF0tYCFQFHajO9q7XnBWUpiG6umnrkLg2kVT5lnhZ
         HCZ3G16Yyig3qYbDuB0drwdCdq5bmXe6LmJUkrOTjpKVX5k846yawxRKmSdO8/k6GECw
         Ktk2qP79N9vD3zRS4Ua3TKJOtiWTHjXCd5RLthIlKUAijPHRaTD6rCiz9GiJuV/bGgsy
         LH6g==
X-Gm-Message-State: APzg51BReYIF/oAYAugVYCDJ7Bk71QH6ZD0Kdp4KG8OU/bG9owcpfIpZ
        0Bixq2/nKyfuMk067f+cz9AiozZT6YQN6KF5fY8=
X-Google-Smtp-Source: ANB0VdZGW8yZBIbNbZTjfig+6iJyMs8ltx1Q4IMJWD402OtAC3G0U46PeRk3rshCV4nyyDfIteeR6L06Dom1KPM7Qno=
X-Received: by 2002:a17:902:9893:: with SMTP id s19-v6mr35823349plp.130.1537382057369;
 Wed, 19 Sep 2018 11:34:17 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com> <20180919034907.GA7626@sigill.intra.peff.net>
In-Reply-To: <20180919034907.GA7626@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 19 Sep 2018 20:34:05 +0200
Message-ID: <CAN0heSpMRfDd7=E_kYL6ucL9bL2VWMGLTAkT72BUrVwR6YTezQ@mail.gmail.com>
Subject: Re: [PATCH] pack-objects: handle island check for "external" delta base
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 19 Sep 2018 at 05:49, Jeff King <peff@peff.net> wrote:
> This is tricky to do inside a single "if" statement. And
> after the merge in f3504ea3dd (Merge branch
> 'cc/delta-islands', 2018-09-17), that "if" condition is
> already getting pretty unwieldy. So this patch moves the
> logic into a helper function, where we can easily use
> multiple return paths. The result is a bit longer, but the
> logic should be much easier to follow.

> +static int can_reuse_delta(const unsigned char *base_sha1,
> +                          struct object_entry *delta,
> +                          struct object_entry **base_out)
> +{
> +       struct object_entry *base;
> +
> +       if (!base_sha1)
> +               return 0;

So this corresponds to "if (base_ref &&".

> +       /*
> +        * First see if we're already sending the base (or it's explicitly in
> +        * our "excluded" list.
> +        */

Missing ')'.

> +       base = packlist_find(&to_pack, base_sha1, NULL);
> +       if (base) {
> +               if (!in_same_island(&delta->idx.oid, &base->idx.oid))
> +                       return 0;

This logic matches the removed code...

> +               *base_out = base;
> +               return 1;
> +       }
> +
> +       /*
> +        * Otherwise, reachability bitmaps may tell us if the receiver has it,
> +        * even if it was buried too deep in history to make it into the
> +        * packing list.
> +        */
> +       if (thin && bitmap_has_sha1_in_uninteresting(bitmap_git, base_sha1)) {

This matches...

> +               if (use_delta_islands) {
> +                       struct object_id base_oid;
> +                       hashcpy(base_oid.hash, base_sha1);
> +                       if (!in_same_island(&delta->idx.oid, &base_oid))
> +                               return 0;

This does some extra juggling to avoid using `base->idx.oid`, which
would have been the moral equivalent of the original code, but which
won't fly since `base` is NULL.

> +               }
> +               *base_out = NULL;
> +               return 1;
> +       }
> +
> +       return 0;
> +}
> +
>  static void check_object(struct object_entry *entry)
>  {
>         unsigned long canonical_size;
> @@ -1556,22 +1607,7 @@ static void check_object(struct object_entry *entry)
>                         break;
>                 }
>
> -               if (base_ref && (
> -                   (base_entry = packlist_find(&to_pack, base_ref, NULL)) ||
> -                   (thin &&
> -                    bitmap_has_sha1_in_uninteresting(bitmap_git, base_ref))) &&
> -                   in_same_island(&entry->idx.oid, &base_entry->idx.oid)) {

Yeah, the new function looks much simpler than this. We have

  if (A && (B1 || B2) && C) {.

Knowing what to look for, it can be seen that we can -- under the right
circumstances -- have A and B2, but not B1, and try to evalute C by
dereferencing `base_entry` which will be NULL.

> +               if (can_reuse_delta(base_ref, entry, &base_entry)) {
>                         oe_set_type(entry, entry->in_pack_type);
>                         SET_SIZE(entry, in_pack_size); /* delta size */
>                         SET_DELTA_SIZE(entry, in_pack_size);

Without being at all familiar with this code, this looks sane to me.
Just had a small nit about the missing closing ')'.

Martin
