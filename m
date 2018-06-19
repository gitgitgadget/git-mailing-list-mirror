Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB431F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966768AbeFSRf5 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 19 Jun 2018 13:35:57 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:44882 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966368AbeFSRf4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:35:56 -0400
Received: by mail-yw0-f171.google.com with SMTP id k18-v6so171440ywm.11
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 10:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=z3rWeXzNWy8FKgxda1d7lWauEDqHKkODaTzCt4dbAjs=;
        b=JoMjKxwdesWBxEDh+epD5cEupdzjS3fbOmg5Cn34DTTpDzyX9LofW0cdG3bMco09a5
         seK0UPpQIkHm2B1FaRE58w2iqyn+5O1NtUqLGSZsNOmH3d4A8FjohjQQqrgQ5Mf9gKY5
         GWd/v8UH4rj+SYa+YHcO7D58yZ5h6mTLdJ2MjBunC8wF2H9yQ3CQ+0ArT8omqrKsb+uP
         rVqyouN5ewy9KJN8uJEI/DUjqIbDtVrobuAy2MYlRrfbi7KH9su0AVBR4hXX/0q0U5p/
         NoXeDRT63lDfN8/GQr6smXOQO6afRyx0OtR8FpwhT8jKMRfdD7JW2gehtsgpEaR+olR/
         fHpg==
X-Gm-Message-State: APt69E10W3u2VRL9IXhSXCpriyRPHgn3Pc2SuPcFOC6d1RCNkWuY5Dca
        GzTlp78nwJaxQZPiqJKS2OOQ3t2tzSNKv+jwaHo=
X-Google-Smtp-Source: ADUXVKIRFGltYsHgypmAktPx0wKhDVU4HzMwlGQOPfq3faoHO6S3FcArtGjqGeuAC9PbUmjjUpvCSu6ex1KKuTEkf0M=
X-Received: by 2002:a81:4303:: with SMTP id q3-v6mr8378670ywa.98.1529429756159;
 Tue, 19 Jun 2018 10:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <b9dfbd6d-60fb-056a-0f06-b5c3350c7623@web.de>
In-Reply-To: <b9dfbd6d-60fb-056a-0f06-b5c3350c7623@web.de>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 19 Jun 2018 13:35:45 -0400
Message-ID: <CAPig+cQJBw5D7K97VGtdi+iKxgf0D96LFzvZ+SGZVTpAWszOdQ@mail.gmail.com>
Subject: Re: t5310 broken under Mac OS
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 1:33 PM Torsten Bögershausen <tboegi@web.de> wrote:
> expecting success:
>      git repack -ad &&
>      git rev-list --use-bitmap-index --count --all >expect &&
>      bitmap=$(ls .git/objects/pack/*.bitmap) &&
>      test_when_finished "rm -f $bitmap" &&
>      head -c 512 <$bitmap >$bitmap.tmp &&
>      mv $bitmap.tmp $bitmap &&
>      git rev-list --use-bitmap-index --count --all >actual 2>stderr &&
>      test_cmp expect actual &&
>      test_i18ngrep corrupt stderr
>
> override r--r--r--  tb/staff for
> .git/objects/pack/pack-8886db3fce4f9657c1a43fee7d3ea4f2a4b5be2d.bitmap?
> (y/n [n]) not overwritten
> error: 'grep corrupt stderr' didn't find a match in:

This is fixed by [1], isn't it?

[1]: https://public-inbox.org/git/20180616191400.GB8914@sigill.intra.peff.net/
