Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571451DF250
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 18:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732299187; cv=none; b=dttF9QrnZxzXnIJUAE2IUepY2w7a0FdhEvPEuLMS2msQY4SxH+lc8+Egz5i5rYxN3uhH+SEuh+Yvb8IhTQfBuM/xwEET926QJBdjtL7y2AxpjDKKKToTCa/U3oOGN/6BQOsUOvLr6C/8zx8DwpDF2rKzkiN8lwWENhX6BxBp2p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732299187; c=relaxed/simple;
	bh=EOq9P/plyzdI376kF004Hi0W8r8mBSs0AhQPUwfeKfw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=SJzhllDJCbfrZPv6hOvo9FpjdJZuWiNwPEOAC3753V0CU3xWNrNEv/oh0z9TM2CXTcIBhiTnPKkcaxofbf9E45sM+MDitVcmqiSrx5wdh2sHRGTGp8qUpC1TJ6gmAyc6HIUSMAoYXrco4ciauerB9KpW3WFUwRU2t2ueHw5fsVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dUfHg8UB; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dUfHg8UB"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53da6801c6dso2162973e87.0
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732299183; x=1732903983; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koIj9NP7rH7O6uQhsa7NaJG5v9+MKUhNRbfMyzRxQRI=;
        b=dUfHg8UB3JqrneD3PaQ0z1W4sI7ODsk1yUIOFV83GpYC+qGnQ1uk732/HBtdhyl/MD
         AKtSWYrSbYEjIKO1moig8I7OfxFupUuWrkKYBAvDl2kNG4XRPlpGTjyohBe3cFiUi6+L
         WvBku7KdRbGxAi4ua+CEhgidIqsACNRzTPqTMAbu841gZonhVp7Cg/KaNKG8K/6pToIo
         eRkNHATjo0P7b+zNPDOkY0qQrFPxIRSmzd0OFfI+pJ2L3Ux2rFW7+iM0prmOpAxiHDtq
         9jgf4Z8BAXXhMod5B3P6Ny1SFbcnuXNW2yPFFMN/qtE7XnMPD/3IIjQ+mDU52ne4iGAq
         54yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732299183; x=1732903983;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=koIj9NP7rH7O6uQhsa7NaJG5v9+MKUhNRbfMyzRxQRI=;
        b=kOjL1UgRRxZrgCAJM29QF1gHV4BVfx0T7ZxnfQAHqucOqfkahEq2KYKyFhtZj1MqJR
         1Q2JGsWpPIx4fS/1lmpWlm7/hO5/INSDDmjdydAdyB16HFZx1DqpP8+w5k9CGuhSSu2U
         snEHK9DSoKjPxfohDxQdD4gvK1Zijv/tMRWk/FXDeajxM+xFuKUwhbysIIR+yPWu1UpM
         DuYXve+PSeI1C5rHFMOALB+fenkYVvx9yDufxBx5zGmFkIkrqyyQPnMs3fUN9WtmvBCm
         BdXLql+B0uY1KZGbeGbVXgCBp0RQgcFKmplME7LsnkIVYfXHptH56iOU0Wj41X+evrj6
         4Hqg==
X-Gm-Message-State: AOJu0Yyn0kLnwRpJNc80++i2w4vT8Pl1MY5lfW3rlcGGu9e/KsKg8GfR
	bf9zdGZ9qFvYQboJFyQCOAHCgrPgytnGG7xnQNqLnr8SttkimxLx
X-Gm-Gg: ASbGnctA2BhnoaXyBPtdkO03nGw37z5EZr1E8/984p+7vCrWRBV2M5ONjonmCabyElp
	yz74sJn/UKlLj8fLgycjFbNY3q6Izlh2FsPujLlfi87IcSHdU/ezKFTXNtY0BGg2co7lC5ZM7be
	5ci/UnzGWN/CqiAyOEg5h4YKX5sA4V643K0zSX7K2LQn+4u52RNZbHOfHyduZJPQNQBa+7ybysF
	/BWX0G/YYu72oVCvZVhufLKWyuYyYLM8UzOmDxz82xTS8U=
