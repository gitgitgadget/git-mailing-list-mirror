Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF1B1FD8
	for <git@vger.kernel.org>; Tue, 14 Nov 2023 02:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c6DPOrgs"
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04382F3
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:18:51 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28019b66ad5so4628425a91.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 18:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699928330; x=1700533130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tgFo12HgXCibStpbmTsVwJkqaVeDBaJDA+5C4c1D0eI=;
        b=c6DPOrgsfAaeAi301XVVN9UZQQAPjvk8Df3NMN1d3Vb9vEpsjUG+/3SLPEC+0K6Qz2
         At3f34HIEw7Dmqz81Rfr3n9wIlHRg5GHWCd+BV9akxIfxQcsRlWF+zKrRSNNt0V4ch8j
         lNBWV07PZPk+FWDU5jeAJX+nKMG57a3MIf/SVO2qT9oBE0CAw0poijIXQdlMO+LMSJKx
         dE9nrG2/CV61gjum0nWWfbUNoPVMtirX/Fe71TZvyjvBuwT6zaUJOzoLTpvKWqkFl0Ap
         QhdxyFUvePky20ozs7wiEu5ZRYzAhbgpizj3c/fA3BKnkYLKJ8ki2dypshd+YiXRjvvF
         BYUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699928330; x=1700533130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tgFo12HgXCibStpbmTsVwJkqaVeDBaJDA+5C4c1D0eI=;
        b=W3ti1oUU1Gt6no65C0iNsOGRRgwXt0I4XXHLM/n8BWsU8EyknmPYKToWiFR5p7LUVK
         c6F0qmSkQb+Yog4rWeVOc5aO5cS42ywTVV3rRWRl52qRjqeJEXZ0tDIxbVUjOq8BmuPS
         COCbHYsny8G2mg0nFKKaKtFIF68wM2EWpQP0wABv0vVq7ZoP2QJL5Sw2Mg0RkBa5wX51
         KFe7PUU+h0XokwDTJioO3HeCIQ4eDSsaREXaIZje/KNlhfIwo1lNe8LJfEBXkvMs82E5
         VgmnvMowMG6XjBFBR6RpGf3W+iiMPzl5zytsSLuu+Q63Af9UDxvto6ff7hEpgMldRyJZ
         0YnQ==
X-Gm-Message-State: AOJu0YwLFlHOO9ZEk1KT9utcN18rLmQzc5QoYEQ3rssrfTA4iGdKXLu9
	xqP6wxXo8SodgsDMJBYczOYBKqQU7ZSQQg==
X-Google-Smtp-Source: AGHT+IFkzdc+RjDV+3WEJBIyd3+bkrhcS+JJUR80DhV1eFyvicIhHUFZ7a8ZNQLulPZgnEehNmuN0A==
X-Received: by 2002:a17:90b:3811:b0:27d:b244:cd28 with SMTP id mq17-20020a17090b381100b0027db244cd28mr8650653pjb.42.1699928330385;
        Mon, 13 Nov 2023 18:18:50 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.61])
        by smtp.gmail.com with ESMTPSA id a17-20020a17090abe1100b002775281b9easm6084396pjs.50.2023.11.13.18.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 18:18:49 -0800 (PST)
From: Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: [PATCH v3 2/3] update-index: add --show-index-version
Date: Tue, 14 Nov 2023 10:18:38 +0800
Message-ID: <20231114021839.8275-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.43.0.rc1.dirty
In-Reply-To: <20230912193235.776292-3-gitster@pobox.com>
References: <20230912193235.776292-3-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> @@ -1181,15 +1183,20 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  
>  	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
>  	if (preferred_index_format) {
> -		if (preferred_index_format < INDEX_FORMAT_LB ||
> -		    INDEX_FORMAT_UB < preferred_index_format)
> +		if (preferred_index_format < 0) {
> +			printf(_("%d\n"), the_index.version);

Maybe the "%d\n" shouldn't be translated? :)

Thanks.
