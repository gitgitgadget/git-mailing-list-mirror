Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2D6168BD
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 20:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729198257; cv=none; b=Cggvfky4Sglx8ameX7pkODeOTAAQ5LET6fWbe/W44kVrlUNBihcGbu+64qdbsEXgm7W38WUzhUjw3AqlegyPJLvLfTSfO1SJPL6FKPdCUiVWCYyi3mklpXtfX5AQ3mz1lw7Fw2KhmUKpWCjeiFu4zXZnyk84AVm6c7C0WyWxFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729198257; c=relaxed/simple;
	bh=44BJse/625C2f0QPl9OtL4dBQLxWV9Hm3BGBe4E4E4E=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Clz7Nf/mkFEZgnP0t3QJbNVi7nrWrN8bicPcSTjXGCWQFsqOXHn+UvMATuIKWWqzTTERNrrJB8sGfjMUo0VvFyIPvGzlcYpvLAJRGQX62C44CL1a+ynVhgesbTo9xDXxdpBELj2HKkWpDXP2cFmNuJmjsII9YN5PmVQnW0/c4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwNIgKaW; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwNIgKaW"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539f72c913aso1790514e87.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729198251; x=1729803051; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CJEC0a7in6ZPEKFGvtfyCVxRh4+6Zvajyj6Tkk5LoYA=;
        b=AwNIgKaWT+aPph+xsEZhBbTxZfJ+koP09jObfUFJCZd3m4Xone8a7zYg7OTRbc5Ttr
         BNaH05mgx0hfTJeMylvtsoXpmdHN/SMGkpoO8jeL3+uxN1Q5mdUtKSoWRU0TDonz6LMY
         iFPQ3U9MLs2TebABWEdv+XzweYh1rruFpQiBrX3TJCE5TjU6JdLefx1j89aRqODydd6g
         4TKdW+2sVMEUsu6pVDAglUH8abHk/NkRfsLAsKe8oR9vSp9GEgl9o1ZhUVw+0rvEgbhY
         0dVSuBB6YzVP7uOq4i63qoRgMs1A/bvbEfPAgVJqL1ICoRtSGb3PSa5HxdFuVa6M2Wd1
         zh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729198251; x=1729803051;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJEC0a7in6ZPEKFGvtfyCVxRh4+6Zvajyj6Tkk5LoYA=;
        b=HGI7n+yohKxXwL0C3/neHMV646P2KJdupF0oRUooOm6HsgyS68KdBdKQLvzoMaNGBz
         3evB1Aexht0Oh7XIgz7mOVyIbfENXfWzYyAyLO8gnF/+86we6E3iGq6wcTu7tCJ9A8YW
         M4IJVQPL31bUI62ifDgI79th1nXB2p6QjxAvH6jhbLIxPpTl604fgOb7uWUZeVvt6xkm
         eU/frsxV8Uv6XmKB7qbxSfGTNkskKRqJRKXPZVYGlkKbhksdN/kfCP6hnd1B4pMzj9hd
         7ulTaO2k7dTG86n3RyjV6wlY9fgk3R3N5PcFlGxX64pSyC/PHmof9HunviF6fKkUdFRE
         5PHA==
X-Forwarded-Encrypted: i=1; AJvYcCW2QJERpcUnNNYHda3VxMNRsbzfF1V5cE8dhatAOF45dOx7MMbQ0dxU926lYLgkGgMvHIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFDQ8H78qcRNb4hLJInQ9Zd6wtczjWlVYHzDqhtQf5+RWkfWxa
	xrRDj1SabBdLI4dAzuCHSIC5j1F4b0MbclzEkNQHLk2ZZTaHwvCsaQlKWbPgll0=
X-Google-Smtp-Source: AGHT+IH0Oc4G7ZL0AxamsPAl4Ee7StsoDmy4r76mEal+D71xgFclLneyyo4BPbPHN2GW9QgjlTJB4Q==
X-Received: by 2002:a05:6512:31c6:b0:536:53c2:8179 with SMTP id 2adb3069b0e04-53a15449499mr143035e87.37.1729198250238;
        Thu, 17 Oct 2024 13:50:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0e1fsm24274e87.170.2024.10.17.13.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 13:50:49 -0700 (PDT)
From: Sergey Organov <sorganov@gmail.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,  git@vger.kernel.org
Subject: Re: Why is pushing to stash not allowed without an initial commit?
References: <bab5a7a9-f006-4a1f-ae38-2dec817c5a82@gmail.com>
	<ZxFe/cEI0SzFMSi0@nand.local>
Date: Thu, 17 Oct 2024 23:50:49 +0300
In-Reply-To: <ZxFe/cEI0SzFMSi0@nand.local> (Taylor Blau's message of "Thu, 17
	Oct 2024 15:01:17 -0400")
Message-ID: <87msj2a1xy.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Oct 17, 2024 at 08:51:29PM +0530, Abhijeet Sonar wrote:
>> I see that the stash commit has two parents: the initial commit and the
>> commit that actually holds the files that were stashed.
>>
>> If git were to allow a stash entry with no initial commit, it would have to
>> create a stash commit with only one parent (i.e. the commit labeled with
>> 'index on <branch>'). I wonder if there is a reason this would be bad and
>> therefore not allowed?
>
> Right, each stash entry has two parents:
>
>   - The first parent is the state of HEAD in your repository when you
>     created the stash entry,
>
>   - The second parent is the state of the index at the same point
>
> So there would be no reasonable value to substitute in for the first
> parent in the case where your repository does not yet have any
> commits.

I still wonder why Git has no concept of the ultimate null-commit from
which all the Git world descends? Looks like it'd help to have one to
handle such corner cases gracefully. Was it just an oversight of
original design that isn't worth fixing already?

-- 
Sergey
