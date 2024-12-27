Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88861F12F3
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735295925; cv=none; b=AcSa/3YrsKkOo1DleynY8Gx/dFvJ9NUtFKhYowxJWd+BYZ5i640VLA5SqPiuSlTLW/qpUHb2vOTwqSd9rHgb+3o5TV+Ha7J7P8hEgU+4TYAMQpkpkUFCEmQeB+TlJ8nLxZ2/dvnZ5PoEcE/0uQP1rijSEzBQZLDwjuL/ESJD4e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735295925; c=relaxed/simple;
	bh=CEsZkANASNEJmYGKZvPwewQYhZUWm9aTU9U3SmMBUNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DKnHhsB5Eg2a6h6MwZ8MD7ug6rtosHo4za/wGvT83ZcaY78XiiRw7MQ+TU2FrVQTEl/FP4zRVKIcG6rYXpB95snabPqIdz8Lx6HBbyGxqI8JLsrzPFZ6Qka3WBW1DbDGudRtKuNhjQUCpppjryK18bw2Zo8o3OGAkd5iTsUWc3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfWBemZs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfWBemZs"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-436326dcb1cso45892045e9.0
        for <git@vger.kernel.org>; Fri, 27 Dec 2024 02:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735295922; x=1735900722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=awZFTTuLPahvJCG8ouM62aMlE6ryuYMdt2phAgkzuec=;
        b=RfWBemZsgg1uPzKw59b5RUQZnTGCfDzDehAsTTccMWziwyyErhdoJ7R0EyD0EGTLwt
         ukNb2fcnxgDbarbI3XEqLYUoado1hyhRdVUaxzEfE/Q+AcpiZrVrETuTLBo/UGzEQgJi
         nJcaIFWXFsmkL54VxT5Z2W0eA+BMMqLH8FhnBaUlv14F1fNaNpCDtzg6ugeXub8u6t1y
         RLOOWW3es1UrPhj+XKDril+HpkOiV1rGL4NtGgOoz4m5hP38r4AYeX4dsZF3zxHKWXHL
         /JcIWJtfsSRt6yhgE8AmqaMZ9H5tdSiEH0NBvNVXFRryIcpnqg+ZyQcX4RRH7A7tHCZh
         yEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735295922; x=1735900722;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=awZFTTuLPahvJCG8ouM62aMlE6ryuYMdt2phAgkzuec=;
        b=kGN6fYU+R2Q+coakKBilgIMHLtBu+97k7PLs5vuIo+wMay1HeyVEtmwioHI6XrH+ox
         OGf6HIyD286Z4dzN9EUp3z3QX9MVzRA+WnEoGjLEv+YcT1oqw7Dknaz7hKcq1GkwoIoa
         QTixEcJ+S5QF/y4fJMlbjGPqEMKfmy0jeygOabWFr+gqfJNRndC7/3ocA4FAa0sKVjTI
         v590/MBKDed2VlEW1VsRsHPonbpIsdDBnMQRK0b2J5+ucls0NizHEQiFGRWX3hDXoQQA
         iXZQgs10AmUiWW6Md54+yK/fsKOEaubx53bZZhickb2tg3N81tI3loFXkHCsOHcqySWj
         2Djg==
X-Gm-Message-State: AOJu0YyVDRtnGP2JkIBauaFvEd6CHEbj9IixYkGfmr2vEjFv1U0PtWVy
	hG43AUAIZ4+VcxdSzWy3mKJGO3D3oTrA9KB+nNjYM+DDkYStMSLn
X-Gm-Gg: ASbGncswsncbHvBItLW9DFRZ8zWKLtlSsomDFTUiFr33+mY+Jddc9oT9Rfr1cjSFDio
	aWH2WQh4JNbI/KAuwk3YKtfK5I9J0qaWY888fxGxsRoMKoJNL4bpJ4oJZA/DzImQY0MCf9xWCne
	Ot3yBm2tkvKF/nOVhPxMkdJWzc70azvZ1O0oNK3Wu9m1TK0IMe3MWP7UWiXe/SECg53wxwXirfm
	lZKZykFXulJROI5gmbGWUnpnScCejdcLAxPGrdXebNqVrMfpnyWUFRG7jGBpNjQsn7uMPFAmYBL
	DXPBGIP7RmuJujD7qnt9I9UmtozY+Dh/BHE=
X-Google-Smtp-Source: AGHT+IG6LlaHGw743zSj9mAfGnnubOU/2+Lltu4MyQ8iIVsLiWcow0oisl0bWlEoplTCAHYOz/iOGA==
X-Received: by 2002:a05:6000:713:b0:382:4115:1ccb with SMTP id ffacd0b85a97d-38a221f2ec7mr22470866f8f.7.1735295921747;
        Fri, 27 Dec 2024 02:38:41 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b4432dsm293292515e9.41.2024.12.27.02.38.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 02:38:40 -0800 (PST)
