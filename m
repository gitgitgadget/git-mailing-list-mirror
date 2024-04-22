Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC763152523
	for <git@vger.kernel.org>; Mon, 22 Apr 2024 16:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803191; cv=none; b=WwVkN6ZI0YM0qHmZsUjLpqLvBuvLKilTjv0sFnTvtVmcdwDq7064sde284hIqSbnWZopBTTzNP52MoavsxsRhXFRO9S7Jzl0hsHagoCJh3fT0iI7ezHX6VhA6UWVsIqqDPrZMhs9T1fwUc4hSvATi77aJnKhfALVF4Qwvwmz0aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803191; c=relaxed/simple;
	bh=+wXIQi0XZxkg+EhvYUoZ9d15AKR2R9GyMKguH/RhsKg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PIomJkj3hE6/KKU17O9Jdvl92Xs9XyBhTPIjyU0wgLBlBUR2koN9SKhARp2FNpQAeUJWAQ46XiU/X9ZDyKKB5krEMwjh7J7jDsvi16X2Rn/fYgn3I48ArdpEkvdsRiZ7+3DcT2TIGHpE3RQ4gwsAUd2Frvojs97cCz6+ilPiugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFRnDjpn; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFRnDjpn"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b13ce3daaso114078527b3.0
        for <git@vger.kernel.org>; Mon, 22 Apr 2024 09:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713803189; x=1714407989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wovq2FdvUI5j0juo+9+BjxmgRhU7cLgdPupNPg0ZuKM=;
        b=XFRnDjpnyBJZlsShXJf/Fh8cST4ZyACune0Sqi43U6pRPcLy32aq6yi6vgjY7+wF8n
         4Glr6EsI0Y3QDqRZZUX3cGdDSoxBm18ZfTp9QK1JNRPG8SF/8FzBJ7Es3ZR5VMzGNLAy
         NFD2fwMKvTszo6mrkQE/z12HLJYo/Byj3+KCiNGOlZ92SJLFCM+1xtTo9NXS7gx/xlS7
         LPqBKJ80fhvhRzJk9xFgs5wm+Gtn145j4j7/x3JrutOEzjj1hAREM1VQYMUUOuNhqQFX
         GwzIn0zYfRNy845Zy6QF8g2x1reP35DnYhm8prLxQj3p7PfRqbouBE0QStc0UJbf8qak
         u7wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713803189; x=1714407989;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wovq2FdvUI5j0juo+9+BjxmgRhU7cLgdPupNPg0ZuKM=;
        b=rRBdtzsdigMhEJ/lzZ3hMHnhQa8m8uRAmXf1qkhy+q5jWRxtv8tDnshnMcT1r+mYsg
         ZSqCxKZlktzXzV1o4N0Ly479Pd5TehP/DcwkEr1frTTjuCnXuJcfFdzzFTRm7OstQF5U
         aQdtfv91Kx58u/OyH1T9LiqPR+gf8507Z5dZD4ckKmiKTKarMDg3cVSLe+wHDuzaPnOo
         HKgQFzMmQ4larWA4AbsHrEZRCGgM/jty/xkfnaxiLkzgqqCpEb5JkkCFXUIMHpHUTfUh
         Z5SQ3CAO3baXCp4ApTFXS+OXFn2orviBWU1SrkLLFWhVS1PFVJTElEJZ/U5GPTDVytRj
         1Acw==
X-Gm-Message-State: AOJu0Yzjzc+VLZDoi7eO2HwJSVO8oYiyAfU5u4xqqJ4hECMaYlZViiQZ
	HA1wh0gRpzdCoAt+TM3IB7Gi3v8JnO+ifL1MgfmCPIRPEX9ET2NPy8AQi8aENmj6tU+kt9iHp1Y
	YtmAy1JQU7TKirw==
X-Google-Smtp-Source: AGHT+IESqSpp5ma/78Ae3WVtjAOwkUmTVUcX2RCk1+KUEHfGolTDRqNLvwW6QfhRDWhOrB69Gcelkjxwu2OWnkY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:4e04:0:b0:618:92c6:64b1 with SMTP id
 c4-20020a814e04000000b0061892c664b1mr2557855ywb.3.1713803188982; Mon, 22 Apr
 2024 09:26:28 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:26:17 +0000
In-Reply-To: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240422162617.308366-1-calvinwan@google.com>
Subject: Re: [RFD] Libification proposal: separate internal and external interfaces
From: Calvin Wan <calvinwan@google.com>
To: Calvin Wan <calvinwan@google.com>
Cc: Git Mailing List <git@vger.kernel.org>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	rsbecker@nexbridge.com, phillip.wood@dunelm.org.uk, 
	Kyle Lippincott <spectral@google.com>, Josh Steadmon <steadmon@google.com>, 
	Emily Shaffer <nasamuffin@google.com>, Enrico Mrass <emrass@google.com>
