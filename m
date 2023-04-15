Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FDC9C77B71
	for <git@archiver.kernel.org>; Sat, 15 Apr 2023 07:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjDOHIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Apr 2023 03:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOHId (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2023 03:08:33 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679834EE7
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 00:08:31 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4ec8399e963so287549e87.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2023 00:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681542509; x=1684134509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jZUeImb56Dv7gMaWS0vUWd1kqT52jBB5Nag68C7WNks=;
        b=KQyTK+Tg+dO24cB463iaWKoPD7QcdK6/dQXICc18qFz+oTsThQZJG65sGPq86z44BA
         V1wdluO9hOZd+RUNmDdMeOEyCBR33q1nkG5jQzP7keWCjIwX/axVOCj+o+LstT8Ge/Oo
         9JYiEBU4fENmiH6noe0oqzr5ZHgTL68j+TzmEuJLVHxWfiz0vZHBGPR42TGIdXchqN93
         xldj0UgeDBOuta/3A9sVze0HVJJX6YP4dKmPJP9kfoDMdnSrsVe5fMc6kfI4Bwjl5doz
         jVJWPFXWUjHaftLD7DgDESurvdOpNxVdaaknFO36QjmhqmorKs0AWO7LBFk9FTahKzIR
         XI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681542509; x=1684134509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jZUeImb56Dv7gMaWS0vUWd1kqT52jBB5Nag68C7WNks=;
        b=GcB6ajoEEYiLMzsXdZmWGtMJ28phY2xsLq5/QTg3hq45P0cY05kvH71Qfb0fyg9XKW
         BprwgwWyaVFBrZSk3ERuAmorwx+W36dCQRCv9K3HaKx0c5eru81Q6xIHAL12FzUXkSyC
         igKs9JUxT9HMWAcXUsf1uNavJ5RpwglcAffs/PWGSMzZ0Aph31TmHsvkH52znhwMIenz
         YLTVQ7M0Ci6YUT+DliSHl7EHj4Vpbkdl43iyzIfSSvM2bl3j0sQRAps/cUvyY6qRvWth
         o86kLK7vMXh/KFYLHgrF64o18VnU01wy+TFn7ReWJhi9nMbZTo9iDZhba47l1sxTgZIG
         Llrw==
X-Gm-Message-State: AAQBX9foYzr/TsoboAHj+QwLaWRm0ZUOAjbpBgEuQxEoH/F01JpShgHa
        qOSlaREoLegpkg3kSPly8DwpS9vo+BW9yW9ReXM=
X-Google-Smtp-Source: AKy350ZEz+/98vodkZuVkWSmL9vYeBqeVy37wpHysHOeX0W5pwnkv+Z2ghTSNEAvL0Qxt1BJ00aBJ+M3PvcAChT9w78=
X-Received: by 2002:ac2:5383:0:b0:4ec:a052:9e93 with SMTP id
 g3-20020ac25383000000b004eca0529e93mr379119lfh.7.1681542509437; Sat, 15 Apr
 2023 00:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
 <CAPig+cQQVby2g+_kfucbYdwOZW5_CEyyyOex=4hXoCJt7TkjeA@mail.gmail.com>
In-Reply-To: <CAPig+cQQVby2g+_kfucbYdwOZW5_CEyyyOex=4hXoCJt7TkjeA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 15 Apr 2023 00:08:17 -0700
Message-ID: <CABPp-BH=LQdjn4yjtCJrPZVHLAZPC0895NYpyUfE92+TKcUsbg@mail.gmail.com>
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 10:08=E2=80=AFPM Eric Sunshine <sunshine@sunshineco=
.com> wrote:
>
> On Fri, Apr 14, 2023 at 2:13=E2=80=AFPM Philippe Blain via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Add some documentation for AUTO_MERGE in git-diff(1), git-merge(1),
> > gitrevisions(7) and in the user manual.
> >
> > Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> > ---
> > diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.=
txt
> > @@ -1343,6 +1343,33 @@ $ git diff -3 file.txt           # diff against =
stage 3
> > +-------------------------------------------------
> > +$ git diff AUTO_MERGE
> > +diff --git a/file.txt b/file.txt
> > +index cd10406..8bf5ae7 100644
> > +--- a/file.txt
> > ++++ b/file.txt
> > +@@ -1,5 +1 @@
> > +-<<<<<<< HEAD:file.txt
> > +-Hello world
> > +-=3D=3D=3D=3D=3D=3D=3D
> > +-Goodbye
> > +->>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt
> > ++Goodbye world
> > +-------------------------------------------------
> > +
> > +Notice that the diff shows we deleted the conflict markers and both ve=
rsions,
> > +and wrote "Goodbye world" instead.
>
> Some grammatical problem here. Perhaps s/and both/in both/, or maybe
> just drop "and both versions"?

It reads correctly as-is to me.  There were five lines dropped:
  * Three were lines starting with '<', '=3D', and '>' characters,
referred to as the conflict marker lines.
  * Two were lines containing content from each of the sides ("Hello
world", and "Goodbye")
and one line added.

Thus, the diff shows we deleted the conflict markers (the 1st, 3rd and
5th lines) and both versions (lines 2 and 4), and wrote "Goodbye
world" instead.
