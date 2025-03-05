Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E52D1FDA7A
	for <git@vger.kernel.org>; Wed,  5 Mar 2025 23:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741216379; cv=none; b=YiZh70i3CKJHYmwLEL/eWbsHlIMcmbpKlrwrmIbvLeMUXXMPVMQkFlSTnyu9uXsu0ixFMg7Na2dbVPbqqu6YEvxpdQ2gNmpEAT1BGw2RurLmzz67WwOnZbXDR53ORQl5DVOcMkJt593OueQhpjmw+326XDcuOY2sQjWzryWA6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741216379; c=relaxed/simple;
	bh=7aD7yc7hOTl+sMwSD3BJKZg2taZfUjPVqUYbkinIlHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bg1FGG3p9185gwwEpYKOq6C2OgO9jnzwjRGh9lEWh7p28tQNL/CI4RjCP/n7seHrh11ZLvHbpUr036DWwGE0/fUsCrBqJjnXbL7D4IK29h1ujCVe9TkDcYgOABGnZ13Osz1HUNAb31LYI9KkR23yiwKCdTcUc0CL9N9ewVXleaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=hQe495Yh; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="hQe495Yh"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e62d132a6a7so10846276.3
        for <git@vger.kernel.org>; Wed, 05 Mar 2025 15:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1741216376; x=1741821176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O/InRIqjNVZx/blpGUkK0n02HMR+7Ej6KHhfZv/3p+M=;
        b=hQe495Yh2PiK3Wef2ZNW1Bq6kNyYJMwonWh5MqaRK6yOh7m1eWcZzFq1hqzxbMwqEP
         DomUNbm11568XysZX2QFxF6ZtOPp3BFWDnKri1FVR06FUKVnhLxpGS77Fa1wCbgXGXFP
         9j7CaemIvrDwXXC3fEKePXWURWMpTP016fFSK1Z2AS2t/wX9cVh/lTFSEHAk0BpSFO8G
         SV1WIp+pCNdsnIlj/WWnq+pJ/c6Ctwy2YOPBdz7xD29ssP8Mcx9gNAzRj1hVG6FgjK5L
         K/8+yQUVSae/HAaTw7IhuS5iK52RKsj4OhmjcpWONl7orQQpqgLZ3OpZi6wH60cqN5Bx
         UFXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741216376; x=1741821176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/InRIqjNVZx/blpGUkK0n02HMR+7Ej6KHhfZv/3p+M=;
        b=i6608pv+X4r3XH4NRdtdmNQOORpXwASoZFW8qAVSZkI5CvtZ0zQhbVZYGQWox9t71f
         LRFzOw+xXyyhMtn9ZtD8qRruoI4FDXBDtIx/wmhCEsPQzOOlISQvtJA4qT18tNkIs7qr
         /YI2dCWqABrf3SvzeK2VOXzCy8l9C9cIf6FQiGgwKa1mEnpE2FhYohnYNMzW9eT06nfJ
         L9USo4hGdfQ0BFK6m954ETiUhge50yOd1z0fN4TCecpk+IVzAwDifF1/9gGWvGLA+yLf
         zK+3Yh+7psqVtYb6ox+zP2CnKfzYSr6W97ILw+H9Gg7tbHzymzVpkZgyhDXmvsr9EY9X
         dz8A==
X-Forwarded-Encrypted: i=1; AJvYcCVt0l5V4BcQpJxXUThtLOn/QCTkBg9+Lf2mBIJvVfHDJxkwIbQfRIbIsiYOsEDzmRNKvG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8DY3VhzoQg9KK+IeLyWog47t4mWP7TZtffYArxr0uGL7kUS/
	bMYpow2XRy7hgQX6I61EUUSisXVPR+TwBsnyE2ftfKc6hcCS7EHlls+9WITZRbc=
X-Gm-Gg: ASbGncuH94Nb/1mJ2HZRAFiFuTvTdb6Nar51ymAmdHle3/ZUfWheklDXq1qWYppYcRo
	61CtuJy39R0A6aroKR0kLe4FIWnBy164hDsLjpmyt36Q3oKD2jYeyzFaBb6kr/L6Sma+85XT//d
	IFxVm+kNM5IHNT4H0BDCtx8KEk1hiVigniwsuMXhhCPZEGDo0eQVNPocmu2XT4wL8LdAiK1maO8
	st49rtiGBvcjV9tXjVB9uhYp6ckIUjfDMoRQKNgry2WlkiIB7sHbV28z01J+0E3qKR67eadia3X
	p9anegAEpo1mH6GJi9Psy/Pm2hq+Eh5WxaFL3QeAjrp1OAw1qnuTHrfR4G6v2bQtTg4/Md/Y/F+
	uRLXFcmeqAFlqTJoh
X-Google-Smtp-Source: AGHT+IHXtrxbpEOdGffoUkdXGoEht0GbWRNvZb3nRnME+34dh00AcVA/CLsHHTVkyqT71QQ5pvJm+Q==
X-Received: by 2002:a05:6902:848:b0:e60:78b9:1502 with SMTP id 3f1490d57ef6-e611e1b8a1fmr6864116276.16.1741216376317;
        Wed, 05 Mar 2025 15:12:56 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-e634b8fdea7sm19468276.50.2025.03.05.15.12.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:12:55 -0800 (PST)
Date: Wed, 5 Mar 2025 18:12:54 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: SURA <surak8806@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: The transfer.hideRefs of the upload-pack process does not work
 properly
