Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEADD17980
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mB65s2qI"
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC3EB7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:53:10 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7a6fd18abso48682467b3.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698087189; x=1698691989; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QP/eSLe3TvX+P0Pscgv+fobu/SdsYG6DVHEVtcPUWW8=;
        b=mB65s2qIUxyQXsAEEaqedsHen+ha+D5w7e+RuJyXqDBa+1Akl6LbCiPYsguI2N447C
         hHHS6t4OUWCG8DwUfBjKvmHs8vYSRYDSEM0eUN5fwNM/FkpweABTEBRa0nVBgg0dsT9P
         SVQpE9se3HDd1JKMOiIobjMgYZI/+daz2VR8JZj4zouXAPPGKik2cvWKgzHUTs7ZnYrP
         hia9fB6nty8FgYy4imR1HfMnh1bybN6wHNklpxFNa1nG/b2E1UkEpVFgIo8+l4L5UGKp
         aUTiBqKMnpTVytg85Y9dW3VBpcCmTSmMh6dHCokw5KbuoLs3yCSwE+Gv9XcKJz2ADQE8
         y7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698087189; x=1698691989;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QP/eSLe3TvX+P0Pscgv+fobu/SdsYG6DVHEVtcPUWW8=;
        b=KUSWzSlgxvAoknRryMTK610F90aMDSbwQ8fHluxLmnCoChmFAM1DUUWMLGLsBMnCpl
         bMVhg/bUAGTdaOodhQdYADcTAz5y1wyuO6iEQOyrt7+xY+d5v8Zd746ss3dHnS2AE8/o
         eopveXd07ZGSHXzPVUDrJDXRJsCjgG56xNE2ttvmpIctMWJ2e/m5SREHMmONcZetJk5T
         dF/EqAXZw8kZFRgILwSxfz8ksnxOv1sv9fjJNImk9CoDUWdA7m8CcIjaLL1loKArd53B
         zxX4w2jfhaS5lyHL/gOrRR/gySvtdekYgA15UTmRiphBc8JGDoefZPempPhKpRyR3Ayv
         mmPg==
X-Gm-Message-State: AOJu0YxwP/jQ8x+QjdX0tnkPPOPiRJHjELYqfkqD0dydI4MgwkeRfTnt
	Wbdh+ZiqeU5Wd8NuYunGQGjc1j2aiamNbDWBGVAK
X-Google-Smtp-Source: AGHT+IF+Nn23PfenpwxxZgtBRLCw6J17rkBivU37Syt2siCb5++5WH6n722RwIUSGeP7Gc6OmJFu4fxXJkwNBI2ronrw
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:29f6:5cb7:f652:5c5e])
 (user=jonathantanmy job=sendgmr) by 2002:a81:9150:0:b0:59b:eb63:4beb with
 SMTP id i77-20020a819150000000b0059beb634bebmr227516ywg.7.1698087189572; Mon,
 23 Oct 2023 11:53:09 -0700 (PDT)
Date: Mon, 23 Oct 2023 11:53:07 -0700
In-Reply-To: <e59ca992d0566f793a07d78f3e65219b51239492.1695330852.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231023185307.996813-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 5/5] config-parse: split library out of config.[c|h]
From: Jonathan Tan <jonathantanmy@google.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org, calvinwan@google.com, 
	glencbz@gmail.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:
> From: Glen Choo <chooglen@google.com>
> 
> The config parsing machinery (besides "include" directives) is usable by
> programs other than Git - it works with any file written in Git config
> syntax (IOW it doesn't rely on 'core' Git features like a repository),
> and as of the series ending at 6e8e7981eb (config: pass source to
> config_parser_event_fn_t, 2023-06-28), it no longer relies on global
> state. Thus, we can and should start turning it into a library other
> programs can use.

Checking this with --color-moved looks good, but we'll need to take
another look once my comments about the earlier patches have been
addressed.
 
