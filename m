Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F814A60C
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763219060; cv=none; b=NM7SwM1M/fnHxtsCck/cYD4rdrAyticQEqLDbuBQTVoUO3QY2QtgamtMnj9HZ8GDWGa4N+z9d30+Xsi9XC4WYIlyDgBoytRgSi0nQFxFRaNG0NFpa0tvdxDq/XOg0IE/rfdA+95PYLwJ6TcPGVy6sWSpBVZlxp4aUZAnXULi+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763219060; c=relaxed/simple;
	bh=TuynT/RUrLuwFnZZFaV6qR7+6X5vGHvxOmVw8+Wqa5s=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Lb1jgEiiJGio3IOTcBnxrH0GcTGUAahkmlttbwEEBwPPoy7bTdSizeApY9sgxW2M+8bLhPEWMl30khNvPSNE+ZVUCy72hqVBJpS9PgTATpUcWozfg2ewsYSPcNgCLpY2226ve9H6KZcUaBlvuboM/MOMGSqScIgzkVQnQkY6cp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itW/Th8w; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itW/Th8w"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47755de027eso21518645e9.0
        for <git@vger.kernel.org>; Sat, 15 Nov 2025 07:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763219057; x=1763823857; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tlaV6ghHYivWDoUsjVaC+iwblBNoHMhpbzo2HmGHX64=;
        b=itW/Th8w6YsNDaSMK1uAroEbIpnMnUPR4bk6ekW3++1EXWuDHIeSF1SLQawiTwwrOT
         TrX2zZCdk5GxkE0WiCTjIlOvyT3LJrWtBJ3wwnGAS35WMHi62X0WRL6eoJMb0Hca+PX5
         sETCGIohASQ/eaMygoL5BHvLbpnYnD8kpOjES8bPA8GsULKKqg5B1Q8P8KUIBwODPGxs
         0WePyDSlUWslNLr0i7SuGZ6dHiXpvI0J/eyYNtgoVz/03Yt24rbPTgrFfxYJ6+U3qae3
         Va26wJ25cEhuV1Mm2RR+zQBu52CoKZQFD+GLP4Ma4WcZ7wwVMDNqo/z3Yu0plFiOKI3Y
         c04A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763219057; x=1763823857;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlaV6ghHYivWDoUsjVaC+iwblBNoHMhpbzo2HmGHX64=;
        b=qo/mZF00SisUDzKtpQ4NUFrBnm+5agbASpoNFnDqTxUotDuzKy/fQL01en+D4JPIiT
         f/c8EqQs1Xmq7r2QXwVD/SQl3Es7f1xOI8JMyaVWf/hCD8hNSEMXZiuyLjUCfVpcIJIh
         JSgneDpzcDCo43j4DQYsomsPN6tW6VqJZoBKltbYw+3EUx0U+HOwge/B8D6DApz+FY7q
         zhczr0rRLsO7yBjPjHZ8wFI12plXaoq4+usTbFSQAUHBNHaKxBc2DgV6YIP5RtIo9lhP
         t/r1mss1leOCZqdmwcvi52dkuhr5hKxmqtxTx8HkLg6UE9tS7cnfEGJOTiR/Vlwz77lH
         l8sQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4u+AfHg+dhhzK9kQA768oKFRC4bRk+4KCVEWavPYyHokDjrNB+vUuIyc0rwZjvW5WaJo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRl/Bjl8CmC4iB47QAowDh9kqT6AHoOIW3LVZvZBRq75E/dWFy
	xkHfCCNvPaTkTSNbcbADI0KNkJuXEMhZav+DUv7oCreMJuDZgBmC2zP6
X-Gm-Gg: ASbGncvIkRM7kAeThFYgBgrLbisAalxQvV8aoDAzXsXvbgqDAsHT9SPZV9yL7ZvvhYZ
	ir2Hy1Wgg/9gbge2hN2sgksNTLEkL2UH2Nuo5pQeiDJvkYVfMBiIOM4s2PG2s3cGCQLG5V0s8Xa
	4F4bD1rrKYkYOtXz9CPS3yNUQplfiZ7onLi91UQyuDVpUFo2fUe3Put021na6Syf2n5Qojz/4x2
	/0JkXN8hYGn6sEJoR9P3GLHuRhvopghYFwqntyDINhZQhuMeun7SJb/yu5DEPdAu8OZfDveDqKu
	2qObuMm1WTP2KuQnfR+tVqUTz//eHIL+MYqZ4J1l9SY8kipnnwT9ebIR2CsPUfG1vK3QbVNF/MB
	kbKWsRb2t27Eq/qF2RyVabTMh/CGNfBlziujPgJwqkSBC6dZeVHHDLi7nMzWesAUTkyjQVJCPJP
	IYq4KJ+nXtBVOxMLIRiqi9YNCOUSHUP/majO3UVQS99fJykuoF7pjM+OYl6WPsa2ADEC7H6gdB1
	A==
