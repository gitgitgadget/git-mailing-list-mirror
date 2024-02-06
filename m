Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECBE7F49D
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 05:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707196376; cv=none; b=UaRBAVfTFGWwWdWvzZw9IlsZgRhGYGAsLErJ2EUjBpk02j4o2JVsdrD/ZuWPOhYIiJ3qIgVG7szfVRR0iZlfsdHnnkDMpLR61fu9kXy6cQj2xBP2PkwiZd83LVrNUM9RzfWAW6dNCLDKNoWxUMHm9IHoa+nQaOVdNUYwa1KqODM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707196376; c=relaxed/simple;
	bh=g9UlVwtI1LDXpmXGclI49NRsg4MbiMGfDL1LQrY7AIo=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Nr3/UKJg5PWPQ1fd9KwVYYo5L5So6Vw8aiy5Wjrm06D3k0BwRn6JK/x3GLrTE5uiZq5F7VSmI/dDyEGDf8Qc4ID2JVG0+7A1sjovCnmUwJ+oWTyu6doR2e7zxmiYQPdss4Kxn9e9KriHZwVGdRvoJNhLZjLU/b+ZsUtVnQuj9EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dl8yVMps; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dl8yVMps"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fd280421aso22400375e9.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 21:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707196372; x=1707801172; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOREw6q372qtoCRNyAiB9WUVEqb0ov38KcUfz5lCeOg=;
        b=dl8yVMpsUXd0SEoZRXOOmuMZQjdH17lrrq3y9WSUmq+IXns4m3qWed4dusRtQsQKJm
         i5bN5yQ/vpbPIOeAGooYXMW/bSkBS3mPJa4jl9wTBp8RzV+UxvuYmOprknl03RQxwgnB
         7YlsP4PS/We/Bccft40/iIERTRh1OnK6iu/Jk9ZoiQjs+2xiuWMbbv4iK3bwwn0vf3Lh
         opnOu4YmoEXKSdY57GUz61oOMincdJeNTu4kqfiRRuwTlseYxYYhIbX7KzqJP+v/CAdW
         rs77cbaD5LvU+WAaNZ1rnT8ypiDWQI7C4fAGlDEscXOtlT19mAEIHYHXTlL20KwEvomg
         482A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707196372; x=1707801172;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MOREw6q372qtoCRNyAiB9WUVEqb0ov38KcUfz5lCeOg=;
        b=Z3CI7HNLAZUrpLgWMvtslcO0EPGifNy48SFMS+YrL+5IAnGnWDr7fJdnuCQK4wKWLY
         ZnehYxNT60HwPTc2thkILCmXGiibbnlY2xe/YiJD8Z2yKugtBk+JN2ipaJCVDHTihN63
         2v5ZG8jXUJm8/smxly46bOolhTL15o73bg2FZeBFMNEQHbg3cC+siQnRSjxmiEU72Om4
         cWVJ2/pc64CByGIfv+LUJ7hsybcWO61IYcQK23AG/hseNFTAy3ma5Mp0/o0nk5kf6Ymi
         uupZQe/T3+0ZCo+Nfw7vOfyQ5Nrsw67HV3qH2yj8fLJMf2+ggrtR0BuWDJoKnYotf3QZ
         UaOw==
X-Gm-Message-State: AOJu0YzrfxXe+2eGvnMINwMLt57fddORDa2wPRWec6R5rH1JWkV5vOLM
	WQ1ik6ciu+ADz+NBC6AjRE6HU2LxKarV6BgNM/O8wlwjwM6dx7XZsO5SjYBh
X-Google-Smtp-Source: AGHT+IEPky0KU8N7zTF1zeZ1Zs9RLiX1/bo+GUbl+a8FrtmMnqOrPMzvp9uzvtHx5kuQ31g1lcaVOw==
X-Received: by 2002:a05:600c:1551:b0:40f:24e:d480 with SMTP id f17-20020a05600c155100b0040f024ed480mr1170079wmg.18.1707196372691;
        Mon, 05 Feb 2024 21:12:52 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUjPceNVeSlbgrsOpz6VZxEsTrVv8jnFtBdw5iHmaYQaN1OQCtzvK1ly5EIECewzpd5wqmlMU15Tx/VWbgOu3ZtZswqffLQd3B/Fol0iqQoyj1FzUt6NlzV46G5awC29NLpfLM9O44RTDnbxk2RSjFP/Tt7R/frqAsvL4bgWJJ40LNekpOuXhBsfI1j1/Brv8+vF8zr4zh4jA==
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19-20020a05600c4ed300b0040fd2f3dc0esm639458wmq.45.2024.02.05.21.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 21:12:51 -0800 (PST)
Message-ID: <80e1958bb8d5d4e74fc9d4334b99d149ae2bcab1.1707196348.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
References: <pull.1632.v3.git.1706664144.gitgitgadget@gmail.com>
	<pull.1632.v4.git.1707196348.gitgitgadget@gmail.com>
