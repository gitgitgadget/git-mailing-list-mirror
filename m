Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786F13A1E9C
	for <git@vger.kernel.org>; Thu,  1 Jan 2026 23:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767310725; cv=none; b=Se2rda6prSkrA5pJexxYvV+akMxUOTL0uMrlsMiOh2bE/JbmcAqzEjJaeU2KR3OMQj3W3FXNC0yfj+stYAWNHyeSuFb8SWSpx4i+ZPrOIz3YwOFJE6ZGHveTAx8+ZVPUs7b2BxJAECb+z/GnLGO1KkV/2wn19lWVS53I332cUMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767310725; c=relaxed/simple;
	bh=M4vUHSLaRyUDcUWBYhAD7AwttnqdptpuRzs18S1HT3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peaxoLoCSgrtF8Vttj8MEd7UlV5bZWSYCRrI+m1M3lIVw0OkXYf9FLjcS74hCTcwMepF4S8tGQPVxFNcBgjSIw04F5bd+Y1xot2qVFk7AZUOTBwRDUjHSyDoKXT6+694PNAXHOQf+VQ1TfEZFQj0eCExuxF1oINKI8qgjQaH1Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpd9A/s8; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpd9A/s8"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59583505988so17870065e87.1
        for <git@vger.kernel.org>; Thu, 01 Jan 2026 15:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767310721; x=1767915521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sgDFLAkxvbKpsYc0gAUUEpLzoQ9vBqrGM5XW760qXg=;
        b=cpd9A/s8genzWZWAhsLFLrntoE9MdTTTCvKebHwDGIld06Pg+g/Kn/hxCnqaMo3EaT
         fqCS2MLahyO1Ti2evjtedc3q4eCzO1Q01fxvvSIvm8s+UHo0p/Egg/8ddyEzCzLf0xmx
         wbxRo+fo05mWgQ1uhUhHN+Fu3l7wx55G2SyzyDn1lBYlXmTjf9q6QIdRl2kv2tGK0HxB
         4yLr6+XBhaeUj3m2D8fhSQyLI5P5/4nML0All/xkCfF5ETbBrxAo0XNROtzqa2b5WNf1
         n1qqnqPE24Mr6DqjbisDyiKIZD55AUr0LYkVAKDfR276ktTSxSzJHTEbF5Lpr5lUJa0I
         aVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767310721; x=1767915521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8sgDFLAkxvbKpsYc0gAUUEpLzoQ9vBqrGM5XW760qXg=;
        b=DNlUkDHoYlRmSRNWsWiLBK1m80be0KU72zymzgemeyI1ReDqCb3pokkIddr9HwbqsU
         mruh4p1mgXYqJ4WWYznRqWRM0YyqLf66u0dTZsIUPLsWZoi0zSO9XFGEQhflZl53qLYf
         RsnrAle0VXan1ZTgJlxq3hUdkUns7lBl2Bo0ZVcKR6WB4iJlpRKvwB05Fgd8g5+wiTe3
         dj9UJpfn+9FO9UgHNGX9cFA977pJvlXpnCR70wIcGPbnXFBNUoUjXIwMjT0bi7BKYNNg
         QWm6zycKfoAq0Cvlx/8lpipF9ZN5g7BKFd0ILQcErCPZ35guZBEyjsAciOj+l6UTdXBK
         e3Ew==
X-Gm-Message-State: AOJu0YwKMmPbGSKXJO21CJsQWbV/PJ3WvrogHuUBSwjWA4tYXK4MFcNb
	atVl82N4TSE8YorCY7dkiq3AuzCcmhk/U7D/n0L89/24WVjLyWR5xfdI
X-Gm-Gg: AY/fxX4sAcplrGBz1S9YxhgrSgG6Pmcrn8kcTYSalK6oefxEyfeUtoYsSye0JhH3wVC
	oTsHQU7xDBvSvxVEQpPNPC4pIoWUeE4vuqYPdLSbgNd9AQIiXKnqm5M2WHQSCr50OW3eF7Aec6D
	YxctEMRvQbvWvjpjDNZeGx8NczN4a2YvXdKRxx5+ymvs51eGELeLtgkCGI8pH9lNTnzk4600Ei2
	agJ4uoSCOYKooQXOKoepYJ2LS+8HtvICa558roDAzj95wpNGqD6oG1C2n/5FsWlnq/A3Q90tF0G
	NW2twtPopzmZtqH9DTt4/Spc7IwQnAdERRBVWTyWzFPaBVuHzViUXZN0oFxs/ZWopVx2HSSmGmM
	KZBOthy0hcJGpZBpaoxQckAmzvLeiK1K01iTW/d0PzQJq2DNgkBGeqYaFpYt6Giq4gCBvu1Z9DW
	MG+DFXkiypvNJlK6wUWbOF3j6izxtwsXWWpOIBPcixWuiedy/VhIQFO2hhGV4JE3p2IwRA8bssH
	va/OsA=
X-Google-Smtp-Source: AGHT+IE0nJ0N0Pm4C2XFLdz0MpPPkFeVGVdZF9/4A8asgPOcvSHK5h72nVfNo+qw9UXdUXEEHlyt5w==
X-Received: by 2002:a05:6512:3e1d:b0:597:d764:206 with SMTP id 2adb3069b0e04-59a17d66f88mr13709328e87.20.1767310721284;
        Thu, 01 Jan 2026 15:38:41 -0800 (PST)
Received: from localhost.localdomain (h-85-24-230-171.A753.priv.bahnhof.se. [85.24.230.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a18618cf9sm12086977e87.57.2026.01.01.15.38.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 01 Jan 2026 15:38:40 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com
Subject: Another look?
Date: Fri,  2 Jan 2026 00:38:39 +0100
Message-Id: <20260101233839.17639-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <xmqqh5t5c4lj.fsf@gitster.g>
References: <xmqqh5t5c4lj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Again this seems to do a "step 1 goes in a direction, step 2 fixes
> its mistake, step 3 changes course" drunken-man's walk.
>
> The same advice to restructure them into a logical incremental
> progression that moves the codebase in one consistent direction to
> eventually reach the goal at the end applies.

Isn't programming always bit of drunken-man's walk?

I'm very hesitant to restructure my history before I am confident I will
not need any of the old work later -- I would hate to lose history if I
make a mistake.

One option is to keep my code backed up on a separate branch locally, but
this gets problematic as I add more work (endless cherry-picking and
squashing) between local branches before submitting new patches. So now you
know some of my reasoning. I'm not saying I'm right, but it's a bit
fear-based.

With that said, my idea has always been to squash everything into a single
commit before merging this. The whole diff is not that big. I can split it
into code in one commit and tests in another.

As a side-note: In my day job we only allow "squash and merge" on our
GitHub. This gives devs the flexibility to treat their branches as a WIP
area before merging, but still gives a pristine git history after merge.
This feels to me like a good trade-offs. But again, happy to take
instructions on how to do better.

> I see you are now using pushremote_for_branch() that is already used
> by branch_get_push().  If that gives us "the other thing" that we
> would want to compare, instead of adding yet another configuration
> variable users need to be aware of, that is really good.

Thanks for the encouragement! I put a lot of work into the tests as well,
I hope they tell the story of what this code achieves now.


Harald
