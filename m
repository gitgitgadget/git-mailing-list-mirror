Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653B43C0630
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219037; cv=none; b=DxKH1hq7VtA6NYphlqWZszZnkXLLlDeWZAKJmNcUEiSae/xFe0FtcFnRJKhtgR6DiAPYVfsgQ7PV4ibpWSaRFIXQZ84nE0F6clrDjkcsKS5seSuFWhlJZFj2yd86u3TE36ozNi3I8hHGYEp8S4WGDI3xjvXA7FkQDsfypJEb6t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219037; c=relaxed/simple;
	bh=oWeuFvn+CXp77S5BiZkZRbcl2jHaBsY0jNodiz80ld8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=taZXLElc5CU/Aze8EYJEXD7UPxbMBxtxbKrOhuwAKlzziKtdsK+YpLkt6SB6opvdg7iGtoMh2APRbkETM+zADlDVRaALbTgwWYqDtgQX92bA6wuA3ebWTUqqFs/TPrw7IzRy8RQAE4MLJQty9vVxK4p951/opIJM44o5td+LlBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVSaoISi; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVSaoISi"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8cd73c4a827so469596285a.3
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 01:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773219032; x=1773823832; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zh1bTJxvitHIE/AI9UJxPv+vM4oSuCUxw5PvsFs0/r4=;
        b=kVSaoISi9r6/nADZ7CE1+tX+dgEESEfEe7uOVF14lNjrAmIwwTbjGbrrkMO0ttNLch
         31WXgpejgTj1G3VJRCjxQIgZ/5JU1rZXz836kpHA2QU09jk0FtYTLjIExIbMbgnayjPQ
         ZHzJMusamocgURixAwaZF712f9QhbWxRxbnQR7/HBwZxBxTeQ8MsMMTMweqNqezQ3l6L
         eQC8KPiBzdbzLamqdhvy5NFiIEhQYquHus/ysifMB3m64g9K2eLBKjfGLz/79vWPgtr6
         oRuq53jUu28wizMMnelGcAjtq5TlpVfLCL6V9xilFc8NwwIg915uI1TKUba+GVp/Ggx3
         QRug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773219032; x=1773823832;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zh1bTJxvitHIE/AI9UJxPv+vM4oSuCUxw5PvsFs0/r4=;
        b=ZqR9wh2SXDxczOw6ZFNSEkiNC9WakoXi3z1PKqYqvxBx9gSVkDKkOoEI8GHZhiSXyZ
         lPu195KfYD0oy6g99cCO+W8K0ymyqWS1OLPfXyhUeuqwPhsw/1qh3IPsmmnfwqd/1KNi
         QRotmrT8h/XQ9tpXwoApM46QUXrcylvHeqA+hsZtupBLmNejaGEdrnQaQ+IofVMCOaxd
         80KkKYxKivXXWR+PBn24T26DujdV6FHipmufFF7ZkVUM4KzoHXx8fiAK88Jcw/AmmGSI
         TYQC2hkHvGeOVaED6UQw9Up0hb5+id3EujIQ64MmgjWxOmv+7Om2bMd+7vQ8jGfXHW0o
         C39g==
X-Gm-Message-State: AOJu0YwmKKz9L9AyLP7tvn4id6Zt8tTugqX3Y612nUjP4SFoEZBoIgUh
	BPWsOAtamQyNDoZdP8dJ9G3isT8VgVOEGkVEdcBq4ixKLFPXru1gkqZyK9s3oXog