Message-ID: <e396131c-1bd3-46d0-bae6-cd97ca9710d8@gmail.com>
Date: Fri, 27 Dec 2024 10:38:33 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/4] add-patch: Fix type missmatch rom msvc
To: Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?S=C3=B6ren_Krecker?=
 <soekkle@freenet.de>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
References: <20241223110407.3308-1-soekkle@freenet.de>
 <20241223110407.3308-2-soekkle@freenet.de> <xmqq34iaxh7r.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqq34iaxh7r.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/12/2024 21:33, Junio C Hamano wrote:
> Sören Krecker <soekkle@freenet.de> writes:
> 
>> Fix some compiler warings from msvw in add-patch.c for value truncation
>> form 64 bit to 32 bit integers.Change unsigned long to size_t for
>> correct variable size on linux and windows
>>
>> Signed-off-by: Sören Krecker <soekkle@freenet.de>
>> ---
>>   add-patch.c | 44 +++++++++++++++++++++++++-------------------
>>   gettext.h   |  2 +-
>>   2 files changed, 26 insertions(+), 20 deletions(-)
> 
> 
> 
>>   struct hunk_header {
>> -	unsigned long old_offset, old_count, new_offset, new_count;
>> +	size_t old_offset, old_count, new_offset, new_count;
> 
> These are not "size"s in the traditional sense of what size_t is
> (i.e. the number of bytes in a region of memory), but are more or
> less proportional to that in that they count in number of lines.
> 
> If ulong is sufficient to count number of lines in an incoming
> patch, then turning size_t may be excessive---are we sure that we
> are not unnecessarily using wider-than-necessary size_t in some
> places to hold these values for which ulong is sufficient, causing
> compilers to emit unnecessary warning?

That's my thought too - I think something like the diff below should
fix the warnings by using more appropriate types in expressions
involving the hunk header offset and count. Our internal diff
implementation will not generate diffs for blobs greater than ~1GB
and I don't think "git apply" can handle diff headers that contain
numbers greater that ULONG_MAX so switching to size_t here seems
unnecessary.

Best Wishes

Phillip

---- >8 ----

diff --git a/add-patch.c b/add-patch.c
index 557903310de..2c439b83665 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -253,7 +253,7 @@ struct hunk_header {
  
  struct hunk {
  	size_t start, end, colored_start, colored_end, splittable_into;
-	ssize_t delta;
+	long delta;
  	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
  	struct hunk_header header;
  };
@@ -760,7 +760,8 @@ static void render_diff_header(struct add_p_state *s,
  static int merge_hunks(struct add_p_state *s, struct file_diff *file_diff,
  		       size_t *hunk_index, int use_all, struct hunk *merged)
  {
-	size_t i = *hunk_index, delta;
+	size_t i = *hunk_index;
+	long delta;
  	struct hunk *hunk = file_diff->hunk + i;
  	/* `header` corresponds to the merged hunk */
  	struct hunk_header *header = &merged->header, *next;
@@ -890,7 +891,7 @@ static void reassemble_patch(struct add_p_state *s,
  {
  	struct hunk *hunk;
  	size_t save_len = s->plain.len, i;
-	ssize_t delta = 0;
+	long delta = 0;
  
  	render_diff_header(s, file_diff, 0, out);
  
@@ -926,7 +927,8 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
  	int colored = !!s->colored.len, first = 1;
  	struct hunk *hunk = file_diff->hunk + hunk_index;
  	size_t splittable_into;
-	size_t end, colored_end, current, colored_current = 0, context_line_count;
+	size_t end, colored_end, current, colored_current = 0;
+	unsigned long context_line_count;
  	struct hunk_header remaining, *header;
  	char marker, ch;
  
@@ -1175,8 +1177,8 @@ static int edit_hunk_manually(struct add_p_state *s, struct hunk *hunk)
  	return 1;
  }
  
-static ssize_t recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
-				   size_t orig_old_count, size_t orig_new_count)
+static long recount_edited_hunk(struct add_p_state *s, struct hunk *hunk,
+				 unsigned long orig_old_count, unsigned long orig_new_count)
  {
  	struct hunk_header *header = &hunk->header;
  	size_t i;
@@ -1626,7 +1628,7 @@ static int patch_update_file(struct add_p_state *s,
  			else
  				err(s, Q_("Sorry, only %d hunk available.",
  					  "Sorry, only %d hunks available.",
-					  file_diff->hunk_nr),
+					  (int)file_diff->hunk_nr),
  				    (int)file_diff->hunk_nr);
  		} else if (s->answer.buf[0] == '/') {
  			regex_t regex;


