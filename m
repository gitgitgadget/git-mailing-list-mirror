Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455DC2E5404
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 13:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761225697; cv=none; b=qKwSd1pypyNsseNpW3ERPL9p3584W+L/8FD3JFCV44vU0/UelbX5BGqPglbEEL2sKAR5TLFQ33xFM/i3nQaUhK6ZbmlnWw52b9qQTuaCm+ySuYOkWy94ygYZXnVtWImLh9Nav3Hc68QfEuUvQWXPMREN0y1pkSU15zM8jAPuReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761225697; c=relaxed/simple;
	bh=xeZu5/UDM2Ku6gEdELXWG+Jtw/3cSqCugOwyOQCFdzU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=ib0ro524MSf2knguHT2i+hUn2JF6At3152gROXeVGRfDSOusGdDS4cUhPlX/2M3vwk6vJuOP4UkjKmVv8TpzH2Va8DrBi7fkaSwbMV3GFgU8t/zXBkunGasfC1SDSeJgiIScqrK94KxMnRjFAz1hBmZoIeDPpYr7rpypiJF41UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wf1hXQ7M; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wf1hXQ7M"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so4692335e9.0
        for <git@vger.kernel.org>; Thu, 23 Oct 2025 06:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761225693; x=1761830493; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qvqgBVUQLWm7umHgdPan7kTAw8ki/+H1fnY2zzktQvU=;
        b=Wf1hXQ7MFW/AHB4K+dNtMgV6yROw3WPmZlQ/uPHU/yBiNXg2JgQVbwpoMFxvkZL1zu
         TKIgVxVQOhfyVhpj5tCLsiiTdwkzMwh8bUvQZiBIg3rz7nImUO16Ecn80SaR6uX4SLdo
         QQcf4y86LjE5j7JFyFPsJWSrI09i4jbwouNIY8H6SVHc/z2zUgm7yIrTRE2q2B/nZBms
         mreWKymFBpSwxhvjmgDJ+VBlcLIzG4v8ORqY9ZedqQnkrpLwXq/MLxU+OfF4ITGcqm9a
         qnFLo7hTi3iJLFRrpgd7vBRyGc05Gq6J94Mp2V5dzPrv4ZWMwdiC2TBQyDOMS8XYrm/4
         PEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761225693; x=1761830493;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qvqgBVUQLWm7umHgdPan7kTAw8ki/+H1fnY2zzktQvU=;
        b=qkw3SxrRM/XOhp1hoNS/Ta/SWraIxOya9nWfZoOvWl6wIruxCCyExrCstiJJGsT1Jx
         XqVLz9qX1aVyS7Q41wnUoC+EpvP3tKGbf46GmabCM90/7BpvqGazZoK3CckWp7XDMI0W
         w+jl5KEpDgBcJV0CfXmbBBMwjsG2zdzynKPu7qKwt6/F0wKMp96dS1AmZa8bXgMUi/Dm
         JuNukWUcY4DXMHDzFo4Mtm8MBsmExWBVTbbq/kiZIcIJY8hXfg0VtjVRAvp86qqvxCUq
         aSNgL4nBvtPyZ8paQlte9P1w7D/CZLUarYZazT87+hl8sLKf8lZNNAMJE+G5pEzPGwWS
         D+lw==
X-Forwarded-Encrypted: i=1; AJvYcCWdJuKPzSFchOMeepP0gJvplZYs4zSmPOLqapk7Xx7Zh2bGQbNiVtXZ3F/mDzlC5k1z8JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzczUjOi7b5s6z79vY1SfRep9z3vReHhTohx9BaCQbGkAGSrifb
	OxsHkOF1bRnIq+clyCtDN9L4H6uqqNjqu19CNdTNfAbyBCH8kQU3mAgG
