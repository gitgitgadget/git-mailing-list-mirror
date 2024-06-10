Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B2B63D0
	for <git@vger.kernel.org>; Mon, 10 Jun 2024 22:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718056924; cv=none; b=lHO1RXwN/x6oqVO7inwUAR2YgEiVOZWprqzolRprLm4qR2yqtPvL+g+FsVrCLAxh+SWA+oICq/wCmdFxA5wpPEjGVV/ce9VObHXfpQqbkiFP6JkamZjVpzqOYnpGNuYg74zjNnNal9uqvAcHHgtlqNy58xBOyZxwIZ39ci/85Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718056924; c=relaxed/simple;
	bh=WB9z4w2wf+plca8l90Bszwf938S8euC8BMqMspU/bjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CEyxjXHZSdPqyuc33ZbdZsAY9Gp4UZaMqi9+gyMRrfGWvEqQcTLL9at8MOcjEa5kL5MJuNhqiKHP6YRtGIhpQZ9dWVAQx9sqTlfgQuKsvoN3TfATsU7tK52M1r5RKzH6LGCRv8BkFNNygv13ny9VHSQwb3CWJbl42OGOiovcNgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9anpDEQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9anpDEQ"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f717ee193fso3023805ad.0
        for <git@vger.kernel.org>; Mon, 10 Jun 2024 15:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718056923; x=1718661723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hvkj7ENiKdXDEimpy/VRmQhwEDphtoVyQ0y+sYcQvL0=;
        b=E9anpDEQxaQKg7KpFErzffG3qgZCMT/GS7pA5HFdlVQoGRH4FKCMavhTm64gSpqWrZ
         fqdheT/ZAq/lqYgWInkFmz8ibUnObZTCQBrj1/FWFqKVVS8i/46+M9OT1N12MR49i85w
         DdIHDQ4DhE6SO1btiq2GLn+1NSMTBgkhq8gNCSJH0QYENZoISRGj4VlqEGlumYeRCgJj
         BWmQCOCyUhvhvH3/stAc8EgHjg3Ni7sFvIl4utOJdbkpExvARusCffFn4EKz6FmkGt/1
         P9EeIF6Rk7LazMA5D693f0z6hCEzZvc5oyLXWjCNiXVi0vhcU4LLTjQXBgjEj0CwfiNb
         MzYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718056923; x=1718661723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hvkj7ENiKdXDEimpy/VRmQhwEDphtoVyQ0y+sYcQvL0=;
        b=GiPR7dwEon5dRheN5p4KvWFhrxMBm4XaP9rS3Hedz9EXNUvZ6U8gFJyGa0A4vo01MS
         9QhS9iPYMMZdzkTXn3dbMdlWY5ieYV2qKjkbaxqvAW12MV0KZKVXrEphZSJ5sjSavcKE
         tEGIJkgBQSJp1xKNvzCAi4AotfTiMiSY3WcAkmXk87KV/pqRVoG17FZd5vzaZsXWwLyB
         etWugPvQOQQKVtlF5N6k7yWE3/p1+E+T7gbgAX2Y4vsQh8a1ZDHLMl9RjPrh8zjr6+ig
         EOUzN+WXdBvY3NCyPPCur4mCC5xJAIQEfarYeezns0N5Fev8GAFw7G7caXyFmSp+IJzu
         rtxg==
X-Gm-Message-State: AOJu0Ywg7KEBQslSC52w5DiYeIJi/Lgn+Bt6ieLEUOPZ04aKCNl1Gkh4
	uQopuKYMzDgcNZzdK0eK+dMgMWJFPHAQiKqFyHLFeFXrDBgHnsfM
X-Google-Smtp-Source: AGHT+IEXb7N16rwHZkpGH+J6B4xlNOT5Nl/UfnfbEqSSbFXbfy5fQQumpuZLdvJpW7fHwFSmVgGF9A==
X-Received: by 2002:a17:903:22c5:b0:1f7:13b1:7530 with SMTP id d9443c01a7336-1f713b177d5mr59521655ad.0.1718056922411;
        Mon, 10 Jun 2024 15:02:02 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76c1d2sm87351315ad.107.2024.06.10.15.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 15:02:02 -0700 (PDT)
Date: Tue, 11 Jun 2024 03:31:59 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: Re: [GSoC][PATCH v2] t/: migrate helper/test-oidtree.c to
 unit-tests/t-oidtree.c
Message-ID: <7o6fuymnfn6b6buyw3yyctjd4dlwlrazspv3xgxvys6djjivxh@qbhyurorgbtt>
References: <20240605134400.37309-1-shyamthakkar001@gmail.com>
 <20240608165731.29467-1-shyamthakkar001@gmail.com>
 <xmqqed944uq7.fsf@gitster.g>
 <72dncmhj2qt6ufh67gbj3ctnwnssnlc3w22x77chcigzxou36f@mnwnrwg4oo5r>
 <xmqqr0d4zevq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0d4zevq.fsf@gitster.g>

On Mon, 10 Jun 2024, Junio C Hamano <gitster@pobox.com> wrote:
> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> 
> > On Mon, 10 Jun 2024, Junio C Hamano <gitster@pobox.com> wrote:
> >> Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:
> >> 
> >> > helper/test-oidtree.c along with t0069-oidtree.sh test the oidtree.h
> >> > library, which is a wrapper around crit-bit tree. Migrate them to
> >> > the unit testing framework for better debugging and runtime
> >> > performance. Along with the migration, add an extra check for
> >> > oidtree_each() test, which showcases how multiple expected matches can
> >> > be given to check_each() helper.
> >> > ...
> >> 
> >> Use "LAST_ARG_MUST_BE_NULL" here, probably.
> >> > +static void check_each(struct oidtree *ot, char *query, ...)
> >
> > I see that you already made this change in merge-fix/gt/unit-test-oidtree.
> > Thanks for that.
> 
> That is merely tentative.  LAST_ARG_MUST_BE_NULL must be on the base
> topic, as it is not something that suddenly becomes required after
> getting merged to the integration branch (unlike other changes in
> the merge-fix which became necessary in the world order after Patrick's
> const string fixes are merged).
> 
> I do not know what other fixes are needed, and if there is nothing
> else that needs to be done in gt/unit-test-oidtree topic, I can do
> "git commit --amend" before merging it to 'next' (unless I forget,
> that is ;-)), but if you are rerolling, please do not forget to add
> that (you do not need to do the constness changes, which will require
> you to rebase on top of whatever contains Patrick's work).

Yeah, I'll reroll as rebasing on 'ps/no-writable-strings' did produce some
errors but the change required was minimal, so I'll include it anyway:

diff --git a/t/unit-tests/t-oidtree.c b/t/unit-tests/t-oidtree.c
index cecefde899..a38754b066 100644
--- a/t/unit-tests/t-oidtree.c
+++ b/t/unit-tests/t-oidtree.c
@@ -62,7 +62,7 @@ static enum cb_next check_each_cb(const struct object_id *oid, void *data)
 }

 LAST_ARG_MUST_BE_NULL
-static void check_each(struct oidtree *ot, char *query, ...)
+static void check_each(struct oidtree *ot, const char *query, ...)
 {
        struct object_id oid;
        struct expected_hex_iter hex_iter = { .expected_hexes = STRVEC_INIT,

Thanks.
