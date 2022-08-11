Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA5C19F2D
	for <git@archiver.kernel.org>; Thu, 11 Aug 2022 08:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiHKIxb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Aug 2022 04:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiHKIx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Aug 2022 04:53:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F593502
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:53:24 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b16so22088042edd.4
        for <git@vger.kernel.org>; Thu, 11 Aug 2022 01:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc;
        bh=lkhmFTC0Mt9AKj8wpql+GYKhA/h/i2WdmQGh4O3vgIA=;
        b=aylpA8sx6OM8J1UgjR1M6hKB1cAYXZRbRiabd1fa4hr8nrFPbC+tDVXQZRWKPGSkXj
         qNmACGHYEKvPxmgo9Nw+Y8AN8CbMQ96mLdkVUTjhJN60KMc0z9szwL/UfrBRNt6fr0i8
         UJLLhfSjk2v+L74xIy6IXicCh5aY6jYI1RWgZ0aGJwAkgJtFvqduqa3MykDiOELO7ryI
         60K05X3j6e3AtYHNY58Z6z8Hgu+9EGRIPC8RFfxIPkHtESlzlAt1vxb2HtrjLyokc2Oh
         h7jcNqkVwKdJR/wpYRqrXE5rvo7JScZqbTd0qnInL8K7rVbwG2K3bXJw8mgN2Cd96TFK
         5QKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc;
        bh=lkhmFTC0Mt9AKj8wpql+GYKhA/h/i2WdmQGh4O3vgIA=;
        b=TxmAaKlBSTaInBfMdw6zneWhI1uenRTtP4mlg8wGQe5v/16nEEg3/y3Oq8p5I96sbi
         Fz364iRFMcYpaZjIjIqIiGCorbS7gxln7v+WvyJ/NxKSEKaQKrpk5P7ys6GUBG0Jr8it
         lSPFwIQG7apW3yz2YXUzM4ODEtcb4Di2PWW4797xZIYfLe2xXDLHkc8dtwNJJOjuHKbE
         IQF+5+QKOkbou47wwMjILCA4PKyN/TCF4gbIar21dCbDhkdfZr+Abiduv0e+wrH+8rrB
         DQUkfqHbsg4zPc/U5Ya9fbQ04y6fYnhrCIGz2I+qWry1khcFOz0b/JxHqCnX5cuVr2Wk
         sSwg==
X-Gm-Message-State: ACgBeo0DsQAf1+4EgT4IAS2v8GtEcsFKHHF5ufF3vOXf6fWv3Ux1ml6x
        IyBTpim5/UhMuhHbK5ucxsCXPjocKQec58nG3p/adqQuhPc=
X-Google-Smtp-Source: AA6agR5dVXrM7Ypd31WFsnqHp2RzXnIPzTvgUc4t4DRfFcVOK0wsXXFDxyORYtKZWkmTsRlFGL1+S3s0GejcFqdqRGg=
X-Received: by 2002:a05:6402:5192:b0:43d:cc0d:6ea4 with SMTP id
 q18-20020a056402519200b0043dcc0d6ea4mr29943018edd.111.1660208002726; Thu, 11
 Aug 2022 01:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAO8o=D6p+aFOeRdTDHwPa1E+V45Uqh-TuSZbz0WU=rE-ksGj_w@mail.gmail.com>
In-Reply-To: <CAO8o=D6p+aFOeRdTDHwPa1E+V45Uqh-TuSZbz0WU=rE-ksGj_w@mail.gmail.com>
From:   Noam Yorav-Raphael <noamraph@gmail.com>
Date:   Thu, 11 Aug 2022 11:53:11 +0300
Message-ID: <CAO8o=D7QC71mnyKSceMpYJzVO4=POva=mJQ1bi0teUHPB9xesA@mail.gmail.com>
Subject: Fwd: Idea: add --squash to cherry-pick
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's something I need regularly, which I haven't found an easy
solution for yet. If there's support, I may try and implement it.

The need is described in this Stack Overflow question:
https://stackoverflow.com/q/35123108. It's fairly popular (107 votes
for the question, 154 for the best answer), but I find the suggested
solution lacking.

Basically, I would like to add a flag --squash to the cherry-pick
command, that would apply the diff between the start and end of the
specified range in one operation.

The use case is that there's a feature branch which I would like to
apply on another branch as one commit.

I could use the `-n` flag to apply all the commits from the source
branch without committing them. However, if there are conflicts, I
would have to deal with them on every commit applied. Instead, what I
want is to just apply the diff between the first and last commit, and
then deal with the conflicts.

I find this to be a very natural operation. Usual cherry-pick applies
the difference between commit A^ and commit A over HEAD. The suggested
`git cherry-pick --squash A..B` would apply the difference between
commit A and commit B over HEAD.

What do you think?

Thanks,
Noam
