Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A22C2BA2B
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8FD20692
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 12:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lccNqylk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729142AbgDKMV1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:21:27 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:45344 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728957AbgDKMVZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 08:21:25 -0400
Received: by mail-vk1-f171.google.com with SMTP id i185so1151128vki.12
        for <git@vger.kernel.org>; Sat, 11 Apr 2020 05:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wW7+2YsV4E+VdoJa41JZQyT4YW4AEgAHoKoxzJxzfJw=;
        b=lccNqylkmiQGAvR+rbTfBlEUKImeSp00fp6yOe3sjPABTxlTvpq9zT2pfplT2HoVTs
         YzX2a04tFHoKD/ZR6QIjjli5HL7p/v51T6h4D8AMTQ/zOKcKXDJhNySQs8gyOwpDRFnB
         NCyfQt+L5F+PCAjwJe6oaVbp8j8AYq76zc7Wjgy3PGDDkFnEEw9KN6zhIIYJPbM2wtyu
         LHTLaO6VMDTAXkoSrXRL4/snpq/gSojB5vzCk/OctdIY96JwkAaQ6h8UcECT+TsMLe34
         DIN3pA+UIOZLEXCAQmSQXaC0EyjYjsLDQijUl/8K/X+ttHa7eheaDRAGYcK22X72sRG5
         aEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wW7+2YsV4E+VdoJa41JZQyT4YW4AEgAHoKoxzJxzfJw=;
        b=b1hCjIZ7r4jHApGFwldn/YZWcDFjD8RGK4S2LgzXfs5PsXRCFCAECqdGvJT58KeEET
         1GFO+2z4OUwrhcC41Q99o3LNO5WNqSC95zgumdJaZjYMeBmQjBz91lPXkHSDguQzzPfD
         iF8avZOjVxTJokOlkXRXZGNJJZMfp0YLwff3WfRtyPe6WIfdaxI17Wbfdp6rEtQQitYq
         KfP/cqYkkA2S7YK+KT/L4Y94uazjBpyvGrYOtpLwQZn6EJW3OT8SPkj2ZcHFe5K4Kyq1
         XMm93D8UybjLfoZ1tALUHy94bt2XTX3HEcI9wueRBJFES5oLq6NvgrTocDs8AbW6TNJU
         jc6g==
X-Gm-Message-State: AGi0PubdBeimpWyVwmdtB8iYk+wMs6oXogXyXKMpkMKgJ73wS9Cb2lSa
        UiHLXvtUSWa6nSJlnMtRAg/KlZaAnNX2ITED5CsP9pn8
X-Google-Smtp-Source: APiQypJRFT5o8DfRwdpusOsd68053PNIodXRXc1LS06aYNB6WlkXVHrelbtevciQR58jKABRrSio/2PbS+U6h42apKw=
X-Received: by 2002:a1f:d641:: with SMTP id n62mr668711vkg.62.1586607684199;
 Sat, 11 Apr 2020 05:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <FC3905FB-D3B9-433D-876D-8DB68D3491C3@anirban.org>
In-Reply-To: <FC3905FB-D3B9-433D-876D-8DB68D3491C3@anirban.org>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sat, 11 Apr 2020 14:21:11 +0200
Message-ID: <CAN0heSrFFABmtitJHu1tVw03oRCs63=UiSknmoZr60NT9dR9Fg@mail.gmail.com>
Subject: Re: Cherry pick a commit but with files in another location
To:     Ani Sinha <ani@anirban.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ani,

On Sat, 11 Apr 2020 at 13:33, Ani Sinha <ani@anirban.org> wrote:
>
> I have an use case where I need to cherry pick a change from one branch
> to another. The change will apply cleanly but the files in the branch
> where I want to cherry pick the co mit to have been moved under a
> different directory. So simple cherry pick will result in conflicts. Is
> there a clean way to cherry pick in this case? Is there an option to
> provide -p0, -p1 etc to the patch?

I just tried the following commands. Admittedly, this example is a bit
silly, but at least for me, Git does handle the move just fine. Does
this work for you?

  mkdir test
  cd test
  git init
  mkdir olddir
  echo old >olddir/file
  git add olddir/
  git commit -m Initial
  git mv olddir newdir
  git commit -m Move
  echo new >newdir/file
  git commit newdir/file -m Change
  git checkout -b my-branch HEAD~2 # pre-move
  git cherry-pick master
  cat olddir/file

What kind of conflicts do you get in your real-world use case?

Martin
