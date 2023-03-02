Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DB1C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 05:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjCBFCv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 00:02:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCBFCt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 00:02:49 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BBB2A6E2
        for <git@vger.kernel.org>; Wed,  1 Mar 2023 21:02:49 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id t22so12654437oiw.12
        for <git@vger.kernel.org>; Wed, 01 Mar 2023 21:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677733367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svgn2Olo+3KulFk0BU/rAQZR3m7R19MCHtVMSwaYqyg=;
        b=IMz7kcuKV/vvMNrqaRRO7TIo2DmhI/YjGAsYQvLUuRqmoR+Wnb/mUwo5LoMexkFtO9
         AoniVzDrGzyqZd7yG5WI7VqEp1hdN74A8uOPo1Zha9cP9mgxsew44SsjfXDPLL2/CpfZ
         CQnJ5U39tuqK1Ddq6SeX8ZoYp8cBoEPR6RMy6z//2i2cortuCpuv1qqroyROrfeohASe
         +a+sg4Ww7ud5yGq0EClHrmfQqzrLJLHnGuyvsNUBRTDvwWFXtleP6zDgeH23M6c8ynkl
         CirzZVG9LXUCXHLphILZN9hqhAhC4fRByj5EKaco9KJ79tauQ93rR2JA/7hbii2QcpSA
         u53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677733367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svgn2Olo+3KulFk0BU/rAQZR3m7R19MCHtVMSwaYqyg=;
        b=u9oUPOySCIfymBd1BbxcoHyerOz6xu9hkMwWXNw4hUPekJDYmuNLk9vHOSIAn1f39S
         1er+wMvExOop5Fv7blsv9mbUjOeQZEUfqXSoTG/2xbDraEgGN2Vm9mONQjx3emtfdv5F
         28yYCp+lXsW3bjIeua/YGOvp4VOPAh9YdEFPDhUHp2aIAJ1lnSEaVCgcUJGpPAGgky+D
         dTfXa/ExSJs8ENpKgK7KoJAFJeKWJJrl4Tovw7uEbiZOGA7sqSYV37VDQYuBAEFcQg4l
         x3yvtho/L0Wb4ePHlrzyWuj3Nq2sv07qIOWFny7+ePBIOaYLmVMXSyTVtVng6xfqso1h
         K3fg==
X-Gm-Message-State: AO0yUKWb5Lz3rIjCo6Qb+JZDHHGCzmJot/L2afV89HhegZGBfqeyVXOb
        d7Uh1IGATrNxg62BamV+/I/zSNo3+nWPGSwwt0Q=
X-Google-Smtp-Source: AK7set9E6a0dWO8RkcrzPn3uD+HzKzR7PzgEJmB/jObkVd2yxWXGH+KM1dXnYknPitRQQAB8i675xa6LSbDa0GJLjhY=
X-Received: by 2002:aca:1005:0:b0:384:1e6a:bf10 with SMTP id
 5-20020aca1005000000b003841e6abf10mr2669334oiq.5.1677733367306; Wed, 01 Mar
 2023 21:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
 <20230225180325.796624-1-alexhenrie24@gmail.com> <kl6lwn403vyn.fsf@chooglen-macbookpro.roam.corp.google.com>
In-Reply-To: <kl6lwn403vyn.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Wed, 1 Mar 2023 22:02:31 -0700
Message-ID: <CAMMLpeRioQUag7THDKACKhS3VS+DsxzZSaFrJ8L5=1+1s=qxAA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] rebase: add a config option for --rebase-merges
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2023 at 4:14=E2=80=AFPM Glen Choo <chooglen@google.com> wrot=
e:
>
> Hi Alex! It was great to see you at Review Club today. If you'd like the
> notes, they are available at
>
> https://docs.google.com/document/d/14L8BAumGTpsXpjDY8VzZ4rRtpAjuGrFSRqn3s=
tCuS_w
>
> though reviewers will send their feedback to the mailing list anyway, so
> don't feel compelled to address feedback that isn't on the mailing list
> :)

Hi Glenn,

Thanks for hosting the call today. I was impressed by the commitment
to having discussion and making decisions on the public mailing list,
"as though the call never happened". It was a pleasant change from
other open source projects I have contributed to where decisions are
sometimes made behind closed doors with little to no opportunity to
ask questions. Thanks again for making me think a little harder about
my patches; I expect to send a v6 by the end of the week.

-Alex
