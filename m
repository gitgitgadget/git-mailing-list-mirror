Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F59C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 01:55:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239618AbjELBzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 21:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjELBzr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 21:55:47 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9195583
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:55:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so100562161fa.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 18:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683856544; x=1686448544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOjdAseKGNHMVcuz5eYsFr8WK1VDvigySyOswa/LnbY=;
        b=q/hI21J3EtwtqjbYZuUujc9D97/YidX9fM+6kW+UdYcwjrZyDCbBvVHv3o/tEDzXnR
         0TkzGwI0/A/5MbsGLRxvm87A/iFEE3oGWEtoqGURaF7CJCTCpNVQfCeFI/lJGhTAth08
         2kZGRHLVHiy/XfRih235DvKN2DAzCoF+eZPBjyMSVhcIPX6mgzCqBp/I6cWWlCM1H3AX
         RzrKPO38/CC3uzsM3FUnYMrVFHbhWXiQxYlwiUj3CUPz+5E07YhKbDQpFFKr8m1Gm5Qz
         k5+xzwCxzVdYzylfUoDWSPqIy1h/lYh+AqUvGnDgX926Vr79y1hpY42o22ir9voahEak
         hRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683856544; x=1686448544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOjdAseKGNHMVcuz5eYsFr8WK1VDvigySyOswa/LnbY=;
        b=hrZKnS0OVjfSv5TOVULeBlfs8RdjPmHGftK/47aNNy+U+T//dF5+Tldl+3mjc5cgE8
         eseuXa9JR+HVkoSkg6WGuTJaaS3qF5NYTiw8dmdaSK5EqcsUtTSHBlrRM1aeIJh7Gr+p
         GSJMMB6NFsQDzviPeT8BYiAC8Rc3fsByi7Yk86PmECnE6lhgBdRhdVdTDnhoUYgiXm3h
         BFRNnztXJNAkOJd7k870SOf5d3RIQGC8G8ypIihXwQi7+i7Su0g32nsULCGwv+N2W5RF
         avxWRx6m2ZLU+MZ3/DmCENdFaJk7hblCLwgvvYa06Eib56VfpS96VeES5v2jOL0CxNsv
         sWPA==
X-Gm-Message-State: AC+VfDzBixpxxFJWb3GnmM8PTFQ2XDwJiwyB2uoiPtPik9RPFmHc8VZB
        emzq9TUDSLQxXAmHqJMJcNg5Miooo0LxdN+hllw=
X-Google-Smtp-Source: ACHHUZ4Lr5BjAJTCj66RQek8PFewZWKBEjeq3hhZyOTaFRP23oIxXX90OwJ8q2QocHAHWqIL1nVY9mkVG5eZ4mTyQ7k=
X-Received: by 2002:ac2:5930:0:b0:4e9:74a8:134c with SMTP id
 v16-20020ac25930000000b004e974a8134cmr3163543lfi.43.1683856544297; Thu, 11
 May 2023 18:55:44 -0700 (PDT)
MIME-Version: 1.0
References: <12a251f77f679123d01892109694f8ee19b96252.1683431151.git.gitgitgadget@gmail.com>
 <20230511172436.935061-1-calvinwan@google.com>
In-Reply-To: <20230511172436.935061-1-calvinwan@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 11 May 2023 18:55:00 -0700
Message-ID: <CABPp-BFXx2f-z994fVzErQNaL+MDA1DsTew6JBdu9sy-v4bYbA@mail.gmail.com>
Subject: Re: [PATCH 01/24] init-db: remove unnecessary global variable &
 document existing bug
To:     Calvin Wan <calvinwan@google.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2023 at 10:24=E2=80=AFAM Calvin Wan <calvinwan@google.com> =
wrote:
>
> Splitting this patch into two would make it easier to review and follow.
> Regardless I think both changes make sense and thanks for documenting a
> preexisting bug.

Sure, I can do that.
