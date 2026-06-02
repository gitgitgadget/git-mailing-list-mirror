Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593CD3F164C
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411390; cv=none; b=Xqg9FmnnHT1LXpM6E6XwbldTgz1pBlQIA73Bddsusi3yASSv3zDDamp7QAat7GZssb8srvN0eVQMpKPWCUrVbawpM7bnXzhy5amMUieKjdQX0aHINX+HxY4O1vQHysHF7lqzbhC5jL/cyGYKxNN86OWnwU/zOpiC+kr8wppAFEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411390; c=relaxed/simple;
	bh=R8eN7COVGugta4uayWTe7Ol1JkUDG08ZZH422eQF9EI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSwP31K62h0g9udDEQcvspUYUr+aasH5PJPcW3SoveNUzpj6+/56Yd7iVchb/DWFScJN+ibMS7zbWtxTItVu/65ocCUGXTXsXeHyh2JgyXaX591eVSYekeGlmEsnYnDLOJQilsRtkrOKK0zE5i1jKI/jMXOPdgAaXkpBzx/wENM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TAZdObKv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktGEgHvL; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TAZdObKv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktGEgHvL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 703091D0016C;
	Tue,  2 Jun 2026 10:43:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 02 Jun 2026 10:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1780411388; x=
	1780497788; bh=KwsBMFCr66/2eFvPNR2E6lx9HSJjGnj6lnLiGVaJ+z8=; b=T
	AZdObKvau3PSXuJVw2+7KRmnMPSJTP0XAPJqQk+ySP3pD6bGhx2Og2Iev1IJNoqV
	1AFTKZQYjEFrwlS3mXsY4yHIyDy7oranvXfprQD9gVzt+PNTx7/Pc89CxoihfaRO
	1cYHnzGCSRzmWzbfrfiRThw56ka2J89BDCluiHoc3mtnUvWPqZTESxZPcNkRlq2Y
	If+D4MAOY8LrYljb2e2fYLYI1kSe77gWrq3UIomJrnsYszwGC/BTmLCRgUpRIRGg
	7slhNh4vHRGGkaCDP+713LIk7l7IvYwueKdW4OnGZQFqVnkLcM7I1bgDXulFPNsc
	4FgDj34Q9wmEzOtXQ/EPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1780411388; x=1780497788; bh=KwsBMFCr66/2eFvPNR2E6lx9HSJj
	Gnj6lnLiGVaJ+z8=; b=ktGEgHvLSLYMkIbQNygC0aXiuB7ikg3g4R+SLABn74Qp
	mgxEDD3qDkxWwRGHnQVOvATfdFpL5ilfAc0e+yJOBk9VSCJYyvfUIKTh48KXWICV
	DsgRvDoY1d0CERKcaOnl25VMg9kJxYBZyw3cWfIBYnZ9z1GLf7tE2SIWSzqb2HP4
	KhIM7C4lfUmwb4ysl0CN6cDtJugZgwdrcFzwOqecaPVwEneak0WpaIpWxca1jtXZ
	JBCPL9IOumoFJjnFoJTJbGO7hsRrq69ej+wv5zCK9Ui/Cert3h0pcElJh8j3pJ/j
	1FAfL0W4tIROmzfpCjwNnhcTQXSEk+PLRbmmLwMncA==
X-ME-Sender: <xms:_Osearxemo7XWUXM2cfqhJWMeKDAFUFs10PMh-Nm7RIDt4DQkDq7SA>
    <xme:_OseapTdup7DYewEW7bwZrhdRkG9AP3X9bqUIP6qFv5el87YMv7oXMnk1sRDg1i6t
    rrvgeSC_6wCWmH96lXhUlh45bmHWV7B47vdOCNXrOlO4b9yEcSB1w>
X-ME-Received: <xmr:_Oseai9GXElEwLrgTYf1DmWg1v6QTwHXsuZZU41LJIJuCOyy7N0-F7rxvDjFmGCMMexy2jX5d7qXPbt-IgSfNCUgGf5BKU5Jkhwe>
X-ME-Proxy-Cause: dmFkZTFEOtWtXvjSicVy0bkeqWQgm0qDJoNebj2mC5YDgPADcJJEmArcpYRaDf4Mmj5VE+
    HEXXh7yQcNUk2b+hsqWS/zatEVyOGu/LjDxqQ2wFsYSAxC0e93ove+PdVz654coY9e+KKs
    ZJCCf7hNERo7BUNV2iylo1j4jZiUuCOU8o9BuW7V0KigQjZmcK35YBT2oGGqJhKFTVyIkD
    ljrLFrzV12KJwc9tca5SI48rjHrNpQnIcwSOEEQCpzqgYPiwkhptzfEfV7E74j9p537xPi
    DEyoPxzuWHdcO0TaNgqBPSDWjDHQRO/leIKT80v50Jbp+M3Sx2N5KE/MDaj5b5XCzJLQgH
    X7F1MOdtuJmWve60ySeLHC9jyFDf+Uz3NQIrzn4H7m3FLhJVIyxQG+ZSKzCCQrSwDHeALT
    15eHyKhF5aQf7pF3NMZna+vPrDK35+sYnM1hjf4pi0mJsWSmPggcDI+sUcxy2KmdmtW72S
    TQzHjikezvIV/zy31NG3YN/VqG9yF8Z+/g08FXv3WfvxtJvfJ3FAM+GevlnEmIr0JCUUww
    sdAZlRCW0GzY99eWQIOUlEQvZaoN2MHowu4ZUj+4vDz7ZdOJAi36dHEeQrPwz8iJtTYG8K
    m8K6pj8vLipbQVabguAAQn1UbSdJ1uhnf1pjt+bBl8AOB/hNHZqbmNNf5RmQ
X-ME-Proxy: <xmx:_OseagplhsC6zWGgHtxSlj_Rpdc2D9fYit9hlqcU-qE6lvnAePwB3Q>
    <xmx:_Oseavl-_nKg5TU6txUtIWBsWI93xMfk5cjcimu7rSFkrPwW6_RpdA>
    <xmx:_OseanKxkzVTD5bfLH4vejpwBOtNuPx_9SkaQEdyZy5uQ1PQy420DQ>
    <xmx:_Oseakys-82kQgdS8XnsmLDzoFV_gQ8dSw1qpFMMa4QTNGv0t4lZug>
    <xmx:_OseavJ6kZ3BuSd_1EfKJBr6BEzi6zAUXdU0JuNDUyu2v9EH42nNpuET>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 10:43:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 1/2] SubmittingPatches: separate typofixes section
Date: Tue,  2 Jun 2026 23:43:03 +0900
Message-ID: <20260602144304.3341000-2-gitster@pobox.com>
X-Mailer: git-send-email 2.54.0-591-g9032776dcc
In-Reply-To: <20260602144304.3341000-1-gitster@pobox.com>
References: <20260602090808.87837-1-gitster@pobox.com>
 <20260602144304.3341000-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing text said something about tests (with [[tests]] to make
it easier to refer to it from elsewhere) and then flowed into a
different topic of typofixes, but it was unclear where the latter
started.  Add a similar [[typofixes]] marker to the document.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index d570184ec8..dec8aea4cb 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -237,6 +237,7 @@ Do not forget to update the documentation to describe the updated
 behavior and make sure that the resulting documentation set formats
 well (try the Documentation/doc-diff script).
 
+[[typofixes]]
 We currently have a liberal mixture of US and UK English norms for
 spelling and grammar, which is somewhat unfortunate.  A huge patch that
 touches the files all over the place only to correct the inconsistency
-- 
2.54.0-591-g9032776dcc

