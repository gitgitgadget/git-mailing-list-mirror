Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D703D1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbeHOCUU (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:20:20 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:42405 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbeHOCUT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:20:19 -0400
Received: by mail-oi0-f50.google.com with SMTP id b16-v6so36760007oic.9
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ROg/+cI5yS3LO5Wrdvw8lRNuSR57Tcgmu5dQ6NwB9Aw=;
        b=cRkxM2lq8vW9bfvDOzsqqgbNA+hQ6q/dbsIAHmopqEB+Vf+SX10nVAf3GJ5ixyG4a/
         9ayDg2pYQa40t8nS5ylnZQnrOHNAX7WLy0LhPB2DEwn8U4FoKfc5IDdsjZL6Gv9vXPYk
         UrloUmqqUyFnx5uts2exoAIh5frSAZ15c5PBjiNqkCYw2mz/4pxhEzdUuP3DogmuMTke
         sukNXqrNgAfrxCl+USqF/ghVUvqieRrYSH022XTh8B0eq1rddd6T259v3aoTPJ+n2qB8
         qwiwQM/DNI1utoXkltGGMTa4ibuu6OeS48YpQAhfyzPn2A8vZKmw1bi7FBvYToZ/w2LN
         4F2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ROg/+cI5yS3LO5Wrdvw8lRNuSR57Tcgmu5dQ6NwB9Aw=;
        b=nIRKv+QanlsV0cZLll5HXO0y4/T01Gw5Q5jXWYafdlqpfAqpw9a0z3hIwzBcmn48KI
         HyldiJ3PGRtiReXiJK82ccCAsIJU94bWMUzzwbx+BS3Ti2Ve/avexM6x+EJMX3v+8Y5+
         eZxnH7EykOdrVPYBkpk6dPukJnbQba5Ic231aRmXYW6mNtzk5JfZgyjlQV2p3IwJuGDX
         TsIR7uEnx8baJiieylUQWCu+vUEPl36ZVg5I4NTpW2bgzL1KC2gq47iH/e7znOA2diiQ
         /n+zqkFHLc9hCvQjKrK0QI5gLgQZ7+m6QHGpMDZ8sm63yj1pBIwf6FSo9rhgDS1fp7kN
         9DPw==
X-Gm-Message-State: AOUpUlHN6AiabnkgFL0m8cJG6iGK6fNHY0r0lasTMvve+pxlDPcg2fno
        WHI+8IuvunRylIHq3ZnNqVZAJmCwYDJoDqrwqI9CBwyYaw==
X-Google-Smtp-Source: AA+uWPzJcg2k17oWC1jusWBAHBT3IYzJHrDAvnZ3rEptAV9zCIM9KXmPOr+KuPnA6Eqk30SdNz/qTRIji8Liw2xlkac=
X-Received: by 2002:aca:be56:: with SMTP id o83-v6mr25166238oif.301.1534289449473;
 Tue, 14 Aug 2018 16:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAMfpvhKr4jmjZ3NUmxMyTM7KJxQX30UYXKf_rJ30A4C=P3tB=g@mail.gmail.com>
 <20180814201920.56534-1-jonathantanmy@google.com> <xmqqa7pozmzv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqa7pozmzv.fsf@gitster-ct.c.googlers.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Tue, 14 Aug 2018 16:30:37 -0700
Message-ID: <CAMfpvh+H5UeHmCqeVNZNoOe_-vgH3_3aTuO+c=imgzaVkC6N2g@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] list-objects-filter: implement filter tree:0
To:     gitster@pobox.com
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 1:55 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> >> - grep -E "tree|blob" objs >trees_and_blobs &&
> >> - test_line_count = 1 trees_and_blobs
> >> + grep -E "tree|blob" objs \
> >> + | awk -f print_1.awk >trees_and_blobs &&
> >> + git -C r1 rev-parse HEAD: >expected &&
> >> + test_cmp trees_and_blobs expected
> >
> > Indent "| awk" (and similar lines in this patch) - although I guess it
> > is likely that you actually have it indented, and your e-mail client
> > modified the whitespace so that it looks like there is no indent.
>
> No, wrap lines like this
>
>         command1 arg1 arg2 |
>         command2 arg1 arg2 &&
>
> That way, you do not need backslash to continue line.
>
> Also think twice when you are seeing yourself piping output from
> "grep" to more powerful tools like "perl", "awk" or "sed".  Often
> you can lose the upstream "grep".

Thank you. I changed it to this:
  awk -e "/tree|blob/{print \$1}" objs >trees_and_blobs

About the line wrapping strategy, the files I've edited all did it
with the \ and the | at the start of subsequent lines - so I made my
code match that style. Otherwise I would have liked to use the style
you suggest...
