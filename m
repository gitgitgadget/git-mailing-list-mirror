Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17B1C77B7C
	for <git@archiver.kernel.org>; Fri,  5 May 2023 19:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjEETBf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 15:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233353AbjEETBd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 15:01:33 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B7420748
        for <git@vger.kernel.org>; Fri,  5 May 2023 12:01:23 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5191796a483so1521110a12.0
        for <git@vger.kernel.org>; Fri, 05 May 2023 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683313283; x=1685905283;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsLtLD9/8k/r97RijwDbUBLBgNW0Yg5pxPJMUKifHJY=;
        b=e4G92W4ZipqNeJt5fDMG5hUlKb63UGAPHmScKuP8BQoXWCvsyB5B7OAgU6BTYhFgnp
         5hDERkp8tgHTvQD2O8TWinjRpUtfrDFHxucFSOHKnsZjLxW0Jz3Pq7sQywZVWI2Efs/7
         BVQ2lmWd+UVeOomM4+yD/obIOMVYOYg+Wr1XO5vQNjzhbf686N7m5MDGXJMgm3tJke0Q
         iANlYUGY2y9Qiley1wB9+dtZHwsAqcJ5L1IbF2gQoW846M2T+FUTISdP/P4Lf0mNy2fY
         SrMWQJxw3dfJCz5AhABMSrjjglueeI34c9f+k+SxizTae+/OaEL8/TFs4m1+KA6hMNKV
         A5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683313283; x=1685905283;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qsLtLD9/8k/r97RijwDbUBLBgNW0Yg5pxPJMUKifHJY=;
        b=U8pKv381CJYTkBbwsCF+swrYKIdsNTHOPkFTF4Oda8THVmjNb2i1nRgCAYRwor4WMv
         fhJgNGde1oPX7lRmEeWye+03NwQKU9/DyDPf+oqKyPmHLJRbvwahR0Pn5YOtqktKaeUa
         8RnaukElEEodWdn5BDZRU+jSvcF33D9z0eSk6Q6tqlem0mZQsYHbJ+hqevX3R+6BhsKI
         4R4KIr18CyVd4sfvRJ6i3lH6vcflXfF6A8uvDORnNM2PCNKXAX8p85Qkx3LE1OGyH8V+
         UAVsKAL5Riyd9NhoV4YfZQbym5UqmNiMj4K4vCaI3r5EWFzWQWPRgyx6JZeqaCn7Ckaa
         wORw==
X-Gm-Message-State: AC+VfDz7SYi/G8YNFtdzK+VYl2q1IC/WPRp13CJGTWABTO/bTi5Ez23A
        cSjxT7Cy/FSjpGy7/rxD79V8KrUPyMM=
X-Google-Smtp-Source: ACHHUZ5Qabr8Dvxmjpd1c/ehge+i3BVHL21zUa9hOAGP01wW7BI2Fxt/kyIJmdScSuIn1f2ngUznUw==
X-Received: by 2002:a17:902:7e84:b0:1aa:f173:2892 with SMTP id z4-20020a1709027e8400b001aaf1732892mr2064802pla.57.1683313282985;
        Fri, 05 May 2023 12:01:22 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902c3cc00b0019f3cc463absm2142807plj.0.2023.05.05.12.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 12:01:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] diff: fix interaction between the "-s" option and
 other options
References: <xmqqfs8bith1.fsf_-_@gitster.g>
        <20230505165952.335256-1-gitster@pobox.com>
        <CAPig+cT=3dmtEEApiPUvB9+5ZHx+uwc1NXhYsf4peYiSwPYPsQ@mail.gmail.com>
Date:   Fri, 05 May 2023 12:01:22 -0700
In-Reply-To: <CAPig+cT=3dmtEEApiPUvB9+5ZHx+uwc1NXhYsf4peYiSwPYPsQ@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 5 May 2023 13:41:16 -0400")
Message-ID: <xmqqwn1md2m5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 5, 2023 at 1:02 PM Junio C Hamano <gitster@pobox.com> wrote:
> ...
> Glad to see "THis" from v1 fixed.
> ...
> And this final part addresses the big question which v1 left dangling
> (specifically, "why the proposed patch doesn't eliminate NO_OUTPUT
> altogether). Good.

Thanks.
