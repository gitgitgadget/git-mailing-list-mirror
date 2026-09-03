Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A73B71BD
	for <git@vger.kernel.org>; Thu,  3 Sep 2026 21:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472494; cv=none; b=aLBrNis0SXGAHW9yYmmxXlVki9pvGkE/3cRVFxVtoX6HO3OyF9Xr5a+HHkOmuG/8p/8yMJx2HjW+gTCXSDQDph+pKp3DldEamXDqX9k57J3NEamUb4AsjVRSUVdYygf4quiBvrJ07I6EK3wsyZYiJ10csCTPBlmJuxWw4Aki1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472494; c=relaxed/simple;
	bh=snljJhbNfWJIfx9ajl55/Tp9nlEVQf5yhZlPyT/RjIs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bw6g+2NH4hHc7h/f6e3xgv5Hcxx+22uE1MU5zFsHod1n6ZWXg1DoM56zoq7t3s3L3ZQISmLmi77S7LzqclwlqvKZADg/eXa5HSxhbc0L5uCnVOzzk+zHL4y5lE2KhY0IVN9/DdrcHyHA9xYYo5LiMsU+XFCpM/E0aLu1QfrbnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MMpeUQ8S; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMpeUQ8S"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92ed19f4d60so35200385a.0
        for <git@vger.kernel.org>; Thu, 03 Sep 2026 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788472492; x=1789077292; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=za6Q408wZTJo+Xiy3W2K5rx9nBvgLv9H8KhhGrXvPqo=;
        b=MMpeUQ8Softb+sIzFKm7oSsZHelzZEmixa9zv77PnClFj7Kx2/E2SzbfWRBsxi1W7C
         jOmGB/uK8tx60gKh3akUXeiZf88U54yTzUNiLD/nBZK8HK62BBwcrjXgUi8u40sjMbxE
         LHEraldA3Yyfq4fMQJknfy6cRNcCCUS3t3VwLw5zuucpCkep7WFYmiuymCfjjywdtMC4
         kI7JZB2HNLWsPyPBHHqF0p/f1fwcBhyC8pqsH/bw91Y3K/8m50/iemIC2/wOWlTjad2f
         3q4UWWndB8uH/GHh6xsvMVaBc5+6DJIoU1jFshCVO9ytVPc9JfHvLkoae6NlSA8E0u7z
         0VCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788472492; x=1789077292;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=za6Q408wZTJo+Xiy3W2K5rx9nBvgLv9H8KhhGrXvPqo=;
        b=GOgS+u1HKirtFyU57QVeVJe20k2HguqoVYMqrPZK1Nx1gEj/YjRFfUosEgcU/4+RL+
         dI4cePFoGao/s7chwEwDScBWJ4sWTkb1IUPPdoNRTwuBlVwoAXepdtAyJiGjn1wwaXjE
         Wr5PNiPYMFXvMUsTyTJwdqpSpA7PdDr+OaROsQxdpBdo5qqPvN63opCI6LXWdJf8GQHj
         gwBBHnqO4t5asNoOcZELK45aqWI6ybeDLH+IeeESOGbC3Q5o7TD1uO9EyKU7MGWTc7i5
         8NT5NKmGicXSQW7Rrf5CxQV6cxD9wXh+v0/8hAwjai/yGQCEoLFe0ddPeSZEi3tuGWUI
         KkPQ==
X-Gm-Message-State: AFuF++mYDAIFAunnCTz+d36FcL/yOw15s40gaD1MbO4EEsLqAoTDOQYj
	CFdI4C0LwE/3HSW82pHjHjWZ0dtP12QwX4HCqjS2SxUoUNqBic0Z0sg=
X-Gm-Gg: AYBFou2uNeYOAf8PEIFfLsuuHE/rgk4zS9OVIAY9H9cSSFdkyR04u/N1KDSPzM3X8P5
	Jqn1Q3QIcSTauIveKsBToiThR6YrWhpdHS7YkqPhUZqQgTQ6MLlTXd59ZXDRZfuq+5GRGf/6LMs
	VCAwUaEyqYZ4CbNG/GXnHzpaksQG+VpWcL7wmwwQXkgPrC5F3rytDxzeeJ9vkmUwhg9QJPTCKHK
	hDKn3kWPBQmSwsvo+g2FXwFCJ52kpOUT7zAOmQ88U9ErZDMTDVeZP9OEJZ7AbCD6b0zBGZLQoZT
	GrRHE8notarz8DzG8qqKNZM9pr6e6c8q6girVlx4N3rmiV47JzOl+rPEkYQGzAlkcm1Lstbtvwl
	nPQZwMKompwfytgVVAnQXL07JXlLlJPhAYWwBmZKOJws5Pmum/ysfMAkKFUFWVw0vrA3eO+K2/6
	KI1Cmj6tQxk3E4K3oo/Jw/iBKC5ys8Pi3Ey5hvAdPDPp8ofyRXNc+1ZAo=
