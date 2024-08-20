Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B437146586
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 07:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139265; cv=none; b=PCt6UippDGoEHwucH08N/wvzsQAKhKwRoaybLE0VT/QpobYsqRt2dtcsjy/oTWFxCW/160hxe/qzKvnaan6eIiVNN6OlaHG6SvgUBhrIh7zhiSKc4tCQSVHoqJiPg28U5AkC4yVh6QMRhjdaiZ/u9A2jI8B+b2lzkFQqoXW6B0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139265; c=relaxed/simple;
	bh=QLiR2yGA/oc50fwxpxNo4wRFu/Af4AfOUiDbbiXMaog=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=d+MUXERcPJJcfFyBoRUo+3HFdrmtc9pLjlQG2quOscV2L+vrb7tj8BP0CzfRXeUAbEVx51V64x2901deXp0BSk7q/VNdLWs0W/HCTzMV8/2ovISRn4XIzGhDbz7DOpDPrf9tFgpMVM3xyz+KQV4PuZ/3mA/1Lroooy4dawnkELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1Qr6LJs; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1Qr6LJs"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5d5c7f23f22so3210570eaf.0
        for <git@vger.kernel.org>; Tue, 20 Aug 2024 00:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724139262; x=1724744062; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ffC38caJWPV1NsJXpA0+eqYAVCDSGY1UcoDVpJuiLNA=;
        b=a1Qr6LJsBF7Ct+GjZgCqVibJqJn9zfBT2MinT7Mv485Q1wHKZF0PD4XE9/iq+nASUY
         LxvicXGeqyYwefs7prbPfHlNoicZTcaoXQt1FZrtBm+y3HJVrHLdiqxJS5K1EHT15E9P
         j/ye6uU0Zf9QGN6DrrelOlRiDfE9X+KcvsDa9YlJUbelMJhd/E9frdBbQrm9YFSGnM+w
         ixsuewSKMt18FYzSU9TrZEvIjAA54npOXYOy2Wxg4yoynbUDJs+0H/E4nUuXKHFu5tNo
         gSi+/aMFuRglG/YE4XCxkzl9bmkIlKBfp/C9WmoePputYxO5lFicOmt9h6a53pOWwdTC
         clBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724139262; x=1724744062;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ffC38caJWPV1NsJXpA0+eqYAVCDSGY1UcoDVpJuiLNA=;
        b=Lzh0Ejhz04UFbvnlFdL6Bfccs2X3bl2eJH0Nc6eP6JgR4fuCOrGJ1kmUeOg5AfV5ek
         qj2uUH0a4pRPJGqPVFIamfrMPkpPsb97zNJG+K2oHY95MCKLmWQABMj/Tou8GQU9wWAU
         3exw4JqKQ3CW1RWaMZvGBT++tyfzx82fcCIhoF+2y6whIYrR+4yGv/RD+tcqe0yzYN7t
         /uRwo8f3lU55zNaJSXA/y2ym61cS2Hvr8VWznOm2rhNWXlK/ODH+ojVAihvwbcBBdbiJ
         I5eKYyLpDmMWbGiktw6qBlU9q4LZVIbswcX/2NunJ1StmPuF86HSah8/x8DCU9DcyZKk
         P54Q==
X-Forwarded-Encrypted: i=1; AJvYcCU96xzw3Oz0QuwmRQtDRAS2fzmZubH5DcPXZ61Eom7bTgOcPl0EB+tqvVGqsooOlEZHeQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuJ+FSxRJO29KQ/TvZUWn3uOIJhcJOYmYTA+ka1HDg3zfUhyFN
	qvcIbzgeDhqOsWDEyOFBJ/obCSY/dRI18bHuuZ75r/AFxHUYwcqI++wu4QOikHASbz3+zxwUCYw
	eLp+5dqtVUxdjBvM/W+1na1FK5BUpQA==