Message-ID: <Z8jadiyUj/U0TORF@nand.local>
References: <CAD6AYr-ZC32VNfUfMB63H-rQRfTdV=VQfBm67i2mG+6GDCNxkQ@mail.gmail.com>
 <Z8D/aiqN5e/aRSn7@nand.local>
 <CAD6AYr84KuBb5N-LVBQo-6Gq2Ms3JKQCk0gyO8i=N8gp3whe_Q@mail.gmail.com>
 <20250304075113.GD1283943@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304075113.GD1283943@coredump.intra.peff.net>

On Tue, Mar 04, 2025 at 02:51:13AM -0500, Jeff King wrote:
> On Fri, Feb 28, 2025 at 10:32:01AM +0800, SURA wrote:
>
> > My previous description was not clear enough. The early hiding
> > according to exclude_patterns in packed_ref_iterator_begin seems to be
> > designed for git for-each-ref's exclude. It is different from the
> > ref_hidden matching rule used by upload-pack.
>
> >From your reproduction, it looks like the issue is that for loose refs,
> asking for_each_ref() to exclude "refs/heads/foo" will not yield
> "refs/heads/foo/bar", but will yield "refs/heads/foo-bar".
>
> And that was true for packed-refs, too, before 59c35fac54
> (refs/packed-backend.c: implement jump lists to avoid excluded
> pattern(s), 2023-07-10). After that, packed-refs exclude both.

Thanks for the careful analysis. Since you and I co-wrote this feature
in the first place, naturally I agree with what you wrote here ;-).

> So probably the solution is for the jump list in 59c35fac54 to be
> pickier about finding its start/end points. It should insist on a
> trailing "/" (I think end-of-string would also be valid, but it may be
> easier to ignore that, and it is OK to err on the side of inclusion,
> since the caller is supposed to do their own filtering).
>
> Probably the logic needs to go into cmp_record_to_refname(), but I lack
> sufficient brain power at this time of night to even attempt a fix.

That is definitely one way to fix the issue, and the fix would look
something like the following:

--- 8< ---
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e..b137641f9d 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -326,7 +326,8 @@ static int cmp_packed_ref_records(const void *v1, const void *v2,
  * refname.
  */
 static int cmp_record_to_refname(const char *rec, const char *refname,
-                                int start, const struct snapshot *snapshot)
+                                int start, int strict,
+                                const struct snapshot *snapshot)
 {
        const char *r1 = rec + snapshot_hexsz(snapshot) + 1;
        const char *r2 = refname;
@@ -334,8 +335,11 @@ static int cmp_record_to_refname(const char *rec, const char *refname,
        while (1) {
                if (*r1 == '\n')
                        return *r2 ? -1 : 0;
-               if (!*r2)
+               if (!*r2) {
+                       if (strict && *r1 != '/')
+                               return 1;
                        return start ? 1 : -1;
+               }
                if (*r1 != *r2)
                        return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
                r1++;
--- >8 ---

I'm eliding some plumbing here to pass the "strict" flag through the
callers eventually all the way down to cmp_record_to_refname().

But I think this is equivalent to pretending like the excluded patterns
all end in a '/' character (if they weren't already like that to begin
with). So equivalently, you could do something like:

--- 8< ---
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index a7b6f74b6e..e4569519a1 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -1024,6 +1024,7 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
        size_t i, j;
        const char **pattern;
        struct jump_list_entry *last_disjoint;
+       struct strbuf buf = STRBUF_INIT;

        if (!excluded_patterns)
                return;
@@ -1043,8 +1044,13 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
                if (has_glob_special(*pattern))
                        continue;

-               start = find_reference_location(snapshot, *pattern, 0);
-               end = find_reference_location_end(snapshot, *pattern, 0);
+               strbuf_reset(&buf);
+               strbuf_addstr(&buf, *pattern);
+               if (buf.len && buf.buf[buf.len - 1] != '/')
+                       strbuf_addch(&buf, '/');
+
+               start = find_reference_location(snapshot, buf.buf, 0);
+               end = find_reference_location_end(snapshot, buf.buf, 0);

                if (start == end)
                        continue; /* nothing to jump over */
@@ -1061,7 +1067,7 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,
                 * Every entry in exclude_patterns has a meta-character,
                 * nothing to do here.
                 */
-               return;
+               goto out;
        }

        QSORT(iter->jump, iter->jump_nr, jump_list_entry_cmp);
@@ -1095,6 +1101,9 @@ static void populate_excluded_jump_list(struct packed_ref_iterator *iter,

        iter->jump_nr = j;
        iter->jump_cur = 0;
+
+out:
+       strbuf_release(&buf);
 }

 static struct ref_iterator *packed_ref_iterator_begin(
--- >8 ---

But then we have to handle the reftable case too, which Patrick gave a
potential fix to below. But equally fine I think would be to push this
^^ logic up into refs.c::refs_ref_iterator_begin(), which would fix both
at the same time.

> The smallest reproduction for me is:
>
>   git init
>   git commit --allow-empty -m foo
>   git pack-refs --all
>   git -c transfer.hiderefs=refs/he upload-pack .
>
> which shows "refs/heads/main" (or "master") before 59c35fac54, but not
> after.

Thanks, this was a very clean reproduction that made it much easier to
diagnose what was going on here ;-).

Thanks,
Taylor
