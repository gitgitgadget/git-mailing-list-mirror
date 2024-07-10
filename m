Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D0A12C491
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 13:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720619194; cv=none; b=rOuxCgJMoH9v8pulB+rvHI2C/i110VU78Gv5UpiuglKFHQGSg6DRu12+Y8nRGooWRGd4gjoFMsTYePPtSroA0cCAKkkutroiaE/7MVH1cRJf4guJWTIof9aG6vkeRZV9QzOKkKbXazUO0S6DCDUEYfrKQAJEDaa9PnOiherEaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720619194; c=relaxed/simple;
	bh=ieTd7qqmOl+kUS3wgzmHa9ouJXYweVzg/X6icUsAS5s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D3Plua7c4Izunqd/oOnJr6HwBeWcXJByu7+O5TSE8N/1qEzbPF9kFL92/ERoeSeXTV++jXS8MYcWMiQfP+x8ocOJAx1Daoz5eMlfK+rVbfbo7ZRnrtqVxH+LEVFHUuZNqV/xPk0GyZhF9eUdpNBFbZwXLa5sl7mT3Zj7k5zY21c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q32G68ez; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q32G68ez"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3678f36f154so3347086f8f.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720619191; x=1721223991; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i8XW3xrW6D0XGm3RoGME7Uh/0YggEAdxPY4c036mPyk=;
        b=Q32G68ezt4qmDv9oNgNJS+8xo200n7F5oWLkm0ORKMN8hlgVfgNDngIOo2n/cfeLxb
         Ub4SehssglYakvNjwt2rrjvUJ2IMe3+gayy3nqBOMDnLNi9EPt2OXKnRAtG40AqT4DO3
         jxugd3FHpJkN21Yh98BIOwF9oMr42155eYeF5ZG2+nevfE0fjEhTMajjx3rZR8Mi59ak
         89Ejsa9Rwt9yaMMdnUwEIqdDKsQs1MwiyAy+csDPOL6bPNATE4MPkD9jV5PP33N6e04P
         osdUX3UI/lc1/N1ZE9kxtNvxwdynpupHaDIf3iTpWTmvmB0vOdlkJzqcPTPaXSXHe3/Y
         RqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720619191; x=1721223991;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8XW3xrW6D0XGm3RoGME7Uh/0YggEAdxPY4c036mPyk=;
        b=a5DJpnuc1YY61OGEfCqxNrUSUSITQ2JiNOGYYIvdiEr/wkqQOzYAbiH1wvD0VaXkuj
         mFhg1UjX+8neyUvpOZ6FCl1n5FFKWCmGOIYnUzO6oznF5Pev+6REVlETnUJQgVvw2GaM
         7+271SbRVKpvTumLLkgDVnPeiih3PVr8o3Dog4p08AbkZyrBR5nRW9XtrFRoiSCSoAA+
         IVqsxLec8vnh5gd+PJjlGkuN+ZC1twoGM+0zAUkupTgogio+0O4uXCnhCrfIl+CsKDxU
         9SxjTtAoxpw2ShPYsJEUxgDA1hSxVrpWf/b1E+/fdyqeoyVQ5p9UmxO94gP6joFAcdSL
         ouAg==
X-Forwarded-Encrypted: i=1; AJvYcCWWZCjj6jh2D1AvOKsgApkw9QeBLVZzLTqM+HEfIcx08WfcTeX8Lf9OvD1CZ5e8DzNJRQeeeY3FnPmbZWmcvAYJFpkd
X-Gm-Message-State: AOJu0Yxzu9zUW0Bl0MeYZY3erm0NLFM6jh97K2I2zjrbugi8jCqcc2fH
	69zhymJGliKZhJDRKbTcBJ2n0hObHLiIeenUheiCG78u2YrPwYIX
