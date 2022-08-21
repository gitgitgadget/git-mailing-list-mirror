Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A105C25B08
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 00:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235891AbiHUAbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 20:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbiHUAbh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 20:31:37 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEEEC26AC2
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 17:31:35 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id n202so338194iod.6
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 17:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XGmdcIsF9sFCqhjqurUnQNygLecErK37nnMv/DYvQyc=;
        b=CgNw3aWkJ/20lQgt3ayQ1AzGfdPjwVShfJ9upwSx7sj0GsxnGf8tU/uX9/UOylL3VB
         douFta+RxpizQA7X8V/PpSgS9DqKGb10BK43yZvJzZ/6j+JLYLejd9PqPYJFZj/85fnR
         1r0U73FFbHanAVt81cK/WIIiPJ/OSa3U4Zir00bzqSP5e/QN5rEXdvAfORsu11E5Vpix
         KOSB4Kwyj9o9hgInkpxflBUQycsF6/2x5FGgVGyc7EwgkeeUm0oICYprKvWTC/VP0UYk
         BWDscmWG+PFHEgi86JCtPYGOI3CyJEd5f4nXRneU7G3c7UDxZYSr/RsDrNhUM4oyHAfB
         JIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XGmdcIsF9sFCqhjqurUnQNygLecErK37nnMv/DYvQyc=;
        b=g0fFIH6Dysymrzkdld3NFbI1+HdBMcrU6wN90IEADlAvMC3TLeaHIer9luggv5M+9+
         /QmCFn4LLFmVmYSq4utK7qqTqvSuDbJm7/WcCPcPnaHcLE0KC9mcnN7c79B00FfBxRsn
         YCmu8tG+iY5lltAO0ESAjvpiD41r6ebGrqu0zSvV0MbkfumFF39WpJsfByfe3D289eZG
         0fd/Jeg/GbP6rcxZgocbjCAnKrK16bb8dv9DK33ozervzqTpfscmawG63H7khJtd6R7c
         q/lgRhHAsQLaI+BQTkYnNYzmbtsWXA7sGopPG4brIj4aRNGQAcnPusOzt4nBpH6N6ajO
         5nvw==
X-Gm-Message-State: ACgBeo39B9ruY41q55wkPOWtQZKwZzStrHRqZp71mjQp0CHsOgbwExwh
        vmtd7YmVMRcnCkPdNFOFnyCkNnGswLrcPyWCyzuu
X-Google-Smtp-Source: AA6agR7SETO5jNF1f1+UAZKXzdbePVczbiZYE7kmVhpNVFg6xvSfIArODtxcqrmSaxAH75opnx15dtaH74Xye4Ij2qw=
X-Received: by 2002:a05:6602:2ace:b0:689:8f31:8cdd with SMTP id
 m14-20020a0566022ace00b006898f318cddmr2823517iov.145.1661041894978; Sat, 20
 Aug 2022 17:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAO_RewbD+BJd1hPKCmCNM8wYBSUmZ2TuOoy6t1up1CT-rbn4DA@mail.gmail.com>
 <xmqq8rniikrg.fsf@gitster.g>
In-Reply-To: <xmqq8rniikrg.fsf@gitster.g>
From:   Tim Hockin <thockin@google.com>
Date:   Sat, 20 Aug 2022 17:31:23 -0700
Message-ID: <CAO_RewZPXP1EUP90kU6uEQ3_CqqC7yWedjfNd7RaVASFSfrg0Q@mail.gmail.com>
Subject: Re: rev-parse: -- is sometimes a flag and sometimes an arg?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  Is there a more friendly way to do what I'm trying to
express?  Should I just use `rev-list -n1` instead?

On Sat, Aug 20, 2022 at 3:59 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Tim Hockin <thockin@google.com> writes:
>
> > ```
> > $ git rev-parse unknown-tag
> > unknown-tag
> > fatal: ambiguous argument 'unknown-tag': unknown revision or path not
> > in the working tree.
> > Use '--' to separate paths from revisions, like this:
> > 'git <command> [<revision>...] -- [<file>...]'
> > ```
> >
> > OK
> >
> > ```
> > $ git rev-parse unknown-tag --
> > fatal: bad revision 'unknown-tag'
> > ```
> >
> > Much nicer error.  But:
> >
> > ```
> > $ git rev-parse HEAD --
> > 113a928239196d0d9f70671517ce917071ceecf6
> > --
> > ```
> >
> > That's not very nice.  Why is "--" treated as an arg?
> >
> > ```
> > $ git rev-parse HEAD
> > 113a928239196d0d9f70671517ce917071ceecf6
> > ```
> >
> > Looking at rev-parse code it SEEMS to be intentional, but I can't
> > comprehend why.
>
> Because the first function of "rev-parse" (among many others) is to
> be a helper usable in scripted Porcelains to "parse" command line
> arguments, shifting them into revs and "files".  Without options
> like --revs-only, --no-revs, --flags etc., it dumps everything, while
> translating "revs" into raw object names, to its output.  "--" is a
> valid command line option for whatever scripted Porcelain you'd be
> writing using "rev-parse" to help parsing its command line arguments.
>
> So everything we see above is very much working as designed.
>
