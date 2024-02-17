Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B508A8004A
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212904; cv=none; b=JfjlimHOgYW4tl63IOEgCjtwNbE1vOetUh3ZKN3hbHeFfj/bD0QQ1N2ZUnhHlEYb2irhOW8mHTeXFI0kNRp/+nCZ1i0uZnaEXqLzIdZGTKqm2+iF8yeMlDFsGanmar/m8OglWpHjsrS5c1TJXJx5e+Sf9RbmnVqqh5Mo3iHwe2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212904; c=relaxed/simple;
	bh=F1NycC4EbjBByTSH5lB0vzLaycThwC2dpbQy+fLogFs=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sZrJdU2MHWccCXdOZvNfo/Ihreetmiz2Ei/TMbEJ0gVoQr8iGjfqaktDeyAt78ZP148AiKr5Pv25RSB6MVn/yta+NKUSE2xZMwE29ktWtRHwAK+2pBrGD8fQaYQSkMl7DzhNJdrU0NIHFMsIhQBmqnzuRV8I0r/r5qYwRSSlnBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfAXApXn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfAXApXn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33d44d78e5fso6659f8f.1
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 15:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708212900; x=1708817700; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6cJKvxkeDZHNTPChkIA6Cm3kCYYihCcNkZPxmSdbj8=;
        b=IfAXApXn924hic4Pr/egFf5Zb3i+1+izGVSDihmoCaYpt6w8+dUSs6cnJSBkq4jIRB
         8pD/CJSzfkGBMASjP3P0zg5dbwmssw/ZcXSxW4AZ35v8EGrTU6PvWmyow1YCK9qSqRcz
         Ky1zjQyEEPdzCEz4/JzsAFkKp52/H1q0y+ib7vwI1MelQP5ZCzbFKv3+CK+8q6vC2GY7
         0Jx5G1RHWzUXRPWbwdmbNdM6fO8f4z95orsxJnkfukXCERmCrviFgTt76ef42G3283wj
         JN2rHgCk4rqS476QrPAmMktuvMsSjpSG7zTNvc3y7ofjdD04bv8ujbkvcm8dFBuTpSHg
         gWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212900; x=1708817700;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l6cJKvxkeDZHNTPChkIA6Cm3kCYYihCcNkZPxmSdbj8=;
        b=URJIDQr8FQTQ/aHKaN29WCE8YuvClJe2/Tiw8Mq7SSRnoqpyf5Frbq9DNpEP4K7zvN
         hRmGzLmUVZjq1GAFppfNRQZA6PdgwSWjokDB+OZwuqge0pjpASVPnChT4y8vPkPiUbOQ
         rzJ88v2OTOonEIJU69K9AMbUHWnWFza6wfPYxXqEri2kiNZzx6Vgp+2L5kh0MbGjbuXz
         +9+verYRgI/WXEh5YkHu0rsy0A5y4RuWobJRzlRkuoq10wkzXlKBZKKGSKQSSK9XVgXs
         yM0B8WuN7z35QdJq2kIrKVu7wo2pBuKNKHoK9T8hp2U2+w0pC9Dv3N/aT7tv7mlBF3as
         yBFg==
X-Gm-Message-State: AOJu0YyfjbEqxDL/B1JFz5rKubySAn5Y0j83r9s1qxL9+BrmQZBie1uA
	uf++lavdHtTcnzhQa0iApPA1ND5kYHwEoAvD5QnIVRPpnFfHLcsvxIzEXeMd
X-Google-Smtp-Source: AGHT+IG0MDxLgcaFqwb++nTBtb10EZCqCKpslv9htcUlef5BvmYuunZKGGJKE+xRl2QCq1a0JEc/QQ==
X-Received: by 2002:a5d:4c85:0:b0:33d:3cea:847e with SMTP id z5-20020a5d4c85000000b0033d3cea847emr293400wrs.21.1708212900029;
        Sat, 17 Feb 2024 15:35:00 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc13-20020a5d5c0d000000b0033d20b430c3sm5251447wrb.115.2024.02.17.15.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:34:59 -0800 (PST)
Message-ID: <f7ac228aae69941032d904c3c6222216786c1d0e.1708212896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Feb 2024 23:34:55 +0000
Subject: [PATCH 3/4] osxkeychain: erase matching passwords only
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
Cc: Bo Anderson <mail@boanderson.me>,
    Bo Anderson <mail@boanderson.me>

From: Bo Anderson <mail@boanderson.me>

Other credential helpers support deleting credentials that match a
specified password. See 7144dee3ec (credential/libsecret: erase matching
creds only, 2023-07-26) and cb626f8e5c (credential/wincred: erase
matching creds only, 2023-07-26).

Support this in osxkeychain too by extracting, decrypting and comparing
the stored password before deleting.

Fixes the following test failure with osxkeychain:

    11 - helper (osxkeychain) does not erase a password distinct from
    input

Signed-off-by: Bo Anderson <mail@boanderson.me>
---
 .../osxkeychain/git-credential-osxkeychain.c  | 56 ++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index e9cee3aed45..9e742796336 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -169,9 +169,55 @@ static OSStatus find_internet_password(void)
 	return result;
 }
 
+static OSStatus delete_ref(const void *itemRef)
+{
+	CFArrayRef item_ref_list;
+	CFDictionaryRef delete_query;
+	OSStatus result;
+
+	item_ref_list = CFArrayCreate(kCFAllocatorDefault,
+				      &itemRef,
+				      1,
+				      &kCFTypeArrayCallBacks);
+	delete_query = create_dictionary(kCFAllocatorDefault,
+					 kSecClass, kSecClassInternetPassword,
+					 kSecMatchItemList, item_ref_list,
+					 NULL);
+
+	if (password) {
+		/* We only want to delete items with a matching password */
+		CFIndex capacity;
+		CFMutableDictionaryRef query;
+		CFDataRef data;
+
+		capacity = CFDictionaryGetCount(delete_query) + 1;
+		query = CFDictionaryCreateMutableCopy(kCFAllocatorDefault,
+						      capacity,
+						      delete_query);
+		CFDictionarySetValue(query, kSecReturnData, kCFBooleanTrue);
+		result = SecItemCopyMatching(query, (CFTypeRef *)&data);
+		if (!result) {
+			if (CFEqual(data, password))
+				result = SecItemDelete(delete_query);
+
+			CFRelease(data);
+		}
+
+		CFRelease(query);
+	} else {
+		result = SecItemDelete(delete_query);
+	}
+
+	CFRelease(delete_query);
+	CFRelease(item_ref_list);
+
+	return result;
+}
+
 static OSStatus delete_internet_password(void)
 {
 	CFDictionaryRef attrs;
+	CFArrayRef refs;
 	OSStatus result;
 
 	/*
@@ -183,10 +229,18 @@ static OSStatus delete_internet_password(void)
 		return -1;
 
 	attrs = CREATE_SEC_ATTRIBUTES(kSecMatchLimit, kSecMatchLimitAll,
+				      kSecReturnRef, kCFBooleanTrue,
 				      NULL);
-	result = SecItemDelete(attrs);
+	result = SecItemCopyMatching(attrs, (CFTypeRef *)&refs);
 	CFRelease(attrs);
 
+	if (!result) {
+		for (CFIndex i = 0; !result && i < CFArrayGetCount(refs); i++)
+			result = delete_ref(CFArrayGetValueAtIndex(refs, i));
+
+		CFRelease(refs);
+	}
+
 	/* We consider not found to not be an error */
 	if (result == errSecItemNotFound)
 		result = errSecSuccess;
-- 
gitgitgadget

