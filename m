Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF6290F
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 04:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754628071; cv=none; b=GYaZwgKX5BNM2ABF7dVfD87oWVJmQkT9d9lAqN6fF13fnOeQgMxNm0FOs4TuUwQ2Qi8F0iPuulfucM7QzJRUM/5nqcvyQtsru63SoUaTM9WcTEA1Ne4yOBwSl5sCc8a1lmrYel8cEG5hlbYk0i3AZB2+2MA72hxl0Nw5bfeLcEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754628071; c=relaxed/simple;
	bh=kD7PITPXc1VEB+Ua1fSrShGoBBmAxAKCvciiqmkKMxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XCQRoeQuLcSc4MBjd85ONUGShynBnNNKOlJgSds5abHJlQaUrZciDaON3k8Utr/hyzTs1+FnFDPlFx685kQVZR76c6Kf46bsfKLClDbWc1tAfhmG+5HHvNyCC3sVFQog6dafCovgqA4bU3T0zMyfvBwqAM7T3MfVcKISBgFYhCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/HLojxd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/HLojxd"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b3f2ea2f96fso306762a12.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 21:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754628069; x=1755232869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HmkLKTXZ8+XJxEXEEQ7UtDbTS/qv/eXprzy44qZGCfc=;
        b=S/HLojxdQ3HIlmogxtVxe48PcHEvDpvLnik+ubQxEwHFVGbrHB2r4PSVwjs3IvQ4RF
         LjB6N7UdIyZot3I9KcTs4r+JztGAOlCLSfRp8i8XJOybolbDFHaMQFL1hMAilLixUoHQ
         rQKWJndo6H6T1NMoSHtl29gJoYNcLG3m8vHw0Gvf0gOnIrKnZfmgYtIDBcrvYKmri2Gs
         P/OmgcrdzbImhfWqZvI5vIEUDRJKAERMOfRVwFL46CnJIW4E1sZmPSPwXuzQWlnZOO3a
         sauB8HcUCw97JZ+GJzVB4MElWS2LFyeTKfMCHh2/lBVxP5ABcbtZBTyTcV9PWu4WD5Yc
         KQOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754628069; x=1755232869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmkLKTXZ8+XJxEXEEQ7UtDbTS/qv/eXprzy44qZGCfc=;
        b=kFQa2vzQa8zToNyq++qClXz7VZye5k5mjZ0tlb4FSQrDzXQW/L2OhJv7bDaKCmFWzL
         pticlJmmPfBATo8+w0vug9QzJoSAMynuSyJlF3lows/NlZ+tV33mG5HbvebRPp9hA1mu
         KakEPP9aQdBxoYTHJws1XwV4NFjZJs0JoV9xYSQIhXrUdoX28jF+l/aO1sFf0yA/J7jY
         BbLxMwWZ9Buvt9uohNOaPdwfixCjHJibpxjF9cmbIBQ+hLRqOQGHlhKiqJPPlFhzC3dL
         j4Htr8BDi52LyAMKGeuQOEz1viTMmpakzdhzHUtaZlLKu9VYbnvHDNTWB0WDQMHUHhnN
         bOtw==
X-Gm-Message-State: AOJu0Yyp1H4HolwAgewXczawv8YzrO6mgw457rYmWfwNHUlkG/aFV7G+
	6x0N7puoMdz3eMYXhBSW+9uNICIMgLOGGIj7P/97XHfPsBQRvgLMWHsBk17nxw==
X-Gm-Gg: ASbGnctQ5sZe1t5FOKCItMixk7kMbmcCM1pRu58YMS47mvcEbHliIWh3RKycZqCH+dq
	tz3ugkf30JqcA2Oj+tVA0ftQqRzJHljkTqUhdvaEVRoxysEHUoLLJ/ZnnX1vtyJh30N9FZrQx0p
	5mKzjfSldsL9e0PwdibABGU5q7Xoa4Gvd90qQ8fZPBxZflTaZLqoYKm9CeIPdhSFsLcPE1P9Uus
	4rS/GD+HS0e5JtYe0w16wWzcY+wERWygrz2vdJn9BiL7JdHYiwGxa0sebxb9LkkqkVvbaEa85dB
	kTrXZU4Jdf2MN3feR2wQUTEAornbAUfWZh/k+ASd0iR/EGW+dVnyH63APjE8RWN+fMm4S5dhEbC
	goWe+PhO1TzhbLzZ2NTeTiTlbzuGcmg==
X-Google-Smtp-Source: AGHT+IHuOJncPTOqqXFSh6Rf2hciHA5p9D2y2MyBKBITP7+fG4l06CqHyC70Wsu063kNfkrXDRydHA==
X-Received: by 2002:a17:90b:33c1:b0:31e:bb42:c463 with SMTP id 98e67ed59e1d1-321839def0cmr1169466a91.2.1754628068910;
        Thu, 07 Aug 2025 21:41:08 -0700 (PDT)
Received: from generichostname ([2601:645:8300:3b10:e54:15ff:fe8e:caa6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32102b2c24fsm9752923a91.3.2025.08.07.21.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 21:41:08 -0700 (PDT)
Date: Thu, 7 Aug 2025 21:41:06 -0700
From: Denton Liu <liu.denton@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 0/3] remote.c: remove erroneous BUG case
Message-ID: <cover.1754627874.git.liu.denton@gmail.com>
References: <cover.1754455931.git.liu.denton@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1754455931.git.liu.denton@gmail.com>

In the case where one pushes a non-existent oid to an unqualified
destination, we encounter the following BUG

	error: The destination you provided is not a full refname (i.e.,
	starting with "refs/"). We tried to guess what you meant by:

	- Looking for a ref that matches 'branch' on the remote side.
	- Checking if the <src> being pushed ('0000000000000000000000000000000000000001')
	  is a ref in "refs/{heads,tags}/". If so we add a corresponding
	  refs/{heads,tags}/ prefix on the remote side.

	Neither worked, so we gave up. You must fully qualify the ref.
	BUG: remote.c:1221: '0000000000000000000000000000000000000001' should be commit/tag/tree/blob, is '-1'
	fatal: the remote end hung up unexpectedly
	Aborted (core dumped)

However, this isn't actually a bug so replace it with an advise()
message.

Changes since v3:

* Include the switch statement refactoring patch as a prelude to the
  functional patch
* Change "if-else tower" to "if-else ladder"
* Shortened the overly long advise() line
* Rebased on latest 'master' to avoid merge conflict introduced earlier
  in the merge cycle (this should be fine since we haven't merged to
  'next' yet right?)

Changes since v2:

* Add t5516 cleanup patch
* Squash test creation patch into the patch that fixes it
* Include the erroneous object ID in the advise message

Denton Liu (3):
  t5516: remove surrounding empty lines in test bodies
  remote.c: convert if-else ladder to switch
  remote.c: remove BUG in show_push_unqualified_ref_name_error()

 remote.c              | 24 +++++++++++--------
 t/t5516-fetch-push.sh | 54 ++++---------------------------------------
 2 files changed, 19 insertions(+), 59 deletions(-)

Range-diff against v3:
1:  82b09af4ca = 1:  d31f320fdb t5516: remove surrounding empty lines in test bodies
2:  938dfb8d4e ! 2:  ee6d69bcaf remote.c: remove BUG in show_push_unqualified_ref_name_error()
[... deleted the diff of diff because it's mostly noise]
-:  ---------- > 3:  3d84072dc7 remote.c: remove BUG in show_push_unqualified_ref_name_error()
-- 
2.50.1

