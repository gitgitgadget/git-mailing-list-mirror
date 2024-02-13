Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06FA62800
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 23:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867404; cv=none; b=n81xj8ZTvZTZCQ+646oA1IMiHXawCENQJFXbSiQEs2ttAbifSStKQFYzr+hAk9JP7aYffOvmXLTLptp5mkY8+tj10QJcVSbdmjS727++9ktFmTShoXP6PSV7TZm72pzwWCA63UXnDWHYb+FEviKEwLuJunDCrv2XQtHhvzJu4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867404; c=relaxed/simple;
	bh=UKYJO2u+FlOwf4vcqPKPXqrkxQsCt9v2W3XrgQU12hg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lfklPxv8+IH+U4XuM6m+PMoPX8/LyRt97J1m2FuOXWZiYCUyC6BIhHLoqUa2elFtmde4JBrBIa2v7aXztQah2sSdC8TkoBseh4Aetlo00hvqSEldLy9vV3JVl7/HygsuE3OUj/7g+b0cE9RmcjvLuj8RoXPq8tkImohAf4Bg9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXcVuG/m; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXcVuG/m"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33adec41b55so797881f8f.0
        for <git@vger.kernel.org>; Tue, 13 Feb 2024 15:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707867401; x=1708472201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+5cLSoRvUNWCRwB2JVPUvC6Dnnw/xZntivmyrv2XZ2c=;
        b=AXcVuG/mI60KUt1jnlaCsFAKO3SaGR4ND8GiGIaf9/zRnphx9BxLPjQJ/RDvp+nTGl
         ygCXHTkCDsK+yzUbq9AXV9C/Yy8zFHw5JlcDQAalvocON3N7NQvSu3bhZC5ObQ7FhczQ
         k1w2JpQfID9tLxfRoQ3ZhPOb6NzzneZAbjuESxgd0+CE3XQvl+OeGV4/7Cs/lXHNmynN
         /eWtpZcFyW5bCP//lZiLyywNT5FUzab6zcoliG8FAPTjqSQ8VUq4I74tqP3nv56ZpADz
         nZd4i/aaKB0eDDzaGyKsy7fujRbQcXbVvuj8UEh+jH0Bsg9YEo68k4t7KHVUc45ZDgir
         ufDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867401; x=1708472201;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5cLSoRvUNWCRwB2JVPUvC6Dnnw/xZntivmyrv2XZ2c=;
        b=Z/aO0rII/6pbenJl/Zfzw/fmd+pfLWI8mOpksuBJbDiRzacouf+e3Hy8qJjTgCFmBn
         u/xvwvWWs+mRp0/xBKvsbs2zreJRYICff4Pt8iUXQfFZ7QPXnmwGXuZKmOv0lBhEZVPc
         sVnVKUBHC09Y6Uqpo8toToLiUKN9DfTSStRG32yXj9K4P9985xddYj0nu+Vx2fOoKAM5
         pphSapvzlgh9WG8jgzrot71EpCKPudWyqEDhHwtAeo+TjYbpX7HqJTCUkRMbIUL1TiVB
         pdujMYNVsAHS+C6fa1eJWjf59m9JyfLP8RtW6j7Vz6LpNG89JV3fyn8eR9MVeY9yE42t
         gR1A==
X-Forwarded-Encrypted: i=1; AJvYcCU28TUuVVz7KWonvmcKfJ19qec9gaYXjARwCVYXW3/Dg+z/A+SllWJnlhayBaJfipDgH7LNXliWUmleik1JT/FMiiYY
X-Gm-Message-State: AOJu0YyuIKDI1Se+i1uLyJ6MVbm6xjDfJHhiLYceWI0Odq13K47WEqOI
	c/F5CdfSIyIT2+aoUirXNPzcd8i6Yp3+OtN6PT+gA5TL9Ck7NSFE
X-Google-Smtp-Source: AGHT+IFlRHt+ZODDhqZwLKEHen2Sp8ZrcOuG85/nkhF9WP/t1tSlX5EUAGWoqE1UQBgQqvZDAY9u5A==
X-Received: by 2002:a5d:414d:0:b0:33b:3aac:3e20 with SMTP id c13-20020a5d414d000000b0033b3aac3e20mr536149wrq.18.1707867400940;
        Tue, 13 Feb 2024 15:36:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUI+/1J33k/rdaQdosJyfigbJinFg3z2fZCarfPZG+Uicjyvn38T8pejLZTG2ORKo/6uWckmQE14Qz7dABoRvcG40HB
Received: from gmail.com (15.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.15])
        by smtp.gmail.com with ESMTPSA id az17-20020adfe191000000b0033b87c2725csm5130571wrb.104.2024.02.13.15.36.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 15:36:39 -0800 (PST)
Message-ID: <59df085d-0de8-45b1-9b8b-c69e91e56a1f@gmail.com>
Date: Wed, 14 Feb 2024 00:36:38 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] tag: error when git-column fails
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, git@vger.kernel.org
References: <1c959378cf495d7a3d70d0c7bdf08cc501ed6e5d.1707679627.git.code@khaugsbakk.name>
 <cover.1707839454.git.code@khaugsbakk.name>
 <9355fc98e3dac5768ecaf9e179be2f7a0e74d633.1707839454.git.code@khaugsbakk.name>
 <xmqqcyt08fa1.fsf@gitster.g> <69f60c3a-ff47-4cb9-a229-6c5a36e7d9fa@gmail.com>
 <xmqqle7o5f34.fsf@gitster.g> <8acde766-e2cd-4901-b665-f677cd15295d@gmail.com>
In-Reply-To: <8acde766-e2cd-4901-b665-f677cd15295d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If the user asks for the list of tags to be displayed in columns
("--columns"), a child git-column process is used to format the output
as expected.

In a rare situation where we encounter a problem spawning that child
process, we will work erroneously.

Make noticeable we're having a problem executing git-column, so the user
can act accordingly.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/tag.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/tag.c b/builtin/tag.c
index 37473ac21f..19a7e06bf4 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -530,7 +530,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			struct column_options copts;
 			memset(&copts, 0, sizeof(copts));
 			copts.padding = 2;
-			run_column_filter(colopts, &copts);
+			if (run_column_filter(colopts, &copts))
+				die(_("could not start 'git column'"));
 		}
 		filter.name_patterns = argv;
 		ret = list_tags(&filter, sorting, &format);
-- 
2.43.0
