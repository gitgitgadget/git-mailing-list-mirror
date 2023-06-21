Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A3CEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjFULll (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFULlk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:41:40 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F01EDC
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:41:39 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a1fa977667so5798516fac.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687347699; x=1689939699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFiSiTt6eg/840q/avtpusAI5ykrz3numz+RiI/lxWM=;
        b=qH55yX9MlRSg7YsGfba2Vl5/HX8nKWlr/25jGfTZa9yovDP2RubdMJBn/hwb7q6353
         2+iezPocO1EITt9ZXaKi6AJGI0fyHSzyD7WKNzPvnoro1nIUOBtxmJuZTJg3hfV2+V3k
         sjzMgTU46bAU0j61xQScx1SdqibV0azNqc0hd5RbQc2MdyAJdmIbMAb8YDFv0uMGt1/v
         e3BP4PZy6M+O22P7j5/0SUsC0EU26gzHB7PFy9UkfbF1+VyS99JoAtBb3+I3a17O4n07
         2rnUr7KsdCwN4vAxr0XNsHMq9N+4WBNpDvcaMOFGDCU1FByV+AlZZkSqHtnV++iX4SiA
         D9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687347699; x=1689939699;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFiSiTt6eg/840q/avtpusAI5ykrz3numz+RiI/lxWM=;
        b=id+s9mGu788q60I45BJcyktpLjaCjIlq1ZgYQeuBlt5VuapIxAVDt2xM85NrOV1DMd
         Fd03u9kSx2KhEOSVquDbO9lC4y/5XjbLXQ/S7Ypwu6hrewm/MO4axRQH8kP+T28bibDL
         uvvooY4VBnVc1qjx5rqptK2PqRCLCrvaFgBRpB+LqAUYrYI7FQ+4IXs0JK1iKClYMwut
         cKvUzjnDQASj/rj9d7p20kt8qO3PHqj/J20i5du3FLBC6dNMc6Jftl6F/NZHp4Yj9xCN
         jgSkURDZ3N+PQUD3kM0x1kuzxWOkl5WryVxqV4wqNulAZqX3JNSJqa4DTA9dzcoAstUb
         1SBA==
X-Gm-Message-State: AC+VfDyvwQhR/KsfpnNJhCywaIYnLQtt1uRr2uuaDm7JLZno7KgVWg6P
        jwtqsV646IRrZQjOTykUBnWAFqFyx3Kvw3fC7Ws=
X-Google-Smtp-Source: ACHHUZ4zFCq8D8QbtR4OTfILTKci0xXvL7JgmzYBfDXxswCP0csmzzLAfvAM+jlV0MJQ7lxiKjsnyv6xbmXTXG9IHKY=
X-Received: by 2002:a05:6870:e896:b0:19e:ed91:1d42 with SMTP id
 q22-20020a056870e89600b0019eed911d42mr10343301oan.35.1687347697055; Wed, 21
 Jun 2023 04:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLa=ZRumrpfG8FxQQG=Q8tGvxEapMvOx6SZyRPh0GSpn5iuUg@mail.gmail.com>
 <xmqqh6r2ni4i.fsf@gitster.g>
In-Reply-To: <xmqqh6r2ni4i.fsf@gitster.g>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 21 Jun 2023 13:41:10 +0200
Message-ID: <CAOLa=ZTBkzc78RpAdeQO2yN_itDbmKvkQ91RQjENwD9Y8uwR+w@mail.gmail.com>
Subject: Re: [Bug?] Information around newlines lost in merge
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 20, 2023 at 7:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
>         $ git merge-file -p A O B
>         <<<<<<< A
>         with a single line added by side A (without terminating LF).
>         \No newline at end of file
>         ||||||| O
>         =3D=3D=3D=3D=3D=3D=3D
>         with a single line added by side B (without terminating LF).
>         \No newline at end of file
>         >>>>>>> B
>
> It has exactly the same problem we already have as these conflict
> section separator lines in that lines that exactly would look like
> these extra lines _could_ exist in the payload, so it is not
> creating a new problem, but people may have built and are happy
> enough with their incomplete automation that relies on the faulty
> assumption that the merged payload would never contain lines that
> are mistaken as conflict section separator lines, and such an
> augmented output format _will_ be a breaking change to them.
>
> So, I dunno.

Thank you for taking the time and responding. I'm wondering if there is mer=
it
in modifying the merge algo.

Perhaps something where files merged with terminating LF would retain it.
So merging "A\n" and "B\n" would produce
"<<<<<<< master\nA=3D=3D=3D=3D=3D=3D=3D\nB\n>>>>>>> newBranch\n\n", whereas
files being merged without a terminating LF wouldn't, so merging "A"
and "B" would
produce "<<<<<<< master\nA=3D=3D=3D=3D=3D=3D=3D\nB\n>>>>>>> newBranch\n". W=
hich
would make it easier to parse.

But overall, I get what you're saying. I will drop it here as expected beha=
vior!
