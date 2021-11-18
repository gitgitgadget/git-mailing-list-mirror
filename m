Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDD44C433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEB7861B73
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242255AbhKRBbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhKRBbR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 20:31:17 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D9AC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:28:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id c4so4350369pfj.2
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WBljdsrcx6YyLxlKRmNcWpktvcP+QPXsxW174l9heMw=;
        b=XQA1yEiDam4S07t8MlcLC1ahPt8wZeQw4a9jDt9KTFcZ7dAC8OWGl+feh4jczRRTPj
         J9KyyRD9QToMgU2COrB37nlVZn8iuElOGNnb3LlKtjPg7ZdiTIFQc/ydXE/0ziv4wCOv
         GCQCYeiKPPPsMsrEmW12Jx72Y9Upymfd/rchSRkjmqeZWl5biCY5lVFrtqbA7xHZg5TO
         6IdQVRKYwMSbVfW17407g2oTfYyeotEai7QsJxjBgoq7csLeY/xLoZY3hBUUQa/W7WBR
         6c2P+SjZbRvI/LG9ofsXAGH2zp9C1h84pfanSugy/mS1uKAuKy5xrM3trg3C2iogRmY8
         rPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WBljdsrcx6YyLxlKRmNcWpktvcP+QPXsxW174l9heMw=;
        b=IHzQUz6auOq5cEmA2zQ+hVj5HjTpgRj2/VmPtLetAQ/VgAl2D0hnjCbikR7nGP5MzI
         S7X9NPZWOOaDxCi8RXnNlG+LunrhJR6mpvcYJZqVMpQQv+B5ofckKKanMEEjmTOyWuSN
         OtvwX9Kxmlo2VL27Am5jBjbHuN9FvVcZp5QxjL0KFHwzVbW0ddBJgxsQSF5uQthfCj01
         1/b1ZoK5Woi6uI+PF1kuXirXEG0bl9SfSNQ19Ni+tDay/4iix+TXPN5i2mgtWZRt//tw
         jhZQwlGUpvvKgh9p3CJIZOYTQ+I9kGeQVUhzPz2/VK/K8ABBjF8XFUS1a3dMV4e4jOak
         U1Rg==
X-Gm-Message-State: AOAM533zufQPXiCBvs6ee3Z0Uaun9htzmEjszcfl9V/COJdtg4nYYnNV
        M3Zw6IaeM4ziPnrA+ruZg7FbKGzoHfEUW+oy86kwQiQ06vo=
X-Google-Smtp-Source: ABdhPJzBtsJNeod/Dk5UzENQQmOCplMulUaVYfYQcHD3Xj0LF5QVIeHzW612x/XZZEDcdrLEYG99XX7nxqdOix/gRdg=
X-Received: by 2002:a63:e40a:: with SMTP id a10mr8482965pgi.299.1637198897862;
 Wed, 17 Nov 2021 17:28:17 -0800 (PST)
MIME-Version: 1.0
References: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.com>
 <CAGyf7-FoRyVtQHa2ETQtRA6fD7x0GDhKVPg+eAajhgPNrsw_OQ@mail.gmail.com> <CAKjfCeD1C2DTnT0cLj4hC9Nq90TOFLiPnd_SLQi0HuMQHZcCaw@mail.gmail.com>
In-Reply-To: <CAKjfCeD1C2DTnT0cLj4hC9Nq90TOFLiPnd_SLQi0HuMQHZcCaw@mail.gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 17 Nov 2021 17:28:06 -0800
Message-ID: <CAGyf7-FgwMkjmyY1-ienUrPyzHAzcJFnZ+D7dcpUF=RGCZAFhw@mail.gmail.com>
Subject: Re: Bug report: Strange behavior with `git gc` and
 `reference-transaction` hook
To:     Waleed Khan <me@waleedkhan.name>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Please don't top-post on the list)

On Wed, Nov 17, 2021 at 5:01 PM Waleed Khan <me@waleedkhan.name> wrote:
>
> So what should users of the `reference-transaction` hook do in general? I=
t sounds like we can never actually rely on the new value corresponding to =
the state of the reference on disk. Is that correct?

I wish I had a good answer here, but unfortunately I don't. My
comments are coming from a similar place: The end result of my own
experiences and learnings trying to use "reference-transaction" for
something. The dual backends, and the fact that
"reference-transaction" receives _no hints_, as far as I'm aware, of
what backend a callback is for, makes some use cases quite difficult
in practice. It would be nice if there was an environment variable, or
something, to indicate what backend a transaction was for.

But for cases like this, where a ref is being "moved" between
backends, the split nature of the backends, and the fact that each has
its own separate transaction, makes working in a "simple" script,
which has no more state than its current invocation, extremely
difficult. Of course, since Git doesn't really have an ACID mechanism
for atomically updating both "packed-refs" and loose ref files, trying
to have a single reference transaction wouldn't really work either.

>
> I suppose if we want the real new value of the reference, we should alway=
s look it up freshly? If so, the githooks documentation should be updated. =
Currently, it has a remark on the validity when the old reference is zero, =
but not on the validity of the new reference.

I'm not sure the "validity" of the new reference is the problem here.
Both reference transactions _are_ giving you the correct new value;
"packed-refs" is inserting "refs/heads/master" at e197d18, and the
loose ref for it is being deleted. To me the difficulty isn't that the
new value is _wrong_ (it's actually right), it's that, because there
are two reference transactions and no shared context between them or
hints as to what backend they're for, it's not really possible to put
2+2 together and realize that 4 is a ref being moved from loose to
packed--but otherwise unchanged.

Best regards,
Bryan Turner
