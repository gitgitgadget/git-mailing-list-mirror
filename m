Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5431F45A
	for <e@80x24.org>; Mon, 12 Aug 2019 10:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfHLKPb (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Aug 2019 06:15:31 -0400
Received: from mail-ot1-f50.google.com ([209.85.210.50]:43658 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727323AbfHLKPb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Aug 2019 06:15:31 -0400
Received: by mail-ot1-f50.google.com with SMTP id e12so12499456otp.10
        for <git@vger.kernel.org>; Mon, 12 Aug 2019 03:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8eCALiZYpWTcht3CFJKy7q4ykjGgP6Eg2ZgwkOovZGE=;
        b=c5yQ37YCbgmAhlOQcQgrExbI1KP/oe4jtdimwNeWoOlcTG0lqdNF6NpncYHOvCV1Up
         WZOqHzM/39JhBeGNu6Ylr1D5Gip8R1bcGje57SWVqEf91LtAO5t24d5AgvsSSv/78dPp
         C1MdRY//Bn449NAuZWjPfdZ+X1Xk0b5TeKfGA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8eCALiZYpWTcht3CFJKy7q4ykjGgP6Eg2ZgwkOovZGE=;
        b=DT8WY0XT0q+u0R31pBlXdsLH5WDrfJGH7mDKXTv9qHW4ZSmwUF4eNNBfLUloWteveR
         wxS3zW97MBPui9YqImm1/Y1wjjZSwT2sbK94ZNoyL2CiAmarJZJm5C8qJnXPEL093Ksl
         +1vIHzLnP0/180CcbWe5bxhd9yPEGzuRmu8heVqJFDKGqyEd67WPhzfOvExsl24H5z0w
         1rkZ8pS84bNsWFFDLROCExMtX+ebWu10b9HwGXF43obLm+OhTlNKwpmHz592/u5M1vXI
         D500M9gjBRPsQT9t1H5xitWJxLQd5y1/3na7OoFsPgw9BXjroZ33U2dn/qc8FNb8baya
         Ewxw==
X-Gm-Message-State: APjAAAVfPr9KBelqHhw0/YqPX3eOGwu7E9XTRQz2ELGrijIK5pZvACbt
        dpTNMiY2r/wx462vDdkxvj7sQGD0WIMsgMcpb0loR3uzVh77ug==
X-Google-Smtp-Source: APXvYqybUgBKAFbPf+oehsO+5ro8urauS8a+6EmlOWQdkGZpkZdRCgiszjo7OFdFlUtDTHB5JvM37u+DDv89tJVxkMg=
X-Received: by 2002:a6b:c581:: with SMTP id v123mr13626771iof.158.1565604930137;
 Mon, 12 Aug 2019 03:15:30 -0700 (PDT)
MIME-Version: 1.0
References: <robbat2-20190806T191156-796782357Z@orbis-terrarum.net> <20190808104212.GA14189@sigill.intra.peff.net>
In-Reply-To: <20190808104212.GA14189@sigill.intra.peff.net>
From:   Jacob Vosmaer <jacob@gitlab.com>
Date:   Mon, 12 Aug 2019 12:15:19 +0200
Message-ID: <CADMWQoP3tH7-e+3FCYkB7b7nf8v-HBQ1toDoje8G_hvD_LaDZw@mail.gmail.com>
Subject: Re: Feature-request: git-bundle --quiet
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a tangent, but relevant: how do we feel about the fact that
'git bundle create' does not perform CRC32 checks when copying data
out of an existing packfile?

See https://github.com/git/git/blob/v2.22.0/builtin/pack-objects.c#L2614-L2622 .

I understand the rationale of "skip CRC32 when serving a fetch",
although I have no clue how much we gain from skipping it. But "pack
to stdout means fetch" isn't quite accurate, as it includes bundles.

Best regards,

Jacob Vosmaer
GitLab, Inc.

Best regards,

Jacob Vosmaer
GitLab, Inc.


On Thu, Aug 8, 2019 at 12:42 PM Jeff King <peff@peff.net> wrote:
>
> On Tue, Aug 06, 2019 at 07:19:11PM +0000, Robin H. Johnson wrote:
>
> > I started trying to make a stab at implementing this, but the code
> > wasn't standing out for it. Hopefully somebody else has poked at it
> > before:
> >
> > I'd like to have a --quiet option for git-bundle, such that only errors
> > are sent to stderr, and not the packing progress.
>
> This seems like a reasonable thing to want.
>
> It looks like you'd have to teach cmd_bundle() to use parse_options(),
> parse a quiet flag, and then pas that down to create_bundle(). Then it
> would pass it along to write_pack_data(), which would decide whether to
> pass "-q".
>
> That would allow:
>
>   git bundle --quiet create foo.bundle ...
>
> -Peff