X-Google-Smtp-Source: AGHT+IHE0pGxLS62CRyCTEeaPXpg1DWqDgF4wnDb3ectwa64LFt6rPotcQ8RRIWM6xEGKwFFAgz7F66aKuwhGvPQzlg=
X-Received: by 2002:a05:6820:22a3:b0:5da:a06b:c405 with SMTP id
 006d021491bc7-5daa06bc906mr12789543eaf.0.1724139262342; Tue, 20 Aug 2024
 00:34:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 20 Aug 2024 09:34:21 +0200
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <7acfe4fecc54beaa71d65f04c92e31ebe95aa1a0.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im> <7acfe4fecc54beaa71d65f04c92e31ebe95aa1a0.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 20 Aug 2024 09:34:21 +0200
Message-ID: <CAOLa=ZSOiNKdJcMkE-P052cZjRXPcFQ7y1LnZFOZ0DMtqGnM+g@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] t/helper: inline `reftable_stack_print_directory()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000004696de06201874e7"

--0000000000004696de06201874e7
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> Move `reftable_stack_print_directory()` into the "dump-reftable" helper.
> This follows the same reasoning as the preceding commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/reftable-stack.h |  3 ---
>  reftable/stack.c          | 20 --------------------
>  reftable/stack_test.c     |  7 -------
>  t/helper/test-reftable.c  | 23 ++++++++++++++++++++++-
>  4 files changed, 22 insertions(+), 31 deletions(-)
>
> diff --git a/reftable/reftable-stack.h b/reftable/reftable-stack.h
> index 09e97c9991..f4f8cabc7f 100644
> --- a/reftable/reftable-stack.h
> +++ b/reftable/reftable-stack.h
> @@ -140,7 +140,4 @@ struct reftable_compaction_stats {
>  struct reftable_compaction_stats *
>  reftable_stack_compaction_stats(struct reftable_stack *st);
>
> -/* print the entire stack represented by the directory */
> -int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id);
> -
>  #endif
> diff --git a/reftable/stack.c b/reftable/stack.c
> index d08ec00959..bedd503e7e 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1603,23 +1603,3 @@ int reftable_stack_clean(struct reftable_stack *st)
>  	reftable_addition_destroy(add);
>  	return err;
>  }
> -
> -int reftable_stack_print_directory(const char *stackdir, uint32_t hash_id)
> -{
> -	struct reftable_stack *stack = NULL;
> -	struct reftable_write_options opts = { .hash_id = hash_id };
> -	struct reftable_merged_table *merged = NULL;
> -	struct reftable_table table = { NULL };
> -
> -	int err = reftable_new_stack(&stack, stackdir, &opts);
> -	if (err < 0)
> -		goto done;
> -
> -	merged = reftable_stack_merged_table(stack);
> -	reftable_table_from_merged_table(&table, merged);
> -	err = reftable_table_print(&table);
> -done:
> -	if (stack)
> -		reftable_stack_destroy(stack);
> -	return err;
> -}
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index dbca9eaf4a..42044ed8a3 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -179,13 +179,6 @@ static void test_reftable_stack_add_one(void)
>  	EXPECT(0 == strcmp("master", dest.value.symref));
>  	EXPECT(st->readers_len > 0);
>
> -	printf("testing print functionality:\n");
> -	err = reftable_stack_print_directory(dir, GIT_SHA1_FORMAT_ID);
> -	EXPECT_ERR(err);
> -
> -	err = reftable_stack_print_directory(dir, GIT_SHA256_FORMAT_ID);
> -	EXPECT(err == REFTABLE_FORMAT_ERROR);
> -
>

We loose this test due to the movement. It is okay, because the code
that it is testing, is now only available in the testing section and is
a test-helper. But it would be nice to mention this in the commit
message.

[snip]

--0000000000004696de06201874e7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 731f8ea3370f0b97_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1iRVJ2a1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNEVVQy85bkt0Tk1TOUNObFdobzdvNzVxU3d0RDN0Rgp0aDl2dEJxRGJ4
dkNEVmFMdFVBSzhsM3E3aXNVOXNKUXYxVjVRdENUUjJ5UUlGdjI3M0xEQTByRUd5a0VTaG9KCldo
NWY0MjhZMUJodFJ4NFVaWFZ2Rmlnd2RTdnUwL3hzZWpXeUkyUzV0SXFYOGh4djJ4REREZVdTZ0hr
WFQxQjMKQ1JHdUpjT1ZHUHczamR1SnIvOE1jZjlCRjVpS0JPTTR1VjhOMnYyWlpKcHcvMThDS252
RWM4K3dONldYNjY4UQpDZlRvM3c2dzk0d1ZvTHhhRmFNYXF4RGptc2dieElMeVhZSEgzSGdUSW9h
QzJ1dnRVaXBUMzg1eTUyTUhrdTBTCkVGL1dtd0NxNWFQY0JJQ1RWWEZuYkhlVHN3ZFRqRFZOOWdH
RWFlRzhWRGlnRjg2cjA5Q2NlaGY3UEZJWVA5UEUKR21yRFQ5bHZlN3FVMVZuWkpxa0p0R0t3YlhC
aWlCY1VvS3F3WHYraDJFVXJjWUFLM0JiWXoraEFKSDhFR3RwWgpEd1BzNDQ3MWpFVW9ES2VLa2Fa
RkR0THdOQ1ZJMUhmNnhadUNWSzJPU2ZYTGprbVFYSUJDL3JZdXg1b0RlQkxYClVoT1RoYmwrWUZE
YzJGUExyTlJWWmdwTXdoc2pSYXFkSXphK3o4cz0KPW41a1IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004696de06201874e7--
