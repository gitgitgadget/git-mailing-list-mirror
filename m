Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC1A255238
	for <git@vger.kernel.org>; Mon, 12 May 2025 09:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747041033; cv=none; b=tSwtCbCGrfQUHFql7k6a6nwenyF28QcqTp1b4BHLzUCWvrFwiJMw9hzpjePVSB5oSp6JuTtoFq3GcXm+gE2IQRwvimJ0BI68oReXNcf1l83LnY5llYZefM3TGWddy4zuPvCJX4U3NulJZ3mB5aKwUlr43OdbayvNLEDGAdfRNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747041033; c=relaxed/simple;
	bh=lHQZibul4HjdX+CjPZT0XFjdWZDQ94z8UieGahPYvs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6KwBswBG3PZYHyfNQ2MpC9HQJsOP/Y3Y1tgyS2GgourkW13WFwAn4FBi/nojPmH5waRJUZIiU7cwrapAKcLTyr4g8CTga4vprKkbAi2Ds+Y4a/cY6KAPXikp411J1k82tdP/hXEKN9ZS9YZt4it5KcMAOmnDXxAYKi0r22nIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jHEUGa3M; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jHEUGa3M"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a1f8c85562so1741219f8f.1
        for <git@vger.kernel.org>; Mon, 12 May 2025 02:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747041030; x=1747645830; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WNR4wxCTn0a+xg2fATZOH0EjTg3GgvUOpe7VEPd3EZA=;
        b=jHEUGa3MK6M296fXe3zRGVPHTISQoaMa80UK0lMAfeifBMr6tCFrwhF47Byv22WiLI
         kIvqjKnkIa2oNZVFBzmcCIGh74Iox9Q/fr6Ehu9DYhSAgRqNYBlfeShY0+1oP0Xc9Gxj
         Xnm8lu23ihAoxUklIUUkDScGIcmN3nJLKOiNd11mWGqejUj79dkqVz/vOwVGJkbSo99N
         nhWlDMbzHLU+tAnr27kVPta8Zxr+ZGvSL4G5h/fU0DD7re3Oi8Hs2RER9XGJhudsgZ3X
         mF3quMSFmsZAh1PrMXUb0COXpG6w7nOkx2b7Qp43gjiAZ1wnYrDx6+UJIx6lK1cUiF9g
         /W7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747041030; x=1747645830;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WNR4wxCTn0a+xg2fATZOH0EjTg3GgvUOpe7VEPd3EZA=;
        b=fiSKVHAKOOJA8R9GY5UaYQ4rkClD0gRk0CNtwLkW0pemAX4XpMuj9is37iU8+aDxOX
         S4OFw24TrBCprqc0s7jJCWPdwPqMnI/m3LAwP8NJlapA1PanMJN5QqBKJUj3UibVBEMO
         ak5+32SmSq8iEb8WGiQCow0Z6VqJ80oAuk5GOPyFx5FC2J+nzjklAraJXHDEEydlDjdC
         FtTiSjrk9PEMvzYabL/NiFFfHgX9EX1Wn4CPIOe62NGmdI/Qa80VjK9jgV4q5HVHrwG0
         VRxEFuWwcABpUwzFCIEjBKUPSKPsrvYGgLVYOmSgNwol18ndytt3xLHXVrOj+9/4g0uB
         BlhA==
X-Forwarded-Encrypted: i=1; AJvYcCVft9nvqtUamZJUvIDq5S0jmUboT2elw86pA9okeQmjYtdKWfxEjcweDSdulQ0Ru4E1kk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwugErDJT8yT5OXGJp9OfvNZbpA/O8qHWIpKrXrJow5ekha8w8L
	HD0hlzx0lMCoaYzTSGZIQwUd3b755CZEeKNNLJAyFIm/W0XQGlvCkFNM+A==
X-Gm-Gg: ASbGncu5mUKYR5B3C0WSv3jT0rOoRdWWFF9Zfzwo6mKEh6DMD0ruH0moJ9RzBRiUezi
	OYQ1nUd6i5GdPZHi07MmWgFNHEwkEgr/FKE3OK19F/Dh7KoDQSB/0PIPWuI04O/GgTdM/ckByiv
	1Go68SKOQ6IHNdEZSX4ic7Ylae+W8l5OYJJ9dFyncdBcK3K0JzsQdyUm23lxrkvtw6f1b9Kd52/
	HAQboQl/JPcsDwakL/RJSVwUsTdyAhtGCy7eYsVpLSI2c4uCwu7P11h9TSNv0X6UwkLyOfS9moy
	9BPOTl73G9egz3fbqUnGBnANA5WqANCXDsl4YGBJ4xMLfIlX3qT9x8z0Id5VUPSBk2wXKLNW1Jh
	bZTEeMWBa9luWbjeK+AWhGujCQps=
X-Google-Smtp-Source: AGHT+IEn6Nam59zrRe7O6tIIKG0RlngwPzRdhvrTo1FluN553VjLi41Gs/YOJJmP7CqTTlv1eJmhLw==
X-Received: by 2002:a05:6000:381:b0:3a1:fa99:21df with SMTP id ffacd0b85a97d-3a1fa992269mr9795057f8f.57.1747041029488;
        Mon, 12 May 2025 02:10:29 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:700:a501:20c3:eb2d:481:4a64? ([2a0a:ef40:700:a501:20c3:eb2d:481:4a64])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a2d30asm11718510f8f.76.2025.05.12.02.10.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 May 2025 02:10:28 -0700 (PDT)
