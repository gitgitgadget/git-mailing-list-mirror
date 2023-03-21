Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0ADC74A5B
	for <git@archiver.kernel.org>; Tue, 21 Mar 2023 16:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjCUQAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231393AbjCUQAD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2023 12:00:03 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FAB271C
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 08:59:51 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id l16so8163330ybe.6
        for <git@vger.kernel.org>; Tue, 21 Mar 2023 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679414390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1vuMB2Xss8dtQ6SpUHUQSAeerpOKeAdnUB9a0rBO+U=;
        b=hOWBl6VRg9q5/ZR6aX3hhlw9kyKPo5z3+GauIYcQqO8eN39CDilad3pyAIyfNlL6pD
         nS0WbLAPNBW6dRFHr9vQlFoh8LYmw7UMAtj8XxmTEfusaadHTaYk3bQYcVBLkRlKwVsU
         wapWZ+8XuB6dsHr1H5b14K18y18cK7w+5VcRU1ysTJDczvbhiGv9cgjF67lv4NM+3/43
         StV7rDDFC8aScFUdeTKa8Q+9kQu0NohvSd89hD5HkG9IXBrBFCMxtsG3WfWD8oH/kCLh
         anpUHupke8uMRtfCKBL54DrZAcu4yWSVAmyxe0v3v3LDLwJaBF5Bc7t1xTr8j7+RjtjV
         lpgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679414390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i1vuMB2Xss8dtQ6SpUHUQSAeerpOKeAdnUB9a0rBO+U=;
        b=TcJxyoD4R0jbDmwqxPBOiBxxyYouSPe0C9vU+SYCqrLg5B26UisGHskafW3FSAhHyh
         gXnL6V5BbcgkwYRI6E/G6EgUrQPXUhb2lZ9I9kw2g8MXL9DdshPq29xq8eHsZ/nh9Fh6
         /u+TwwzW2ODsDlMfrkAVJ+CDULY7ICLMu8GsXHiSb9RYOjoIV5FXjbaUP4r9jcXbl/bd
         YptfOrAGl7WDKs3mfXZb0b9GIHMJiyBQWE/vXWoYETV8IVCO6sOmYRcU2Vlg52R8co8/
         yEJtmwrb6T/PosimDNZkr2S1OZdUzTNh1I3C4UNxkyLLXLnNdqUwVIXN9sOXqlkdhUdO
         K0EQ==
X-Gm-Message-State: AAQBX9c/6lv6I+CBQbQMn9RQKQDZZg3f3Jfoc/bwJqdtSWR2kgmn0R1N
        loXvghmVLHFs9HRjQyu09/eeYpWaLBDe4XqjSlpJSzFw
X-Google-Smtp-Source: AKy350ZYswX8U2fNT1XDTzYrq5x8tMYQ40rPSs997Jf3S5TY/ym7kkRkv+9fE1nRR/KeUWo/oFOUcUs9GisjG/a2vNw=
X-Received: by 2002:a05:6902:1109:b0:b6d:fc53:c5c0 with SMTP id
 o9-20020a056902110900b00b6dfc53c5c0mr1998080ybu.1.1679414390653; Tue, 21 Mar
 2023 08:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAPNJDgcauhz_NraSPTQfiDM61gyghSJShZLPUtt5HOr2xKysZg@mail.gmail.com>
In-Reply-To: <CAPNJDgcauhz_NraSPTQfiDM61gyghSJShZLPUtt5HOr2xKysZg@mail.gmail.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Tue, 21 Mar 2023 09:59:39 -0600
Message-ID: <CAMP44s1VnaM=vVYX-uvN1O0D87cgmWYjZzh+QzVhxr68c8W3Cw@mail.gmail.com>
Subject: Re: [GSoC] Intro and Micro-project
To:     Edwin Fernando <edwinfernando734@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2023 at 9:32=E2=80=AFAM Edwin Fernando
<edwinfernando734@gmail.com> wrote:

> I found and looked at a few places with pipes. I have a few thoughts
> and questions on making a change. Firstly (if this is relevant), how
> do I ensure that the file I write the std output to doesn't have a
> name clash with other such files made during tests?

Every test script is run inside a different directory. You can check the $P=
WD.

> I will follow up with an email of the proposed patch.

I'm not sure of the usefulness of such patch.

Cheers.

--=20
Felipe Contreras