Content-Type: text/plain; charset="UTF-8"

Thanks everyone for your initial comments on this discussion. I wanted
to provide some examples of how an internal/external interface could
look in practice -- originally I had intended to use git-std-lib v6 as
that example, but found that it fell short due to feedback that only
being able to expose a smaller subset of functions in that library would
be insufficient for users since they should have the same tools that we
have for building Git. In this reply, I have two examples of paths
forward that such an interface could look like for future libraries
(both methods would require a non-trivial amount of code change so this
seemed like a better idea than completely refactoring git-std-lib twice).

Part of the reason for wanting to expose a smaller subset of library
functions initially was to avoid having to expose functions that do
things a library function shouldn't, mainly those with die() calls. I
chose `strbuf_grow()` as the example function to be libified with an
internal/external interface since it has a die() call and in a library,
we would want to pass that error up rather than die()ing. I have two
ideas for how such an interface could look. For reference, this is how
`strbuf_grow()` currently looks:

void strbuf_grow(struct strbuf *sb, size_t extra)
{
	int new_buf = !sb->alloc;
	if (unsigned_add_overflows(extra, 1) ||
	    unsigned_add_overflows(sb->len, extra + 1))
		die("you want to use way too much memory");
	if (new_buf)
		sb->buf = NULL;
	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
	if (new_buf)
		sb->buf[0] = '\0';
}

The first idea involves turning `strbuf_grow()` into a wrapper function
that invokes its equivalent library function, eg.
`libgit_strbuf_grow()`:

int libgit_strbuf_grow(struct strbuf *sb, size_t extra)
{
	int new_buf = !sb->alloc;
	if (unsigned_add_overflows(extra, 1) ||
	    unsigned_add_overflows(sb->len, extra + 1))
		return -1;
	if (new_buf)
		sb->buf = NULL;
	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
	if (new_buf)
		sb->buf[0] = '\0';
        return 0;
}

void strbuf_grow(struct strbuf *sb, size_t extra)
{
        if (libgit_strbuf_grow(sb, extra))
                die("you want to use way too much memory");
}

(Note a context object could also be added as a parameter to
`libgit_strbuf_grow()` for error messages and possibly global variables.)

In this scenario, we would be exposing `libgit_strbuf_grow()` to
external consumers of the library, while not having to refactor internal
uses of `strbuf_grow()`. This method would reduce initial churn within
the codebase, however, we would want to eventually get rid of
`strbuf_grow()` and use `libgit_strbuf_grow()` internally as well. I
envision that it would be easier to remove die()'s all at once, from top
down, once libification has progressed further since top level callers
do not have to worry about refactoring any callers to accomodate passing
up error messages/codes. 

The shortfall of this approach is that we'd be carrying two different
functions for every library function until we are able to remove all of
them. It would also create additional toil for Git contributors to
figure out which version of the function should be used.

The second idea removes the need for two different functions by removing
the wrapper function and instead refactoring all callers of
`strbuf_grow()` (and subsequently callers of other library functions).

int libgit_strbuf_grow(struct strbuf *sb, size_t extra)
{
	int new_buf = !sb->alloc;
	if (unsigned_add_overflows(extra, 1) ||
	    unsigned_add_overflows(sb->len, extra + 1))
		return -1;
	if (new_buf)
		sb->buf = NULL;
	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
	if (new_buf)
		sb->buf[0] = '\0';
        return 0;
}

void strbuf_grow_caller() {
	strbuf *sb;
	size_t extra;

	// if only success/failure is passed up
	if (libgit_strbuf_grow(sb, extra))
                die("you want to use way too much memory");
	
	// if context object is used
	if (libgit_strbuf_grow(sb, extra, context_obj))
                die(context_obj->error_msg);
	
	// if there are multiple error codes that can be passed up
	if (libgit_strbuf_grow(sb, extra) == -1)
                die("you want to use way too much memory");
	else if (libgit_strbuf_grow(sb, extra) == -2)
		die("some other error");
}

One shortcoming of this approach is the need to refactor all callers of
library functions, but that can be handled better and the churn made
more visible with a coccinelle patch. Another shortcoming is the need
for lengthier code blocks whenever calling a library function, however,
it could also be seen as a benefit since the caller would understand the
function can die(). These error messages would also ideally be passed up
as well in the future rather than die()ing.

While I tried to find a solution that avoided the shortcomings of both
approaches, I think that answer simply does not exist so the ideas above
are what I believe to be the least disruptive options. I'm wondering
which interface would be more suitable, and also open to hearing if
there are any other ideas!
