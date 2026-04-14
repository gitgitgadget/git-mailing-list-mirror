Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA939FD4
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 20:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776197312; cv=none; b=X8AA8z7WST2ICtp1DUEYx/ojUiNXTDTBNVpzddXgvsjU1oFjY+HpX1ylruWZdRIFpZVdITbpKzHeKxmM/7+kG1ow5HP4JA2BCIKhHD1ZpWg3647SvueAWQdugJJULX2ICCFahoyQGhDRbBfbJwVNMx79BpeBWs8O9ZjTugGzwrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776197312; c=relaxed/simple;
	bh=gV6FPTDxy1GHuKikipMuyb/SYU4bi+Gy97pi00PS62I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgxnHqaPP9SF9NKEg5DEeiTM+BdQ55kqn7CYtbZBC0cJ3/96ypehZUIIKcPpbcZn1OXx6H3w3NVPfelXxwZDS0UD6kfH8mdqrDLYS4Vco+dlx8VfSgQsgvtro+azeBKpjLinuwTKJrP6o2R8MpUIFkkagORpdGaHvKxowFZx0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioshWZqT; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioshWZqT"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-38e97e73234so5124311fa.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 13:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776197309; x=1776802109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hPc3hdjRggPkD0mwtnVjSJ0rmZi8t/FJzJF01/QGDcg=;
        b=ioshWZqTQH4tLb/a+m6Ohlfez+NaK34a9JyLA6CQjSgNsbWW0aKpU/EfWDDnLhVTvZ
         YErvzw4AeIvNWyOOelOHDdwAlEU4fIgnXrbfeonoBzy68DYUKsDov2dj9tWG/lnE9PNp
         /V/EWowt9o/7O1v/N8aUp15nSUzyg3Dk+f/Nkn4DKrXI2JgqtKgGs6N65COgfSqln8qR
         I6iPoC3WEBHFxO+3ZJrJ7byNlqC714fyH88/gg+04ZgQg1299PhA+LDwEiiJ4Yg9IcEQ
         CIxxkLpCf2pSHrwyIP9MFJX6hZ9FQ8hD2et8ntl+SDOPEC2SuGmMr5yJGCNmj7RZ5FC7
         I4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776197309; x=1776802109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hPc3hdjRggPkD0mwtnVjSJ0rmZi8t/FJzJF01/QGDcg=;
        b=SG6V7AXyoIBYf8rrrfqIUvcoWemlgQluR19XYitnHUWFRKhsAHaRG0NWTK8bHaLx9s
         3FJiN5AC65KK6jZV3bullZHEP9/kw27Zm/++KXbjsx9ZKyru6TPrv0Q+grnXe/KAwfkC
         9dGDuWuw/JemEmKE6mOz77jD/3paKvXI6hwnZOFIZIEiujuaQpxmXxEumI6nHWXdP4LU
         vLd78x987xcyVf1KOP4KgRaBYG4+m0H2EybB7oysw4TF/+XG2rdXc87sB7OsiOLYP7qB
         AEJs/Lq3sB22acWEysXP0anCnc4snf+cscD/aSrNd1tHLc6dwukC6BGcZxwQCYIoKQS4
         qKEg==
X-Forwarded-Encrypted: i=1; AFNElJ8Qm1M5D3jxkQvte0CEe9tZbAwQ5smFCeAqzSd7sX4R68J+BS4dnadgO6YPMXrK7P5CQwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyySQuwXUCxTGy4yUezWjBARlJAbVOHweIv2rUgNU/TTv787kG4
	XsQAveSiUIFdWRh+FLCKQw6q+d8djRVYxzP53p5tY43BzNdrUHr/jp0N
X-Gm-Gg: AeBDievuwaRpxArguUH87zhs740kG5teErEZ/kVzgON6OFiQW7Nsk3pIKlFv5AbpiYj
	RM2T+B0T5U3UCmucR8yidiUQqoaHxuXk+XbVW4+jeCax1l58fH0DpcQUZmpDZPPnsys6aUl3JkJ
	RhNArKRzjahNQlJy31tO5fFzauN3dbtGbMJSawD2PooIIHorqC9UHNnXQvi3lgBmtZly4Ik6Nxk
	2tCMEf6mmyV2T//tiFtL8Qbo2ewZSR17suQH1dFJW00d2atMkaieU130ZGpB7dcUVbOt5M4cxgv
	2dTPQlmeg4WQwnf10lIlTGARFiUpOF92mM2gK3Oklq+G+iyCjZSxOws5YjCMSFc9zc2sgB7EuhN
	6msUhYOWTY2Kd1NNPvBNYIBOdWj4nWaWl0lFerQKvzOrxbnfeeqjCp/j+t/aivytRk0jRMYBq8W
	Wv+VY756BG+iLQcUC6b4bF81Z6Ga4F7IvRlCXgvuwaUquYTreW2KgAM6/KNJvc4aEAwgQqtOWZ7
	QmEQv1QpWzDJ0c/YBbYzcCeIX0=
X-Received: by 2002:a05:651c:502:b0:38e:76c2:dc8f with SMTP id 38308e7fff4ca-38e76c2e786mr33650951fa.25.1776197308568;
        Tue, 14 Apr 2026 13:08:28 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38e4926eb14sm35134031fa.2.2026.04.14.13.08.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 13:08:27 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: phillip.wood123@gmail.com
Cc: chris.torek@gmail.com,
	git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
Date: Tue, 14 Apr 2026 22:08:27 +0200
Message-ID: <20260414200827.51072-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.rc1.77.g97a5d87c81
In-Reply-To: <d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com>
References: <d5a47638-545b-44b3-9da5-803c06b3f98a@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > +test_expect_success 'apply with custom conflict labels' '
> > +	git init conflict_labels &&
> > +	(
> 
> I'm still unclear why we're creating a new repository here. Our test 
> suite is slow enough already without each test spending time creating 
> its own repository. There doesn't seem to be anything here that requires 
> isolating the test in this way.

Yes, I want this too, but I had some problems to get it to work. Found a
way now I think, but the cleanup is not 100% trivial (this is the only
reason to run anything inside a new repo).

Harald
