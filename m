Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725974C98
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 22:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988900; cv=none; b=LdAISVVNc9PH0NLTPKMlczqB55tmux5QyREDcUrZdDUwgYr1RKvdzb1YXS+mbL9taYJQpcVq0ExWp/St9I2bJfkCpybhxSftWA/jRkO0+2jLLhfu9hoNHxycTgQh/VkAUq+VWeyi9Pq/vy2KjZVfNzSM/Rix5p+DZUQvD9ZhRnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988900; c=relaxed/simple;
	bh=gtRQfW68ysV+neB9bke+NOUeqBTva7q8wHWe0qxN9vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeMEWWeKLk7LnQQXb9Vkd3Vr/HuXfbTqm7Ba1q/Xg8znBWyswBE5+Hi0KH7Mh+N33HTft4mxnUwjCA7lzjh1et7U5u/Wo+CCK3MGqrJbHGpUVBxlLFmYxa6a+IPI+dlwASsWJlYc0eTULWlYKO3GdkCu/i5ZwqEQJmJYTB2TmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Tpi9hjwM; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Tpi9hjwM"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e803de44766so4255965276.3
        for <git@vger.kernel.org>; Tue, 03 Jun 2025 15:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1748988898; x=1749593698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lyRWva2jIt9WfJBOCelKZ+OjFPkw7ryIRH9qbmdIjXw=;
        b=Tpi9hjwMlB9/EWnJ11lqd+8kH9lZr6IFVpyxtVF0EnF37LVaK8K3XfuSaF37KXIuJl
         S879UKyf7knyHt79uSgmxTpjXJObcMZZHYVYb/+r950CyzrucXrOyfjCXmV9XhjLjmQc
         ncen+W9FHB0EOTKjfugsFgsTO1frsD9D+IwPHbgcMgDLn8rmUTwgbxsqLCo0kZzB/MAt
         4HO1ahfecC65yZM7rYumVnxopWecF4/+Q9u+D88BuknulkblDarwngQBE3lHUxILpePL
         hFyf3lwZAB8xoZmxmoFX3J9E21rdbVWOc522pajSGhv5fBRaWIqAKBFqr6pjSvLEj0o3
         MYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748988898; x=1749593698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyRWva2jIt9WfJBOCelKZ+OjFPkw7ryIRH9qbmdIjXw=;
        b=gSBBkvBF8UnG5FiYQbt2X1gvTFa1y1LufRdIuJ9RYT/eWFYOU6V7fsv7PolNUdK7nz
         N1VhnQ0oLRbfHrTQwYweiSLfAD8Vj1OzM/ikDQ0IncAPhddPug+rJYWPorQ1zYlAsssF
         MB0HHWxhigM7HQ4YYGZHUB8HHvk21scp6m9H6qHCSy+oBPvrTkxKuKa2ihQ8Eyz1wRjx
         e6ZppfYqytftdvWcWAHKjeYnWAhA17gmrDotBsZrhFXUxmiyjVvtvUPprcwMu2UeUeMz
         NCi1pbzSxyan/DU3RKZecxFpj9zNoVD33WHZ2U28j8vBeyfg46PbAD0kXd9kwvOhxlxP
         jDmw==
X-Gm-Message-State: AOJu0YwevB2pciGn3gfgDcCUPT4hY/Vt8vJJMXstE0aXrIn8mZsrV2h+
	zbrUFNU7FOIDd8XlSjLlcU3gMHtDhmzIeG8yJ0aKrmsJUp0zycz8IE3mXV2l4pdRZCg3ExC7Clt
	zvuqZ
X-Gm-Gg: ASbGncuExX9WefndqeOZMv17i/TgoBgExp2re0wWC7Lz151Ivbb0Sd2xF3QH0Np+HfL
	QbUtSOFZgOZf9Ecf1q7oW/rlbL5qdQoXj2OxfuDHxgJww9FnmKC0hrtj96ThM1pVga3MgQDL1Ew
	bYj7w9OADAz7IciVbsTyuEktauHR15N6kfYMBwJV63PUVvR36P641hGB+fGgFN0P8Xt1fT4sPln
	xCBm8NcaUfLPlqDV93ka+gDuR30VaR7PWtKwTR5GT/fMheiJNLKDQkGZ3bOSvRk+mgkFmb/2jSR
	5mtq+BacG+6wbUwjC10c8NiFpFO4jEkL7vdLFm4zB2YIOvFpmBWA98NiNE4+Ok2b9OqnZEBEWbI
	n0wO9MDi+8k2G3G0GyA8P1Rs=
X-Google-Smtp-Source: AGHT+IHWxjFHLgZr7HbdR4c81xG43pyR2kGlnLMpW2d3mRYSQ3pfPa2oHVrDjhxOCFk5JLT+2XY9Ig==
X-Received: by 2002:a05:6902:1083:b0:e81:7690:247f with SMTP id 3f1490d57ef6-e8179c0e6b8mr885882276.15.1748988898442;
        Tue, 03 Jun 2025 15:14:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e7f733aed2fsm2889361276.12.2025.06.03.15.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 15:14:58 -0700 (PDT)
Date: Tue, 3 Jun 2025 18:14:57 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH v5 0/3] pack-bitmap: fix memory leak if load_bitmap failed
Message-ID: <aD9z4bVNSLi0TuRq@nand.local>
References: <pull.1962.v4.git.git.1748140983.gitgitgadget@gmail.com>
 <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1962.v5.git.git.1748920444.gitgitgadget@gmail.com>

On Tue, Jun 03, 2025 at 03:14:01AM +0000, Lidong Yan via GitGitGadget wrote:
> Lidong Yan (2):
>   pack-bitmap: reword comments in test_bitmap_commits()
>   pack-bitmap: add load corrupt bitmap test
>
> Taylor Blau (1):
>   pack-bitmap: fix memory leak if load_bitmap() failed

This version looks pretty good to me. There's a pair of minor
suggestions that I left on the second patch, but otherwise I think the
result is ready to start merging down.

Thanks,
Taylor