X-Google-Smtp-Source: AGHT+IF7IMViQOxbOJarmD0iNhzrnB3hz1NGN0OCy3BqxDa3OvoY25rMLsvT1h3kVDDXHk72FrQ9zQ==
X-Received: by 2002:a5d:64e3:0:b0:42b:3c25:ccea with SMTP id ffacd0b85a97d-42b59394964mr6665992f8f.42.1763219056891;
        Sat, 15 Nov 2025 07:04:16 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:658:8901:ced:8495:73eb:ebd6? ([2a0a:ef40:658:8901:ced:8495:73eb:ebd6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e7b074sm15691466f8f.7.2025.11.15.07.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Nov 2025 07:04:16 -0800 (PST)
Message-ID: <0eee1597-3e83-4a47-90a5-60942da01673@gmail.com>
Date: Sat, 15 Nov 2025 15:04:11 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/2] builtin/repo: fix table alignment for UTF-8
 characters
To: Jiang Xin <worldhello.net@gmail.com>, Junio C Hamano <gitster@pobox.com>,
 Git List <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>
References: <cover.1763098804.git.worldhello.net@gmail.com>
 <cover.1763213290.git.worldhello.net@gmail.com>
 <d0975427c9002ed28e6bbf18403034709f286a2c.1763213290.git.worldhello.net@gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <d0975427c9002ed28e6bbf18403034709f286a2c.1763213290.git.worldhello.net@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiang

On 15/11/2025 13:36, Jiang Xin wrote:
> The output table from "git repo structure" is misaligned when displaying
> UTF-8 characters (e.g., non-ASCII glyphs). E.g.:
> 
>      | 仓库结构   | 值  |
>      | -------------- | ---- |
>      | * 引用       |      |
>      |   * 计数     |   67 |
> 
> The previous implementation used simple width formatting with printf()
> which didn't properly handle multi-byte UTF-8 characters, causing
> misaligned table columns when displaying repository structure
> information.
> 
> This change modifies the stats_table_print_structure function to use
> strbuf_utf8_align() instead of basic printf width specifiers. This
> ensures proper column alignment regardless of the character encoding of
> the content being displayed.

How does it ensure proper column alignment for non-utf8 encodings? I
don't see how it is possible to calculate the display width without
knowing the encoding.
> Also add test cases for strbuf_utf8_align(), a function newly introduced
> in "builtin/repo.c".

Nice.

Using strbuf_utf8_align ends up being quite verbose. An alternative
would be to keep using printf() but calculate the padding ourselves as
shown below. Either way we end up calling utf8_strwidth() twice on the
same string which is a bit of a shame but probably doesn't matter too
much in the grand scheme of things.

Thanks

Phillip

---- 8< ----

  builtin/repo.c | 10 ++++++----
  1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 9d4749f79be..1b139b89672 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -298,8 +298,9 @@ static void stats_table_print_structure(const struct stats_table *table)
  	if (table->value_col_width > value_col_width)
  		value_col_width = table->value_col_width;
  
-	printf("| %-*s | %-*s |\n", name_col_width, name_col_title,
-	       value_col_width, value_col_title);
+	printf("| %s%*s | %s%*s |\n",
+	       name_col_title, name_col_width - utf8_strwidth(name_col_title), "",
+	       value_col_title, value_col_width - utf8_strwidth(value_col_title), "");
  	printf("| ");
  	for (int i = 0; i < name_col_width; i++)
  		putchar('-');
@@ -317,8 +318,9 @@ static void stats_table_print_structure(const struct stats_table *table)
  			value = entry->value;
  		}
  
-		printf("| %-*s | %*s |\n", name_col_width, item->string,
-		       value_col_width, value);
+		printf("| %s%*s | %*s%s |\n",
+		item->string, name_col_width - utf8_strwidth(item->string), "",
+		value_col_width - utf8_strwidth(value), "", value);
  	}
  }
  

