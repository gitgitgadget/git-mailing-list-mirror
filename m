Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5750536607F
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774202986; cv=none; b=CPHz5taeDUJOCwDZySHRlAwmhp0rbt2Lo+H3l8Rw8I/sn94+J6SjDQMG9v2jSEMhLvB8f0cgcvV+0TYCqw5/sj2oCVD/h3iH1K1RvJ+kGuzNq6igv1biYUbKrYY0VstwMB1cpo/FzZBA5PP2DR6QfQcEXdgzIk1225YvCcfQiPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774202986; c=relaxed/simple;
	bh=n8+gMdyARta3lNKpSEsMUV/C9ezVKXvFHVbWKoSaHtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GGSGgWZoLAiHwVyeMhJ2RjllVqmV/fpaihPdg6WkVffbagAX0tyK1lkW7s+DxrQu+jRm5Q4oGhwVT9L1kDMDdN9w7/9fzk17IwTvhJB+teCQJcCcL8wGkxcox2bHauG/tQg64T/+hYVoGx7xzcoKFfe260cDISG2N87Nwu5HKQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=gYNBNzsT; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="gYNBNzsT"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64eaf8aa893so1550274d50.3
        for <git@vger.kernel.org>; Sun, 22 Mar 2026 11:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1774202984; x=1774807784; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Z8k7JAH/XQ838YQWBuRsnr3o0L2fQA9uOMNMaTH4ro=;
        b=gYNBNzsTCDoXjilWlshJbjdUWRyDYXZP5oiqVmcx2ssV8kwQHzn3npQM5pVfDPPqA8
         BK1bHDw6Y7tY3YxWZZ16/EKI7MSG4ZrfMFue1ohWbaSR2GWCIPf02FdfSmH7l3tzVbu1
         u0ZR9BFE7ZR6oYKae7pJug6STyLXtVrx+qqxHkpkE91fuZgd9cz4uCju0GncmNSaBlc0
         hJfzezzw+pE02FGEGKDU5SmkIpbFuy0sGIgBNnHlx9a0OuJa2ds2l+wqGY4a2KZ4u7M4
         j8rIEBpiqMYZFy/I01Ed4ng1r4rVteNRkJ+P2xjg7cFoJfxl1fNNt7sYm/hLuYViiSLu
         YyqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774202984; x=1774807784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Z8k7JAH/XQ838YQWBuRsnr3o0L2fQA9uOMNMaTH4ro=;
        b=RJBFwPsNnWVrO0tRCK40WgVUT/vIsezf3Z1WL/CU3ti3fZGvni2FZFueTm5QSY5rMJ
         fCmo8dNT9dBBoAAzh4zLETDrSGp8MCvC7uMGejkI62w3VjSqKZU2yEJTdUi4+WUAUXkX
         kE9lPHalt+T+LZpO2tiNgPOH3YRPjAkiTHENPhowBIRhZWs6Q3/kaeQbbh2EDAn8KpHd
         pCSarYKzmidR+33EwDio0MwCO3dNxAzrANRABFvRWlNbAs2VEeF8kMacRKVcEGooFfzK
         ba/N/XiV6/A3KuQ3DS6M0BHg2MDSyjljVv916uY4pLPf0aLe3xLLCyMujmZg6fqJ5URl
         Ziqg==
X-Gm-Message-State: AOJu0YyL187aTzUavXokyzk0w6gjbkxw8GbPbQRT5gA2bmN+GjIwVdS7
	JI1/0KxF3Pf93wnSYw+IApzVuFlHm2MtnrmvDPRXBsxgSF7z4Z+aHdZCIr0/Hr0jo+0=
X-Gm-Gg: ATEYQzxMXre3DtxlXQJQMX8CRlM2aUqI9JWTgrCVLyXXXdyeNssVYJ0k2DVsjXXyPD3
	5YLPglB4uQFAXpfndLTotTdiOczcyvkhypJ770z2YDUZva+svo+zTa3FIah2gn9Zz+hYo4XPOWD
	2PMnqxE9sQkerh66pW75BsCPi+4VY8UNgV5pYkHEBGFCSq94kevn1blMUkwlaSQBnWFs37luHXy
	rQLm6jmk/ie76YjMqtGqU/vaQG8ubqKfRSytEKY3lxUpu7OkPpSX7QjM8zV8ED5+QdiayBa1WL5
	GvD6h3LKpuoEaRqfPURy48M9VCEe/ORcLoMmXG0qeL15iHZuMJR0ojUXuRRWwBb7p2iKeu4ida2
	B1/pNuBLk4luOo+SpPVjUA+Op94UE3xw2K4SFIl5KQlTV5vTo7p9o68jfVfMOfN+kNPj4bg2o40
	KY10K4RvnPtqnzkEzMdo3BU604MSRsxnUqraGlVYuWyYDATXK4KnU1XEbKH/nO4l5CbNLfClrft
	Rbdo7bqjA/xEZC5RGXRGGzxZcuk7Q==