X-Google-Smtp-Source: AGHT+IEq3P1iC5jwimEjPdfkEC23W6HBQwSISqYpZiQyjyAWwzH6QjlQ6UECK1sKz8GcKuBqVPT/zQ==
X-Received: by 2002:a05:6000:186:b0:360:744e:4f23 with SMTP id ffacd0b85a97d-367ceadcd97mr3417263f8f.63.1720619191036;
        Wed, 10 Jul 2024 06:46:31 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:600:8501:575d:f6b:be83:bc74? ([2a0a:ef40:600:8501:575d:f6b:be83:bc74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab199sm5355161f8f.106.2024.07.10.06.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 06:46:30 -0700 (PDT)
Message-ID: <d5d27cad-bacb-4a79-bb50-e65d2bb6808b@gmail.com>
Date: Wed, 10 Jul 2024 14:46:30 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC/PATCH] add-patch: handle splitting hunks with
 diff.suppressBlankEmpty
To: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc: Ilya Tumaykin <itumaykin@gmail.com>, git@vger.kernel.org,
 Johannes Schindelin <johannes.schindelin@gmx.de>
References: <9b31e86f-c408-4625-8d13-f48a209b541b@gmail.com>
 <ab974e62-098c-4200-bee3-7de8d9115516@gmail.com> <xmqq4j937pyf.fsf@gitster.g>
 <20240710093610.GA2076910@coredump.intra.peff.net>
Content-Language: en-US
In-Reply-To: <20240710093610.GA2076910@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peff

On 10/07/2024 10:36, Jeff King wrote:
> Subject: add-patch: handle splitting hunks with diff.suppressBlankEmpty

> When "add -p" parses diffs, it looks for context lines starting with a
> single space. But when diff.suppressBlankEmpty is in effect, an empty
> context line will omit the space, giving us a true empty line. This
> confuses the parser, which is unable to split based on such a line.

> It's tempting to say that we should just make sure that we generate a
> diff without that option. But we may parse diffs not only generated by
> Git, but ones that users have manually edited. And POSIX calls the
> decision of whether to print the space here "implementation-defined".

Do we ever parse an edited hunk with this code? I'm not sure there is a
way of splitting a hunk after it has been edited as I don't think we
ever display it again.

> So let's handle both cases: a context line either starts with a space or
> consists of a totally empty line.
> 
> Reported-by: Ilya Tumaykin <itumaykin@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm a little worried that this creates ambiguities, since I don't think
> we are careful about following the hunk header's line counts. Imagine
> you had an input like this:
> 
>    @@ -1,2 +1,2 @@> 
>    -old
>    +new
>     stuff
> 
>    some garbage
> 
> We obviously know that "some garbage" is not a context line and is just
> trailing junk, because it does not begin with "-", "+" or space. But
> what about the blank line in between? It looks like an empty context
> line, but we can only know that it is not by respecting the counts in
> the hunk header.
> 
> I don't think we'd ever generate this ourselves, but could somebody
> manually edit a hunk into this shape? When I tried it in practice, it
> looks like we fail to apply the result even before my patch, though. I'm> not sure why that is. If I put "some garbage" without the blank line, we
> correctly realize it should be discarded. It's possible I'm just holding
> it wrong.

When we recount the hunk after it has been edited we ignore lines that
don't begin with '+', '-', ' ', or '\n' so if you add some garbage at
the end of the hunk the recounted hunk header excludes it when it gets
applied.

I think your patch looks good. I did wonder if we wanted to fix this
by normalizing context lines instead as shown in the diff below. That
might make it less likely to miss adding "|| '\n'" in future code that
is looking for a context line but I don't have a strong preference
either way.

Best Wishes

Phillip

---- >8 ----
diff --git a/add-patch.c b/add-patch.c
index d8ea05ff108..795aa772b7a 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -400,6 +400,12 @@ static void complete_file(char marker, struct hunk *hunk)
  		hunk->splittable_into++;
  }
  
+/* Empty context lines may omit the leading ' ' */
+static int normalize_marker(char marker)
+{
+	return marker == '\n' ? ' ' : marker;
+}
+
  static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
  {
  	struct strvec args = STRVEC_INIT;
@@ -485,6 +491,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
  	while (p != pend) {
  		char *eol = memchr(p, '\n', pend - p);
  		const char *deleted = NULL, *mode_change = NULL;
+		char ch = normalize_marker(*p);
  
  		if (!eol)
  			eol = pend;
@@ -532,7 +539,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
  			 * Start counting into how many hunks this one can be
  			 * split
  			 */
-			marker = *p;
+			marker = ch;
  		} else if (hunk == &file_diff->head &&
  			   starts_with(p, "new file")) {
  			file_diff->added = 1;
@@ -586,10 +593,10 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
  			    (int)(eol - (plain->buf + file_diff->head.start)),
  			    plain->buf + file_diff->head.start);
  
-		if ((marker == '-' || marker == '+') && *p == ' ')
+		if ((marker == '-' || marker == '+') && ch == ' ')
  			hunk->splittable_into++;
-		if (marker && *p != '\\')
-			marker = *p;
+		if (marker && ch != '\\')
+			marker = ch;
  
  		p = eol == pend ? pend : eol + 1;
  		hunk->end = p - plain->buf;
@@ -953,7 +960,7 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
  	context_line_count = 0;
  
  	while (splittable_into > 1) {
-		ch = s->plain.buf[current];
+		ch = normalize_marker(s->plain.buf[current]);
  
  		if (!ch)
  			BUG("buffer overrun while splitting hunks");
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5d78868ac16..385c246baf0 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -1164,4 +1164,31 @@ test_expect_success 'reset -p with unmerged files' '
  	test_must_be_empty staged
  '
  
+test_expect_success 'hunk splitting works with diff.suppressBlankEmpty' '
+	cat >expect <<-\EOF &&
+	diff --git a/file b/file
+	index 777b174..ebc9684 100755
+	--- a/file
+	+++ b/file
+	@@ -2,6 +2,6 @@ p
+	 q
+	 r
+
+	-d
+	-e
+	-f
+	+s
+	+t
+	+u
+	EOF
+
+	test_config diff.suppressBlankEmpty true &&
+	test_write_lines a b c "" d e f >file &&
+	git add file &&
+	test_write_lines p q r "" s t u >file &&
+	test_write_lines s y n q | git add -p &&
+	git diff >actual &&
+	diff_cmp expect actual
+'
+
  test_done
