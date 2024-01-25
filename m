Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E926EB4A
	for <git@vger.kernel.org>; Thu, 25 Jan 2024 16:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706199618; cv=none; b=aHfwkdGVGCbesXbavFUKhWAcQIPfbVqb56qB/vsg8qXKDfxGh8T2YOBX6isfapLKtL+FREFjQmhmrMXn2nmOSh+nYswCLCP01REKt5mfK1l586YNDIjBGcU0JnB1/Vk83wjun7l7OZo84dWnZ+cQ3VVxWK3iozqWbM/ubNR+Fbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706199618; c=relaxed/simple;
	bh=njCooK6Z0+H1WrHjBD/UDU6MFvShLNv161rIjZSwjNw=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REUgsIO4zDIka+c71/5zvFsZwQo/6myUzRJVLGbfijmSsH+kE1oBRsHcDWKo+l3tg5YT3FAHZaNc5k9JaeYRob9w5J+Fl6fJ+xcd/8wynvmqv3fIqs///FfAWFuAw07UXtDOyKqCs+FudMXvxz91hcRjq0I/BBnw/ccW8jB8KL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fe13BCeP; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fe13BCeP"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-21481a3de56so1758069fac.2
        for <git@vger.kernel.org>; Thu, 25 Jan 2024 08:20:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706199616; x=1706804416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Y2SX3OAfYXoJStpI7p4Ek1ctWlVWi892frEzlzYrc=;
        b=Fe13BCePHAVNk5z73/gTcTCXN5C1njcYXItT2wfbItKE6AioTmyCoijTUKV4hW5KZQ
         4vLLCpLYpIeDCMmhkJCpGe3M9NFtjS1dzaoounCwJ/jtdAYaUE+UWfUd/fZ8aBnh72IU
         M2iaOZ3ePiarCJrUMnJHvy8eSN4KOTHdVn3ZV15DRXJ6Xs+ut1OSRi/9laRCo1mvO0Lg
         zjEqiXtmjeq13BoAKIJgW/VrRHwsr2HYas1TRJvSGtNXIfRNxtg7U5dL9sAFT+dsRExZ
         XFOVje8I8VKuRspVEWCY6aaPOeJj1fxYpc7kpQqzTahQf+i3fliVDZeDeBX+G9asW+2j
         rH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706199616; x=1706804416;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2Y2SX3OAfYXoJStpI7p4Ek1ctWlVWi892frEzlzYrc=;
        b=s5bCglD3IMk+3omiLoYp/n8jCcsj/Y157CWUwoWCokgNEPvk54PiZOY6rZNXXWNwSK
         udtFFK3vIV4de0iiTDEIa/sUrJFBQnnfay636LpUb7cccKbaJGV9f1xL5dX+a9MbSVgo
         MXE84l4HX/G1kG8SMryT6p9aEECAhHsVR00RFQWB2ZoKCdSMHmH8Ipwcq5quAXmmlYCY
         RYBU/do6YzqQ2xQL+8gF45/mdNA6+HSLHqprobYwhza/M7vwKbAGy5EtQAJrRLFynS4t
         pFhrNxWQZjRIY8yc1CqTN43KgSzc5ciG2CzkWWuYtqZqipxsbLHFyWfds7Hy7Uh2t7Z4
         3UfQ==
X-Gm-Message-State: AOJu0Yw8sGWX+iORJtMOwIrbcPEI9ARzhYjEiQoPYE9Q7A/eVLbWfvOl
	4xk9F17DzLmkM22nfy9KN1u97nh4cpjsyVl69ECBSrFaY8vjQuNQoL57HxA8NBNIXvkLbS0ld0O
	RiicEIEVc6Mj4FAhkClvT1MEtlRo=
X-Google-Smtp-Source: AGHT+IFpKamwueuRBey3MjtDWVcOiztpBYwVLwyf68GPcSgfY4JUdIllJZSwsJ5yFGjVXPqbugXTysIVYNdThEj0fv8=
X-Received: by 2002:a05:6871:29a:b0:214:cd1c:bb88 with SMTP id
 i26-20020a056871029a00b00214cd1cbb88mr1180968oae.112.1706199616332; Thu, 25
 Jan 2024 08:20:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 25 Jan 2024 16:20:15 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqqfrymeega.fsf@gitster.g>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240124152726.124873-1-karthik.188@gmail.com> <20240124152726.124873-2-karthik.188@gmail.com>
 <xmqqfrymeega.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 25 Jan 2024 16:20:15 +0000
Message-ID: <CAOLa=ZQxMZo2Y6x6GmVw=df_xS4tkF4D1_tZOeLb7jL5d5bKXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] refs: introduce `is_pseudoref()` and `is_headref()`
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, ps@pks.im, phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000000c47b2060fc78e3e"

--0000000000000c47b2060fc78e3e
Content-Type: text/plain; charset="UTF-8"

