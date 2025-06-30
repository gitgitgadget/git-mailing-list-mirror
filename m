Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB6B3D69
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293886; cv=none; b=rARVZ6yQ/QQ5i54qJbDXuO5rMlS3EFr5tVlokPFmuchSqp2usYDVWszjRTdTyqOlosI0AfLP/NQhOGZ0epZdTeNNos33Jvm+wesv3c+NVOBsJDuCn2+4XzGZ8lsxmW5MbajOUqQJKpT2vIh3XB+Hfcslh58Xi1qdMgooSeXR28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293886; c=relaxed/simple;
	bh=QHWGez4plvqLdl95YdiUF8EPIc8qUBW+iXiwyT6HVOE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ClPC6RJ7lFJ+ff8AkyLSi5AKX89WDvQwR9X6fgz0liMHMeeolfy/AoKm8H0e//Ni+aPMUPXInTtXRLzrsTtCYZXITjv1GhpzjcnnBGL6ZcdYc4v9jR4zcp1SOEk4x+g7sRr+dvHme5fiFtktxwzy6YRlbSU6U2bH2sf0D4eLCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9AWwEUt; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9AWwEUt"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-234f17910d8so41578475ad.3
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751293884; x=1751898684; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kizB8QJYcYXTZVKAeZFeHM/Dhb98Pdi0DbG9fo4ejm4=;
        b=i9AWwEUt1H4H3js0RMeHSxbEJIcL74hKs1XqLm/JWpL+Um74yx0jdCGXn3LsYO0Imp
         KM9p19zInPz2LugV0XYgdzItFwW+42Twk8Wh+c1vdtl4UXF+cJq1TCgp/dCUPtTmbzgf
         FBid8knAZn5htj4NAYcZc7COnbvkvXmS+XJdiJ1DLr9ABbfQI5scWnTqtmRXNlrGqGR2
         n/YWJ2IZhYjV81F65OA04Ae6H6c1t8xgJrkElxSCkeVMdPOxSyetu8olR6pUL8+ITFCA
         kZrnYv7XQ9JtXuYCqGPAa9iuGbhwUu2T234MujL8QebGI6usYbsoXV2y5cL8QhwLa8Fh
         LLZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751293884; x=1751898684;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kizB8QJYcYXTZVKAeZFeHM/Dhb98Pdi0DbG9fo4ejm4=;
        b=ntb50AIPVpN1PXEUh0upjCscdv4p7vlDmNVoLbBg7b8LTtc8IM/u6NplClW9TjNWBu
         U5ubBDF/ZsyacwHLlPXxm2TI6Ay+XYFWrkYAHOXOZR97jM+SPE9ks77A66frkiGgMi9g
         H3gmWJbpN5bEpnRJUJQ6GwoJtdWKIQ0t+pZj8PqkizR7LivnsN//XaMrHtYnXmqbapzO
         mfr376xcLmEjzt1K9zdbvXdvoJ1es+ZPjQSOiETRNcQnh6XH2A+u5WIf3Zc4aq/OdzeK
         6d03RQ+Ui15M9jBZzVL70b1m1U6UefDQ6rdtIjSHKCyRCpOeOvm7edK9+5HvlYdpoNI1
         XEuA==
X-Gm-Message-State: AOJu0Yw3EK+u3wR1pT5/sUXuNPss03/mul8wORW1nTDPs1llFYoJkGV5
	BZUXbuvC2a1wM3cnvwPQ2KgoW9myA+aZZEfAf9DU9gVLPOCtxfZg+xrs
X-Gm-Gg: ASbGnct+BdmBphKtO3X9E10Nt/9oPqyuG84wDGzJ/hKGn7EvqE3k28nhu3LUD14ehpp
	MvffdzxixBnwtvv0WbaDC3whmtulcsRY8O/ocVBHXGSCHAuGCozuozRdCMi2AyCzi0PQUNhusb/
	QppgTKDYrqiu7HrmKR1rf7+0p5x30ieu4PcsZiFIZXARTM15cvB1UjI0V2HZojnuNojfuUdqrjq
	yEpO3hKZFjCGhEv+BZc0T6PdHWZBOJ6g7pQC9pS1dr/Hw90bd+5Wcrzj/Mm50KoA3I6PCzgrgXz
	h+ORGL6yTUPtdprGSE5f2Gu6bMIAL5UCTv5OzjUqCPFBgpQsHS2wbLRUrP0lzDWsuMrUoqI10t5
	GTm6oBpKDB5Xk1nxvNOl2JgfatBk=
X-Google-Smtp-Source: AGHT+IFWbVayL2dVhrEEMreULmsCf2ylP8hEbj2K+aTCHaXqrdEzZQBARTnikrCmtL6IPVcMdehOUw==
X-Received: by 2002:a17:902:f78e:b0:235:f4f7:a64c with SMTP id d9443c01a7336-23ac45d58e3mr225135565ad.12.1751293884311;
        Mon, 30 Jun 2025 07:31:24 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23acb3b7d97sm83823695ad.172.2025.06.30.07.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 07:31:23 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org,  Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-pack: clean up extra_have oid array
In-Reply-To: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
	(Jacob Keller's message of "Fri, 27 Jun 2025 15:09:04 -0700")
References: <20250627-jk-fix-leak-send-pack-v1-1-aadcf0ed8a4b@gmail.com>
Date: Mon, 30 Jun 2025 07:31:23 -0700
Message-ID: <xmqqfrfh5mis.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.e.keller@intel.com> writes:

> From: Jacob Keller <jacob.keller@gmail.com>
>
> Commit c8009635785e ("fetch-pack, send-pack: clean up shallow oid
> array", 2024-09-25) cleaned up the shallow oid array in cmd_send_pack,
> but didn't clean up extra_have, which is still leaked at program exit.
> I suspect the particular tests in t5539 don't trigger any additions to
> the extra_have array, which explains why the tests can pass leak free
> despite this gap.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I didn't check to see why the t5539 tests don't leak. This leak occured for
> me in a day-to-day run with my local git build that happened to still have
> sanitizers enabled:

The other side may tell you about objects you _cannot_ fetch from
them, but if you have them, these objects can participate in the
common ancestor discovery and reduce the size of the transfer.

If the repository A you are pushing into use an alternate object
store B (i.e., created by "git clone --reference B $URL A" to make A
borrow from another local repository B) for example, the refs in
that alternate B that point at objects not in the repository A are
shown as "extra" objects.

Perhaps we can have these tests push into such a repository?

> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index c6e0e9d05186..61486e378cab 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
> @@ -343,6 +343,7 @@ int cmd_send_pack(int argc,
>  	free_refs(remote_refs);
>  	free_refs(local_refs);
>  	refspec_clear(&rs);
> +	oid_array_clear(&extra_have);
>  	oid_array_clear(&shallow);
>  	clear_cas_option(&cas);
>  	return ret;

The change looks obviously correct.

Thanks.
