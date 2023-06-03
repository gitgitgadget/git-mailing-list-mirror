Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC58C7EE29
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 01:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbjFCBsC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 21:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231202AbjFCBsB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 21:48:01 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1589C194
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 18:48:00 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3edc05aa5so3657468e87.3
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 18:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685756878; x=1688348878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32ygF0Tgp4GtZiHLcJ13WXjSyJC/EPz5n+L+csMBkGQ=;
        b=QxV2mD4hxjyc/dSl3AHQHH1SbtW4V2SOt0rRnOBjqNTYx9rMnOh5AOz8+93AXvBWWJ
         U7BeOy82hLW0boEsQSGgoHycIZHHTIqGIjLDDoIYmP1i0BJQKrIu4hdrfqyF41eDNbzz
         jatKxW0guT3k0u3YJgNZUwFc+OpESi/PCbgVF6F3ljP/oB0mgbMx/GrNfmAjKrlVVMDq
         zv2Iz/FCFTkVzfIfEU6iun7jJ/mQOcgLET4mQ7LvNf/16uuhUJUy8gtTQ3ovEjO5HWso
         z6Cp5GhACn1KHGyobvtHF50FSisnNaxlFZuHy2gN4uMgzTW5UkfrJuIXBk9mVWQWDUDx
         ALrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685756878; x=1688348878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32ygF0Tgp4GtZiHLcJ13WXjSyJC/EPz5n+L+csMBkGQ=;
        b=fDsEvost6fpvtJxqyF5Af1zy6vnYH+chmwmn5nt04YsItuxSjv4GIBihEAB4J99VqM
         jb78iYXgtesqIAwS4zU0cz76n1nEusY1R3OrdHRD1d5JuuecVTQFQ7Yyom+3eqJ20Ca9
         7wgLX9zHdHeJkBNOF+rlrW+Lwfkmfi0f2ARI41jT7ftSMZ/hmgcoyCkSG6Gxw3CWY964
         +cInTJ1XFBI+kg5xG50NvJAmiJ7fONnpkvBNnQHEdtQdKy7IKZAx8IJsN8c/AIXZikrM
         itEUQ8YgJgmbmb6BvssXU6NT/FfQq40vUfZk4jWugSuA3Cc0+UJIiIiikpR0YRlcT/ep
         6CfQ==
X-Gm-Message-State: AC+VfDxHC+iorWYkcrBEuYG1mcS5r4eTpaAUc3b8R+sxF7df1S5DpiIp
        NmhxmwcefE7g/2XvZfiGxP/U7jlbmwhT6K8dsp4=
X-Google-Smtp-Source: ACHHUZ5mPcTNx5RK1+y+4b9sMRjy4R+x/KPOcEoMopDqPxfL5x1x7D31bNzgL8yPhw0lyysLnWxia+NSsnrpe++2zeU=
X-Received: by 2002:ac2:5203:0:b0:4f3:ac64:84d9 with SMTP id
 a3-20020ac25203000000b004f3ac6484d9mr2603068lfl.20.1685756878133; Fri, 02 Jun
 2023 18:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1537.git.1685126617.gitgitgadget@gmail.com>
 <5fc2f923d9e6aa13781d7d6567c9bd38a9dd1f0e.1685126618.git.gitgitgadget@gmail.com>
 <49ea603b-ebbd-4a14-e0dd-07078e56de0a@github.com> <72fb4420-2492-e644-58cc-b9b3dbfb8037@github.com>
In-Reply-To: <72fb4420-2492-e644-58cc-b9b3dbfb8037@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Jun 2023 18:47:44 -0700
Message-ID: <CABPp-BGjUXhvd9sWe7YAzbSi5WYscM=9qt5BZQujbdnVRVFtYA@mail.gmail.com>
Subject: Re: [PATCH 2/3] replace-objects: create wrapper around setting
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2023 at 12:50=E2=80=AFPM Derrick Stolee <derrickstolee@githu=
b.com> wrote:
>
> On 6/1/2023 12:35 PM, Victoria Dye wrote:
> > Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <derrickstolee@github.com>
>
> >> diff --git a/replace-object.h b/replace-object.h
> >> index 7786d4152b0..b141075023e 100644
> >> --- a/replace-object.h
> >> +++ b/replace-object.h
> >> @@ -27,6 +27,19 @@ void prepare_replace_object(struct repository *r);
> >>  const struct object_id *do_lookup_replace_object(struct repository *r=
,
> >>                                               const struct object_id *=
oid);
> >>
> >> +
> >> +/*
> >> + * Some commands disable replace-refs unconditionally, and otherwise =
each
> >> + * repository could alter the core.useReplaceRefs config value.
> >> + *
> >> + * Return 1 if and only if all of the following are true:
> >> + *
> >> + *  a. disable_replace_refs() has not been called.
> >> + *  b. GIT_NO_REPLACE_OBJECTS is unset or zero.
> >> + *  c. the given repository does not have core.useReplaceRefs=3Dfalse=
.
> >> + */
> >> +int replace_refs_enabled(struct repository *r);
> >
> > Since the purpose of this function is to access global state, would
> > 'environment.[c|h]' be a more appropriate place for it (and
> > 'disable_replace_refs()', for that matter)? There's also some precedent=
;
> > 'set_shared_repository()' and 'get_shared_repository()' have a very sim=
ilar
> > design to what you've added here.
>
> That's an interesting idea that I had not considered. My vague sense
> is that it is worth isolating the functionality to this header instead
> of lumping it into the giant environment.h header, but I've CC'd
> Elijah (who is leading a lot of this header organization stuff) to see
> if he has an opinion on this matter.

I haven't really formed much of an opinion on the sea of globals in
environment.h and elsewhere beyond "I sure wish we didn't have so many
globals".  Maybe I should have an opinion on it, but there was plenty
to clean up without worrying about all of those.  :-)
