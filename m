Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EQP8bt5L"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028FD198
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 10:26:22 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5cfd2325a06so22156157b3.1
        for <git@vger.kernel.org>; Mon, 27 Nov 2023 10:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701109581; x=1701714381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMoo+pOzLBszy01/uJzh8B4IAfIAzHxaB+ZpFSs+v2M=;
        b=EQP8bt5LzX6CZJtC15JtkxEUyxbjGaCn2f/lhPC0WpzQC8WJz3CZDQX/Qkuv5jXw4I
         2+S+ObCJ6EBa7JJRw1SGLNPxdFbnylqlfDSgJZcer4jCLyAqZyqiRTSOujlMYr+PDJLH
         IijyIUg4XNtjSN6WYuL2QjFozxbKcOoi6r5UgYKh38vWCqLqim/idgwtVpjTxNBxMuhD
         3FtD296cFmHYaKJwMV0/08XKBduJ2q89zYqGZ9D0fwskWj/hTZDlr2sCNT8UY7czq05b
         AXupXAGkvGkCPqw/P34yMytPKb+0uZHdbYQZzScbaGOziL9BBEJtIhxW5ss/gG6QohpV
         xamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109581; x=1701714381;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMoo+pOzLBszy01/uJzh8B4IAfIAzHxaB+ZpFSs+v2M=;
        b=mL/uwTIBCtSpka8VNnethkeN8WOZNPEr8aAuV5yzeuK6IvQmYECjXBVRUUYbcOdcex
         DUGh+ub5iWkLMJky0VlgwGiYRBX08U95f1RpKof+EPqCibCZy2t+flJ7bzE4EmgYSrzp
         ud3QfcDG/xO0BuxdzYwQ7Aegs9DfXvmIolh/hXFeqLmqdvPAOTymWXRSw/yWa/eDuO3S
         eiCXcLz+fNR4iefWPFltAAu9frfi+pUs1spZkdPR08LFz3hcnkBb/lo+zaGso+OcFlq5
         s6C7AD+siHxo1uBinBlTDFVh61E1Ofq4+yBr9qxMHtITufoH6sG1g14wWdUFBIxdlpYR
         8FAQ==
X-Gm-Message-State: AOJu0Yy8kRNMsnTNk74x/qt88tILsGUWRfN/Ia45RJHrU+sDeJGkhepl
	Oqg1cX4ITyQGhaja86CVZ//ogci1sd5qtfYXUdxS
X-Google-Smtp-Source: AGHT+IGbvBcQjdI4Ak8z0ulwqJH77nmsGTgoGio3FIkuduyXLzL9NaqPYKmqRXJXefQf2ytWX6cqj6wIKB74D/Vv3CqO
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:cd35:e99f:a751:de05])
 (user=jonathantanmy job=sendgmr) by 2002:a05:690c:470e:b0:5cb:d80c:3d34 with
 SMTP id gz14-20020a05690c470e00b005cbd80c3d34mr247513ywb.8.1701109581239;
 Mon, 27 Nov 2023 10:26:21 -0800 (PST)
Date: Mon, 27 Nov 2023 10:26:18 -0800
In-Reply-To: <CAGE_+C4B=zjPqNV+fGt9gaA0O8qmqmK3CDh-eLBPmXx+ChzXAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127182618.212901-1-jonathantanmy@google.com>
Subject: Re: [PATCH v2 0/5] Avoid hang if curl needs eof twice + minor related improvements
From: Jonathan Tan <jonathantanmy@google.com>
To: "=?UTF-8?q?Ji=C5=99=C3=AD=20Hru=C5=A1ka?=" <jirka@fud.cz>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, 
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ji=C5=99=C3=AD Hru=C5=A1ka <jirka@fud.cz> writes:
> > I've already reviewed 1/5 so I'll summarize what I think of the rest.
> Thank you for your time looking at everything, Jonathan.
>=20
> I'm sorry for the delay in my reply, I was away for a while and also tryi=
ng
> to get clarity from the cURL side, summarized in [1].
>=20
> [1] https://lore.kernel.org/git/CAGE_+C5u9H8m5faK1vXKk6QTyjcHgKHqxOZy5ptz=
sYbF_0yrCQ@mail.gmail.com/
>=20
> Most importantly, the bug has been apparently in libcurl only for ~1 year=
 and
> it can no longer manifest for a few months. Therefore, the main point of =
my
> changes is a bit moot and we might reconsider what is useful and what is =
not.

Thanks for following up with the Curl side. Even if the Curl bug is
fixed now, for what it's worth, I still think that it's worth including
this mitigation in Git.