Hello Junio,

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> We cannot directly add the new syntax checks to `is_pseudoref_syntax()`
>> because the function is also used by `is_current_worktree_ref()` and
>> making it stricter to match only known pseudorefs might have unintended
>> consequences due to files like 'BISECT_START' which isn't a pseudoref
>> but sometimes contains object ID.
>
> Well described.
>
>> diff --git a/refs.c b/refs.c
>> index 20e8f1ff1f..4b6bfc66fb 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -859,6 +859,38 @@ static int is_pseudoref_syntax(const char *refname)
>>  	return 1;
>>  }
>>
>> +int is_pseudoref(struct ref_store *refs, const char *refname)
>> +{
>> +	static const char *const irregular_pseudorefs[] = {
>> +		"AUTO_MERGE",
>> +		"BISECT_EXPECTED_REV",
>> +		"NOTES_MERGE_PARTIAL",
>> +		"NOTES_MERGE_REF",
>> +		"MERGE_AUTOSTASH"
>
> Let's end an array's initializer with a trailing comma, to help
> future patches to add entries to this array without unnecessary
> patch noise.

Sure, will add!

>> +	};
>> +	size_t i;
>> +
>> +	if (!is_pseudoref_syntax(refname))
>> +		return 0;
>> +
>> +	if (ends_with(refname, "_HEAD"))
>> +		return refs_ref_exists(refs, refname);
>> +
>> +	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
>> +		 if (!strcmp(refname, irregular_pseudorefs[i]))
>> +			 return refs_ref_exists(refs, refname);
>> +
>> +	return 0;
>> +}
>
> The above uses refs_ref_exists() because we want these to
> successfully resolve for reading.
>
>> +int is_headref(struct ref_store *refs, const char *refname)
>> +{
>> +	if (!strcmp(refname, "HEAD"))
>> +		return refs_ref_exists(refs, refname);
>
> Given that "git for-each-ref refs/remotes" does not show
> "refs/remotes/origin/HEAD" in the output when we do not have the
> remote-tracking branch that symref points at, we probably do want
> to omit "HEAD" from the output when the HEAD symref points at an
> unborn branch.  If refs_ref_exists() says "no, it does not exist"
> in such a case, we are perfectly fine with this code.
>
> We do not have to worry about the unborn state for pseudorefs
> because they would never be symbolic.  But that in turn makes me
> suspect that the check done with refs_ref_exists() in the
> is_pseudoref() helper is a bit too lenient by allowing it to be a
> symbolic ref.  Shouldn't we be using a check based on
> read_ref_full(), like we did in another topic recently [*]?
>
>
> [Reference]
>
>  * https://lore.kernel.org/git/xmqqzfxa9usx.fsf@gitster.g/
>

Thanks, this makes sense and the link is helpful. I'll do something
similar, but since HEAD can be a symref, I'll drop the
`RESOLVE_REF_NO_RECURSE` flag and only use `RESOLVE_REF_READING`.

I'll wait a day or two, before sending in the new version with the
fixes. The current diff is

diff --git a/refs.c b/refs.c
index b5e63f133a..4a1fd30ef2 100644
--- a/refs.c
+++ b/refs.c
@@ -866,7 +866,7 @@ int is_pseudoref(struct ref_store *refs, const
char *refname)
 		"BISECT_EXPECTED_REV",
 		"NOTES_MERGE_PARTIAL",
 		"NOTES_MERGE_REF",
-		"MERGE_AUTOSTASH"
+		"MERGE_AUTOSTASH",
 	};
 	size_t i;

@@ -885,10 +885,23 @@ int is_pseudoref(struct ref_store *refs, const
char *refname)

 int is_headref(struct ref_store *refs, const char *refname)
 {
-	if (!strcmp(refname, "HEAD"))
-		return refs_ref_exists(refs, refname);
+	struct object_id oid;
+	int flag;

-	return 0;
+	if (strcmp(refname, "HEAD"))
+		return 0;
+
+	/*
+	 * If HEAD doesn't exist, we don't have to die, but rather,
+	 * we simply return 0.
+	 */
+	if (read_ref_full("HEAD", RESOLVE_REF_READING, &oid, &flag))
+		return 0;
+
+	if (is_null_oid(&oid))
+		return 0;
+
+	return 1;
 }

 static int is_current_worktree_ref(const char *ref) {

- Karthik

--0000000000000c47b2060fc78e3e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 131ec4d058c396d1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1XeWlqMFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1menU1Qy80clFHYUFMV1lYQXRrWTFpMGFmQUdvTmtkYQowWkdjS1k3OTUr
STVVZi9NNnNEQ2o0Zkw5enpEbE5vNi9ncUdmWDdXVkFBUUEwY3pzNzUrKzMzV1RTRW1reEpICjg2
cTJacXpzdGJOMGlpcFRENUtUeHRrSmk3TlJnWWdqc2JJekJJdXNmODhQRVYxdnQwUVJZNkVjcUhC
THBodTkKQXhvTWpoMElCRXMrYWg5N3RINzk1RkN5ay9yVmpXeDdjNGRYbm1hV2V4WXZ0QWR3djVD
bDVxLy9nWDNraWJGZgpuZDluYnR3SVdKMmM1SHliMVpqa0pQN0Z1SGtsTFJYM0VwWEdnYmh4ZTVI
RmE3OG5Nc1czalI5ZzFLYU5OaGY2ClQvYUduL0FnWmZvdE12ZHliRis4MUFGTmJ0VFgrQmR5QVAz
dm91RERTa01zNzBnVmZJQlZyM1EwQk9Fak04OFcKamZCY0c2bTZDTTdzd25lNGZnZjFJVHJrdDFE
WWNoM1dZK2ZBYjZtMk5lOVdvZExXU2xKeW1hUGl1dUZKekxldgpweTd1TENZZjFiLzVkTCtRajhW
UEM0MDhNdy8yMEx6aC9GeCs4S0lmMXZneUVmRHVvMGhJUEwzRkFVZENFTDk4CmYxdzB1R0oxUXRQ
Sjk0VlQ5RDRoNy9pT0NGS01DUkFPR2UzUC9CZz0KPThyRTIKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000c47b2060fc78e3e--
