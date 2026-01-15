Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4A412B94
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515438; cv=none; b=kC6dctbIhzKJjVesW1UFLxN3UqLDRNTOfqFdK/zH6nPr62NwYgIwDnX+H9KnUaBaXVD3Z0a9dxv4bFscLK96a8ZVEQJt/PqIsAVRjospG9y8xx1cyPha/R2Wmfv853oUoDY+Sg1FaiWIXWzZ6tK5QAeQPDFAMaqNPNKn+IBwUbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515438; c=relaxed/simple;
	bh=pXYn55cseNM6xhsX/hcJL64QQsxmT3k5aAuMCwVeHLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpOnlMDpLo0GLCuTyAm5GFbnC9NtCZ/7p0dA6s3+bPZYLKy2KAP50jvlA4tXVJjxndYMiiu0lECFnYuPWsWDlULANdUYM/uZ2NB7vqb7Ug+KMPR20Oexi00wNQs/SPXoLODnHYstD3QKte8ZtWiVSj32z3tJAATwOH/CHVW/0Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eL6mPGVA; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eL6mPGVA"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1232d9f25e9so2593326c88.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768515436; x=1769120236; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX/NZ8RKcQ/6NticMOiAl/WfBQQyKuVANR+hurxh+O4=;
        b=eL6mPGVARh1fBPNWAO8wkFRJSYT4Grpxhr1V7w9+mx2N4/H5cTgzjHS7APLUi/w2zW
         ++kQLCXQqWLPyhymjlnIIjSbIP2qKUQJvaB/j4kzRNbD1pn6Bi16MMWiI0Q1K36wxEVA
         O1BVMNV7fzhPHxBLdgg03GKzNbIBR7uWB/kXNVkFcq8Xn83yJnCneY8HT/+2EoBYBRuB
         /q2xGh3njrrb26IJi0S9sKubAhR/kgo0DYuL3fZCykH+elNQHB5ng3pMUPB1BCMqkGJW
         KQWP7/lCSUalTzSKLgT8NJKZ2xmqn1rvC6qxbn9Os45SjWY7vqE1oUBO93CcOc/7b272
         p3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768515436; x=1769120236;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX/NZ8RKcQ/6NticMOiAl/WfBQQyKuVANR+hurxh+O4=;
        b=ZZgjW6oVuJgY9j9S1uZXd4KXDUhGtJLJ8SEfmys/+r+LB6HYlNwt37T8w1/pB1ChoQ
         J3LV/ll3QoClxeIcnCeh7EGJmJp7PtMyA0J1JfmYVGkPij5XcHTmAxznNICPpAZ0ELqr
         kyrZdHgi0IW+uAeU8Pz1QJqfj+rVDd0Du3zu6tYuvTDp89m1JyufvUVsOjt07LVzcLuw
         m9oKp9k6yTu82tEX/8RgDLgYq7BM7PI+9gJbdJCsyIB78377uZo0Nu2flvHjScVsGtm7
         o6QGO+Y/qQsi2RtLQKxO9uM0dmUv/0cKHF9a2U6XgiokZZLmYDH3T6xIAiiUHd5hvSgN
         7iLw==
X-Gm-Message-State: AOJu0Yw8/3DUF7c3HfIMaz9G38VDCCNJxJ+J3wzWGDf9ic6RSfTdk7Go
	Uf6PcCy9erLF5XgFKzJau8JKiNQXzuZOmvi6hRzT+O98TmDt33B64VpKhnYnRzniis5MAYvROhl
	PYTUvrdZHf8Ar1etrHUK+v2NB2t7OQLDUHA==
X-Gm-Gg: AY/fxX4L0scCdS96iahk2R5JpsHrfeFWj064M174H3jb97p0mF3ncD1Oxzg+ogcDXIu
	iNncs+jRmmpYzzv33MAS8RfY4z3lT96dDgEkpAVa/GbH1A4xSfvQrRVHNd1brKg4UMKgpwZ5S5V
	x0M9LAjuWwZzyc9zsiX2VIZoO7WriFsOzT/O0+hou/UDconCnWcwJT1jz015As3TV/krYjRsSFp
	cHc3SGoBfE9emNiI9kLpqK1FhugLbJrlPqKNqAB+g3mE/5DFlzAZRG4JJ/U2WX+yDUEHtAAgC7k
	USpNIViXrQ==
X-Received: by 2002:a05:7022:4399:b0:11b:b179:6e17 with SMTP id
 a92af1059eb24-1244a78154bmr1400995c88.34.1768515436044; Thu, 15 Jan 2026
 14:17:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768217572.git.belkid98@gmail.com> <cover.1768318762.git.belkid98@gmail.com>
In-Reply-To: <cover.1768318762.git.belkid98@gmail.com>
From: Bello Olamide <belkid98@gmail.com>
Date: Thu, 15 Jan 2026 23:17:17 +0100
X-Gm-Features: AZwV_QgIIU_xEMbouAUybH1xu-jLO54zGKXyAmJ48uvNEnuOYashq2FWyNfHE-4
Message-ID: <CAD=f0L_qrQcp+FbYmSLqwMZt-H99xJGUB=VG_wFvmkHXyPBTAg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v2 0/3] store git_default_config() parsed values
 in new config struct
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com, gitster@pobox.com, christian.couder@gmail.com, 
	usmanakinyemi202@gmail.com, kaartic.sivaraam@gmail.com, me@ttaylorr.com, 
	karthik.188@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 13 Jan 2026 at 18:25, Olamide Caleb Bello <belkid98@gmail.com> wrote:
>
> Hi Git Community,
> Over the course of my ongoing internship, which focused on moving global
> variables in environment.h into local scope, I have attempted to move some
> variables into the struct repo-settings.
> However there have been some design concerns as regards the use of
> `prepare_repo_settings()` with respect to when and where to call the
> function, and also the change in behaviours when the variable is lazily
> loaded as discussed in [1] and [2].
>
> After different deliberations, Phillip Wood proposed creating a new config
> struct [3], adding it to the repository struct and passing the repo struct to
> `git_default_config()` to store the parsed config values per repo.
> This ensures the current behaviours will be retained.
>
> I have experimented with this approach for some values and I would
> appreciate feedbacks about this approach before we can move forward
> and use it for more variables related to `git_default_config()`.
>
> For now, the parsed value is stored in `the_repository` in
> `git_default_*_config()` and further efforts to pass the repository
> parameter to `git_default_config()` as the callback parameter will
> be looked into later on.
> The link to the CI tests can be see in [4]
>
> 1. https://lore.kernel.org/git/43aaec10-2696-44c9-8728-2045b83dc5d3@gmail.com/
> 2. https://lore.kernel.org/git/a881499d-e236-4f8e-a217-b6bce69e3e3c@gmail.com/
> 3. https://lore.kernel.org/git/8899016f-eeef-404b-8da6-ff3a90e81cea@gmail.com/
> 4. https://github.com/git/git/actions/runs/20953059862
>
> Changes in v2:
> ==============
> - Renamed new struct to repo_config_values
> - Moved struct and functions declaration and definition to
>   environment.[ch]
> - embedded the new struct in the repository struct thereby removing the
>   need to allocate memory on the heap
>

Hello,
I would like to know if there are new comments.
I want to send a new patch version.

Thanks
