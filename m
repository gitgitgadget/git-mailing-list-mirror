Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9482E1AB53B
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 15:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726067923; cv=none; b=eYf+YdWw5g/3HONG/cUwRaIYcHA0CaHZGeizsKKMeVr/+5iR/3F6AMJa5upzsJCsUTyaN8xjZIvkx3JL54tRU+jAJjqcuJQIKk9dHKVInxL2pcxf9OSkQQDel7ye7KODeDiwcWn6qgL42Tpgmk4AsPlcWW2j0BZ560rhAzhvbDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726067923; c=relaxed/simple;
	bh=COlog7r+7Vt9Yx+63eZ6yaQJ6rzY4eKyk4XFSzLQP9I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MKbREtpPmhqo2OVW/7aC/30PvL9ESPrxcCbm0zVLUQ3dcbeGFPKsPEAbMnwNWjFojU/SUoLKK8m+3OR4gzd45De9GhEZbJA4q+vvYW133/jqA2KhIYNZcjMgVW9zY/fobEXhiKB2zbBXaxBLIFkmZHQ1SU/5DTHE5qQpllupJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw0ti+bg; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw0ti+bg"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c24ebaa427so1680482a12.1
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 08:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726067919; x=1726672719; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YNBR18b7BGiRB3Ncu48NFZ8PDEckL+7WFNx8Vd+57xQ=;
        b=Cw0ti+bgZVuKu+lPhjxMi88HwKeeRvcgeYKg6FEvurp8YDdxkaChC2nJor3PQbHWF+
         68XoMqQ6zDxxPlVw9yYprMfhesMGEN9jMzI4HPxkuJDDkLZ6gkdUK9BcfMTK5m95Ttyd
         im3qe5uzsz1Kmf8q2Rg7LZw9FNFsNfSDehFqZDfbHK/OvnhpJmuYp6ToceMt23D9+MMO
         dxUvXyoIFiNQP9SOzCUTHfK2vzcu16vWGE8OwKUIWQ2zz/+HFxD5spS0xap6bazXtOJ2
         1koAadQ+hamQ8sTf+ahQOowr+JvGUOHPZLQ+eYt6SRhOteuPB2Q3BXGX+lndWQr3tA9b
         aUig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726067919; x=1726672719;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YNBR18b7BGiRB3Ncu48NFZ8PDEckL+7WFNx8Vd+57xQ=;
        b=I62+isl2xbo/hJYFLt7nubxRvw+mrR/uuHRl2AE4qJc2IKtPtZjfDmhfaVhMNSi7tB
         frznOk9Cpm2PXtMn1jVyN9LWTaAIOBRfcVz2PRrtB95Lte117IzD3jH4MEPYbrAjPDqq
         ltT4O9LXNS7JImM3Iau7l9Ah8/6T3qTj3pHwsoeSuqkkqzqCCXN9PewGP+fSshybxtBi
         ut07KHDmgzXVdjqudrwouen862/ETsrudb1Vnd2HvLyHBldCbxLsIsXAa4ttCjw5elTj
         OWzo44rgnTsv3cF6025DlYPKZ9HNxR5cykYAvsejsZ/WUGSCunLT7NuBs6yy1HH3DAIX
         Ev9A==
X-Gm-Message-State: AOJu0YxH56EavgKO00xgOZKnL+BEVXrFCJfbDr1vHv58WlQ+XqvLUIdQ
	5uc/4QcRP6+ZbBw18cHzF2ufHKshIOgr+hTaoVNRAfV0yN1AN41tNvKa8g==
X-Google-Smtp-Source: AGHT+IGsjsdKJryIGY1XYyP3gzsAo+fIHRWZBiQCTeeJzR67AkIiwPRW1JsynitJOGoM9hNJoJ58HQ==
X-Received: by 2002:a17:907:6d09:b0:a7a:8284:c8d6 with SMTP id a640c23a62f3a-a8ffb29987emr524079366b.24.1726067919505;
        Wed, 11 Sep 2024 08:18:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72ed3sm624215366b.135.2024.09.11.08.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:18:39 -0700 (PDT)
Message-Id: <a8dfe403d0683aec4265bf920921e45d5b59cec3.1726067917.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
References: <pull.1789.git.1726067917.gitgitgadget@gmail.com>
From: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Sep 2024 15:18:35 +0000
Subject: [PATCH 2/4] remote: print an error if refspec cannot be removed
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
Cc: Han Jiang <jhcarl0814@gmail.com>,
    Phillip Wood <phillip.wood@dunelm.org.uk>,
    Phillip Wood <phillip.wood@dunelm.org.uk>

From: Phillip Wood <phillip.wood@dunelm.org.uk>

If the existing fetch refspecs cannot be removed when replacing the set
of branches to fetch with "git remote set-branches" the command silently
fails. Add an error message to tell the user what when wrong.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/remote.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 794396ba02f..4dbf7a4c506 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1603,6 +1603,7 @@ static int set_remote_branches(const char *remotename, const char **branches,
 	}
 
 	if (!add_mode && remove_all_fetch_refspecs(key.buf)) {
+		error(_("could not remove existing fetch refspec"));
 		strbuf_release(&key);
 		return 1;
 	}
-- 
gitgitgadget

