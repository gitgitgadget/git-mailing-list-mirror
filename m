Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EEDC433ED
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E19613DF
	for <git@archiver.kernel.org>; Fri, 14 May 2021 09:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhENJIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 05:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbhENJIf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 05:08:35 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216D7C061574
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:07:24 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id g24so15136680pji.4
        for <git@vger.kernel.org>; Fri, 14 May 2021 02:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hPw93N+bBiVScQMdw1gEcUQSdL4LHn1XTNcvvLkQRlU=;
        b=mW6l0rkHlvd5gAaswvtNiTHItoIxHj9jmc69DFSFlKXnkb6/y2kCs8eG3y7fei9o4t
         k+2XjYvaAXdXNfOLBydrvW/HiYrzPUBwEMB+xRnVa0rJr9DhOHlPQlOfDqoEXfHW6Mj3
         mDeSno6BBM2wiJLf+EOOhKgQ4XD8kBR3AGrc8g1zma68dqiJb/ov0kjTZJbX+6sgpUmD
         0cryj3rpL7eb8nHdcd3PqJCS8DPSrzsKA+9VUiQydNi4arQskycFqXhgzd6r+NkEeJtt
         sbsk3h2D+fhaMwc3twceGLDA0HXo3P8V7Cj4V5s7RBuObD6AZ6sKlmiXW8qoBhwxtcGH
         Tt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hPw93N+bBiVScQMdw1gEcUQSdL4LHn1XTNcvvLkQRlU=;
        b=snHTN33EkD5hPVxZkXzw5V7V6od7SU1nDz6y5Wb6OPL4GFoHxXhq2T8H9dU2QI22jH
         joB0D24pZoEYjLyratO/1peiNA9b/sV7hUqCKjQPrhgzAiH32FBcJTu+ZRpmL5SWbsBi
         x3LjWU3Dj1L1o1DuaZIWb2nKXEiGm/GC+xJN3nBw75cugbcS9rFNBVirpJRmMAR4er1u
         NbWtZkPtvVe7b7xWQ5FfD6xu2Wjy8YWpZDPOP3wCxjYv9b0GyKzX8caPs6uuc1xKu/ra
         BPCqaN/Jw8UKyElllCGmKcx4OHzQWdLMV86FG6rpX+Yxi1PhF8+UCh7N8brIPt4LifN+
         Ohdw==
X-Gm-Message-State: AOAM533/aCP9KH/OcvY81LzoeFXtHGejWhtmjuWyjtbCRttv1TKU9nDH
        xdQNpdeoX/DYqrfkLy8MRsUufCwbWoPIqld0uuYLwatgW4c=
X-Google-Smtp-Source: ABdhPJzO/FexFMIM7H25eXz5HkVOBilxtmxnHCe2Y9GMezC5oIp0vbLBMkUlkM7CD5O+pNrcze0GHGX2Xvwwbc4D0ZU=
X-Received: by 2002:a17:902:9a01:b029:ef:11d:4b77 with SMTP id
 v1-20020a1709029a01b02900ef011d4b77mr40998350plp.51.1620983243471; Fri, 14
 May 2021 02:07:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1620928059.git.martin.agren@gmail.com> <f2a78267fd0f424c5cfa6969c891597af4d5171f.1620928059.git.martin.agren@gmail.com>
 <xmqqzgwy8faq.fsf@gitster.g>
In-Reply-To: <xmqqzgwy8faq.fsf@gitster.g>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Fri, 14 May 2021 11:07:11 +0200
Message-ID: <CAN0heSqsrUU=GYsckhZT7Dvx=Rh3aWMMTMBLBfy2XuDWYpQPFg@mail.gmail.com>
Subject: Re: [PATCH 3/6] git-check-ref-format.txt: avoid single quote
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 14 May 2021 at 00:00, Junio C Hamano <gitster@pobox.com> wrote:
>
> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Asciidoctor renders 'git cat-file' with the single quotes.
>
> I somehow find this sentence a bit hard to grok.  Do you mean
> "instead of typesetting them emphasized, the two-word phrase is
> enclosed in a pair of literal single quotes"?

Yes. I will improve the description.

> I have no problem with this particular rephrasing from "srcref's
> value" to "value of srcref", but forbidding possessive "'s" from any
> future documentation is troubling.

I think this is a case of several things going on in one paragraph in a
way that confuses the tool. As Felipe commented, it's probably correct
to call it out as an Asciidoctor bug. If we hit is *once* across all our
documentation, I think it's correct to work around it [and report the
bug, if we can], but not let the experience impose a blanket rule on
ourselves that we mustn't do anything that even resembles this
paragraph.

> > -. A colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
> > -  value and store it in dstref" in fetch and push operations.
> > +. A colon `:` is used as in `srcref:dstref` to mean "use the value
> > +  of `srcref` and store it in `dstref`" in fetch and push operations.
> >    It may also be used to select a specific object such as with
> > -  'git cat-file': "git cat-file blob v1.3.3:refs.c".
> > +  'git cat-file': `git cat-file blob v1.3.3:refs.c`.
>
> The proposed log message did not explain why you wanted to avoid
> double-quote pair on the "cat-file" line.  Is this meant as a
> workaround for the "single quotes are shown around git cat-file"
> issue?

Hmm, I've somehow tended to think that it's 'git foo' the tool and `git
foo --bar baz` the actual invocation. SQs for the former, backticks for
the latter. Like, `git cat-file` is not a correct invocation of 'git
cat-file'. But I think I'm starting to see the error in my ways --
CodingGuidelines says to use backticks around command names, so it
really should be `git cat-file`. And changing that might just happen to
avoid the issue that triggered this patch.

Thanks for your comments.

Martin