Message-ID: <67ba7cf4-e6b9-4c05-9960-e95fdcd4ed97@gmail.com>
Date: Mon, 12 May 2025 10:10:28 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 3/4] builtin/stash: provide a way to export stashes to
 a ref
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250508234458.3665894-4-sandals@crustytoothpaste.net>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20250508234458.3665894-4-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi brian

On 09/05/2025 00:44, brian m. carlson wrote:
> A common user problem is how to sync in-progress work to another
> machine.  Users currently must use some sort of transfer of the working
> tree, which poses security risks and also necessarily causes the index
> to become dirty.  The experience is suboptimal and frustrating for
> users.
> 
> A reasonable idea is to use the stash for this purpose, but the stash is
> stored in the reflog, not in a ref, and as such it cannot be pushed or
> pulled. 

I think the commit message would be more convincing if it concentrated
on the need to import / export chains of stashes and the convenience of
having a dedicated command to import a stash as one can export a single
stash with

     git push <remote> refs/stash@{<n>}:refs/exported-stash

and then import it with

     git pull <remote> refs/exported-stash
     git update-ref refs/stash FETCH_HEAD

Having said that I do agree that adding these new commands is a good
idea.

> @@ -154,6 +155,12 @@ store::
>   	reflog.  This is intended to be useful for scripts.  It is
>   	probably not the command you want to use; see "push" above.
>   
> +export ( --print | --to-ref <ref> ) [<stash>...]::

I was surprised to see that --to-ref does not take an argument. I think
that is confusing and it would be better to use OPT_STRING() rather than
OPT_CMDMODE() and manually check that only one of "--print" or
"--to-ref" is given. In the end it is no more work because now you have
to manually check that we have a ref when "--to-ref" is given.

I was also surprised to find that "git stash export HEAD" did not error
out. I was looking for a function that checked the topology of a stash
commit and could not find one so I thought I see how difficult it was to
add that. The fixup commit below adds a new function to check that a
commit looks like a stash and refuses to export anything else. The patch
adds a new function rather than using assert_stash_like() because
despite its name that function is pretty lax (any merge commit will
satisfy it) and is more concerned about filling out a stash_info struct.

Best Wishes

Phillip

---- >8 ----
From: Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH] fixup! builtin/stash: provide a way to export stashes to a
  ref

Reject commits that do not look like stashes.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
  builtin/stash.c | 42 ++++++++++++++++++++++++++++++++++++++++++
  1 file changed, 42 insertions(+)

diff --git a/builtin/stash.c b/builtin/stash.c
index d8332af4017..02cf344ed96 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -180,6 +180,33 @@ static void free_stash_info(struct stash_info *info)
  	strbuf_release(&info->revision);
  }

+static int check_stash_topology(struct repository *r, struct commit *stash)
+{
+	struct commit *p1, *p2, *p3 = NULL;
+
+	/* stash must have two or three parents */
+	if (!stash->parents || !stash->parents->next ||
+	    (stash->parents->next->next && stash->parents->next->next->next))
+		return -1;
+	p1 = stash->parents->item;
+	p2 = stash->parents->next->item;
+	if (stash->parents->next->next)
+		p3 = stash->parents->next->next->item;
+	if (repo_parse_commit(r, p1) || repo_parse_commit(r, p2) ||
+	    (p3 && repo_parse_commit(r, p3)))
+		return -1;
+	/* p2 must have a single parent, p3 must have no parents */
+	if (!p2->parents || p2->parents->next || (p3 && p3->parents))
+		return -1;
+	if (repo_parse_commit(r, p2->parents->item))
+		return -1;
+	/* p2^1 must equal p1 */
+	if (!oideq(&p1->object.oid, &p2->parents->item->object.oid))
+		return -1;
+
+	return 0;
+}
+
  static void assert_stash_like(struct stash_info *info, const char *revision)
  {
  	if (get_oidf(&info->b_commit, "%s^1", revision) ||
@@ -2101,13 +2128,21 @@ static int do_export_stash(struct repository *r,
  		 */
  		for (i = 0; i < argc; i++) {
  			struct object_id oid;
+			struct commit *stash;
+
  			if (parse_revision(&revision, argv[i], 1) ||
  			    get_oid_with_context(r, revision.buf,
  						 GET_OID_QUIETLY | GET_OID_GENTLY,
  						 &oid, &unused)) {
  				res = error(_("unable to find stash entry %s"), argv[i]);
  				goto out;
  			}
+			stash = lookup_commit_reference(r, &oid);
+			if (!stash || check_stash_topology(r, stash)) {
+				res = error(_("%s does not look like a stash commit"),
+					    argv[i]);
+				goto out;
+			}
  			oid_array_append(&items, &oid);
  		}
  	} else {
@@ -2118,13 +2153,20 @@ static int do_export_stash(struct repository *r,
  		for (i = 0;; i++) {
  			char buf[32];
  			struct object_id oid;
+			struct commit *stash;

  			snprintf(buf, sizeof(buf), "%d", i);
  			if (parse_revision(&revision, buf, 1) ||
  			    get_oid_with_context(r, revision.buf,
  						 GET_OID_QUIETLY | GET_OID_GENTLY,
  						 &oid, &unused))
  				break;
+			stash = lookup_commit_reference(r, &oid);
+			if (!stash || check_stash_topology(r, stash)) {
+				res = error(_("%s does not look like a stash commit"),
+					    revision.buf);
+				goto out;
+			}
  			oid_array_append(&items, &oid);
  		}
  	}
-- 
2.49.0.300.g813f75aecee