X-Gm-Gg: ASbGncu/LLyWxlcYV599iTAk6gaRdJrfOIy4OYiJPn+pqku0r43qpW011XkeFUBbRdU
	HxvpBnvXnp7I0ybGswpCduh/+wWsMb9UDBKbM3TFI3TmRapTc0xhKjVg2NKpVihPZf4MR1kpoIe
	afZAJnUDKaA+O6a8lJ7mKcrDM3EvZF+U9P9WB64gH/1HUQQcZgiTGGlQzP4TH3Z9A5I3IZ861f5
	Bz3efBtPQgFnQevCXGDHYuzpSfKxdMQr5lkucZkiJTl0DSL3iO/kd1PLdOUvHSbaseCohjhZ0T4
	SDH2GDi5/dMbiT77jfObQVuSD6txptDxda7qI5cWcCf3IOzgfpl1qOj+3Xlb37Jxm+HoF2m6MHx
	BEgUJbUSq9mAkJOh39+rfPqHiuPD/CjujbxVGVrj7hBQ/BrfbcSi4XSRuFCWH7ZqVryNiMDg0yk
	e4I+SQH0YaW1ci/RZVzS08W2maAmVLwXATK3txnmStrkFP7CcB75aWyjCxBtXipXnak8pFx+qFQ
	g==
X-Google-Smtp-Source: AGHT+IEDGHAkgAdH48S43ksT5VXMZnlEUnFjCDkA9Z0epXr4WcLEHTaLM9JZKvHDP2C2VCXEadD1vQ==
X-Received: by 2002:a05:600d:8394:b0:471:1717:421 with SMTP id 5b1f17b1804b1-4711790c587mr120714415e9.19.1761225693327;
        Thu, 23 Oct 2025 06:21:33 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:62a:101:611a:6fa9:aa15:af04? ([2a0a:ef40:62a:101:611a:6fa9:aa15:af04])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b3esm93817725e9.13.2025.10.23.06.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:21:32 -0700 (PDT)
Message-ID: <7d12b046-365f-441c-af8e-8a39d61efbbd@gmail.com>
Date: Thu, 23 Oct 2025 14:21:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 01/29] trailer: append trailers in-process and drop the
 fork to `interpret-trailers`
To: Li Chen <me@linux.beauty>, phillipwood <phillip.wood@dunelm.org.uk>,
 git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
References: <20251022053951.602605-1-me@linux.beauty>
 <20251022053951.602605-2-me@linux.beauty>
Content-Language: en-US
In-Reply-To: <20251022053951.602605-2-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Li

On 22/10/2025 06:39, Li Chen wrote:
> From: Li Chen <chenl311@chinatelecom.cn>
> 
> Route all trailer insertion through trailer_process() and make
> builtin/interpret-trailers just do file I/O before calling into it.
> amend_file_with_trailers() now shares the same code path.
> 
> This removes the fork/exec and tempfile juggling, cutting overhead and
> simplifying error handling. No functional change. It also
> centralizes logic to prepare for follow-up rebase --trailer patch.
> 
> Signed-off-by: Li Chen <chenl311@chinatelecom.cn>

When I review v3 of this series I said

>> As I said above reusing the existing code as you have done here is a
>> much better approach. However it would be much easier to review if
>> the code movement was separated from the refactoring. I'm also
>> struggling to see the benefit of a lot of the refactoring - I was
>> expecting the conversion to use an strubf would essentially look like
>> fwrite() being replaced with strbuf_add() and fprintf() being
>> replaced with strbuf_addf() etc. rather than reworking the logic.

Unfortunately this version has the same code changes as v3 that make it
are virtually impossible to verify if the behavior is changed or not.
The diff below shows what I was hoping to see as the first step. It
refactors interpret_trailers() in place to factor out the code that
processes the trailers into a separate function. That makes it easy to
see that fwrite() is replaced with strbuf_add() etc. and so verify that
the behavior is unchanged. If you view the diff with "--color-moved"
you'll see that virtually all of the code in the new
interpret_trailers() function is moved from the old one which in turn
makes it easy to verify that there is no change in behavior. I would
expect the next patch in the series to move the new function for
processing trailers into trailer.c and the patch after that to refactor
amend_file_with_trailers() to add and use amend_strbuf_with_trailers()
and stop forking "git interpret-trailers". Then builtin/rebase.c can be
modified to add support for trailers using amend_strbuf_with_trailers().

