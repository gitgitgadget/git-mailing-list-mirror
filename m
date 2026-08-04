Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1E742BC46
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 22:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785883221; cv=none; b=eJOk3kWwv5l/BXuDhWS0A9BrVWv5g+2WNmcIfiuRWqAuHQAXvHuW4orlMLOUHEw1gaCw6CVFKquWNAvees8o1tg5n7jj1gU/hWX214fg4UAEsiLpWGA+KtFLbIX2lTmZ2DzNIk9PUoELHtedEkvRY36L2hJ1vednXDAaPg51RXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785883221; c=relaxed/simple;
	bh=5mKBrNmwwIvzZYdKVVwYLuVHl7fTp0wdt3LnIKO/GHs=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=Nw4XAbKHowV7o/DyOGrc1t3TD01+SVfJmoiI0v21ZLwyQPCPPvDCEA1sCE0LeEE1Cr5W4lxtbiuFdUteVlIEOMVgrErCQ/Li27myGiuG8IJx/zjtRKI+3s+FTDC4g03FVf+4WWMH/AH+XeyZblBBWt18AWbWt7H7Q+ZcDCbYi3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z2fHk9Vf; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z2fHk9Vf"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-382ef647e20so352536a91.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2026 15:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785883219; x=1786488019; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kgEjS00c/vz/kCxF5CktkMo8wQ7ufqB/MNIyk9cRLiw=;
        b=Z2fHk9Vfg42akvIptfA0UjiUF14Qua4PfazIDz69R11kJp4z//99AfksawYlkJA4gB
         cpT4bu4eSJTsoRYhasZT4uESq1jV0uDzqqfOWYngNDyopdcvKKYlya7wAUKzd7oGvSiq
         cEsz+48EiCzMVaNAAgJrZxw4R4DC0l+f9PtIuuim/qnOv6CGNScBTMbNuxj/iaHQJWfm
         n++KfKz2JbQlIi+Y+xbF77JY6XLBuwDZXABYkEHfyzpwOuuBXQmkWW5yC9106H5uvYMG
         nabeh+oYtZ2dffxQLQ1UUr/YnZrfZFX4KjNgUFLbwnZHJGQOXUOeievFV6YCLCM6A5El
         yPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785883219; x=1786488019;
        h=cc:to:fcc:content-transfer-encoding:content-type:mime-version
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kgEjS00c/vz/kCxF5CktkMo8wQ7ufqB/MNIyk9cRLiw=;
        b=ZZeZ+IBpq/6vxpgqM0byr4gYMdgs0xy/8hrdlePjUBXYUR2fDAhsanmYGIvtJ+nNV2
         8QctrJ706Wei/DRrYHWOTvVkjaQcciiJVtyKoH/PPRC1ThTlNLgoU+epI/bgbsQxumpS
         pjBRDXik4BWj42KAgJsAgbMDL0S2f1eI5wf6VTMD/n6/kuiDfKrhPRMwluYWG4QY1/qL
         kYCXRo4pgEPryJeOdEsA0TAEPmNk2xdlSzFQpiA5gpAxzdDUKSgLJq4wtE5yIYe8Hi2b
         q0zGlwxbvO6E/R5+7w/Ia51vJzyiSKvvRR34kWyAMPSmlDpl9TSV9jy/3dMZCltvAZGF
         KAcQ==
X-Gm-Message-State: AOJu0YyTCaT2t4AKPEllOGt7gVbpTWzsvFmgastBnS42cUTI9nT2xOC+
	St48rOjcm5i32W8ylXYENnmpOnaC7AsoYo9HIOvENdb6j1OjivqChj7IajSkww==
X-Gm-Gg: AR+sD1001ws+L0Egv34eVEwmssY7CWkZVdmW5tpAs1y9L5TXG/LWhyECdC6Um+JVmPO
	8tDpcxXzSC06BjubYsTkfld8LWjIIMaYKcfssBhYMTCzOwJvzPKNFLGqRCY21ZiusWKWV+kPEAQ
	HU6x+rx6N8GWiI+Uoytr9pHtLb+Or1uFQAU6QOxNvQoS7eMLLsXfn/IUv/XyyKfEy+dVmd3/636
	Nk03CXNiuB51az3+5uijEDDUH2O1wvAJyEuxCGSkKRfWCFY+MD3QCKXfVudTvRRiuZYOTkAtQ1h
	9PAgr2S09bkMeGgBcQCfnPFkgtNsYI2dOkSOUmGxJ8RPIaOOO7iJI5G8Fpj76yx9Smil02af7NU
	XaGBFzXd/NI1KDkLi5y5PHwv3Bt6oGeMbwR6+AmgQf/7Vpj2Ya/N/uRXi+oi4Nfc+NxrnAsdHiU
	C7aejuyaXd4950N9YLJ59GtNFukJ8EGdBDGxMbYwsKVauQRX5GG0jgpWYTmZzOhhyr