From: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 06 Feb 2024 05:12:24 +0000
Subject: [PATCH v4 24/28] trailer_add_arg_item(): drop new_trailer_item usage
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

This is a preparatory refactor for deprecating "new_trailer_item" from
the API.

Instead of preserving the where/if_exists/if_missing information inside
the new_trailer_item struct in parse_trailers_from_command_line_args()
(only to look inside it again later on in trailer_add_arg_item()), pass
this information directly as a trailer_conf which trailer_add_arg_item()
already knows how to handle. This reduces the number of parameters we
have to pass to trailer_add_arg_item() without any behavioral change.

In the next patch we'll be able to delete "new_trailer_item" altogether.

Signed-off-by: Linus Arver <linusa@google.com>
---
 trailer.c | 29 +++++++++++++++++------------
 trailer.h |  3 +--
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/trailer.c b/trailer.c
index 9b8cb94c021..6ab5cf7e5d7 100644
--- a/trailer.c
+++ b/trailer.c
@@ -729,21 +729,12 @@ static struct trailer_item *add_trailer_item(struct list_head *head, char *tok,
 }
 
 void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			  const struct trailer_conf *conf,
-			  const struct new_trailer_item *new_trailer_item)
+			  const struct trailer_conf *conf)
 {
 	struct arg_item *new_item = xcalloc(1, sizeof(*new_item));
 	new_item->token = tok;
 	new_item->value = val;
 	duplicate_trailer_conf(&new_item->conf, conf);
-	if (new_trailer_item) {
-		if (new_trailer_item->where != WHERE_DEFAULT)
-			new_item->conf.where = new_trailer_item->where;
-		if (new_trailer_item->if_exists != EXISTS_DEFAULT)
-			new_item->conf.if_exists = new_trailer_item->if_exists;
-		if (new_trailer_item->if_missing != MISSING_DEFAULT)
-			new_item->conf.if_missing = new_trailer_item->if_missing;
-	}
 	list_add_tail(&new_item->list, arg_head);
 }
 
@@ -759,7 +750,7 @@ void parse_trailers_from_config(struct list_head *config_head)
 			trailer_add_arg_item(config_head,
 					     xstrdup(token_from_item(item, NULL)),
 					     xstrdup(""),
-					     &item->conf, NULL);
+					     &item->conf);
 	}
 }
 
@@ -791,11 +782,25 @@ void parse_trailers_from_command_line_args(struct list_head *arg_head,
 			      (int) sb.len, sb.buf);
 			strbuf_release(&sb);
 		} else {
+			struct trailer_conf *conf_current = new_trailer_conf();
 			parse_trailer(tr->text, separator_pos, &tok, &val, &conf);
+			duplicate_trailer_conf(conf_current, conf);
+
+			/*
+			 * Override conf_current with settings specified via CLI flags.
+			 */
+			if (tr->where != WHERE_DEFAULT)
+				trailer_set_conf_where(tr->where, conf_current);
+			if (tr->if_exists != EXISTS_DEFAULT)
+				trailer_set_conf_if_exists(tr->if_exists, conf_current);
+			if (tr->if_missing != MISSING_DEFAULT)
+				trailer_set_conf_if_missing(tr->if_missing, conf_current);
+
 			trailer_add_arg_item(arg_head,
 					     strbuf_detach(&tok, NULL),
 					     strbuf_detach(&val, NULL),
-					     conf, tr);
+					     conf_current);
+			free_trailer_conf(conf_current);
 		}
 	}
 
diff --git a/trailer.h b/trailer.h
index a2569c10451..32fc93beb33 100644
--- a/trailer.h
+++ b/trailer.h
@@ -55,8 +55,7 @@ void duplicate_trailer_conf(struct trailer_conf *dst,
 			    const struct trailer_conf *src);
 const char *trailer_default_separators(void);
 void trailer_add_arg_item(struct list_head *arg_head, char *tok, char *val,
-			  const struct trailer_conf *conf,
-			  const struct new_trailer_item *new_trailer_item);
+			  const struct trailer_conf *conf);
 
 struct process_trailer_options {
 	int in_place;
-- 
gitgitgadget

