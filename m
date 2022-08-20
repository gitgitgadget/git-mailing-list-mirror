Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50562C28D13
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 00:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244889AbiHTANa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 20:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244880AbiHTAN1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 20:13:27 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2230F11A22
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 17:13:24 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id a4so4465381qto.10
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 17:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=EZbp4bk0UhdIr7EWzu7vSbOPWSAso8Hh0kK3rMWkvG0=;
        b=fPR8PRxM8sSN44Ka/UoHBz6IZ0YgOpx1ON9gIVVxPY4cyPaufojEYVbG/2Y8w9rIIK
         SISTTeYO+5tRw8xH6iTEn5dzgII5DqBijDa2uJNTVAiOnnxyGk4Cvoh6/O04XWciz499
         qpc5nXiPIdMJqNy3Mtv9/mkE7rh4OgZ+YNhjz+1/PaFBqmltULnH4aIZj2ioyirBtzDh
         mrDTpfECO1mK+yl7ZmK7BRsMu8Np2Ac2i7NA000/6giHbNJ037rQYmcfjHQADpRkKvv/
         Zmoq6YD5EPS03LNVWD6QqIc6mEadeEjRavQSlAqKbkJFkQvlFD5xtA9cjbU5f52ZLbDi
         AhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=EZbp4bk0UhdIr7EWzu7vSbOPWSAso8Hh0kK3rMWkvG0=;
        b=bfh1sIKIWCrLCoz7Pn2P5FlHUxQv4+V2Ot8BbEK6V2zTk+xF/29sih8g25ld20SOA/
         dIS2bDDJrIy4pwtPkDwBc/rEeuZjzk4vEzsda5VEMCeKiY+9fuLjP98WiWzEN7InMkmB
         VXW+AC7eIWtRAyYQ5m07TIrjKjTlvpva5Ovft+Uv4JjTxTJlkIGwEs2WDKETNQW6OaWp
         umoSdg1/JP4h22qzsAcYLl7uKwNMykUSDLjsP3H6/fuh0kjtVnQwO36OjXltCXfG0Mud
         s8lK41Jnkd9s+8txXUGY2igWEuOMnie2mvIDpMdNxZHW6O+QcRw4UgTEYvh2Ex5RAoQw
         ZmBQ==
X-Gm-Message-State: ACgBeo16AnsHHMBrokk+blQKNAUVFpuGoiv/FP+LYTfYm+ZOnyUQNqkE
        bRoojxTmcYJU2qUOn8EFADhJ5CGRgGcc19/6I2E=
X-Google-Smtp-Source: AA6agR6G4hnuyyKJU8Ly88JED2nVTYwU4QhS3w5XnN+qTHKkYiWwA6fquQXSEYd4A0wdS8xdEN/D6CbVqtLLj0LQy8Q=
X-Received: by 2002:ac8:5c8e:0:b0:343:5983:a246 with SMTP id
 r14-20020ac85c8e000000b003435983a246mr8549664qta.153.1660954404072; Fri, 19
 Aug 2022 17:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
 <pull.1303.v3.git.1660883290.gitgitgadget@gmail.com> <7b7918f8-d997-89e8-2ba0-7bb31beb9335@github.com>
 <xmqqtu68j60w.fsf@gitster.g>
In-Reply-To: <xmqqtu68j60w.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 19 Aug 2022 17:13:13 -0700
Message-ID: <CABPp-BFOag0sTO_wa8qM2h-GWigyQdj9ki0Rrd1CCKD39Y96NA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Allow --ancestry-path to take an argument
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 19, 2022 at 2:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Derrick Stolee <derrickstolee@github.com> writes:
>
> > On 8/19/2022 12:28 AM, Elijah Newren via GitGitGadget wrote:
> >> Changes since v2:
> >>
> >>  * Incorporated Stolee's suggested patch as a preliminary cleanup of t=
6019.
> >>    Slightly modified his patch by:
> >>    * fixing the "repetitive" typo pointed out by Eric
> >>    * removed the unnecessary "return 1" pointed out by =C3=86var
> >>    * switched "rev-list" to "log" since we are using --format anyway, =
in
> >>      order to remove the need to call "sed" afterward
> >
> > Thanks! I appreciate you fixing all of my mistakes and
> > incorporating all of the existing feedback. It also looks
> > nicer as your patch 2 than as a third on top.
> >
> > This version looks good to me.
>
> Yup, it looks good to me, too.  Thanks, both.

And thanks to all the other reviewers as well!  Good suggestions came
in from several different folks.

> Let's mark it for 'next' and merge it down soonish.

Sounds good.
