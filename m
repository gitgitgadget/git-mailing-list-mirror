Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E138B1F453
	for <e@80x24.org>; Thu,  1 Nov 2018 07:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeKAQDi (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Nov 2018 12:03:38 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:45864 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeKAQDi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Nov 2018 12:03:38 -0400
Received: by mail-ua1-f65.google.com with SMTP id x3so6863870ual.12
        for <git@vger.kernel.org>; Thu, 01 Nov 2018 00:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hVGqjCoBxVtPr1XecoXDb3u0cRaHCd9dy6pE9y0gPI4=;
        b=Nlf7mW28o1fGXhq7YJnXUg0vk0sOJXEd10/3bd7kEYA2gimOJNbIqY29jRMjR+pPso
         DhxdavUNQzlAGauzngVF1DUa6HLmld8Jt92vmsf/GgVvOiYgZtC8PH6FINeXvnz3zEOq
         L/ATCPIvMnDC8PCrJ8ChZhuICdS5JfKGDr/bVkntCpTDwJjUqHdA+t1mteiwee5072Kg
         E5ES0sRI4jU7aQuHIXke9PBUVhfOvqpZ9g7DcT60bDDniOWqghJEnKx/nCWcHnUPtKkS
         lRYmc+UjJzI+CfiPr6+OFpcT+23qVzc0DBzVYtpjDtOTQ9LlHGCDRJrOqIm2vPUY7m3F
         ln0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hVGqjCoBxVtPr1XecoXDb3u0cRaHCd9dy6pE9y0gPI4=;
        b=H/i9d5VpdsSMI9R6C5NPuNcM/smMiveU+vQ9K6fT4b4VtweXtDa+kDAP9KwWpYEpiu
         7Sjvx1tFuAXNtPt/rpjNEaYyl9fZr/K84aBIefFCFQM4GXw+65VQF5aZrluo9ZlttOMc
         lWn+p8x3hLxIXzOWQHMN7l1VBniAUhh8fPHpV9Jqggf4jeTgkTFhS5AwvW9Wy3yY5993
         iFEI//N9UH85XlMHaGF+htkCFi7VUxRRzKP/G3oD8SrZ5bnStRbTYEO/TfAFby4ymDCL
         Jeewk6O2GRC7fATNx2his1F7WuD2qKyJpKMjPlzfDt/+z1vHDtE7cF8P5eJuQ38aHyYk
         Sz/A==
X-Gm-Message-State: AGRZ1gIP9kpM9Ji1zRpYmi3XA0PlUHYrNSn9zBDXu+4prbnIgwmgebwT
        VFz82ExuO6dvs0uEIsfBtg5iB8wxJmnFT6Br0q4=
X-Google-Smtp-Source: AJdET5eicR+cODuTFoWcT/LeKq6iTyQfjrjN4UObCCnE/plDfz0TqojE2Pw9wNLPS+1AYfFgHQS+FsilVgFhnR17NPo=
X-Received: by 2002:ab0:2311:: with SMTP id a17mr2857654uao.130.1541055715095;
 Thu, 01 Nov 2018 00:01:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181014020537.17991-1-newren@gmail.com> <20181019193111.12051-1-newren@gmail.com>
 <20181019193111.12051-9-newren@gmail.com> <d23b4e26-4df4-273d-a75c-a0af915a6e5e@gmail.com>
In-Reply-To: <d23b4e26-4df4-273d-a75c-a0af915a6e5e@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 1 Nov 2018 00:01:44 -0700
Message-ID: <CABPp-BFZugCFDS_A7FrWdRhp7WO0m8jhsqbSnNCSUWnAVz7mtg@mail.gmail.com>
Subject: Re: [PATCH v3 8/8] merge-recursive: improve rename/rename(1to2)/add[/add]
 handling
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 31, 2018 at 8:08 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 10/19/2018 3:31 PM, Elijah Newren wrote:
> > [snip]
> >
> > +                     char *new_path = NULL;
> > +                     if (dir_in_way(b->path, !o->call_depth, 0)) {
> > +                             new_path = unique_path(o, b->path, ci->branch2);
> > +                             output(o, 1, _("%s is a directory in %s adding "
> > +                                            "as %s instead"),
> > +                                    b->path, ci->branch1, new_path);
>
> I tried really hard, but failed to get a test to cover the block below.
> I was able to
> find that the "check handling of differently renamed file with D/F
> conflicts" test
> in t6022-merge-rename.sh covers the block above. Trying to tweak the
> example using
> untracked files seems to hit an error message from unpack-trees.c instead.
>
> > +                     } else if (would_lose_untracked(b->path)) {
> > +                             new_path = unique_path(o, b->path, ci->branch2);
> > +                             output(o, 1, _("Refusing to lose untracked file"
> > +                                            " at %s; adding as %s instead"),
> > +                                    b->path, new_path);
>
> It could also be that I failed because I'm less familiar with this part
> of the
> codebase. Elijah, do you think it is possible to hit this block?

Yeah, this one's going to be a little harder; the upper block would be
done with a D/F, but I think for this block you'd need a directory
rename so that unpack-trees.c can't tell that the untracked file in
the way is actually in the way of anything.  But since this is in the
rename/rename(1to2) area, I think I had rules around avoiding doing
directory renames if the other side renamed the file to avoid getting
into rename/rename(1to3) situations and other weirdness.  So, it might
require a transitive rename (i.e. file renamed on both sides, and on
one side it's renamed into a directory that the other side renamed
away).

I'll try to take a look at it tomorrow, with everything else.  We'll
see how much I can get done.

Thanks for digging in to all these and bringing them up.
