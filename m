Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C245710F9
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 00:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719794731; cv=none; b=c3Y1e0rZIkoqbSZ0266g/4IwN2/Z2s2Z1oGI6Bdob9QnxaQFTxp4rDrENzCPCVX54NseLzQohPV2Fr6Yjx2nXMl7RRboWIoUkdDrPFIqD6C3oSP4QivqrBuqNs5xG8/iG05Xp4IezEbXqhaBRnJKpRgviwrW1mahBknXr1AEpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719794731; c=relaxed/simple;
	bh=UuYfNEKmj3El4eKtXCdvkbPna2JlJ1UG24RDlMzI9Yk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZuSEAEEQF3Zc+QAsKv/njq2g8OkXdwN6QSR6IXnF2fTK08naAw8OoLTsyNglQh5IBRf58oEm4HI7IH3N8AKsE5Y6/DisS8Ee1KsbKKvFttb+C6428YwF4tSjIhPSRBBgScxqGOEmLoKDtnuL/W1HZbfBVGInvTB6I4AzGuTtf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OkREfOMy; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OkREfOMy"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1220469a12.2
        for <git@vger.kernel.org>; Sun, 30 Jun 2024 17:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719794729; x=1720399529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a7yT7Y4QiMRSLd5CBy6vaLTJppzaiCF26Hgx071GyhI=;
        b=OkREfOMyTcGDQQGKVAqw5y4nOI/hHNntTbOw4YAwoDiRKE/a3J52XoA/4/avW57wS4
         8XB/t2BmbGz649qevkA3iCPQ+Ub30W0szobCVt8/QeTCJrP8pBXMmodu0kiNUlc8T17U
         5osY0w8mks0LxlYboPLsC1KafTI4YfHKZM00qODOhIJuQD0rDu97yZfaOQ1jOxMQZ9oc
         ut92nfrB2PsntUjueMXQnECbxNA2zv4a1KKu8CPMAceLISY4x8+wc9NNc2xmnzbWPCBD
         YOyRSS8XbenDG03ZmtbE7svN94lB8r99cZZo0Nyzktjsagcy18WDzd6tgPRGuSqgq+UN
         N+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719794729; x=1720399529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a7yT7Y4QiMRSLd5CBy6vaLTJppzaiCF26Hgx071GyhI=;
        b=NKvTlh8bWGxrP4s3GQfdqLLC4GGWGObXzkQko/LpVMIa51Uvk4T+h+qRs7rZFy0jxX
         DK+LOrNaUgOoHyijW+rIznT4aymDf5w0K8zS+7EFUvu/I8VkruhtkNrv4frXyHp5YaUl
         uwlvBEYCSdR+EydFd44NHkU0jpFR8O6FEbA2RA6U2cHYO84h3PkFMzdn+7rQvq1ZBn1I
         cfcJJkzr48FRw5aA7R1zpt2QU3Lff5ZvSsNKZM8iybo1WA5SGX9DMaOVLveDSAvERTpT
         SvI6yDIq06HwB19AujimFt3iE+ApqVoqjUaEsCmh+g1zhkD6ZlVH129+E4Xpb705DIrf
         72gA==
X-Gm-Message-State: AOJu0YwyTsv2CYljpDtUxCnvcRkbgETuu0CDcWRw/dh/kzwf9IqW0w2W
	GJGBxN+DfQxXgLrEtTi/ikMI/wzVsT4G4UzmZoF5rhGQocrM9Z+8Z5lQh8Smxmd1SBCuZ7+1lGo
	7kJ/Li4YoMzIgXUUC0S2sxyfwKj0=
X-Google-Smtp-Source: AGHT+IHeocEFqOwSG8NG5tTkof4tYm3TXJcBGbIqSt6ehi3GlFzg8XMM0BIiejbFxyCgDHQDfRS3LaHBaG2k/yHAhY4=
X-Received: by 2002:a05:6a20:3c8b:b0:1be:c4e6:ed40 with SMTP id
 adf61e73a8af0-1bef62140b9mr3326563637.51.1719794728967; Sun, 30 Jun 2024
 17:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
 <CANiSa6hVbrCpPtBCL_W8+43uWGL0LFJkFhSJYGtfFgxX75zE8w@mail.gmail.com>
In-Reply-To: <CANiSa6hVbrCpPtBCL_W8+43uWGL0LFJkFhSJYGtfFgxX75zE8w@mail.gmail.com>
From: Martin von Zweigbergk <martinvonz@gmail.com>
Date: Sun, 30 Jun 2024 17:45:17 -0700
Message-ID: <CANiSa6g9L8PM8wLhrH_3TYFBh7FwgGXXAk9qVpFkSM3zdcKqKw@mail.gmail.com>
Subject: Re: Determining if a merge was produced automatically
To: Pavel Rappo <pavel.rappo@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Forwarding to the list without HTML so others can correct me if I was wrong=
.

On Sun, Jun 30, 2024 at 3:32=E2=80=AFPM Martin von Zweigbergk
<martinvonz@gmail.com> wrote:
>
>
>
> On Sun, Jun 30, 2024, 11:06 Pavel Rappo <pavel.rappo@gmail.com> wrote:
>>
>> Hello,
>>
>> I'm looking for a robust way to determine if a given merge commit
>> could've been produced automatically by `git merge`, without any
>> manual intervention or tampering, such as:
>>
>>   - resolving conflicts,
>>   - stopping (`--no-commit`) and modifying,
>>   - amending the commit.
>>
>> My initial idea was to re-enact the merge. If the merge failed, I
>> would conclude that the original merge couldn't have been produced
>> automatically. If the merge succeeded, I would compare it with the
>> original merge. Any differences would indicate that the original merge
>> couldn't have been produced automatically. Otherwise, I would conclude
>> that it could've been. This approach is simple, but involves multiple
>> steps and requires clean-up.
>>
>> My second idea was to use `git show --diff-merges=3Ddense-combined`,
>> which only prints hunks that come from neither parent. If nothing is
>> printed, I would conclude that the merge could've been produced
>> automatically. This approach is simple, single-step, but seems to have
>> an issue. In my experiments, I found that if some hunks from different
>> parents were located closely enough, output was produced. So, checking
>> if nothing is output could lead to false negatives: a merge that
>> could've been produced automatically might look like it was tampered
>> with.
>>
>> My third idea was to use a recently added feature, `git show
>> --remerge-diff`, which seemingly embodies my first idea and is immune
>> to the issue of the second. It is also single-step and requires no
>> clean-up:
>>
>> > Remerge two-parent merge commits to create a temporary tree object=E2=
=80=94potentially containing files with conflict markers and such. A diff i=
s then shown between that temporary tree and the actual merge commit.
>>
>> However, this bit means that I shouldn't entirely trust its output:
>>
>> > The output emitted when this option is used is subject to change, and =
so is its interaction with other options (unless explicitly documented).
>
>
> There's basically only one way to display an empty diff, so I suspect tha=
t checking that the diff is empty is still going to be enough for your purp=
oses.
>
> Note that you can specify e.g. the rename detection threshold to use whil=
e merging, and the person doing the merge might have used a different thres=
hold than you're using when you're trying to check if they added other chan=
ges. There are also different merge strategies and diff algorithms to choos=
e. That means that you might get false positives and false negatives. Maybe=
 that's still good enough for you.
>
>>
>> What is my best course of action?
>>
>> Thanks,
>> -Pavel
>>