Thanks

Phillip

---- 8< ----
diff --git a/builtin/interpret-trailers.c b/builtin/interpret-trailers.c
index 41b0750e5af..4c90580ffff 100644
--- a/builtin/interpret-trailers.c
+++ b/builtin/interpret-trailers.c
@@ -136,32 +136,21 @@ static void read_input_file(struct strbuf *sb, const char *file)
  	strbuf_complete_line(sb);
  }
  
-static void interpret_trailers(const struct process_trailer_options *opts,
-			       struct list_head *new_trailer_head,
-			       const char *file)
+static void process_trailers(const struct process_trailer_options *opts,
+			     struct list_head *new_trailer_head,
+			     struct strbuf *sb, struct strbuf *out)
  {
  	LIST_HEAD(head);
-	struct strbuf sb = STRBUF_INIT;
-	struct strbuf trailer_block_sb = STRBUF_INIT;
  	struct trailer_block *trailer_block;
-	FILE *outfile = stdout;
-
-	trailer_config_init();
-
-	read_input_file(&sb, file);
-
-	if (opts->in_place)
-		outfile = create_in_place_tempfile(file);
-
-	trailer_block = parse_trailers(opts, sb.buf, &head);
+
+	trailer_block = parse_trailers(opts, sb->buf, &head);
  
  	/* Print the lines before the trailer block */
  	if (!opts->only_trailers)
-		fwrite(sb.buf, 1, trailer_block_start(trailer_block), outfile);
+		strbuf_add(out, sb->buf, trailer_block_start(trailer_block));
  
  	if (!opts->only_trailers && !blank_line_before_trailer_block(trailer_block))
-		fprintf(outfile, "\n");
-
+		strbuf_addch(out, '\n');
  
  	if (!opts->only_input) {
  		LIST_HEAD(config_head);
@@ -173,22 +162,40 @@ static void interpret_trailers(const struct process_trailer_options *opts,
  	}
  
  	/* Print trailer block. */
-	format_trailers(opts, &head, &trailer_block_sb);
+	format_trailers(opts, &head, out);
  	free_trailers(&head);
-	fwrite(trailer_block_sb.buf, 1, trailer_block_sb.len, outfile);
-	strbuf_release(&trailer_block_sb);
  
  	/* Print the lines after the trailer block as is. */
  	if (!opts->only_trailers)
-		fwrite(sb.buf + trailer_block_end(trailer_block), 1,
-		       sb.len - trailer_block_end(trailer_block), outfile);
+		strbuf_add(out, sb->buf + trailer_block_end(trailer_block),
+			   sb->len - trailer_block_end(trailer_block));
  	trailer_block_release(trailer_block);
-
+}
+
+static void interpret_trailers(const struct process_trailer_options *opts,
+			       struct list_head *new_trailer_head,
+			       const char *file)
+{
+	struct strbuf sb = STRBUF_INIT;
+	struct strbuf out = STRBUF_INIT;
+	FILE *outfile = stdout;
+
+	trailer_config_init();
+
+	read_input_file(&sb, file);
+
+	if (opts->in_place)
+		outfile = create_in_place_tempfile(file);
+
+	process_trailers(opts, new_trailer_head, &sb, &out);
+
+	fwrite(out.buf, out.len, 1, outfile);
  	if (opts->in_place)
  		if (rename_tempfile(&trailers_tempfile, file))
  			die_errno(_("could not rename temporary file to %s"), file);
  
  	strbuf_release(&sb);
+	strbuf_release(&out);
  }
  
  int cmd_interpret_trailers(int argc,
