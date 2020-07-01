Return-Path: <SRS0=EAeL=AM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D66C433DF
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 11:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB1D206CB
	for <git@archiver.kernel.org>; Wed,  1 Jul 2020 11:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2VsZPEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730447AbgGALzT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jul 2020 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbgGALzS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jul 2020 07:55:18 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF357C061755
        for <git@vger.kernel.org>; Wed,  1 Jul 2020 04:55:18 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id c25so3566626otf.7
        for <git@vger.kernel.org>; Wed, 01 Jul 2020 04:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zYkvM19x0P7QzjUoUksfNyY6Wkjx9gX6vcSHrFs71Lc=;
        b=e2VsZPEzviflpoFzFBhiUH1MGzIBmbPYWEHFuACJuUC/9TjJjEZsYuLiPpcqZibDZM
         SenGrPXt5ldJKJhocuQfqJ/YDDLxXfVcGkAqs8ppj65Qd8wV4tOyUZJ1oWY6x7yiKKer
         ncqoU8Isdlhvh/PoikbkEt5dOEItH4EmZFWeI7eUnsq0NgrixL0YG3gD92Mg48jTmD7q
         BE6uRx+vrEhoxBHhp2xXldnsZP8DbhRCaH/fc4+3wZ6dvYgAUaL33lIu3DBYg3VRr12d
         QHrG185mN4a2G3JVAQoKrBEn1/NzfIcZCEScC7gjgAhPQL1i2iCTPZS0yfBZZROVauZ7
         HK+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zYkvM19x0P7QzjUoUksfNyY6Wkjx9gX6vcSHrFs71Lc=;
        b=Q8ZCLa7y7M0xue0dxuuUW9M0sto5yLVGgMMjQXfkcTyXT+zH9/xuuE29fQnAr0RkiM
         8eh+OJgUSN1pAbMBachBQfpjm+z8ZXCi614FWm1tGOXXG/6dXN98u+o9smDVnKITPFja
         Any4h6NnK3b+FxulSGydV9MjPJK0gxQlphfyduYB8tiOfuIM6f6hj6jdLCBPZ/C+pppU
         zUf+ASyQJcFGOSUxCFwA/V8jRgcusrnCjGZ8pgytSzN4KnnEkRWFYHJlPGO0/ddNh9Ou
         gp4FPiR9fhgtDKjcSAzEBE1tBfZ048e9Ar6KJPpL+qFQmizlw1GgWtNo/jP49jTW8fTu
         vSfg==
X-Gm-Message-State: AOAM531EOaX5ISJQUrTS2dxpflYGXFMbhfZCCppmYDPgyX3XzhOwcxaF
        tnZsj0QD5yNLdgQShOioX2ifrVxkoa9qdZO39CA=
X-Google-Smtp-Source: ABdhPJzpXPsZd5oAQ1ldb0FlNb0+qXstqedjm3OqGH2uq1lTBu2p13fWhQ5pplxUj6QAWQZGFzsy83e7Pl0DE2qdx1E=
X-Received: by 2002:a05:6830:60a:: with SMTP id w10mr18005976oti.241.1593604517827;
 Wed, 01 Jul 2020 04:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+CkUQ_-_Rzu00w1L7QeMxT73a_MsD=8kY0+wtuRmze4z+1_AA@mail.gmail.com>
 <CAP8UFD2qbtoXay1AgwrdaJ8XgVkq=NqBTa=KptUTop19xzUVuQ@mail.gmail.com>
In-Reply-To: <CAP8UFD2qbtoXay1AgwrdaJ8XgVkq=NqBTa=KptUTop19xzUVuQ@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Wed, 1 Jul 2020 17:25:06 +0530
Message-ID: <CA+CkUQ9dW9E+yujwU0A7KYu6-fdK9Y4q31+Gq6-9AYoyLyQT6Q@mail.gmail.com>
Subject: Re: [RFC] ref-filter: add new atom `signature`
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Heba Waly <heba.waly@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, Jul 1, 2020 at 3:23 PM Christian Couder
<christian.couder@gmail.com> wrote:
>
> Hi,
>
> On Sun, Jun 28, 2020 at 12:05 PM Hariom verma <hariom18599@gmail.com> wrote:
> >
> > Hi,
> >
> > In ref-filter, we have a bunch of atoms which serves as a formatting
> > option for `git for-each-ref`.
>
> Ok.
>
> > Despite of having 'subject' as an argument to 'contents' [i.e
> > `%(contents:subject)`], we still have 'subject' as an atom [i.e
> > `%(subject)`].
> > Likewise for `%(contents:signature)`, we can have 'signature' as an atom too.
>
> Ok. Some things are available in different ways perhaps because of
> historical reasons and backward compatibility.

