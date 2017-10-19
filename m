Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9C8F202DD
	for <e@80x24.org>; Thu, 19 Oct 2017 21:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbdJSVbW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 17:31:22 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:51021 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdJSVbV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 17:31:21 -0400
Received: by mail-qk0-f194.google.com with SMTP id o187so12143737qke.7
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 14:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=X1pJTDQLbQbq4zlgD8Iw4z14/My5mkxHoJhXwBlSaWI=;
        b=O6mg0dJKgJBThGVXjWrOjGaAChgP8Y51tY4YS4c6zAb2uRwST1M13jHiwKki6VodUv
         CdiMcScQLVu1iH9pP7QRDzYPynLfkC/Abvve8Qv9EcGTQUM09cECJX9EW8kahIHljJsA
         BHUi181Xc6a01U3sPfn2rBz8mnniiI6+g4nbIcUQH8MnlwZk/aEUBspIs18YHnFq2aWv
         IargGA9Qyy9luzjIIQ2l5UzCZxsW+DOWSWn6vLzGtiYTFbz+cGYIhsx5XUK1sP9a4Jpw
         4ZBOXr6pfkvaK6BL4R4f3VJRaWM6c22T6HmXzo/WW+XztwrPX+93ST6HKlFqqqzvt9F5
         YMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=X1pJTDQLbQbq4zlgD8Iw4z14/My5mkxHoJhXwBlSaWI=;
        b=m/7nF8553O5o2hmd8um7KO4cBSd01tafmIJvfevC1FSQpU5DlyoOpa+6TEx61QBgZ5
         ZcAUPJB+jkVAhz6omSrcn1fgl60RRPv2EWD5tuVeL73GHR0Rj/GDu9RWYI/YBkIdUYUQ
         kcWCAjgzc/KUWGRGAIdLFky4MSwU1Iwv1CgeHLM2F8b9bXK3cpzsQgaJkqZrZBUQVSjJ
         vlpyFs28mmS8cJdCO87GRoQd1wH5h1lqgaomNNdx6ePDwO2E5dMU9x6UGxAlJiP9bZ+S
         EDRCdCIE79a5iB4g1gAJK1Z/358g6GWgh//4Rng7cGLCa4illqIinBuXuH7BaDrwref9
         ZJ7g==
X-Gm-Message-State: AMCzsaXcg1C++9brXl1fw/qblHceYUDjcJOKCB5lVlUlXCkzSzALVVxp
        bXZ8ZFiWvQ47WLqu/JUyGK/aWFePQHQ22kzNTWi7vA==
X-Google-Smtp-Source: ABhQp+QDSBoJsg0g+7KbZlSV7u358CeqyQeHSAxHTt7fz33GPTEYj6+x4lLelUU/+txlN/RxswTzwjbfFpQF2Nnh1jY=
X-Received: by 10.55.18.165 with SMTP id 37mr3874185qks.352.1508448680604;
 Thu, 19 Oct 2017 14:31:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Thu, 19 Oct 2017 14:31:20 -0700 (PDT)
In-Reply-To: <20171019203119.d2xbryov2y5t2aig@sigill.intra.peff.net>
References: <20171019202326.grovyfsragl2d7xx@sigill.intra.peff.net> <20171019203119.d2xbryov2y5t2aig@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 19 Oct 2017 14:31:20 -0700
Message-ID: <CAGZ79kY3jVgBRCKkswHV7xbjiiNgvsbVsgq_9PpVwa-zTt4q0Q@mail.gmail.com>
Subject: Re: [PATCH 5/5] diff: handle NULs in get_string_hash()
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Orgad Shaneh <orgads@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 19, 2017 at 1:31 PM, Jeff King <peff@peff.net> wrote:
> For computing moved lines, we feed the characters of each
> line into a hash. When we've been asked to ignore
> whitespace, then we pick each character using next_byte(),
> which returns -1 on end-of-string, which it determines using
> the start/end pointers we feed it.
>
> However our check of its return value treats "0" the same as
> "-1", meaning we'd quit if the string has an embedded NUL.

I agree. The code looks correct.

> This is unlikely to ever come up in practice since our line
> boundaries generally come from calling strlen() in the first
> place.

get_string_hash is called from
 prepare_entry, which in turn is called from
  add_lines_to_move_detection or mark_color_as_moved
   diff_flush_patch_all_file_pairs

that constructs the arguments in
diff_flush_patch
 run_diff
  run_diff_cmd
   builtin_diff (part "/* Crazy xdl interfaces.. */")
    xdi_diff_outf( fn_out_consume as arg!)
     xdi_diff
      xdl_diff
       xdl_call_hunk_func
        -> fn_out_consume(cb, line, len)

xdl_call_hunk_func however uses pointer arithmetic instead
of strlen. So I think this sentence is not a good idea to put in
the commit message.

It may not occur in practice, due to binary files detection using
NUL as a signal, but conceptually our move-colored(!) diffs
should be compatible with NULs with this patch now.

> But it was a bit surprising to me as a reader of the
> next_byte() code. And it's possible that we may one day feed
> this function with more exotic input, which otherwise works
> with arbitrary ptr/len pairs.

Good point.

>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I noticed that we make an extra copy of each line here, just to feed it
> to memihash! I guess "-w" is not a critical-performance code path, but
> this could be fixed if we could do memhash() incrementally (e.g., by
> putting the FNV state into a struct and letting callers "add" to it
> incrementally). Maybe an interesting #leftoverbits, though I'd want to
> see timing tests that show it's worth doing.
>

I agree.

Thanks,
Stefan