X-Received: by 2002:a05:620a:6193:b0:939:72cb:bae3 with SMTP id af79cd13be357-93972cbbc8amr553459685a.26.1788472491656;
        Thu, 03 Sep 2026 14:54:51 -0700 (PDT)
Received: from localhost ([2600:4040:767f:b400:eef4:172d:17c7:db71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9397fbc9987sm62248485a.41.2026.09.03.14.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 14:54:48 -0700 (PDT)
From: Samuel Bronson <naesten@gmail.com>
To: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Cc: git@vger.kernel.org,  gitster@pobox.com,  christian.couder@gmail.com,
  siddharthasthana31@gmail.com,  ttaylorr@openai.com,  ps@pks.im,
  johannes.schindelin@gmx.de,  l.s.r@web.de
Subject: Re: [GSoC PATCH v5 6/6] builtin/repack: add guards for --drop-filtered
In-Reply-To: <20260813200830.84348-7-r.siddharth.shrimali@gmail.com>
	(Siddharth Shrimali's message of "Fri, 14 Aug 2026 01:38:30 +0530")
References: <20260810174047.6524-1-r.siddharth.shrimali@gmail.com>
	<20260813200830.84348-1-r.siddharth.shrimali@gmail.com>
	<20260813200830.84348-7-r.siddharth.shrimali@gmail.com>
Date: Thu, 03 Sep 2026 17:52:06 -0400
Message-ID: <s0vqzjavw8p.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain

Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:

> @@ -332,6 +361,29 @@ int cmd_repack(int argc,
>  		if (ret)
>  			goto cleanup;
>  
> +		/*
> +		 * Refuse to drop blobs that the current index references.
> +		 * Such a blob would only be lazily re-fetched by the next
> +		 * command that touches the worktree, so dropping it reclaims
> +		 * nothing. This guard just avoids that churn. Bare
> +		 * repositories have no index, so the check is skipped there.
> +		 */
> +		if (!is_bare_repository(repo) && oidset_size(&drop_oids)) {
> +			struct index_state *istate = repo->index;
> +			unsigned int i;
> +
> +			if (repo_read_index(repo) < 0)
> +				die(_("could not read the index"));
> +
> +			for (i = 0; i < istate->cache_nr; i++) {
> +				const struct cache_entry *ce = istate->cache[i];
> +
> +				if (oidset_contains(&drop_oids, &ce->oid))
> +					die(_("cannot drop '%s' (%s): it is referenced by the current index"),
> +						ce->name, oid_to_hex(&ce->oid));

The good news: I've tried this whole feature on a real repository and it
*seems* to work quite well on the whole.

I was able to greatly reduce the size of my llvm-project clone's object
databasev not originally cloned with --filter, using it.

The bad news: dying at this time is *not* convenient, especially after
we've finished that *entire* enumerate_promisor_blobs(), (which is kind
of slow for a step with no progress output, btw).

While I do want to keep the index blobs, I do *not* want to cancel the
whole operation over them.

The following seems much more convenient:

-- >8 --
Subject: [RFC] builtin/repack: just don't --drop-filtered index blobs

Instead of dying when we would drop a blob referenced by the index, just
... don't drop it. (Retain the explanatory message as a warning.)

This allows `git repack -a --filter=blob:limit=0 --drop-filtered` to
work in non-bare repositories that have non-trivial files around.

Not done:

  - Fixing the tests to match

  - Allowing `--filter=blob:none`

Signed-off-by: Samuel Bronson <naesten@gmail.com>


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=convenience.patch

diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..ab4471f740 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -378,8 +378,8 @@ int cmd_repack(int argc,
 			for (i = 0; i < istate->cache_nr; i++) {
 				const struct cache_entry *ce = istate->cache[i];
 
-				if (oidset_contains(&drop_oids, &ce->oid))
-					die(_("cannot drop '%s' (%s): it is referenced by the current index"),
+				if (oidset_remove(&drop_oids, &ce->oid))
+					warning(_("cannot drop '%s' (%s): it is referenced by the current index"),
 						ce->name, oid_to_hex(&ce->oid));
 			}
 		}

--=-=-=--
