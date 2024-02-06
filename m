Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F607CF0E
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196362; cv=none; b=E9SN8tfxoIFnVN6JTj575m8aJ6EM+DmHoMg1CyLP6QgbeC757Ji8o7IxcIK4PZmQhEzS7dr11Z4+uWTEyowsuSb2tbdcBraS2z63KWmXDlejT398bylX47m0k3eoErewrEUpUi8MF9cWrkVkYXlopnZOEUEsmYjjIt+WGfBoDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196362; c=relaxed/simple;
	bh=xEjCtEwH8053b8FmPyEdmUirelnDF6WIWGEupqxMwvY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ck5V92cAOK7yizVbH8VLV+kTPcxUmViiJFvP7fxZJwQKm2eyx8evxv7FYpycSomFFnDFem6ChtJaKCrmr173j/Jp5aOV6tkK9IgCUQmFhCwZtgZKuXjw0eKr4eim6HqQY9EwcJqRkrlokqP2CVppLvQwyHHUk+3b2lun5+uxAMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5EVBdmv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5EVBdmv"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40efcb37373so3902535e9.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196359; x=1707801159; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxs7mFyDPThYA0V3QkOpNhWsLeMxmasJHGkliFUZuUg=;
        b=f5EVBdmvHYD0nK7XmTvr4ieHKA+KEq6hNZ4h0PFh6kUUcCL90A87LjhAPVQfhv1avO
         NJoznrAgutoD2j/DW2dyfpljcnplTGQjVewIJDR6fUKi0vxheDD/EbSbCqidoHehihyb
         hoWC9wlxWVL+FDNh+dJypBJRbo0OjLX2gXq6TbNlqxT+kMEwvLhXJ85vVaIy/ElnZHld
         WyTnbU32aBIxPD2cNGG2LDcx1uTwobzeC/zBm3E+O9KqNnfjRruL2ATsbfKu6C+yOOqA
         l6QDWL1CLF5LtWG4QJvfEZ+KBy/jNFxBTU83kqFHDpa3WBYpV4ufvY8wHPCZ3ja8agWm
         Kgog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196359; x=1707801159;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxs7mFyDPThYA0V3QkOpNhWsLeMxmasJHGkliFUZuUg=;
        b=IwpMxyas+h+d0/hmN1O3e/xVzME7nfv04ySVoVQT28/OHenolTAoAzBltGmHt2BZ5r
         yZ9gTQKEy3vOr1E/fxKaNLHh57GI6w+LBNyi00o2UTNd6Q5Ba9SqRX2WxQH4a3s9kseq
         FKlL2pn1NN0/8e578R88PO5sUVYAWVkhvPzGkSWUt5WPI/sUgo7RF+62L32CIGNvpyva
         0tjnZP9cuur5Zpqcuc7esSGS1tYUinqQ7T2VQuPQ99QyNr2BQATP3YwQCaK8yN4nJyGS
         GtNwawsGXe0jFCgR6IDqZouOkXQiLencdC5ayFQCMQvRk6c2AuHbQGwRbS0sWsCXUe9V
         3NkQ==
X-Gm-Message-State: AOJu0Yxbf56ll+IDRHftmcb/s+8MtP52BO6x1g9/ERdomX89qfo0MjOf
	4w4mI1G3gDhEhGUUM3vTRCrhXT7cTAXbr3In0aCEkkg1AZK2vX+gvrTYKTo5
X-Google-Smtp-Source: AGHT+IHsyidatQ99DjaotlBsJWhQDmd/dLqQ2s1UwbGjmYo1NYapBAORNLMrdBxIwtpK3W1Bl9D1+Q==
X-Received: by 2002:a05:600c:5249:b0:40f:d22e:f9e9 with SMTP id fc9-20020a05600c524900b0040fd22ef9e9mr1337646wmb.10.1707196358969;
        Mon, 05 Feb 2024 21:12:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXiCCbl0RsldZOrbtPqwiedBYoCo5BolTZQjTsAtpxRVzVWYSRUvmqgXn2/Pn9CZB3NrbqQhieUJUYURl4Z4lsdW50AKDMhRvh6nrHHIHT4ojQu7YLckxEnmvjYiRsMmLOllA4r5BlELiYdtQHxmdRdXwnbYHaW3gdNNahCAKt6jZGRiycTU0aLREUJEggCzLKhU58nvbAucA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b0040fdc7f4fcdsm658917wmo.4.2024.02.05.21.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:38 -0800 (PST)
Message-ID: <6906910417aefafd296997548b77038222883753.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:09 +0000
Subject: [PATCH v4 09/28] format_trailers_from_commit(): indirectly call
 trailer_info_get()
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

Instead of calling trailer_info_get() directly, call parse_trailers()
which already calls trailer_info_get(). This change is a NOP because
format_trailer_info() only looks at the "trailers" string array, not the
trailer_item objects which parse_trailers() populates.

In the next patch, we'll change format_trailer_info() to use the parsed
trailer_item objects instead of the string array.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/trailer.c b/trailer.c
index e92d0154d90..e6665c99cc3 100644
--- a/trailer.c
+++ b/trailer.c
@@ -1140,9 +1140,11 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 				 const char *msg,
 				 struct strbuf *out)
 {
+	LIST_HEAD(trailers);
 	struct trailer_info info;
 
-	trailer_info_get(opts, msg, &info);
+	parse_trailers(opts, &info, msg, &trailers);
+
 	/* If we want the whole block untouched, we can take the fast path. */
 	if (!opts->only_trailers && !opts->unfold && !opts->filter &&
 	    !opts->separator && !opts->key_only && !opts->value_only &&
@@ -1152,6 +1154,7 @@ void format_trailers_from_commit(const struct process_trailer_options *opts,
 	} else
 		format_trailer_info(opts, &info, out);
 
+	free_trailers(&trailers);
 	trailer_info_release(&info);
 }
 
-- 
gitgitgadget

