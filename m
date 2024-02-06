Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE77D3F2
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196364; cv=none; b=ja4qMPcyK7QZmVaUtyC30Z8xNyTAhDZJLk5k7higwNjokpJaOldGdMGjdUCpzQD9ZYUlVFWZg+k/taeGb7PHzl2J1X3fKXp3YeRW1dQfZ11Q9at2TQkUimzuytJJbRWZZXe91uKwjpFhHszzveLZI5U9l8KcpxQ5izG4K6bJ5eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196364; c=relaxed/simple;
	bh=hFYWqf/eNtAVR2xBEDUlIu9gKkRnsIbQ80K31A2J3Nk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=DD5C0DcFpeSqYufZk7Fst5GstrBFwFCVCSvo9785f9/5si8V7EncEVDnujQ5jjyGYdANMXaK598A/GdXrt476KJjxk9hRQioOTxITUiu9DzUyMaJ63jWakLbGhuSZHQ5kN5vIifs7qk6bxL0ax9iASHyEYntJ9s9NzjqxqaaV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HQJ+ob0X; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HQJ+ob0X"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b409fc4aeso952851f8f.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196361; x=1707801161; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu3C6QYFVde3gn9amt7IKrmgfKcfRFijD1kT5Q6lcwI=;
        b=HQJ+ob0XQlSyagPpsLP3cQebLgvttWz/8jt157ZKzD23ef4PEE5aBfnvmh5wC9k2JU
         +isSog1IQOyp8z89QQeF9tE6y3/3n/L8RYD0E8KOjuj8FH7TIO7MdYUhwwK+BBcxPhzo
         FWlLBLfSl+1o4b8LWNba4G9WIAgBGUW8554LZOC1lcJngoso33GlgnzdEhHfA9QJDIU7
         Ml1Jn9sXr097xEMAi9LoQdxO0/bg/114HVit+jMnSaYEHuGf9mHP5Sgji1i4nAuhSUnC
         stQ0/Lhte30fcHZYD5aAtOZo7tKhoagDacmH3Ldk4f8FEwvPKJ/OEZvJ9tf6Le7dJ2l4
         o4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196361; x=1707801161;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu3C6QYFVde3gn9amt7IKrmgfKcfRFijD1kT5Q6lcwI=;
        b=npKywFojWt8vqTxnEi/TRO4/eB493G78NSzjps6ZaUg6RoCzXpOwsZfcXuF17gnRES
         /g0bGd2A2hI1WLD6E1i198vOCy+A7dgcVyR1ZZjg5YIYPLy6egDKY5exhE/C4kJfCjIq
         UOIh82ZrZP5UofW25x24tqalKs52K6iOFtvN6DZemjmi24pEDEem1Gp+LtMv7qTJlOda
         mLIJLgTB9Z8KzGVOX3EQnaQYo71sLKOA26z+m9G4lfHI0fOi6EkypULrqp7bppu1aQXp
         x0FnZB5/Oj6taqHpf8jh7ANkSDVC52gGrWK0moXM5vjRHmRp8mRfY9kJnu3Kf5VXBf+e
         +Fmw==
X-Gm-Message-State: AOJu0YzdpLcbfxw/nP5oR/WmIqZovEtMWKOvdrtWtIPvUCUH4CJkfNAr
	3UKtMqrUi79f44UNZVqf+A/oD49NETcUyojhUxvIj0WI2n+diGv2PtYYZ/K2
X-Google-Smtp-Source: AGHT+IHGFk9hlSWq8mmWafuCoN6q0DsXd/QPQNk7OOp1wN9Nw1mNNOInDC69n3Y23PSuHkNujFWBCA==
X-Received: by 2002:adf:fecf:0:b0:33b:3ad8:22c5 with SMTP id q15-20020adffecf000000b0033b3ad822c5mr368128wrs.68.1707196360899;
        Mon, 05 Feb 2024 21:12:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWAITre0R28baAOmBVLmmvaqdQktV/5wURO0rKgAHNRouKUp7eQNN395PaVBfYHlU3YOKq83RnAkFqb2Kri54evyjkQ/CjP3Kld7q0JBIF/ojyllb3wJU/Pom/ZsWwOvrpU0gVBaV/dVEPVZNprYu8dpw81ep1NzO58ly8OW/4BET9r5CI9dKAgSDLnliDuIDPiTgpt3X2Q7Q==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q12-20020adff78c000000b0033ae4df3cf4sm1060630wrp.40.2024.02.05.21.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:40 -0800 (PST)
Message-ID: <457f2a839d5da9da225e842275bbf8b15f194f1f.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:11 +0000
Subject: [PATCH v4 11/28] format_trailer_info(): drop redundant unfold_value()
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
Cc: Christian Couder <chriscool@tuxfamily.org>,
    Junio C Hamano <gitster@pobox.com>,
    Emily Shaffer <nasamuffin@google.com>,
    Josh Steadmon <steadmon@google.com>,
    "Randall S. Becker" <rsbecker@nexbridge.com>,
    Linus Arver <linusa@google.com>,
    Linus Arver <linusa@google.com>

From: Linus Arver <linusa@google.com>

This is another preparatory refactor to unify the trailer formatters.

In the last patch we made format_trailer_info() use trailer_item objects
instead of the "trailers" string array. This means that the call to
unfold_value() here is redundant because the trailer_item objects are
already unfolded in parse_trailers() which is a dependency of our
caller, format_trailers_from_commit().

Remove the redundant call.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/trailer.c b/trailer.c
index 6333dfe1c11..12cae5b73d2 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1102,9 +1102,6 @@ static void format_trailer_info(const struct process_trailer_options *opts,
 			strbuf_addstr(&val, item->value);
 
 			if (!opts->filter || opts->filter(&tok, opts->filter_data)) {
-				if (opts->unfold)
-					unfold_value(&val);
-
 				if (opts->separator && out->len != origlen)
 					strbuf_addbuf(out, opts->separator);
 				if (!opts->value_only)
-- 
gitgitgadget

