Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDE2F1FAED
	for <e@80x24.org>; Wed, 25 Oct 2017 04:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbdJYEl1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 00:41:27 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:50066 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbdJYEl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 00:41:26 -0400
Received: by mail-io0-f172.google.com with SMTP id n137so26284178iod.6
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 21:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qNSHAIQPcTHwF0o/UXxK9oPM4dFQNNX/yQvg3xK/kg8=;
        b=uQqw8cT1ZiUZCm1FhWSQ1Ze7SIKyV+ajNHfbvrRU3O1I0jB0+qiR8AjsZ+kJPu9AAK
         fzzzCvdVTG1Q8UpWfAhw3XLugSK4U/OEGfWDfB7hBntZQ2yytr5btJ47oINF+KEKpyJq
         Th2zqkzywhmyz+LFT1MmpH8M2n+ZkR3hkFvuvNRh3yb5xL/BFOkSYJ6BosTE62RaClFw
         IyIc0GgdjD70bfMGudNsqdclEY8YWHE6vj2YYwOj/VpbqY+f5LLo3IKu4mJpMkVQAjwp
         eY3cQI8ECk/AJIQ80b/VnSf4TBXalYIjtkU/BWc7OjpzCZebOdqfmE/iWYf7aUAl8ZTA
         djGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qNSHAIQPcTHwF0o/UXxK9oPM4dFQNNX/yQvg3xK/kg8=;
        b=Lo1HZsM92294VadVpDppIDujRUfmsF2lmV1Jr0BWnxKWyeIhqPqkc33q+I4YhfPVWg
         Mkw9IPwN3c4NaeH5WreQx0aZhGtpsHzE0SkqxA8S7Hxg6s0MgLitg+0+nODHiFngRbDm
         7Pw21jLKZ3PzOP40lLWwpMmyAo93de+AXIxKU4zSgXx0l+B4Y4WXafOIJMkmBlk6gu3Z
         g/24IisOcqCsVKVyJ9LCb6mfDS2349cM2hll/A2zrn7yujqSfzlRrez9QaNhtU4OxIa2
         KYjoiLw9Incue6kvuOKDmHYwNnnqbpIxrn0s0kJpUxOs4jvq75L+YDQ4hFpblOUoazy8
         w2fg==
X-Gm-Message-State: AMCzsaVq0d7+oOi5gh20BWcUeRTKhYn/5CSPZjlRI3OPcV3djLiRK/kt
        FlsmIo1FIixH5227X/UwPCqOAsnjb2kRBPGTpflTkA==
X-Google-Smtp-Source: ABhQp+T0g97PbjZMInwXDDIZrnGZHo0liVBtlnJxtWor65PCT/ic2WEz5EDaaAEUv8uohKb51yl0Jvub6BcDmQax5WA=
X-Received: by 10.107.8.100 with SMTP id 97mr23956063ioi.83.1508906485971;
 Tue, 24 Oct 2017 21:41:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.174.66 with HTTP; Tue, 24 Oct 2017 21:41:25 -0700 (PDT)
In-Reply-To: <20171024185332.57261-11-git@jeffhostetler.com>
References: <20171024185332.57261-1-git@jeffhostetler.com> <20171024185332.57261-11-git@jeffhostetler.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 24 Oct 2017 21:41:25 -0700
Message-ID: <CAGf8dgK3pW8T4Tst6LZuJxLZTDjk7Ak5iwK0WYBSLrWR1S8YBg@mail.gmail.com>
Subject: Re: [PATCH 10/13] rev-list: add list-objects filtering support
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 24, 2017 at 11:53 AM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>  static void finish_object(struct object *obj, const char *name, void *cb_data)
>  {
>         struct rev_list_info *info = cb_data;
> -       if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid))
> +       if (obj->type == OBJ_BLOB && !has_object_file(&obj->oid)) {
> +               if (arg_print_missing) {
> +                       list_objects_filter_map_insert(
> +                               &missing_objects, &obj->oid, name, obj->type);
> +                       return;
> +               }
> +
> +               /*
> +                * Relax consistency checks when we expect missing
> +                * objects because of partial-clone or a previous
> +                * partial-fetch.
> +                *
> +                * Note that this is independent of any filtering that
> +                * we are doing in this run.
> +                */
> +               if (is_partial_clone_registered())
> +                       return;
> +
>                 die("missing blob object '%s'", oid_to_hex(&obj->oid));

I'm fine with arg_print_missing suppressing lazy fetching (when I
rebase my patches on this, I'll have to ensure that fetch_if_missing
is set to 0 if arg_print_missing is true), but I think that the
behavior when arg_print_missing is false should be the opposite - we
should let has_object_file() perform the lazy fetching, and die if it
returns false (that is, if the fetching failed).

> +       }
>         if (info->revs->verify_objects && !obj->parsed && obj->type != OBJ_COMMIT)
>                 parse_object(&obj->oid);
>  }
