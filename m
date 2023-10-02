Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20915E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjJBC1Z convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 1 Oct 2023 22:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234639AbjJBC1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:27:24 -0400
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F478AB
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:27:21 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-65d066995aeso34482786d6.2
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696213640; x=1696818440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0h3RMSXS4ia3YIlVTRDhIdew6RbDHtKpo0HSKsa6Hmc=;
        b=sE2SBAz1MLGY7dzHnwoc0E+tFXQjtR7CYGPDUJnLK1eL4sP1ABGsEvNuMIY90wdQtb
         4H7Q+0NTlS8Ghi040W0yr9t6Q4+Yi/4NbJLGzUbiPqCh3Or1rElTtS3xALw0RNJYlrGw
         pZLStibnZNfqe02RzRHyBUdHidZNtTcE8oBmg9375oeeDSAkpYp1+CvmogrCAF42jorD
         ZqzZk7e0xv4A+3hO2SLeOxhwWCTTpcaxJ4T8Zd3wcrx4uwa/xDvFr9D5RWbXQCgrEE7C
         ZYEadrbsrIZlEZVwMQ8fpGRquTV6e3KkK70kex/RafRopT1PdqZdTI/9Ny9oLYb9HLfS
         8e3g==
X-Gm-Message-State: AOJu0YwrKeS6Lr+qSnVYDbt/xDl4M0MB/iXp4DaNQOtn4BRtWiIS6bsC
        Krns0CBv7lRzp8yUeKLJSPX+Zj19ndTgt6qWNG4=
X-Google-Smtp-Source: AGHT+IFzhJyD2ZHe/YPB8whnkFvTDS99tje0B+ozLoGwWkyddrX5KZdeZNLiYyMMFqmGquexUZYSW/tGv6a2fa5dQ28=
X-Received: by 2002:a0c:e54c:0:b0:651:7aa8:cb5e with SMTP id
 n12-20020a0ce54c000000b006517aa8cb5emr10181491qvm.49.1696213640298; Sun, 01
 Oct 2023 19:27:20 -0700 (PDT)
MIME-Version: 1.0
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
 <20230927195537.1682-1-ebiederm@gmail.com> <CAPig+cRshiUNXfU=ZY4nZXgBgTJ_wF0WVDxWpqkEKPAT9pjX_w@mail.gmail.com>
 <87o7hhbyxi.fsf@gmail.froward.int.ebiederm.org>
In-Reply-To: <87o7hhbyxi.fsf@gmail.froward.int.ebiederm.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 1 Oct 2023 22:27:09 -0400
Message-ID: <CAPig+cRxJ1422BMKWZ7bXASMwist0tU+Nb1ZrhHPdt6iknv2kQ@mail.gmail.com>
Subject: Re: [PATCH 01/30] object-file-convert: Stubs for converting from one
 object format to another
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 1, 2023 at 9:22 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > On Wed, Sep 27, 2023 at 3:55 PM Eric W. Biederman <ebiederm@gmail.com> wrote:
> >> +       die(_("Failed to convert object from %s to %s"),
> >> +               from->name, to->name);
> >
> > s/Failed/failed/
>
> I don't understand wanting to start a sentence with a lower case letter.
> Can you explain?

Consistency with most of the rest of the messages emitted by Git.
CodingGuidelines call for lowercase and omission of the full-stop
(period).

The choice, of course, is subjective, but these are the guidelines
upon which the project has settled for better or worse. (You can
certainly find older code, which predates the guideline, using
capitalized messages, but it's good to adhere to the guideline for new
code if possible.)

> >> +int repo_oid_to_algop(struct repository *repo, const struct object_id *src,
> >> +                     const struct git_hash_algo *to, struct object_id *dest);
> >
> > I suppose the function name is pretty much self-explanatory to those
> > familiar with the underlying concepts, but it might still be helpful
> > to add a comment explaining what the function does.
>
> I could use words that repeat what is in the function signature.
> But I don't think I could add anything.
>
> I would have to say something like:
>
> Look up the oid that an equivalent object would have in a repository
> whose object format is "to".
>
> Is that helpful?

That would help clarify the function a bit for me. Explaining the
function's return value could also be useful.
