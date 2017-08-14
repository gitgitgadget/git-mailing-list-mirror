Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC9BC20899
	for <e@80x24.org>; Mon, 14 Aug 2017 17:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752378AbdHNRNt (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Aug 2017 13:13:49 -0400
Received: from mail-yw0-f176.google.com ([209.85.161.176]:34907 "EHLO
        mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752370AbdHNRNr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2017 13:13:47 -0400
Received: by mail-yw0-f176.google.com with SMTP id l82so58449205ywc.2
        for <git@vger.kernel.org>; Mon, 14 Aug 2017 10:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=OwYG+s3sUVgWKf4R4YkvKZvHoO1T+7Y+NhiyrORtTwc=;
        b=DNQDt+lLpa4h3jVcXUZSwpfrkbd9qrbhYGz0xn2EnI4EhvYrNPsJf5gGqDVwS2A5ZA
         HDpRUcdmCM4tNiS0xgaG0lbq7oMVgoYfY5ODIKh0A9sF4HdL/jidPnOc5DxwN4KHd60p
         vD3J97HI/fmyyI7o9lc9JFvV2GCfGVGhk3dqb5Iv28v61JvXZuR8m4TezZHfHUY6255g
         mbQyiVaTjnkt8V/HWXu1YWQFUD0LwBERAcAZlO5NhUI6/2kSEeSC2HH0B+rX60bRU9UB
         JcL5D9eT52SfVRyEGBsh7/sMFzY5lgiwYyFBMz8bTnpkbbjETDaIfctSfTkI9Mcso9Yn
         A+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=OwYG+s3sUVgWKf4R4YkvKZvHoO1T+7Y+NhiyrORtTwc=;
        b=bVnpgXlbio9Sa9mPCtlt3qbHrTRpSmNwZrS2vE2hv8ib53PDAoV51S6FxalcEwJHat
         2XZEweg0yO9OGwDtJzGYk9EcSdg92kj9QgcOgMbM/4mBgK0uvosQie0IXPamMBGtkCzk
         2jAWVMISOffWQYN2w0vhGKDSGCAWjOcL0K0hbKWY8Fwbrs62ZMCv3D2j17Q3TJlg/rQZ
         mxtwtPnMyoCphZxzXQ/afHKFri+XuqWG+X7yFh5oMv73+IGZOgU9pW6ooIMAEKToU1V8
         iNacYFuQ8Sj8FtPlhzjtvrn1SRdM5sWLGW2WpqIrFZbZNG9srpxYMHMpuzmveKWiiZMK
         cbow==
X-Gm-Message-State: AHYfb5h+svCvNtNfGQMCClOiOBNZzGqZ7nP62hZgGPQ64dxCbDCx+JJi
        wd4VSrGOy/w0If2ZOV+TL/hmsLX++a6E
X-Received: by 10.129.31.215 with SMTP id f206mr20412249ywf.29.1502730826264;
 Mon, 14 Aug 2017 10:13:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.75.3 with HTTP; Mon, 14 Aug 2017 10:13:45 -0700 (PDT)
In-Reply-To: <ae81b1cf697b2d541eadd21b40ead497a0c32eb9.1502491372.git.jonathantanmy@google.com>
References: <cover.1502491372.git.jonathantanmy@google.com> <ae81b1cf697b2d541eadd21b40ead497a0c32eb9.1502491372.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 14 Aug 2017 10:13:45 -0700
Message-ID: <CAGZ79kZZLOr70Ly=VGbic_5pj_cey6mfxwNd6WCtAAPZa5GTWQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] diff: avoid redundantly clearing a flag
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2017 at 3:49 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> No code in diff.c sets DIFF_SYMBOL_MOVED_LINE except in
> mark_color_as_moved(), so it is redundant to clear it for the current
> line. Therefore, clear it only for previous lines.

Oh that part. I remember debating with myself if I rather want to have
the upper bound adjusted by one less (block_length instead of
'block_length + 1'), and then add a constant to 'buf[n - i];'

The patch as implemented is fine, too.

> This makes a refactoring in a subsequent patch easier.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  diff.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/diff.c b/diff.c
> index f84346b47..4965ffbc4 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -895,7 +895,7 @@ static void mark_color_as_moved(struct diff_options *o,
>                 if (!match) {
>                         if (block_length < COLOR_MOVED_MIN_BLOCK_LENGTH &&
>                             o->color_moved != COLOR_MOVED_PLAIN) {
> -                               for (i = 0; i < block_length + 1; i++) {
> +                               for (i = 1; i < block_length + 1; i++) {
>                                         l = &o->emitted_symbols->buf[n - i];
>                                         l->flags &= ~DIFF_SYMBOL_MOVED_LINE;
>                                 }
> --
> 2.14.0.434.g98096fd7a8-goog
>