X-Received: by 2002:a05:690c:d96:b0:792:7828:b709 with SMTP id 00721157ae682-79a90af0022mr104443737b3.22.1774202984300;
        Sun, 22 Mar 2026 11:09:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79a903a294fsm46100957b3.8.2026.03.22.11.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 11:09:43 -0700 (PDT)
Date: Sun, 22 Mar 2026 14:09:43 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 4/5] pack-objects: support excluded-open packs with
 --stdin-packs
Message-ID: <acAwZ1ARhvsTSpO5@nand.local>
References: <cover.1773959041.git.me@ttaylorr.com>
 <bd78919e19cfa968556ad4241391120ed56e9dce.1773959041.git.me@ttaylorr.com>
 <20260321165711.GA718452@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260321165711.GA718452@coredump.intra.peff.net>

On Sat, Mar 21, 2026 at 12:57:11PM -0400, Jeff King wrote:
> On Thu, Mar 19, 2026 at 06:24:25PM -0400, Taylor Blau wrote:
>
> > @@ -3750,8 +3756,6 @@ static int add_object_entry_from_pack(const struct object_id *oid,
> >  		return 0;
> >
> >  	ofs = nth_packed_object_offset(p, pos);
> > -	if (!want_object_in_pack(oid, 0, &p, &ofs))
> > -		return 0;
> >
> >  	if (p) {
> >  		struct object_info oi = OBJECT_INFO_INIT;
>
> I haven't read all of the patches carefully yet, but Coverity observed
> that without this call to want_object_in_pack(), we are left with "p"
> that came from the caller. If that "p" is ever NULL, then the
> nth_packed_object_offset() call above will segfault. But if it is not,
> then the "if (p)" below is pointless.
>
> AFAICT it will never be NULL, and the conditional is now pointless. But
> it wasn't before your patch, since want_object_in_pack() may set the
> found_pack to NULL if the object is not wanted.

I think that's right. Looking through the code again, the "if (p)"
conditional is indeed no longer useful, since the sole caller of this
function (the callback to `for_each_object_in_pack()`) will always pass
a non-NULL `p` pointer.

It's tempting to add something like:

    if (!p)
        BUG("add_object_entry_from_pack: expected non-NULL pack");

But I wonder if we should instead store the result of calling
`want_object_in_pack()` into a separate variable, only creating an
object entry if "want == 1". That would have the effect of *not* marking
objects as traversal tips if want_object_in_pack() makes `p` NULL.

I think that's OK, since what we really care about is having objects in
both included and excluded-open packs being processed as traversal tips.
Because we're enumerating only objects that are in included and
excluded-open packs:

 * Objects in excluded-open packs will cause `want_found_object()` to
   return 0, propagating that through `want_object_in_pack()` without
   setting "p" to NULL. We'll process these objects as traversal tips,
   but not create an object entry for them, which is what we want.

 * Objects in included packs will return -1 from `want_found_object()`,
   causing us to NULL out "p" and search through other packs. If we find
   another pack containing that object, then we'll set "p" to that pack
   and return 1, otherwise we'll return 0 if no such pack is found.

I think that's the right behavior, so doing something like this instead:

--- 8< ---
@@ -3742,6 +3749,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 {
 	off_t ofs;
 	enum object_type type = OBJ_NONE;
+	int want;

 	display_progress(progress_state, ++nr_seen);

@@ -3749,8 +3757,7 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		return 0;

 	ofs = nth_packed_object_offset(p, pos);
-	if (!want_object_in_pack(oid, 0, &p, &ofs))
-		return 0;
+	want = want_object_in_pack(oid, 0, &p, &ofs);

 	if (p) {
 		struct object_info oi = OBJECT_INFO_INIT;
@@ -3762,8 +3769,16 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		} else if (type == OBJ_COMMIT) {
 			struct rev_info *revs = _data;
 			/*
-			 * commits in included packs are used as starting points for the
-			 * subsequent revision walk
+			 * commits in included packs are used as starting points
+			 * for the subsequent revision walk
+			 *
+			 * Note that we do want to walk through commits that are
+			 * present in excluded-open ('!') packs to pick up any
+			 * objects reachable from them not present in the
+			 * excluded-closed ('^') packs.
+			 *
+			 * However, we'll only add those objects to the packing
+			 * list after checking `want_object_in_pack()` below.
 			 */
 			add_pending_oid(revs, NULL, oid, 0);
 		}
@@ -3771,7 +3786,8 @@ static int add_object_entry_from_pack(const struct object_id *oid,
 		stdin_packs_found_nr++;
 	}

-	create_object_entry(oid, type, 0, 0, 0, p, ofs);
+	if (want)
+		create_object_entry(oid, type, 0, 0, 0, p, ofs);

 	return 0;
 }
--- >8 ---

may be more readable. I can't shake the feeling that there is some
important case that this is missing, though, what do you think?

Thanks,
Taylor
