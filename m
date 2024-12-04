Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF9B18B460
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 21:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347286; cv=none; b=TDOR9MFaExY9Em7e3V4/ksP2OLY/33ylK7UjGHZD1A91PTpOmb3D4sMtoCAB9dfvDofUf7sYRNW+3Dm1pMzHWe69SX8TXfo1hM5x9Y+wMP0RXHEc5qNtI3gAPZ7S7IGvtMfljA5iW3QFvP32Kb804ZqSFuXBHMQbMJXDRbi6BCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347286; c=relaxed/simple;
	bh=cx0YnwlmE+tSJBBj65j9fIcWq4Pguwtsjajo7nHuI/k=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t4+aC++3xXN5MQ/sICFG0fdPhVDm5pt/QvcT1ACjtvYkOKhJ5xNvWq7ku8yHsP56P3/ABcUxs7x1acmm2tG86A9gOH6VVYRpDRx9F9ispaOsmq9jzwwAIGs9XNgrg/ddtVkhHnfKyzxYbYh6VGuVQXyK84tnuWpek1np7j4n1/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dl28QAzs; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dl28QAzs"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4af60a0478fso124603137.1
        for <git@vger.kernel.org>; Wed, 04 Dec 2024 13:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733347283; x=1733952083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cx0YnwlmE+tSJBBj65j9fIcWq4Pguwtsjajo7nHuI/k=;
        b=Dl28QAzsYOTYzu0hUUdYHPmbvI7W++t9JfG1u62Uw003hAcTpZepyKuObRufd+cyYG
         br6y7tDd5nuLEKVegp+sGjCsamco8sHEB4za4pMBMZ4KAqnd7ueO3Zq/SqYwiC5cqAii
         yBOP/vxKoF1aJcHM+izIxsFmsoatq//fKwoHFqS3Q5htAX28a8n5Jp+MWd9N4GHyAZvU
         EQ/cjqlb3yAT3V+94RrUyvqjt2LFUJSV4Y+TuX0l6A9V+x0Zhn9N87zSexbyIDvdrmMS
         5W4JZJbVBsLrlc6lw8r0MKF6C4IFemxYWTkkwzJksO+NyqRqfCl7EXjhbn6ThxCGzRA5
         Wgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733347283; x=1733952083;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cx0YnwlmE+tSJBBj65j9fIcWq4Pguwtsjajo7nHuI/k=;
        b=leYg7+xNSXJBZdwsd1qawxlVMmwNKDWwUZ74OU+5uKnCG0JK/4f+UsPVB0tr4AtXDd
         1JMm8QzFUIRwzqLZWT7aHWCzbRSWVIeRCFdy37H2BYiyrymaa5LbfegRih+iSyQmxTxZ
         YM6uvbrru6NNwWOHDzuoOtUA6kBEgiaA8yIxKbSXB5QzT2xK39/qW7UWVwg5jfjaaYn8
         c7GqypZNKtChkRfAqeTg81IS6jt5dPHyFGYLkuvz3Il1RUnYRkkt2TbgjeLXrlrsn6CJ
         QtLNePJ6hfW+h5TQywIts3iD7PoktmK0uDg2UYdaGpXM3Vbggn7be4oIcW9dLFg5IPGD
         xGOw==
X-Forwarded-Encrypted: i=1; AJvYcCWYoP4/Uzb1jmBJEoBSkDD4KqWIgjFBrW0MyURX4fAmLJBAk9JbCV8c+Ar2llro7CAPMpY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwybpF0MCYem8F2ZiYBTDsfJNbFKmj1iCfBD8i5WjL3Kd6GGBEt
	wSXza9m/YKd3y+HFRVtWzt6tM2sEjB8Cohc28+gWu6s7ywCuPF2MfZrkVZEOpk16kJ75KxhXfVi
	HdwhcntlOhrWri5xz0+0EJDPXcoc=
X-Gm-Gg: ASbGncsffewnlsuBZyDlEvu8qx3o8WebiwfJH/aNEv8S/ozASSckc72pKX0k/OtogPG
	6QsZsDB2MTI78Es0JpQY2VOu553zurUmQ7UsLP0UQiYjTaCjfXr5H6MR7fy9/r9wq
X-Google-Smtp-Source: AGHT+IFhTqRj3omI9uOWQEBqIs8KmuGftxSJ8C+FzOpH+hJyg004Qd7sddliKqpc/sGGFu+x9qZVSvvR+JPmXSM1+7A=
X-Received: by 2002:a67:ef8a:0:b0:4af:456e:5427 with SMTP id
 ada2fe7eead31-4afb9534a48mr1320226137.4.1733347283632; Wed, 04 Dec 2024
 13:21:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 4 Dec 2024 16:21:22 -0500
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <6a95708bf972cb22c8abf1da389350fc9f53c4ca.1733181682.git.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
 <pull.1823.v2.git.1733181682.gitgitgadget@gmail.com> <6a95708bf972cb22c8abf1da389350fc9f53c4ca.1733181682.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 4 Dec 2024 16:21:22 -0500
