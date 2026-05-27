Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428023BCF7
	for <git@vger.kernel.org>; Wed, 27 May 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779897007; cv=none; b=pnrbjt2WVqhdslk/8Kkv/Hwl3Y1o5s1BoGhb6VGEa70InyO63TbvUNcB4hb/SLh9waNBEqAv/Nd3TUvEqQYNSb58smKRJPZqOZe08GDIM73Kl+sCe8sJWk51pIa3B5tSwzALr8vdVjEuz+6YcgUB61ilmbRzddnZgrdCywZUk1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779897007; c=relaxed/simple;
	bh=zCFYjsO80RMR+48Vmx5o9a11THc7cOYN/gl0pW92CFQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aSrzqcga5DqTIrDDF2Ix7TfTKMrpW+pryo95xtw0S9ZUwibCKPMQd7hx+G5rOfI6zbn6CxljrP4efcWIL+crFU/pt40pjNRlbhun5UtzmG6zGTitFgqasOHKGAFXS2HqyxS9pK8kUxLEsxGlxJt33MJFWLvdkRWbpm/4OCSTR6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n1Vu1r2p; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1Vu1r2p"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-914a90b69a3so661609785a.3
        for <git@vger.kernel.org>; Wed, 27 May 2026 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779897005; x=1780501805; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SxvIYZlBmrOj1lyC8Hwt6k3FQnXINMslKAkJNNH/LmY=;
        b=n1Vu1r2p2ubB3oHtnn4kIlyuAxsH2HdZZs0q41YXSq6aHI3ScIXedgFZC8iYWXqV6D
         8OQ658olrXtgBEqvES3bg+uJPdko+b4u55Nm6WBYcBhnz/gji8QoVUUGXHfBt7L2ahYx
         PCRcYRhO4ZHHZcMpYLBX2QCwI9X61KzzdUPJFyqc55e4L/aIPyHpLSd2nFIEWn719to/
         9N8kNfgmgcKRY05fX9/RrjWO2dX17HAJ/pApysbs9HV4FcRHKtUg3EcSkGFBp/e7oMG5
         JCzhYUmPixVZ4Smr5PgxpFtPUB9/b6GulZNX1IVXARkMi1RFoqZjmNXtzRZOpQzBghKj
         mvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779897005; x=1780501805;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SxvIYZlBmrOj1lyC8Hwt6k3FQnXINMslKAkJNNH/LmY=;
        b=tOl6HK02sdWzbeixGXuAP8fe0TObvqRmaLe8svPpO6EraLUzrfshicE+3bMcwoS7lw
         1Ta3C0cKMXtYYmQ2GWuDb5+pilhfmdmCKlLFn7VgNQOMnJOnIRp9HHYCbOHE6uwayCzT
         FaLeHSOMhxMekQ1J79F081kFptvn21mKbt0fsb/yz6N6bZCW3roFQmaH3Ebuj+CNnnCK
         uESNvILexZAzoKOrpVHoVQEJcf33bYOPsIWPcmCQizPQPcLmpTpOehBCpTx1QMRmbL0h
         qO1G0RjjDf46ZxjXwil0XLGN8Uonepou8ipx2zVr5ILuUPIocg5STZb6ypzGrFcUe2Iq
         DSEg==
X-Gm-Message-State: AOJu0YztDtgP6lNhSurYiRUe06LDd1bjtYDWc3Dt/sksjLWbIuCQtzbv
	TV+uAuUdwN9Fh+ud7iNQY1tsCoEk6wB9odTNuXh/Bh/lmOU1CZpYqeIh6tDxgw==
X-Gm-Gg: Acq92OFIwmm+LB6hRolqdPjXFCQmimlys+5dAYdqf3+fsNWeM/MzmB1V6HgmsGiGkdj
	PRCVGbGuPLQpEblgUqhN+0A16gmDyEnIjd8nPxud4MZzlFbx+vJ7jc7KBnOThtWntPKHL4aZGHX
	IbUGb0fGqrcWJQqzSkCrSgzXxDhh2PQaZLmmMolFLgfmg43aCz2YXerF1xKP5Tw7n6CRV3LxQYG
	AfGx8AuOQ6Lw+it8VqhpTTJFLJk44Ok3zb6ezz1TSmmpFDWx/UmAdu5VgXZ201xRsNP5uI9LO7m
	RAh1jVmAtyXcx7PXKgeeYD6HGOZW2UTjTasBPGzVmnAc1aliYQVwcG1BjKf9qI1NiRabwC65oSK
	F+PBqpMDUdZxu50OVKbJ19dMZtudRcrpv2WmOsKK7X0bya6pJB6wxwyxT7RkFelrtECjQan0ZWO
	LC5uJOm+NAUfPCYOpzprpcvJWlOmw=
X-Received: by 2002:a05:620a:4004:b0:90f:c88d:ebc6 with SMTP id af79cd13be357-914b48c68b4mr3603392285a.17.1779897005559;
        Wed, 27 May 2026 08:50:05 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.239.32])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f86e9ba7sm503115885a.6.2026.05.27.08.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 08:50:05 -0700 (PDT)
Message-Id: <743adab469c748aed66555e5390379b54154216d.1779897003.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2127.git.1779897003.gitgitgadget@gmail.com>
References: <pull.2127.git.1779897003.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 27 May 2026 15:50:00 +0000
Subject: [PATCH 1/3] pack-objects: call release_revisions() after cruft
 traversal
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

enumerate_and_traverse_cruft_objects() initializes a rev_info on the
stack but never calls release_revisions() afterwards.  This is not
visible on master but becomes a leak once the revision walking
machinery uses dynamically allocated structures.

Add the missing release_revisions() call.

Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 builtin/pack-objects.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 480cc0bd8c..67025e8625 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -4275,6 +4275,7 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	traverse_commit_list(&revs, show_cruft_commit, show_cruft_object, NULL);
 
 	stop_progress(&progress_state);
+	release_revisions(&revs);
 }
 
 static void read_cruft_objects(void)
-- 
gitgitgadget

