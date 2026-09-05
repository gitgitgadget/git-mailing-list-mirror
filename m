Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB164E8DE4
	for <git@vger.kernel.org>; Sat,  5 Sep 2026 17:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788628419; cv=none; b=ID1gZnW8/cfqGaj0ZNl7j+BxFH1t5T/g7lFx3nWYh29OkISg5dIsvg4I6N6U+WTOhph3fCP4LyaHwUy1Gv+2CsnPByoyshoJQ/mAMF/6gLiHGd800RdsBW0Tbl2q1BkcikPZyjv6TuLhZ/U5kFSHIpzu7QhaAUN2XEQvjap8gpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788628419; c=relaxed/simple;
	bh=b7wDv3AlLUesCGuR9szbYb7MCU/RLTmuRhB1p4vdRpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pAcFmxeVmCPl3u5DVuzrBYPV0+pbfQaeEplGXNUqPHGmtvkIKFbhzBRIoY41YGtMfHoLwh1wCf49s4QsvWvF+fzgvv257FK+0lFno+uakUD3AMtr0HW9DBrvlZGOSVynC7eEXFTDa5T9HQAM/fXAwNIVD8m2S7FzFf7NVr+VFtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=BPOdafbf; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="BPOdafbf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso1395464f8f.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2026 10:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788628416; x=1789233216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ukagXpoJ2PRw3ZRnuJ8VzeniXzZAaoeuTK0qU3wBOU=;
        b=BPOdafbfO/BmSefNPEc4GpzsTkD6JySEOjx+j3byabBcebY5r+A2AOmEAkmXjRer/3
         nIdWgmepyc0mhhz1ToLx2gVG4gYcZX7qUDQmr7rcPZxGFJEjNM5c0HQilbBd2bbKa2BK
         u3hAMP198v7Lp/A2MwUJ+FVsPcckQaSFjIYsdtNpd7SgmC7rxKC9YT/tCV6KkGKJXTyN
         4nXGJeLhMcp2yJFJmaJw9hMGGvI2HarZ6GmHn4yFMkukJqrys0Zkvs2y40oV+hKDs0DL
         fy3qHdgjQug/x2XCOxOSsCCh6rxUtA7mqjAvk6TL9UVcgTihfJHCHLuqwZhBTL1PoZ+R
         IGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788628416; x=1789233216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ukagXpoJ2PRw3ZRnuJ8VzeniXzZAaoeuTK0qU3wBOU=;
        b=CK9Ilx+rSpD3hQ9MEEkQM6tbR7ryKiV+vUnVD7c9UtwEUPlBHKtBgvLvjdXGZMSzEk
         iC175CzOkZ5V8Jwe24u+MAjZs26sHg57fn+vVnxmynHQZ8RUia2ZkQ90Oj57dBQTUocn
         mHAiO3H/wf9OFgGVCSJG/GuKxnjah9Ctxqo96S9rWHeMOLZJd4ID/RGHRO/6SfvdY8sI
         Xy488w6f+zostEyiae46aNOq73jiMyny768qAbOqfu2LedXuuPURNmYrmjoMrk8KlRpX
         ADAnVuv6efZ5sz+6fUhG+2VkI8ZxcvUFaaXULZS/5+JWSagKPnJj8kEuxpQ+UiOAO7pB
         BrOg==
X-Gm-Message-State: AFuF++nlOM52aaLW0iFYKR16tYlFKqdzBfvfNL4HqcTtfa8XyE6E2PbO
	unRYkD1ZFnSggTpk5ocV/1bWPa02hFOW2MkL6o1FcGaJyAW7/wb8XLi/ogLYll9eVygVHgWup8M
	IB80pWywr3ftQ
X-Gm-Gg: AYBFou39zqlywxx1D9eKJtbhFWNlOCHKHYoM2LhmPC2rV9X9BEAiQ+x9y72WqOgcK9/
	33mjC8Ok4Q6GvvX+amo+RbbdvOFx07yPLElWmW+AYCJvXJp0/WMcCPMz7ENgeh9lOLH0GoKDr9E
	y65pbnkWgdNaFXLXayrbi7Ty7hMQYJEPhTriRPQJDkiOUXyy3We6uQ5bz5f/REmL0RD5DSkc9Rx
	83JiZeluUHQ3r33aSSnCm9QVEDnFuNZdhP6yzy9zgEGK15RRy7c8SaGpeLu9rfV8iuNw3s6GcqB
	dnyqbsXfNPyJXdfGvMbJVP0MiknMOmhffMl0lR5EgziLJE1jq0nuVb8yHNNed0RSSv/7jQfMpt2
	XpaithC10ukHOAEY7xR+sdw14BsohBqlG5cU/87zQEme+qTBTc6qmhUaY8jmEiyePhLVBMbMYr/
	K10QT5PNCrbjoz5L6rIOmccuC6wTo3o+j5wmEu5B20X4RKVs9VtXAOjOTCWWGqvHovAfar
X-Received: by 2002:a05:600c:3546:b0:49c:fc6e:a3db with SMTP id 5b1f17b1804b1-49cfc6ea79emr95650765e9.26.1788628416187;
        Sat, 05 Sep 2026 10:13:36 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm252763335e9.4.2026.09.05.10.13.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 10:13:35 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH v3 2/2] doc: cherry-pick: note --no-commit skips CHERRY_PICK_HEAD
Date: Sat,  5 Sep 2026 20:13:32 +0300
Message-ID: <20260905171332.34670-3-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905171332.34670-1-f@lex.la>
References: <20260903125524.67889-1-f@lex.la>
 <20260905171332.34670-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list of what happens when a change is hard to apply states without
qualification that CHERRY_PICK_HEAD is set.  Under --no-commit it is
not: d7e5c0cbfb (Introduce CHERRY_PICK_HEAD, 2011-02-19) skips the ref
on purpose there, presuming the user intends to further edit the
result and possibly pick more commits on top.

The option's own description says nothing about the ref or about
authorship.  "git commit" reads the author of a cherry-pick from
CHERRY_PICK_HEAD, so without it a plain commit records you as the
author.  Say so where the option is described, and say that this is
the point of the option rather than a wrinkle: what is being built is
the user's own work, not a reproduction of the original commit.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 Documentation/git-cherry-pick.adoc | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-cherry-pick.adoc b/Documentation/git-cherry-pick.adoc
index 42b41923d5..f4cd8b9db7 100644
--- a/Documentation/git-cherry-pick.adoc
+++ b/Documentation/git-cherry-pick.adoc
@@ -25,7 +25,8 @@ happens:
 1. The current branch and `HEAD` pointer stay at the last commit
    successfully made.
 2. The `CHERRY_PICK_HEAD` ref is set to point at the commit that
-   introduced the change that is difficult to apply.
+   introduced the change that is difficult to apply, unless the
+   `--no-commit` option was given.
 3. Paths in which the change applied cleanly are updated both
    in the index file and in your working tree.
 4. For conflicting paths, the index file records up to three
@@ -101,6 +102,11 @@ OPTIONS
 +
 This is useful when cherry-picking more than one commits'
 effect to your index in a row.
++
+This option does not record `CHERRY_PICK_HEAD`, so a plain `git commit`
+afterwards records you as the author.  That is by design: what you are
+building is your own work, which you keep changing before committing,
+rather than a reproduction of the original commit.
 
 -s::
 --signoff::
-- 
2.55.0

