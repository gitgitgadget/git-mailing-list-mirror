Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6AD5C7618E
	for <git@archiver.kernel.org>; Sat, 22 Apr 2023 15:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjDVPAz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Apr 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVPAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Apr 2023 11:00:55 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AF91995
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:00:53 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2a8aea2a610so25739471fa.3
        for <git@vger.kernel.org>; Sat, 22 Apr 2023 08:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682175652; x=1684767652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ld/CvC+bXvFJd4IaFEHiOv4pNo5nhQd9LrZZY0B9iH8=;
        b=OXoyQLoU5BqpTkMf+oQq8/xsRcSj0ZXlwKeWgqmW6ZLE/Cr0PsKK2mIhmBQHjU8OTK
         ZPzA7BWO9D3z6buWyT0tr2y443iKeOA3w93WNrp+I1DZJoJ2dVz2dlmam2Dwribj71Bg
         cmgk5y520Z8rknXfAZcRJU8U/JDGnV4aMaHLDgbq2M6n7EgdRriQzxSjeDnN+pd1I59h
         Xu4DTICICIRjQrzT1gG7pYThRSOQg6yUUzn2irlmgil1hLcX57kco5gfvTTG7QIcuYB4
         s4+F7gWUt/96Zmk5uZf43CZEwZUCzl/s0+XPLwYaZ+M0G3KNmJrJ/ebrVfOBYkYjPt+M
         1uvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682175652; x=1684767652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ld/CvC+bXvFJd4IaFEHiOv4pNo5nhQd9LrZZY0B9iH8=;
        b=kMr+pB5OSPMt3Hv7AbVHCRrVL57B4aK9jBRuQfkzPPyKRLDXWYrh2WPQh1nWSUogY3
         Y7zL3ZS+rK9xwGOA8gz5bSrtsMnEN/PwXXV+lk8bwROS6OzcqGlzJxKfpKHKiEvEk0Of
         BIhtAboE3FIWb77RM6aQe0feiKdrB4Qy71cGA55wHs9awtbO0KpnUwE9yTH2+WzEUPvj
         j7x9+2R4drl8ajV31LepGBO47pFEuVAcaxkto0nGLJjHF6tSWOE4XsB0aW2R1/NYzqnF
         nZ6CIRUHL6GgnNw2Qy7m1vosmqpmFNfz1v/CnCqO4dOeBsJV9LrgwFquZaKUmaZKCs0r
         BFPw==
X-Gm-Message-State: AAQBX9f18Tz2bIK9F81qZk78UAaj/WvLoSyVzCJz5rm1DHOuL9D243yw
        /d/Dr01RfFu+oIg66SRIWUZukfDGxU4VWG7/9i9t1B4P
X-Google-Smtp-Source: AKy350Zi1fVZSQDtOq7QQu2EQBxzU8vzPE+y2BxR67PYrVgrPRHBY9J7YhEmbzwnz4Gwv1WlJdzBTl8bKAqw248S+cQ=
X-Received: by 2002:a2e:9c47:0:b0:2a8:bd42:a811 with SMTP id
 t7-20020a2e9c47000000b002a8bd42a811mr1274430ljj.27.1682175652078; Sat, 22 Apr
 2023 08:00:52 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqwn26w5cd.fsf@gitster.g>
In-Reply-To: <xmqqwn26w5cd.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 22 Apr 2023 08:00:00 -0700
Message-ID: <CABPp-BGPbo8B6JXBOHTQs0LegpwHccbnnGe__ea05fkO_34YKA@mail.gmail.com>
Subject: pb/complete-and-document-auto-merge-and-friends (Was: Re: What's
 cooking in git.git (Apr 2023, #06; Thu, 20))
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2023 at 3:57=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> * pb/complete-and-document-auto-merge-and-friends (2023-04-14) 5 commits
>   (merged to 'next' on 2023-04-20 at 2728a01622)
>  + completion: complete AUTO_MERGE
>  + Documentation: document AUTO_MERGE
>  + git-merge.txt: modernize word choice in "True merge" section
>  + completion: complete REVERT_HEAD and BISECT_HEAD
>  + revisions.txt: document more special refs
>
>  Document more pseudo-refs and teach the command line completion
>  machinery to complete AUTO_MERGE.
>
>  Will merge to 'master'.
>  source: <pull.1515.git.1681495119.gitgitgadget@gmail.com>

This merged to next already?  Doh.

There was some misleading text (and a few typos) in 4/5, and good
suggestions from both Eric and Victoria in the thread for wording and
display improvements.

Perhaps we can at least wait for a fixup patch?
