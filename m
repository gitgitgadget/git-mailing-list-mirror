Received: from mail-yx1-f65.google.com (mail-yx1-f65.google.com [74.125.224.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0371627456
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 00:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761092806; cv=none; b=Vc3Ip5YOr6c1NKWIGzXRxYISsh0z7yqd/l1siLrckd1wS6E4FpsvwJ5X5RTLtcWRayPwPiHI9EizbacmK4y13ZKMy5HuG70zG9Vev2NxYw0Kd1d2LN/o2h/ieITEie9cfQiqoKokoaUrL1NyvTN0HuMl58xoJK7Otr+nmhXPG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761092806; c=relaxed/simple;
	bh=7nCHCYCe9dcUMYyfVxtFmWxgH2G/1qMb+4rtXobfXAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f+YJzoPeBvYCK8Oj0ssIz0viAVo7nNfsmX5hZDDIY+iTLKU+RUZNY4ktGn/ZRcpOH4YvQYPsWjwIdH2a9GhBdBNkR/Sw5k0VWVpDhrjuTYNzG9CRaJbBMl5rSTNPPSRZdkEW3iCQ8Awkth7sxXYVkV5pyQdGHNzU0GVI4QrbeQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=VlfjHJQX; arc=none smtp.client-ip=74.125.224.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="VlfjHJQX"
Received: by mail-yx1-f65.google.com with SMTP id 956f58d0204a3-63d0692136bso6542342d50.1
        for <git@vger.kernel.org>; Tue, 21 Oct 2025 17:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1761092804; x=1761697604; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P4QBKpHs5oF7EbUOA1UEAdkU8gF0HSu8TR02QLL+d78=;
        b=VlfjHJQXv3GtZgYh1k37fhekiLeyQ1BR1C4vGSJGA3AkULclThFGIz9GQfN5DxjHUu
         3NjrJf1rtOa0zwdIQOrUTsW7/vTpIl1ncTK+NbfQIZwnU/CGyPCxNeFTofhi7HSRti43
         Jve5Jx8a6jsuX1+/NgOWVSLdFfjW3yizZaqQGhV/BhsQpO+z0oF/WIDGOmFt2OX9dJAC
         MQ/wByXQvB+APEClNIZwgQeW6Rvqn3ldU7+h6ctLk+Eu/KH9KJuwM+BK/YwWAoDbNHG3
         xezp2O/Tu1/PmcFklqxbHE/es3rlsTiv0u1Ct6Wh795OcgWYaq670ax9/5B3naQEGpWy
         XiYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761092804; x=1761697604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P4QBKpHs5oF7EbUOA1UEAdkU8gF0HSu8TR02QLL+d78=;
        b=fJhb4+9jBcG08+Xz6oPoNnisNN5pCKvSf4++2TblqN5rpq06lHp7pqdj/5Z5LOMoLX
         OfnWt2vjAT46zKvUNatTzYQsLYYXXlTWQ67LTlny/qxeWp4LCaodPHNKxmQWNxhuwszB
         qdCGIW8wQ6YeEXcWBxhD8WQRUWedW2nnBhWJExPZZReCo4qcsLmXR6sgJjyQ2z8u317N
         kJVO3NsXwsdwARHwEgsoVevc1+KKIUr3yhJ6NbpF6vTy3avg09L9PNvWr6RW+w6pZ2+q
         h6nFojV7gP0EWdkm/jGDRUrLFLEgaJh0PQExs508KRBLlx6TlVndCnkJ4hQY1RRYiouA
         WXNw==
X-Forwarded-Encrypted: i=1; AJvYcCUNgPbZK7tqJHpx31z2PU6LpFr9JvEWQFxSJtbmEbEo0IY9Ac1xw1h9najfnffQSaghmHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxZ1atTDvItIXfz8pR4ksSmQp0bWa0a6oC1TZXAeKVuI/Zjxiu
	Lr49zMi6qldt4mP9uldd967mYgbGtzIyiAAZlBwxEwibrplU1DM3vC3FB9h69/993BU=
X-Gm-Gg: ASbGncuZdjk0EXSn7IIfnGKFihnlxNyMVWxE4n36lmKoddTJqlMPLkY4+t/Ygydxabv
	rNpbIeZF9D69nz9Bqb/1J4oYXBJwyiVi6JivD5eKS0UWYoFptHeHsM1eRjiuKQeuvODPkSbe+Z4
	roMROxrNoQ7kzzH/SrUNdIxxAsoo/dyDThWQLmuugt7a4lbs4haZ/aLeTreTCsaBts1N5vy1P1P
	IGNymfcoM1gB+dTFhHBaavdPh6FkLnRFp48Zmk9icOvhke7HAaMqYt0P3elk23kus9HN5mCVltO
	3K+KhFjZUnttw9HFqFpcke23AIsMmpav9MvMvRi5HaOg5Owlt2RcTr27wlI9iSEqvET43zBL56P
	YFYU/hU8Uk1xCXkix8cvF4wrct7rUjtJBKPShOfSlvE9e88kHchJSBlO8PFjbhbKiNwPM1I7wEv
	PJtusTZORNHlHmohpH4A44MqIhGN388HVDDUcZkQZWu/6Q4xs1GMJWZSaWef53Z4YN9x63np0UK
	OoyEs/7znH+CBerCidRmgfhSaG2
X-Google-Smtp-Source: AGHT+IGor+0TBMha8qJ09befVaq8yoaVBWoMTC8Za+zh5A09IItdYyuOKljOxwukfsePSCSPy/7vkg==
X-Received: by 2002:a05:690e:134a:b0:63e:34ed:a131 with SMTP id 956f58d0204a3-63e34eda971mr7733830d50.31.1761092803612;
        Tue, 21 Oct 2025 17:26:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-63e267c6082sm3624986d50.14.2025.10.21.17.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:26:43 -0700 (PDT)
Date: Tue, 21 Oct 2025 20:26:42 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Toon Claes <toon@iotcl.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] last-modified: implement faster algorithm
Message-ID: <aPgkwnq87UeusC6v@nand.local>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <20251021-b4-toon-last-modified-faster-v2-1-f6dcbc26fc5c@iotcl.com>
 <xmqqy0p4uoqc.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy0p4uoqc.fsf@gitster.g>

On Tue, Oct 21, 2025 at 10:52:11AM -0700, Junio C Hamano wrote:
> > +		struct diff_filepair *fp = diff_queued_diff.queue[i];
> > +		size_t k = path_idx(lm, fp->two->path);
> > +		if (0 <= k && bitmap_get(active_c, k))
> > +			bitmap_set(lm->scratch, k);
> > +	}
>
> Earlier path_idx() wanted to signal an error by returning negative,
> but the type is size_t that is unsigned so it cannot do so.  We
> instead get
>
>     builtin/last-modified.c:307:23: error: comparison of unsigned expression in '>= 0' is always true [-Werror=type-limits]
>       307 |                 if (0 <= k && bitmap_get(active_c, k))
>           |                       ^~
>
> and in this case we actually deserve it (in the sense that this is
> not the fault of dogmatic trust in -Wsign-compare; this is caused by
> using size_t to count things).
>
> And the solution for this is *not* "size_t" -> "ssize_t", because
> ssize_t is not "store half the range of size_t with negative values
> reserved for something else like errors".  Its width can be much
> narrower (this came up in a separate thread very recently [*]).
> Instead we'd need something ugly like
>
> 	if (k != (size_t)-1 && bitmap_get(active_c, k))
>
> A quick band-aid patch to make it compile is attached at the end,
> but it does not try to address the root causes, which are abuse of
> size_t as count_t and religious use of "-Wsign-compare" [*].
>
>
> [Reference]
>
> * https://lore.kernel.org/git/9eafee4d-ea94-4382-ada0-58000d229d2e@gmail.com/
> * https://staticthinking.wordpress.com/2023/07/25/wsign-compare-is-garbage/