X-Gm-Gg: ATEYQzys3bVcDyV7mtYKLRQ//ZRefNiEaF92K8ygwhr3OQLHQJ8BTa0CIWEbhBKns3U
	0wDl3GupnXkXrUWKEiCF7t5/Or/3jix2/lgq78lFRZkoB593xfCFITSLFnbToj0xpD+yO8etFkM
	Rvh0xbIFvehzgJoNWJ2ob7eFHuG02jsgE6nqL0z7Fvmkb1985IaD8Fw1WMjKjNnHLit0VNXvffb
	QZWBtpGWbC7hoL62D3r7Y8hdTiDzwNGS+torhk1vLRVvwtAP/wiuHsl3zenQDLmO8xbqyq06yJv
	veTcMDtBeNB8ppYcyleJUjgu2vSxjXIz3WgTfT66eGdblCo8aP6iEiruxWR+Q4M4eopSN+21l64
	7JLI4C63+g/xxN06mYHOaP4TfrW9WN2EkeLpJyCo7rFwL1n/MYFx9H8BW9aeMV5JjsaVliFrKWh
	jVXFq20QSQXLSuOZLkd0mGJZo=
X-Received: by 2002:a05:620a:1a82:b0:8c9:f996:81f9 with SMTP id af79cd13be357-8cda1ae719bmr200886685a.82.1773219031690;
        Wed, 11 Mar 2026 01:50:31 -0700 (PDT)
Received: from [127.0.0.1] ([40.81.42.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda21100dasm97777185a.25.2026.03.11.01.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 01:50:30 -0700 (PDT)
Message-Id: <pull.2233.v4.git.git.1773219028.gitgitgadget@gmail.com>
In-Reply-To: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
References: <pull.2233.v3.git.git.1773149337.gitgitgadget@gmail.com>
From: "Arsh Srivastava via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Mar 2026 08:50:23 +0000
Subject: [PATCH v4 0/5] Advice on checkout dirty files
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Arsh Srivastava <arshsrivastava00@gmail.com>

This is my submission for microproject [GSOC]

This patch adds a new advice type ADVICE_STASH_BEFORE_CHECKOUT to help users
when they attempt to switch branches with local modifications that would be
overwritten by the operation.

The new advice follows the same patterns established by existing advice
functions such as advise_on_updating_sparse_paths(). When triggered, it
lists the affected files and suggests using git stash push/pop to save and
restore local changes.

The advice can be silenced with:

git config set advice.stashBeforeCheckout false

Changes:

> advice.h: add ADVICE_STASH_BEFORE_CHECKOUT enum value advice.c: add
> "stashBeforeCheckout" to advice_setting[] and implement
> advise_on_checkout_dirty_files() function
> Documentation/config/advice.adoc: document the new advice key

Signed-off-by: Arsh Srivastava arshsrivastava00@gmail.com

Arsh Srivastava (5):
  advice: add stashBeforeCheckout advice for dirty branch switches
  advice: add stashBeforeCheckout advice for dirty branch switches
    [GSOC]
  unpack-trees: suggesting 'git checkout -m <branch>' with its
    repercussions
  Updating tests and unpack-tress.c [GSOC]
  File updation [GSOC]

 t/t6439-merge-co-error-msgs.sh | 6 ++++++
 t/t7406-submodule-update.sh    | 3 +++
 unpack-trees.c                 | 9 +++++++--
 3 files changed, 16 insertions(+), 2 deletions(-)


base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2233%2FArsh123344423%2Fadvice_on_checkout_dirty_files-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2233/Arsh123344423/advice_on_checkout_dirty_files-v4
Pull-Request: https://github.com/git/git/pull/2233

Range-diff vs v3:

 1:  eb5639dbc3 = 1:  eb5639dbc3 advice: add stashBeforeCheckout advice for dirty branch switches
 2:  e88c851701 = 2:  e88c851701 advice: add stashBeforeCheckout advice for dirty branch switches [GSOC]
 -:  ---------- > 3:  4237b9667d unpack-trees: suggesting 'git checkout -m <branch>' with its repercussions
 -:  ---------- > 4:  b25ea22410 Updating tests and unpack-tress.c [GSOC]
 -:  ---------- > 5:  2ef7d5a3d6 File updation [GSOC]

-- 
gitgitgadget