X-Received: by 2002:a17:90b:1843:b0:37f:bfa2:1887 with SMTP id 98e67ed59e1d1-3903c53639amr2652805a91.8.1785883219103;
        Tue, 04 Aug 2026 15:40:19 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.101.211])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867bc341sm15214359eec.27.2026.08.04.15.40.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 15:40:18 -0700 (PDT)
Message-Id: <pull.2372.git.git.1785883217733.gitgitgadget@gmail.com>
From: "Daniel =?UTF-8?Q?Mart=C3=AD?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 04 Aug 2026 22:40:17 +0000
Subject: [PATCH] credential/libsecret: load secrets explicitly
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: M Hickford <mirth.hickford@gmail.com>,
    Mantas =?UTF-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Daniel =?UTF-8?Q?Mart=C3=AD?= <mvdan@mvdan.cc>,
    =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>

From: =?UTF-8?q?Daniel=20Mart=C3=AD?= <mvdan@mvdan.cc>

secret_service_search_sync() can return an item whose secret is not
loaded, despite SECRET_SEARCH_LOAD_SECRETS being set: the search
silently discards secret-loading failures, and the GNOME keyring
daemon silently omits from its GetSecrets reply any item that is
locked or that was deleted after the search matched it, e.g. by a
concurrent "credential erase" from another git process.

secret_item_get_secret() then returns NULL, which we pass unchecked
to secret_value_get_text() and secret_value_unref(), producing

    secret_value_get_text: assertion 'value' failed
    secret_value_unref: assertion 'value != NULL' failed

and losing the password even when the secret is still retrievable.

Drop SECRET_SEARCH_LOAD_SECRETS and instead load the secret of the
one item we use with secret_item_load_secret_sync(), which does
report errors. A secret the search would have silently dropped is
now retrieved normally, and a genuinely inaccessible item produces
a useful message instead of assertion spew, with git falling back
to prompting either way. Merely guarding against NULL would avoid
the assertions, but would forfeit a secret that is still available.
The cost is unchanged: the search no longer batch-fetches the
secrets of all matching items, and the explicit load fetches the
one we use.

Signed-off-by: Daniel Martí <mvdan@mvdan.cc>
---
    credential/libsecret: load secrets explicitly

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2372%2Fmvdan%2Flibsecret-null-secret-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2372/mvdan/libsecret-null-secret-v1
Pull-Request: https://github.com/git/git/pull/2372

 .../libsecret/git-credential-libsecret.c           | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/libsecret/git-credential-libsecret.c b/contrib/credential/libsecret/git-credential-libsecret.c
index 941b2afd5e..6bbdf2bd45 100644
--- a/contrib/credential/libsecret/git-credential-libsecret.c
+++ b/contrib/credential/libsecret/git-credential-libsecret.c
@@ -126,7 +126,7 @@ static int keyring_get(struct credential *c)
 	items = secret_service_search_sync(service,
 					   &schema,
 					   attributes,
-					   SECRET_SEARCH_LOAD_SECRETS | SECRET_SEARCH_UNLOCK,
+					   SECRET_SEARCH_UNLOCK,
 					   NULL,
 					   &error);
 	g_hash_table_unref(attributes);
@@ -143,6 +143,18 @@ static int keyring_get(struct credential *c)
 		gchar **parts;
 
 		item = items->data;
+
+		/*
+		 * Load the secret explicitly rather than via
+		 * SECRET_SEARCH_LOAD_SECRETS, which silently discards load
+		 * failures and returns items whose secret is NULL.
+		 */
+		if (!secret_item_load_secret_sync(item, NULL, &error)) {
+			g_critical("could not load secret: %s", error->message);
+			g_error_free(error);
+			g_list_free_full(items, g_object_unref);
+			return EXIT_FAILURE;
+		}
 		secret = secret_item_get_secret(item);
 		attributes = secret_item_get_attributes(item);
 

base-commit: 5b2471720c93ee30e5764a19f3d3b3ae9ec9712a
-- 
gitgitgadget
