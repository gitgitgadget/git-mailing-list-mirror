Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE140C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81139206C0
	for <git@archiver.kernel.org>; Mon,  4 May 2020 17:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SnOGIa8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgEDREV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 13:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729938AbgEDRET (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 13:04:19 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF93C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 10:04:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id s8so11557506wrt.9
        for <git@vger.kernel.org>; Mon, 04 May 2020 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OS0NNCkyqS4FV74t60NHvBkX2PxxCPclusEJk35bCe4=;
        b=SnOGIa8nivQk9Ix4dgCJWGA1ry8iS+j2xK9gAyF/EY51Uw4JDq1mBZa/b2Gda55Kll
         C3vDqriwVx/76Zxm+g98jbFMGAxKpk7ZiGAtnfFbOVD/FxYP5Cz+ivPvOXVmpUTf4bRp
         K3dBFzCim17GCDNbQl+2PH0dwwaz9UkWZNN9v8gHCKpaVnBNF467eRhq2mUuS/1/oIK5
         98hIX4ud7ZJ8cIsEu/IhoDLghbl1pjvgH8noKrl3xPa4skGONM0Y4iKJ/auCDKp21Dj9
         /MYwoZmMCPdzPmzUCZ+1UHkfoljEUfbMBYMBMY7QurdQhpfNzMoYcMqIrdFGc7xDp/Mn
         krDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OS0NNCkyqS4FV74t60NHvBkX2PxxCPclusEJk35bCe4=;
        b=E5coUkPWgEp05wjni0WnUky0bgd9BfLTqr9CyjcTbT84abkn1N9ReJhX+xazTsYUwP
         bs5XxOGoz++hTVbHyf5IrbDikgE9qa8zYcO0zNVJrRmthfGi9R+prk+oBoG8ubwTzJx+
         vjRJPWjK8+JYAoCJLD4O+9Y+xS2QwVX7iTrWf6ELIiBSA/XGr8rxwfgqLtfFKEIHgeZs
         DR/a6hOen5WyES2EA7Yvk2TWcExQOeY52TRKWbhzR173Io6LvWxGWIIlZFNl+Ipq+tCC
         5OxuO94pn/bG7i156iXpernJVUdEE4WoYexPsMzKGXigiw1Z7mpwvfa9dKcu6lbc8/D9
         EklA==
X-Gm-Message-State: AGi0PubHSj+UeekWyM6m8YPCukmgBqXZRRBKsvq3l5MPg3r479oYJvwp
        tEE3Gavz5ktBuMghSntdI6UWCdzc4Q9v90Zw6C44rg==
X-Google-Smtp-Source: APiQypLw7Xf4oObF1NzhvwUI27l3mzk4tGVJ/o3jTG1AF36iE80NoA6AdEIEhe2camodWA7oxt45njXs6AyFigY01K0=
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr24197wru.219.1588611855988;
 Mon, 04 May 2020 10:04:15 -0700 (PDT)
MIME-Version: 1.0
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 4 May 2020 19:04:03 +0200
Message-ID: <CAFQ2z_MR2JTAmxcLCzHiVJnufdHRzzbo02kM_wxM7b6agZKc1g@mail.gmail.com>
Subject: Re: [PATCH 0/6] Minimal patch series to fix the CI runs of hn/reftable
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 4, 2020 at 3:31 PM Johannes Schindelin via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> These patches are not intended to be complete, not by any stretch of
> imagination. They are just enough to get the CI run to pass, even in the
> Windows-specific parts.

Thanks for the investigation. I had begun to setup a Windows
installation, but you beat me to it.

Here are the two fixes as I applied them.

 https://github.com/google/reftable/commit/201f21aa39f993c970ef4d19122fedd5=
b91e716d
 https://github.com/google/reftable/commit/18b041472306b31813dbd6408f6a61da=
aba60013

> As I mentioned elsewhere, I would much prefer for hn/reftable to not
> re-invent get_be*(), struct strbuf, struct string_list, struct lock_file
> etc.
>
> However, in the context of the test failures, I do not think that this wo=
uld
> have made a big difference. Apart from the unportable constructs, and fro=
m
> the "delete/rename while there is still a handle on the file" issues, it
> would appear that one big reason why it was so hard to debug and fix the
> test is the recursive complexity of the data structures.
>
> To elaborate on that: struct reftable_stack has an attribute called merge=
d
> that has an array of struct reftable_reader * (confusingly called "stack"=
).
> Each of these readers has an attribute of type struct reftable_block_sour=
ce
> that uses a vtable and an opaque pointer to abstract three types of block
> sources: file, slice (which is apparently unused, i.e. it is apparently j=
ust
> dead weight for now) and malloc.

All of the unittests use slices to read and write single reftables in-memor=
y.

The malloc block source is used to swap out a block coming from the
file directly, with zlib  uncompressed data (log blocks are zlib
compressed). I think there should be a mmap block source too, at some
point.

> I am not sure that this abstraction fest serves us well here.
>
> Quite honestly, I would have expected the packed_git data structure to be
> imitated more closely, as it strikes me as similar in purpose, and it has
> seen a ton of testing over the past decade and a half. I could not recogn=
ize
> that design in the reftable, though.
>
> It is quite obvious, of course, that the code tries to imitate the
> object-oriented nature of the Go code, but it seems quite obvious from my
> difficulties to address the problem where stack_compact_range() would try=
 to
> delete stale reftable files (without even so much as a warning when the
> files could not be deleted!) without releasing all file handles to all
> reftable files, even the ones that do not need to be deleted. To be smart=
er
> about this, the code has to know more about the nature of the block sourc=
e
> than the abstraction layer suggests. It has to know that a block source
> refers to a file, and that that file is marked for deletion. My heavy-han=
ded
> work-around, even if it works, is not really a good solution, but it is a
> testament that there is a lot of opportunity to simplify the code
> drastically while at the same time simplifying the design, too.

If the code tries to delete a file while it is open, that is a
testament to the fact that I haven't written code for Windows for many
years now. It is not a testament to any fundamental problems with the
library design.

The library which you are complaining of weighs in at about 7500 lines
of code (excluding tests), which compares pretty well to the original
JGit code which is now ~6500 lines of code. I don't think there is
room to simplify it further, and I say this as a person who has
significant experience with this format.

If you wish to prove me wrong, you can send me patch. Until then, I
don't buy your arguments.

> I know you have been putting a lot of effort into this library, so I feel=
 a
> bit bad about saying the following: The hn/reftable patches will need
> substantial work before we can merge it with confidence. Part of the reas=
on
> why it is so hard to review the reftable patches is that they intentional=
ly
> refuse to integrate well within Git's source code, such as (re-)implement=
ing
> its own fundamental data structures, intentionally using a totally differ=
ent
> coding style, and it concerns me that the stated requirement for bug fixe=
s
> is to treat Git's source code as a downstream of the actual project. I am
> not too bad a C developer and would consider myself competent in debuggin=
g
> issues, even hard ones, in Git, and yet... it was really hard to wade
> through the layers of abstraction to figure out where the file handles
> should be closed that were opened and prevented deleting/renaming files.
>
> At this point, I don't feel that it makes sense to keep insisting on havi=
ng
> this in a separate library. The only other user of that library will be
> libgit2, and I really think that given libgit2's heritage, it won't be a
> problem to adapt the code after it stabilized in git.git (and since libgi=
t2
> treats git.git as upstream for the libxdiff code, it won't be a problem t=
o
> do the same for the reftable code, too). I believe that the best course o=
f
> action is to reuse the data structures libgit.a provides, and to delete t=
he
> re-implementations in reftable/. Only then can we start working effective=
ly
> on refactoring the code to simplify the data structures in order to clari=
fy
> resource usage (which was the root cause for the bugs I fixed, although I=
 am
> sure that there are way more lurking in there, hidden by the fact that th=
e
> code is not covered thoroughly by our tests).

I'm happy to change the library to use more common primitives that are
shared between libgit2 and git. Could you point them out to me? Note
that the basics that you are complaining of (put_be*, strbuf vs slice
routines, etc.) constitute around 700 lines of code. It's not going to
make an appreciable difference in complexity.

Here is my counterpoint to your proposal:

Reftable was developed outside of git-core. If you feel this series
with its giant patch is too much to review, you can have a look at
the incremental story of how it came to be, both in the history and
code reviews of the JGit project, and in the commit history of
https://github.com/google/reftable.

The idea to put the code into git-core, and especially your proposed
(but unsubstantiated) plans to "simplify" its design, make me very
worried about interoperability with the JGit reference implementation.

Could you explain to me how you would qualify a reftable-in-git
library against the JGit implementation?

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--
Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich
Registergericht und -nummer: Hamburg, HRB 86891
Sitz der Gesellschaft: Hamburg
Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
