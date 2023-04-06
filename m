Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE1FC7618D
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 16:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDFQD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 12:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjDFQDz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 12:03:55 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4046D4C16
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 09:03:51 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id nc3so11363499qvb.1
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 09:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680797030; x=1683389030;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pj2xyCeQ2vNzf8w0clReTJQ0t5TxgpRsPcxulT2RKlk=;
        b=FG4+6FtBhPT+bcHvFAoLtM94bgJOleb0kFRD3csXfSipJ1MEFZ27C7z/P9YR0j6+Hk
         8/Q9uGR9buQPwDV+eWCZI4KSkrWWt8TXiaW5ulhw7hDRDwV403yCYaN2JS5XeWb2P8GV
         Xi6nPROb2yuCuCK+ZHdNqT4CeojMGVUVu58npqYfSfTFEgthmGjuh5D/huL19jz/cvjv
         qvhktZLfw7bXVrynEqxZ5MuDpniOFpbsFe19IsNt8sWrl4qNScA+/a9al41jk+h1rWet
         0v4sHt21r/gWIhFkLd17JTYG3OnYM6hpqffpniIVPrR+RTPl25PYy3YrnVbv71t/eDnO
         +3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680797030; x=1683389030;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pj2xyCeQ2vNzf8w0clReTJQ0t5TxgpRsPcxulT2RKlk=;
        b=4y1wQdFN2TzpXLhc4eTSzBFUKHlT58aQphXfJk3zreux87X44pwwVlAwg78MrMhs5P
         sYtU+rsfyWI83lhVGnN6pNg1DvC20RTil03blzLP0a2eMsAZnMBw6YEYO4ZHVP4oTsID
         68iT0vZYroWipbhzKV/DZTbhqROCZX1mPe9Gg8xlU+p6+aT6T3w/0fPgAB8be7k41NjI
         zL2KU+ugZZ3IL1b+rloTjE4fjD7vmpNxUUwVpzKXwJfP464SYNQoK+k8/+DinQi6R7X2
         TZav39IT0AuYWJK16pZCpiNUB52QSudIBe0E2DHktUFNrkO+/eJ4HPd7cukMbVwJ9hYM
         z7qA==
X-Gm-Message-State: AAQBX9emYMsj12v8mdsxajR9qUO6Yl6mG7SyUtFHNcjnBPOZFsWuCgS2
        YAYohpQQNe1z387MVMGIufw=
X-Google-Smtp-Source: AKy350ZQz5/p5ExGEIEvsa4U5n5h2upU6P7WnLR/vZLOX0ueuXZhK0Q77tmb/gqqJukBKFvi6mY6WQ==
X-Received: by 2002:a05:6214:23cf:b0:56e:f1fd:f185 with SMTP id hr15-20020a05621423cf00b0056ef1fdf185mr4413674qvb.32.1680797029814;
        Thu, 06 Apr 2023 09:03:49 -0700 (PDT)
Received: from smtpclient.apple ([2601:5c4:4280:38d0:b05f:4a57:f2e6:c25e])
        by smtp.gmail.com with ESMTPSA id mg20-20020a056214561400b005dd8b93459fsm608331qvb.55.2023.04.06.09.03.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Apr 2023 09:03:49 -0700 (PDT)
From:   Benjamin <ben.knoble@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: regex compilation error with --color-words
Message-Id: <4ACDA0A6-1D84-4112-B600-84F05151BA72@gmail.com>
Date:   Thu, 6 Apr 2023 12:03:48 -0400
Cc:     dds@aueb.gr, demerphq@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de, mario_grgic@hotmail.com,
        sunshine@sunshineco.com
To:     Ben Knoble <ben.knoble@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ack, forgot the link apparently:

[1]: =
https://lore.kernel.org/git/CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUf=
d_bUg@mail.gmail.com/=
