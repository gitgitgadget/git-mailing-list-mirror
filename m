Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D125C1CF91
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4821BF
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 13:52:31 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-671357f0209so14953446d6.0
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 13:52:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699044747; x=1699649547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZP4uuxubCxA7Z7aw5RA4/Bd/m4nrtBBTBJDfkyjyUHw=;
        b=hxqvxfIyZpZ9qL/Q+tdu8hzarXbiuG+fU53Dma4D6ykMhpevMrtXf5ZZPPxmhFb4hN
         VybxjuMMKzfG5UU/40xeD1dXTBwjpH5LfllfGVSmEemTK236Eq6Grjj4iENAi3lUp9lt
         7sY9c1Ey3n4/vMwJ6wm7AjXpkMyBIcUAfmm2v/goijNKQpSU/F14ePLJ8Gh7Bj2QtXco
         063q4FIPWIP3VBkvg5NtocAFWjt58mAdCrljBFCPLBOt6YnyU5nlXP69Fpq2aKbcNMf2
         FKKTPhKj4dpusDaFvJJNiBlbvtn3GVVQ+Nz1H6JHZ56tuHDJJZg5KtVWzgKi7+4xWhWf
         VPaw==
X-Gm-Message-State: AOJu0YyFqVSqNER2fVLmBcE6lgIcWT+YjFrq/qaBssApVdf1Mg2uyikN
	Cr3McDnVgpwbPvCygmMnGB2fWi7XzUMK5kf8qDRz657BBEQ=
X-Google-Smtp-Source: AGHT+IHKBcySEIkrupupd5u9pP/3nA4zZEm2s2Nd/1TsuAShbCD8n9azFfHSG9mypKXga+mBLGI4bDzrvG9FHLsEek0=
X-Received: by 2002:ad4:4ea7:0:b0:649:384f:ed4 with SMTP id
 ed7-20020ad44ea7000000b00649384f0ed4mr29043575qvb.19.1699044746726; Fri, 03
 Nov 2023 13:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
In-Reply-To: <00a101da0e88$778cd3b0$66a67b10$@nexbridge.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 3 Nov 2023 16:52:15 -0400
Message-ID: <CAPig+cTzWCpmksJm-0M1MfUSeYpWbgMaFNHRSOtAhCsNQigV-g@mail.gmail.com>
Subject: Re: Request for Help - Too many perl arguments as of 2.43.0-rc0
To: rsbecker@nexbridge.com
Cc: Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 3:03=E2=80=AFPM <rsbecker@nexbridge.com> wrote:
> I can no longer test git as the number of arguments (and size) sent to pe=
rl
> from the make infrastructure is too big for my platform. Is it possible t=
o
> use xargs instead?

Presumably you're talking about the invocation of chainlint.pl?
Considering that that's quite an unimportant part of `make test` for
those just running the test suite (as opposed to those authoring new
tests), the simplest workaround is to disable chainlint when you run
the tests by setting environment variable GIT_TEST_EXT_CHAIN_LINT to
0.