Yeah, this is a true positive. I was curious if GitHub's version of the
code also returned "-1" from a function whose return type is unsigned,
and in fact our version of this function (called diff2idx()) returns an
'int'.

Practically speaking that's probably OK, since we are unlikely to have
so many active paths anyway (or if we did, we'd likely have other
problems to deal with ;-)), but it is gross nonetheless.

I wonder if we should inline all of this into its own function and not
expose the bitmap index for a given path at all? Perhaps something like
the following (on top of Junio's other suggestions to get this compiling
under DEVELOPER=1):

--- 8< ---
diff --git a/builtin/last-modified.c b/builtin/last-modified.c
index e9050485a9..ce3ae4fb3d 100644
--- a/builtin/last-modified.c
+++ b/builtin/last-modified.c
@@ -226,13 +226,16 @@ static void last_modified_diff(struct diff_queue_struct *q,
 	}
 }

-static size_t path_idx(struct last_modified *lm, char *path)
+static void last_modified_mark_non_treesame(struct last_modified *lm,
+					    struct bitmap *active_c,
+					    char *path)
 {
 	struct last_modified_entry *ent;
 	ent = hashmap_get_entry_from_hash(&lm->paths, strhash(path), path,
 					  struct last_modified_entry, hashent);

-	return ent ? ent->diff_idx : -1;
+	if (ent && bitmap_get(active_c, ent->diff_idx))
+		bitmap_set(lm->scratch, ent->diff_idx);
 }

 static void pass_to_parent(struct last_modified *lm,
@@ -303,9 +306,7 @@ static void process_parent(struct last_modified *lm,
 	 */
 	for (i = 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *fp = diff_queued_diff.queue[i];
-		size_t k = path_idx(lm, fp->two->path);
-		if (0 <= k && bitmap_get(active_c, k))
-			bitmap_set(lm->scratch, k);
+		last_modified_mark_non_treesame(lm, active_c, fp->two->path);
 	}
 	for (i = 0; i < lm->all_paths_nr; i++) {
 		if (bitmap_get(active_c, i) && !bitmap_get(lm->scratch, i))
--- >8 ---

Thanks,
Taylor