X-Google-Smtp-Source: AGHT+IFPShXYKS3FU68VClyZdKVDRwjSP72TAjeDhtcDljddsZkZFkRUU/gL0Y8uvpw5yF2HCN93Uw==
X-Received: by 2002:a05:6512:4025:b0:53d:d951:bee3 with SMTP id 2adb3069b0e04-53dd951c138mr1501462e87.11.1732299183102;
        Fri, 22 Nov 2024 10:13:03 -0800 (PST)
Received: from localhost ([88.215.132.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2497cfdsm483118e87.248.2024.11.22.10.13.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 10:13:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Nov 2024 18:13:01 +0000
Message-Id: <D5SWT5JKU6S9.2LH8H7ECRZXXM@gmail.com>
Cc: <git@vger.kernel.org>, "Lessley Dennington"
 <lessleydennington@gmail.com>,
 =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "Elijah Newren" <newren@gmail.com>, "Phillip Wood"
 <phillip.wood123@gmail.com>, "idriss fekir" <mcsm224@gmail.com>, "Joey
 Salazar" <jgsal@protonmail.com>
Subject: Re: [PATCH] git: fix paginate handling for commands with
 DELAY_PAGER_CONFIG
From: "Matthew Bystrin" <dev.mbstr@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>, =?utf-8?q?Martin_=C3=85gren?=
 <martin.agren@gmail.com>
X-Mailer: aerc 0.18.2
References: <20241120101741.8225-1-dev.mbstr@gmail.com>
 <CAN0heSoryo-DO6WXKqqASJ5nDLqb3PNNiZv1TP=Pq11wsiSM6A@mail.gmail.com>
 <xmqqmshrrxpq.fsf@gitster.g>
In-Reply-To: <xmqqmshrrxpq.fsf@gitster.g>

Junio and Martin thanks for your replies!

> Martin =C3=85gren <martin.agren@gmail.com> writes:
>
> > Hi Matthew,
> > ...
> > Actually, no, it's not so much ignoring as *forcing*. Since you force i=
t
> > to 0, doesn't that mean that `--paginate` ends up basically being
> > `--no-pager`? So `git --paginate branch` is now `git --no-pager branch`=
?
> > That doesn't seem right. An optionless `git branch` would have
> > paginated, so adding `--paginate` shouldn't change anything.
> >
> > But even if we force it to -1 instead (for "maybe"), I'm not sure I
> > understand why such an undoing of user intention is wanted. If I run
> > `git --paginate tag -a ...`, maybe that's just self-inflicted harm, but
> > are we certain that for all the `git foo --bar` which won't respect
> > `pager.foo`, that it's also completely crazy to provide `--paginate`?
>
> The whole thing started with
>
>     Calling commands using editor in terminal with `--paginate`
>     option will break things. For example `git --paginate config
>     --edit`.
>
> which many of us may respond with "it hurts? do not do it then", so
> I agree with you that a fallout would be worse than the problem the
> change is trying to "fix".

I see the point and totally agree with it.

The root of the 'problem' is related with editor, not with commands. So may=
be it
is a good way to deal with it in editor code? I've quickly come up with
something like this:

diff --git a/editor.c b/editor.c
index 6b9ce81d5f..04a1f71694 100644
--- a/editor.c
+++ b/editor.c
@@ -13,6 +13,7 @@
 #include "strvec.h"
 #include "run-command.h"
 #include "sigchain.h"
+#include "pager.h"
=20
 #ifndef DEFAULT_EDITOR
 #define DEFAULT_EDITOR "vi"
@@ -60,6 +61,9 @@ const char *git_sequence_editor(void)
 static int launch_specified_editor(const char *editor, const char *path,
 				   struct strbuf *buffer, const char *const *env)
 {
+	if (pager_in_use())
+		wait_for_pager();
+
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");

Brief testing shows what it works, but more complex approach may be needed.=
 What
do you think about that? Should I continue work on that despite the fact it=
 does
not really hurts? If yes, is it better to create new patch or send as an up=
date
of the current?
