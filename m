Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573B53BF665
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773148116; cv=none; b=ULoOq7oigOjWvLdyykJh4n5YwWoMPgCBZl/i3Bs4OnI5YR1kpmFJN6WYTfbRlYRlAQGP2C0USCV2aAkLe7qytCjwv8N20WzRXQMa/F1w/9G/TKTkp+T3C2ZoAZM2f+kmqo7eQ8Q0BFshm2em0sSWvfwRehiBjLx4d5Z/c7YSYWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773148116; c=relaxed/simple;
	bh=8+yKnUOlNuP4eeQCTb8fVYEIi2oYRZYtBnmj4yZqIaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gb5V3TbXdTp1tDF2RTmw3lf6GZPjUnAbslmNMTAj6aNSENfDVNCNEHZpwn8xHgLYd4YxwP6+Vkr7oeflRn2NErXvNcm0IpdSYkL1DRX3i/xoR32/MWycpryZga7R7af6TVej1sDFxdV6ohYcaq+Jv5KwFUgvip3LJgvG8l8ZZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmK4NHlo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmK4NHlo"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7384f5a9cdso2503406a12.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773148115; x=1773752915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUfpw6AdHZ0TAeIx6Y7WNJoC2hIu31oUZvTv36BhpCY=;
        b=YmK4NHloarqGBAjdJ+dhGZj/vpv9cPcHQttKxXcC6zhWn+LyESMs4noJODHM9AfEc1
         E1DZghtbtviHQMen6RIXFy/uGlW1g2RhCfyDkCTblNdnL90AkL4FZiMGoxGrqKNkH9cn
         xoQDevR/+YrzZGh6NDV+W4oMvGYb637SvxAbckUzuppVBg6iGgwFXKCRMhbIBUZR3xc8
         G5VXtXAya5pntFGnkdRoLtiGRzki2Nvw0Z0aIZyGIi0fxqHo0+GtbE8+gnAKMbS/6P3F
         XeH8F0zsM+1KJzR7zBrMJRg46WtYgX/bKNYgXrFzCE9s6IMRlh/20cb3tW3iA3KNn3I8
         PFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773148115; x=1773752915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUfpw6AdHZ0TAeIx6Y7WNJoC2hIu31oUZvTv36BhpCY=;
        b=wEodIPZ9pfJ+jRvYsMIL0u3cFz8r81yB2CdmOvuBM6skrv+YJpWD/ia3KWWzl+MP7Y
         Va/3rDOM5r9l6lDQi2dwQA09CmJ+HGgqPqxgS5A5jkTRJ/BkGxkTOqFeuoT/PDyUN4gP
         2jOo3RAHhgX8yMACC8PFswNo0cR5rgSSMueLe7qPXXG7AhU17Eb2pcsjvkWDh7EwxXnk
         Lu/6rnMrW/QbWulL20hFi266L4dxiFjFHe0pcfKkXkx8BTE+URYq1EoZelsr8LEJYeHq
         73jZq/gHTIydQT9xWL1Y9EuyUmmVCWcelq4PqP8LWp+WrgDp24kyzDb7ARwKDJ+v3wc8
         UHGQ==
X-Gm-Message-State: AOJu0Yy5xJHNSTsebSmUgopxalRCRZqaYclnTcMKY29zrPUMlUfCDZKq
	H14XYnXJxSgeI8+WUZ+cs3J8zbQLlgmpQ1mvFFqsTeFA0/G9p9Yne2mt
X-Gm-Gg: ATEYQzw/EHV5cKbaipv5YhfvBJJxwyAHxDk3xu+rkjGZZe2gXxnSQSj2MnZFwyNgvtE
	Bj2CPJyWmiv0mj5v1As5nf9WIWG1VyJSknz6la5jOAc5MUim5JNCwgmo7IaXt8dRcR01V38b7yM
	dIlBoRD1UKZmt8ZlXEez8UfbV7kqUAafVafBwTbwqbtJSVFtJnEh7Ur2NARswIGtxSu3/STrxW6
	H5r/Zj4Xnz8NusQmnVfR+ZcANszSqYTtSyqq7MshgM+SFiEhjjcebdBVnh4j/Y1VXB3eOjT1B9U
	0LjzHGLKyeBWcLCz9128RCpmo0AmwbHfRVHdlZkiEsGBWZEyKgdA1+PQjvPDMZMw5bTEYNIdEW0
	uukmeEG9A8iBHhkpN6NPDKpsKFRTcmtUhuBIh5qPYsxzFp6OldcIiQPFy3+kdqCNOXdIlsqhHNg
	P8op0brdwyfge+MC/Phmio8wKl2wLBxEaBVaWdglIhcdzeOUIP4dkCm7MUzpMeR083FFOgSyW8v
	NC0bBxgblCQEqEaORV9NAcHCiLjM1ch
X-Received: by 2002:a17:902:e552:b0:2a0:fe9f:1884 with SMTP id d9443c01a7336-2ae8249e5ecmr139155175ad.55.1773148114627;
        Tue, 10 Mar 2026 06:08:34 -0700 (PDT)
Received: from jayatheerth ([2405:201:c005:b959:7d42:d207:de10:1218])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83e9dbfdsm154051775ad.34.2026.03.10.06.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 06:08:34 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	mansimaanu8627@gmail.com
Subject: Re: [PATCH 0/2] repo: remove redundant variable shadow in stats_table_print_structure
Date: Tue, 10 Mar 2026 18:38:19 +0530
Message-ID: <20260310130819.41516-1-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <4adf6d4dca90e2c7f780d594a533c21247c459b8.1773109018.git.gitgitgadget@gmail.com>
References: <4adf6d4dca90e2c7f780d594a533c21247c459b8.1773109018.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


> Remove the inner redeclaration since the outer 'entry' is already
> available and non-NULL at that point.
>
> Signed-off-by: Mansi Singh <mansimaanu8627@gmail.com>
> ---
>  builtin/repo.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 0ea045abc1..5540bd25d2 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -412,7 +412,6 @@ static void stats_table_print_structure(const struct stats_table *table)
>  		const char *unit = "";
>
>  		if (entry) {
> -			struct stats_table_entry *entry = item->util;
>  			value = entry->value;
>  			if (entry->unit)
>  				unit = entry->unit;
> --
> gitgitgadget

Hi Mansi,

This is a good catch
but I have to say this patch is already sent by me
And is also merged into the master branch [1].

You can search in the mailing list or sometimes check the
"What's cooking in git.git" (recent one [2]) before making the changes.
You don't need anyone's permission to work on a patch
but it is also important to not step on someone's toes ;)

1 - https://github.com/git/git/commit/676c145afdd88024057296f11fdf2c224001549e
2 - https://lore.kernel.org/git/xmqqh5qozdkq.fsf@gitster.g/T/#u

coming to the double naming problem
That is because one of your patch is using `format-patch` and `send-email` method of sending patches
and the other one is using `gitgitgadget`.

My suggestion would be to stick with one and move forward with that for the entirety.

Regards,
- Jayatheerth