Okay.

> > Currently, `%(contents:signature)` internally uses `parse_signature()`
> > that only works for signed tag objects. I plan to expand the scope of
> > `signature` by defining it as an atom and will make it work for
> > commits too.
>
> Didn't you say already that "we can have 'signature' as an atom too",
> so isn't it already defined as an atom? Does `%(contents:signature)`
> work for commits while '%(signature)' doesn't? And what happens when
> it doesn't work?

Sorry for the ambiguity in my statement.
- Only `contents` exists as an atom, which accepts `signature` as an
argument. i.e '%(contents:signature)'
- 'signature' does not exist as an atom. I plan to add this.
- `%(contents: signature)` only works for tag objects. For commit it
prints nothing.

> > Also, thinking of adding `signer`, `key`, `fingerprint`,
> > `primarykeyfingerprint`, `trustlevel` and `grade`[print 'G' for good,
> > 'B' for bad...] as arguments to "signature".
>
> Ok, I guess all the above arguments would be new.

Yes

> > This change will also help me in using ref-filter's logic in pretty.c
> > for formatting options like "GG", "G?", etc. To know more about these
> > formatting options, you can take a look here[1].
> >
> > If curious about what approach I'm taking for using ref-filter logic
> > in pretty.c, see[2]
> >
> > Would love hear your thoughts on it. Any suggestions will also be appreciated.
>
> It would be nice to see, at least for the atoms or arguments that you
> are planning to, or have already, worked on, a list showing how each
> formatting option in pretty.c maps to one or more atoms possibly with
> arguments.
>
> For example something like:
>
> %GS: show the name of the signer for a signed commit
>   maps to: %(signature:signer)
>   status: yet to be implemented
>

Yeah, that would be nice.

## User Formats

%H: commit hash
maps to: "%(objectname)"
status: Implemented

%h: abbreviated commit hash
maps to: "%(objectname:short)"
status: Implemented

%T: tree hash
maps to: "%(tree)"
status: Implemented

%t: abbreviated tree hash
maps to: "%(tree:short)"
status: Implemented

%P: parent hashes
maps to: "%(parent)"
status: Implemented

%p: abbreviated parent hashes
maps to: "%(parent:short)"
status: Implemented

%an: author name
maps to: "%(authorname)"
status: Implemented

%ae: author email
maps to: "%(authoremail)"
status: Implemented

%ad: author date
maps to: "%(authordate)"
status: Implemented

%cn: committer name
maps to: "%(committername)"
status: Implemented

%ce: committer email
maps to: "%(committeremail)"
status: Implemented

%cd: committer date
maps to: "%(committerdate)"
status: Implemented

%s: subject
maps to: "%(subject)"
status: Implemented

%f: sanitized subject line, suitable for a filename
maps to: "%(subject:sanitize)"
status: Implemented

%b: body
maps to: "%(body)"
status: Implemented

%GG: raw verification message from GPG for a signed commit
maps to: %(signature)
status: Implemented

%G?: show "G" for a good (valid) signature, "B" for a bad signature...
maps to: "%(signature:grade)"
status: In progress

%GS: show the name of the signer for a signed commit
maps to: "%(signature:signer)"
status: Implemented

%GK: show the key used to sign a signed commit
maps to: "%(signature:key)"
status: Implemented

%GF: show the fingerprint of the key used to sign a signed commit
maps to: "%(signature:fingerprint)"
status: Implemented

%GP: show the fingerprint of the primary key whose subkey was used to
sign a signed commit
maps to: "%(signature:primarykeyfingerprint)"
status: Implemented

%GT: show the trust level for the key used to sign a signed commit
maps to: "%(signature:trustlevel)"
status: In progress

## Commit Formats

Note: This is only for the commit body[as pretty.c only handles commit
body]. First line that contains `commit hash` is handled by
log-tree.c, So no need to map it.

'oneline'
maps to: "%(subject)"
status: implemented

'short'
maps to: "Author: %(authorname) %(authoremail)\n\n\t%(subject)\n"
status: Implemented

'medium'
maps to: "Author: %(authorname)
%(authoremail)\nDate:\t%(authordate)\n\n%(subject)\n\n%(body)"
status: Implemeted

'full'
maps to: "Author: %(authorname) %(authoremail)\nCommit:
%(committername) %(committeremail)\n\n%(subject)\n\n%(body)"
status: Implemented

'fuller'
maps to: "Author:\t\t%(authorname)
%(authoremail)\nAuthorDate:\t%(authordate)\nCommit:\t\t%(committername)
%(committeremail)\nCommitDate:\t%(committerdate)\n\n%(subject)\n\n%(body)"
status: Implemented

'raw'
status: Not yet Implemented

Thanks,
Hariom
