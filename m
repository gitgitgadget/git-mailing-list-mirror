Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08051C00140
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 01:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244680AbiHIBIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 21:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbiHIBI3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 21:08:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5061D332
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 18:08:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id kb8so19690550ejc.4
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 18:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jqbDgqlfD8Qt7u61qNp/OpKjqQMYQ0bLlS2eBVDi084=;
        b=QYwL4Sfg3qngRg4K2SCk85/fqSmFT4Ctd6yCQV2OV0kP9M+zv4m4pNDlShPoYTFdsw
         QawwegMi7az6j3hVvecr9l3jRPYSw62i3LmVzfsZdG2z/qts3WaNC75yNP/riYJC6FGx
         ZKS1L+va2UcHnzVkauEDOJIRkZ3CGpyGMeJZe0okWKVpmugYyKI8YaL7cptJcyUSAm9M
         4DiqH2PWu1PlJRONjHIWf5KVehFwNPrAtQjCGS9bSkrKThUflOR9jfAs5KR/prdUfkP2
         mPl/ynXxbd0keblkuJ2L8rcp84caG9eAVRtU3x/wtBbeCExIbwOZYs+L+PNGa2j6j/aS
         GDiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jqbDgqlfD8Qt7u61qNp/OpKjqQMYQ0bLlS2eBVDi084=;
        b=FZc0MCeH02d34O/eVBvBVSn9LocilrZDqol16ZP+0WGuzSVCyd+nKlUXqlaeCtyySX
         gpcQWaGsJLuFM+3aosuFJbgsH8FqoXwgG+oEXjktwoSsSFGU7fzY5lcqH6yAORHy75rK
         YpByzIMYhmKsIE3SxOyV3STozw8cEIxA6VnCJGpSbPmKvIAqcL6ZTV+ll+XWAkbLrmAi
         TxnPOrrC//KI5IUVzTNH+2XchTW9n/RbjRRwx+v4ig+Zpo9AVOnGBNsg61oMndn8EMaY
         aqQvMWlxIue8Y9NNlpHevoivWF3MJxa5JEbXhWB9i44/Ab8V48pi3GTDv8LFoEDsND0x
         dmIg==
X-Gm-Message-State: ACgBeo2f6CDY9ZyyCoVpP2y/xgVIA9H4gnqkRFg2JbIA0EsYUhiAFZO+
        gL5R2OWg2S6MItoFZUtByNQrEUqQ5eEEnG9FeZoSQpGUbzU=
X-Google-Smtp-Source: AA6agR5aTYTfmMKPiW/wOtSE1yBL/rMYcf+PPbi522bO+1dWTa+TsK4XvcIPZc2WKMe7nbezhi3Vg+hzuk7Qova3Xkw=
X-Received: by 2002:a17:907:28c8:b0:730:9ccc:331f with SMTP id
 en8-20020a17090728c800b007309ccc331fmr15091703ejc.608.1660007306835; Mon, 08
 Aug 2022 18:08:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220809004549.123020-1-felipe.contreras@gmail.com> <20220809004549.123020-8-felipe.contreras@gmail.com>
In-Reply-To: <20220809004549.123020-8-felipe.contreras@gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Mon, 8 Aug 2022 20:08:16 -0500
Message-ID: <CAMP44s2RsvXnt8LtDcv+Ai_kCxmtURGWXmwfchO08dhjMxkGhA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] mergetools: vimdiff: restore selective diff mode
To:     git@vger.kernel.org
Cc:     Fernando Ramos <greenfoo@u92.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 8, 2022 at 7:46 PM Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> Apparently some people want the diff mode to show differences only on
> the visible windows, so turn this on only when the tab has more than one
> window.

> @@ -323,8 +323,20 @@ gen_cmd () {
>         IFS=+
>         for tab in $LAYOUT
>         do
> -               test -n "$CMD" && CMD="$CMD | tabnew | silent execute 'bufdo diffthis'"
> -               CMD=$(gen_cmd_aux "$tab" "$CMD")
> +               if echo "$tab" | grep ",\|/" >/dev/null
> +               then
> +                       test -n "$CMD" && CMD="$CMD | tabnew"
> +                       CMD=$(gen_cmd_aux "$tab" "$CMD")
> +                       CMD="$CMD | execute 'windo diffthis'"
> +               else
> +                       if test -z "$CMD"
> +                       then
> +                               CMD="silent execute 'bufdo diffthis'"
> +                       else
> +                               CMD="$CMD | tabnew | silent execute 'bufdo diffthis'"
> +                       fi
> +                       CMD=$(gen_cmd_aux "$tab" "$CMD")
> +               fi
>         done
>         IFS=$oldIFS
>

Notice that after reorganizing the tab handling my layout becomes really simple:

  set hidden diffopt-=hiddenoff | silent execute 'bufdo diffthis' | 4b

And your layout becomes:

  set hidden diffopt-=hiddenoff | echo | leftabove vertical split | 2b
| wincmd l | 1b | execute 'windo diffthis' | tabnew | leftabove
vertical split | 2b | wincmd l | 3b | execute 'windo diffthis'

So this "works" too, right?

Cheers.

-- 
Felipe Contreras
