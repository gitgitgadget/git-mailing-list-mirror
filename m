Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AE1C43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 18:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiGOSse (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 14:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiGOSsd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 14:48:33 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BEC3CBDA
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 11:48:31 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j22so10504761ejs.2
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 11:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jyYlA609E4/BoCrb3J0r/ZxsHDS2aV2PjfqW5oSX5E0=;
        b=RtHPS08NsNXuVyoGIenalbZFNfE+5zodrzT3f/eYC/ruuRgbKbozoOMQ9aY5Ksw9Jt
         s98OwFFZfn8ISfNv+bobvLelb4HsSz8q6Hs7/CRC0sPMHfCZs0zoJuaq7Gl0vUqY85sT
         wQ7IktnRw6LHdZv3JUDzFZEorPaff7jqkmR6OHhfRhxOVn+rnt/C6ChXZi+BMAZOG2YR
         WcR1OwF8HyEmAKe0DdqcC73B0XD4vNA5f6rrxZo1AYtT62KWINKIoWMOFEk1oPQzQm16
         M/Et/DgVML1IajGT6yW/nMH2BIVxfNr2ahNOW65t9nvj0IdifaSG1cpqrk+Mhcv++99O
         jBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jyYlA609E4/BoCrb3J0r/ZxsHDS2aV2PjfqW5oSX5E0=;
        b=kn6y0YwxLwcNul7FJwHBtP+hZk3reLYo+S8YtPhjpSSysOuf7kpVeZwQ1+3cZ0zxXB
         WawDmMT3T00iZXT8itOVcT6v0gdQX02/8sJWGfGdRxfp1rz5GouBZYz1GeYukrjicS9W
         uEq9vEOar5ENQlFZ+mtPw/rWq5wPWvHIB4mxKJnyWtXtb95CWpIxJgkWwWgz5ek2GvSP
         8601viviMfEdUPZQpD677SIFDIQVqtonMX+rvib8ZN2pp22qpl0Vk8LFBm4iDT1HFV9D
         rEge6EKygtGbXMrcVw21PLSvo4h2aIfcfEkdd6rrIAsal/xRvVgeOqwMciA8IE8m43/O
         JgSA==
X-Gm-Message-State: AJIora/3FuERpaoh1x8dfGQYpPlLoj13JeuQMG3k/re0aT6J+J0XD1vt
        DtptXSxCD+/Ley4A8iwZ37hjGZqvv1fobKHwqXc=
X-Google-Smtp-Source: AGRyM1tB0bLwRceCjg+cfD9WQ0J+Q1KZ4oshhc2nm759hYs77PIDLOH+jLfqh/QDji9YsQv5cyvX0B9lmrQl4XjhsCY=
X-Received: by 2002:a17:907:6890:b0:72e:e404:46d2 with SMTP id
 qy16-20020a170907689000b0072ee40446d2mr7678407ejc.578.1657910910526; Fri, 15
 Jul 2022 11:48:30 -0700 (PDT)
MIME-Version: 1.0
References: <ac52cfea-edb0-b68b-36e2-ab45d2959727@iee.email>
 <20220709075310.83848-1-chakrabortyabhradeep79@gmail.com> <d70a4505-60ef-82c4-5497-499ac788782a@iee.email>
In-Reply-To: <d70a4505-60ef-82c4-5497-499ac788782a@iee.email>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sat, 16 Jul 2022 00:18:19 +0530
Message-ID: <CAPOJW5wPuWR3wgLk3Svo2mNgSNr4R0D9Y_ygSAG9OTb1F3WyTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] Documentation/technical: describe bitmap lookup
 table extension
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 8:31 PM Philip Oakley <philipoakley@iee.email> wrote:
>
> On 09/07/2022 08:53, Abhradeep Chakraborty wrote:
> > Hello Philip,
> >
> > Philip Oakley <philipoakley@iee.email> wrote:
> >
> >> Not sure if this is new in this extension, but should there be a link or
> >> two to the basics of XOR compression and some of the bitmap look up
> >> techniques?
> >>
> >> It's not always obvious if these techniques are 'heuristic' and only
> >> have partial commit data, or they have all the commits listed, Nor
> >> how/why they work. My point is more about giving new readers a hand-up
> >> in their understanding, rather than simple implementation details for
> >> those who already know what is going on. For example, are there any
> >> external articles that you found helpful in getting started that could
> >> be referenced somewhere in the docs?
> > As this series is only about adding a lookup-table extension (and not
> > about bitmap itself), I am not sure whether it's good to include those
> > things in this series.
>
> Thanks for the clarification. I must have slight misread some of the
> discussions and falsely thought it was the XOR compression (which is a
> technique I wasn't really aware of), that was being provided by the
> extension - Where would it be best for me to look up the background to
> your "extension" project?

Sorry that I missed this message. I got the information related to
this project from the gsoc project ideas[1] page, additionally you can
see the comments[2].

[1] https://git.github.io/SoC-2022-Ideas/
[2] https://lore.kernel.org/git/YNovuzAsaEb2uIaa@nand.local/

> > (As the name
> > suggests, this file should only contain format details of bitmaps).
> > That file would provide the answers of "Why bitmaps", "how they are
> > stored",  "How they are fetched", "how they work with pack-objects,
> > git-fetch, midx etc.", "Detailed explanation of each bitmap extension"
> > , and lastly "what are the future works" (if any).
>
> One thing I've realised on reflection is that I'm unclear how the
> 'reachability bitmaps' and the 'commit-graph file' techniques relate to
> each other (and to the ODB DAG), and what features they pick out within
> their heuristic, explained at just enough level to allow folks to
> appreciate what the options that select them will do for their use case.

I am not familiar with 'commit-graph file', so I can't tell you about
that. But for bitmaps, you can look at the introductory patches[3].
After that, if you wish, you can also inspect the code related to
bitmaps.

[3] https://github.com/gitster/git/commit/e127310

> > What do you think?
>
> I'd be happy to collate contributions, suggestions and thoughts.
>
> Trying to create these good introductory descriptions can be really
> difficult, as you can only step into the same river once (the 'reading
> for the first time problem' of not being able to un-hear the
> explanations of others when reading a 2nd draft...)

I agree ;-)

Thanks :)
