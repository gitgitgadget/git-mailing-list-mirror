Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 975DA1F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 22:41:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751260AbdARWlJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 17:41:09 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34459 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751255AbdARWlI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 17:41:08 -0500
Received: by mail-lf0-f68.google.com with SMTP id q89so3497052lfi.1
        for <git@vger.kernel.org>; Wed, 18 Jan 2017 14:41:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MufVp/n2l7xXiCyk7Que3+kyAMfmA0gFXPtflU99Ry4=;
        b=TSxOISn+M4bpIo5re1w8toYTQFCBvECUuekFaNJlwHyfx8755nlyAbed6niMmOCNSK
         FS7HV5SqYAG9RPgUvfDoiAUw83Fv2xBT6IZSxCVlClIKV9CGupcYZs4o0cDnhnXAI+T0
         TmH3F8YIw6WExN0dXH/rk/Z8CS+Ik1dxgNiy3LFrnDio8+dchVIFpAOeLFkr98VJ+1in
         xqhIANEl+p6C4gWi7tmSg55Em9v1DMd9fLunpgg5EBMghHTuEPU+HZz5mARnLYcPoDg0
         iFZrBC7kN+8i9kz5oX1r9gH44XOYY8FscvSByH+1DO/nGyL50KOViSC2ikhQYSbnuNaP
         UAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MufVp/n2l7xXiCyk7Que3+kyAMfmA0gFXPtflU99Ry4=;
        b=DVRo0khJjzZJYh/lWMucnseZ8pJ2JqWF9QShvgeaD1eK0CQQONYBrW8O5x6O66PJvN
         fmbEoIdS87MlpZ5yGxgiYjizkJ9srCyqvoM6Iz00PYn7Ew24LHYa1kKG7EgNEARv5nET
         smfOOcx8kiwUWu3gwA6PZdSDiB6dvDQhseTedQdGkS5zVIRtiYmbVP0kF7okcQaVK/KZ
         o4b+FmRXFxSi5AjknwtiKFbm5i6yquguDFosY1ZGc0BDLVp9gDb66ONnzW1ldGldYp+G
         X8dendeiIGoIeEy7C/9X6q0ndkrTikF2LX6+LyfyRm9A0vNSNHtHprPbDLs+Ib4pycoQ
         0x9g==
X-Gm-Message-State: AIkVDXJUbXJGaLiByd8RmAtgdzK+uezS2QwJtpaWdPurrZ28couYGGnf8o5ahCcew6h3lFsYnlKN1Tt0OhuaqA==
X-Received: by 10.46.72.1 with SMTP id v1mr2543506lja.12.1484778684495; Wed,
 18 Jan 2017 14:31:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Wed, 18 Jan 2017 14:31:03 -0800 (PST)
In-Reply-To: <xmqqy3y82fs8.fsf@gitster.mtv.corp.google.com>
References: <20170118000930.5431-1-jacob.e.keller@intel.com>
 <20170118000930.5431-4-jacob.e.keller@intel.com> <xmqqtw8w86xc.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xo4-45je995LLoyh-LbGTTf3EZUVW-UV+Dd=Wg0EGRvVA@mail.gmail.com> <xmqqy3y82fs8.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 18 Jan 2017 14:31:03 -0800
Message-ID: <CA+P7+xo3bS0EfXaVCZbd6NwbBA8vP5HiZNpAh_4v7S_p2jm+Zg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] name-rev: add support to exclude refs by pattern match
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2017 at 1:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Yes this makes sense. I'm still looking at whether the alternative
>> implementation suggested based on the git-log style would make more
>> sense or not, but if we keep this as is, the added text you gave is
>> important.
>
> I actually think it is a red-herring that "git log" honors "orders";
> it does, but that is not a result of carefully considering the
> desired behaviour.  It instead is a historical wart that came from
> the fact that "--branches" and friends uses for_each_glob_ref_in()
> that takes the top-level hierarchy paths like "refs/heads/" and the
> implementation of "--exclude" piggybacked into the function in a
> lazy way.
>
> If exclusion were done independently (e.g. in a way similar to what
> you did in this series using subpath match), we wouldn't have had
> the "the user must give exclude patterns first that would affect the
> next inclusion pattern, at which point the exclude patterns are
> cleared and the user needs to start over", which is an end-user
> experience that is clunky.
>

However, it is useful that exclude patterns only apply to specific
match parameters? That is the advantage of the other implementation.

I think I agree that it's not really worth the complexity, as it
requires a much more complex explanation of how the parameters
interact, and in general doesn't provide that much more
expressiveness, since at least for "git describe" by definition it
either finds the tag as a match or not. Sure you could say "include
all tags matching x but only if they don't match y" and include all
tags matching z even if they match y" using that mechanism, but I
think that makes the entire thing needlessly more complicated than "we
use a tag if it matches any match and doesn't match any exclude".

Thanks,
Jake
