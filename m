Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF8FC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2EFF20768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 18:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgDGSRA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 7 Apr 2020 14:17:00 -0400
Received: from mail-qk1-f180.google.com ([209.85.222.180]:38773 "EHLO
        mail-qk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGSQ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 14:16:59 -0400
Received: by mail-qk1-f180.google.com with SMTP id h14so370153qke.5
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 11:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gxo/oio8j8MK6mL2bBUEiEoyiSDPLwcHbahppnDKd28=;
        b=l+lDKxapCXtmpV84bkE1ktJ4a84FzoqkVzBIs1Df73WgN1rS6vIWUwWfWv1s9nJxs8
         lEU8bHKicejYiaX4MhUXiGst+G8hJ3MsrvHne1ZRRTfOWmm033qVNt8VUvjRMaDalb/t
         RhfWS1lIsx2C0n4lWNG0FQcAE5FsWU2fAettEQgve6l3aZL52EBDmwDqUbwGZEA8NhHD
         O8Sy8shzpRWffVKcS2eq961HvfpCZ86/TAvo6t5Nl6cAuuvnYSel9jImC9Ukoi4+jm22
         AACevB3UJke06LVXBxr8K5T9g0fWzmPBeasIz/QgtiF52DOGZIl4grTI3zoVrXpDGLh4
         6UCg==
X-Gm-Message-State: AGi0PuZIxaEjoKoBDgXlL0X6wUtrRil0ast1hfzl0HND8iH20hXT73yA
        UWVBerEyA6Gk0htHqqquHFPkQb/RiYD8X+qcZt83ViV2W0o=
X-Google-Smtp-Source: APiQypIFOshVDwKDBnMqxSV7kaYm7FMeVSlToI99f1J4wLGIdylTqcJHzrvbWM2iKeHdEblqW/3B2O+OnzCtbRC2YbY=
X-Received: by 2002:a37:85c2:: with SMTP id h185mr3505845qkd.446.1586283418253;
 Tue, 07 Apr 2020 11:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAAb+AL8+c6knrQnoi7YOjyM+Wc8-rws-JXVufBc=PciAvPPFJQ@mail.gmail.com>
 <CABPp-BGFinonZJb2u_0-fX3y_UyJ1dY+O40oN0WAzZht0ddJ4w@mail.gmail.com>
 <CAAb+AL-95RKhTghJX4uLxiM3dqZW6U914XBXaLcwK+gC_FezWw@mail.gmail.com> <CABPp-BE1mDQYcj6nRfS4osn8-E_WdV-Nenn9dQSA+JCr+pjKLQ@mail.gmail.com>
In-Reply-To: <CABPp-BE1mDQYcj6nRfS4osn8-E_WdV-Nenn9dQSA+JCr+pjKLQ@mail.gmail.com>
From:   Sami Boukortt <sami@boukortt.com>
Date:   Tue, 7 Apr 2020 20:16:47 +0200
Message-ID: <CAAb+AL9KaFbOk2eMPbn0zCKC4KfX-chx4O3ndLz=zpdgpq_MVQ@mail.gmail.com>
Subject: Re: New git-rebase backend: no way to drop already-empty commits
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mar. 7 avr. 2020 à 20:03, Elijah Newren <newren@gmail.com> a écrit :
>
> On Tue, Apr 7, 2020 at 10:28 AM Sami Boukortt <sami@boukortt.com> wrote:
> >
> > […]
> >
> > Sadly, that is somewhat inconvenient, as those commits are not
> > actually “intentional” from my viewpoint (though I understand that git
> > has no way of knowing this), but rather created by another tool
> > (git-imerge), which means that I have to check each commit
>
> git-imerge creates non-merge commits?  Is this in the case when it is
> acting like rebase?  If so, is this possibly a bug in git-imerge (in
> that it doesn't drop commits which become empty)?

It is indeed with `git imerge rebase`. I don’t know enough about
git-imerge’s internals to know how easy that would be to fix, but it
does seem as though that would be the ideal approach.

> > individually and risk mistakes. The old `rebase -i` behavior, where
> > such commits were automatically commented out, would be an acceptable
> > compromise, or even a comment added at the end of the commit line (so
> > that they are still kept if the editor is closed without changing the
> > rebase list). If there are plans to eventually remove the “apply”
> > backend, could that workaround be considered?
>
> Automatically commenting them out is bad; that causes frustration for
> people having to uncomment all the commits they intended to add.
>
> But we could add some kind of option.

Instead of automatically commenting them out, how about automatically
annotating them while leaving them in the rebase list, like so:

    pick 8441f42 Commit A
    pick e3fcaf8 Commit B  # empty
    pick af34c53 Commit C

> > Alternatively, I could also use `git filter-branch` (with
> > `--prune-empty`), but apparently, its use is heavily discouraged.
>
> You could use
>    git filter-repo --prune-empty always

That does seem like it would work, but wouldn’t it process the entire
repository (as opposed to filter-branch which can take a list of
revisions)?