Message-ID: <CAOLa=ZTuAKtYvtWoR0cvaORiXPsjBxq-nhXL8NJZpJSmBtEdpg@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] pack-objects: add GIT_TEST_NAME_HASH_VERSION
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc: gitster@pobox.com, johannes.schindelin@gmx.de, peff@peff.net, ps@pks.im, 
	me@ttaylorr.com, johncai86@gmail.com, newren@gmail.com, 
	jonathantanmy@google.com, Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000001d45c50628785de0"

--0000000000001d45c50628785de0
Content-Type: text/plain; charset="UTF-8"

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <stolee@gmail.com>
>
> Add a new environment variable to opt-in to differen values of the

s/differen/different

> --name-hash-version=<n> option in 'git pack-objects'. This allows for
> extra testing of the feature without repeating all of the test
> scenarios. Unlike many GIT_TEST_* variables, we are choosing to not add
> this to the linux-TEST-vars CI build as that test run is already
> overloaded. The behavior exposed by this test variable is of low risk
> and should be sufficient to allow manual testing when an issue arises.
>
> But this option isn't free. There are a few tests that change behavior
> with the variable enabled.
>
> First, there are a few tests that are very sensitive to certain delta
> bases being picked. These are both involving the generation of thin
> bundles and then counting their objects via 'git index-pack --fix-thin'
> which pulls the delta base into the new packfile. For these tests,
> disable the option as a decent long-term option.
>
> Second, there are two tests in t5616-partial-clone.sh that I believe are
> actually broken scenarios. While the client is set up to clone the
> 'promisor-server' repo via a treeless partial clone filter (tree:0),
> that filter does not translate to the 'server' repo. Thus, fetching from
> these repos causes the server to think that the client has all reachable
> trees and blobs from the commits advertised as 'haves'. This leads the
> server to providing a thin pack assuming those objects as delta bases.
> Changing the name-hash algorithm presents new delta bases and thus
> breaks the expectations of these tests. An alternative could be to set
> up 'server' as a promisor server with the correct filter enabled. This
> may also point out more issues with partial clone being set up as a
> remote-based filtering mechanism and not a repository-wide setting. For
> now, do the minimal change to make the test work by disabling the test
> variable.
>
> Third, there are some tests that compare the exact output of a 'git
> pack-objects' process when using bitmaps. The warning that ignores the
> --name-hash-version=2 and forces version 1 causes these tests to fail.
> Disable the environment variable to get around this issue.
>

The patch itself looked good to me.

[snip]

--0000000000001d45c50628785de0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 1e5f27a8bedc391f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1kUXg5QVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWQwQy80anluVUJvVVRPL2RWMkZWc1d6MTJtNjkvQgpJaTZtQXlKWm1Q
dTM5MGowUzdRTVc1RUFsTjJndTlHSzAxenRvMklKVExvZFJWa3Vjc2RrWVltYjg5UmtMTTZTCkNR
VGR5RWszRkl3cHk5MEhEbU5SdWRhUGxFTFhNdjErK3ZZZk1xOHQ2WFhER2VSay95S3FENklBWlRJ
OWdMWE0KR2dnMFdxaGtBd2FLcjhBSGMreEJHeXYyUXAwZS84YjZvNjBtcTNlT0c5T05kRTNyTUFu
STIwRTJwTVBBSHFrOQpKYlg5TmFmSUx5Mmx6ZTIzMGY5OVF2b2I3djBDY3I3U2RDaEQ1dnRaN1hw
dkRQa3lTakcvdGlJa0dkbDQzWndRCkRUdDVZTXR5MzQ4UXFiKzU3UUtUaVJ2aWJEYjZkd0xiQkVL
dVA1Nmpob0pzTk9LQ0laK21MVFRMc0R3amcxSFUKQ2R0OUloMUc0WW8waHF5TEVJeU43TjFNckFr
SUJBWEg2T2tkZ000ZXhKK05iSEFjemRrYUdCTEdXUHRSeEU3SApZb1J3Ymt1QVROdTAxVlZMbFBD
UVBOa0ZrSnlWQjBzYVZYVEk1ZjhNSkYyc1AwYkZSUTlhVEtFeHBVMkNhNjNCCm1jblRSNWh5MlNr
S1hYRGxINDNMaUtnUTBHTVpMNVg1OEUya3Y5ND0KPTM1L1UKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001d45c50628785de0--
