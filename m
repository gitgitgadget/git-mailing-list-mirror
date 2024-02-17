Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722358005A
	for <git@vger.kernel.org>; Sat, 17 Feb 2024 23:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708212905; cv=none; b=IwJuHBhACMNGSFHRdQeAGw2xkaU9jN/oIcpGvX6qb12baqLz4kF0YcpB48Ojvx0zHqHKmiB1XA9jhd8ANImfG4fIIhTIrxf1TCKGBzhYmduWtmq3QGNbKrH6EWjd9gLUBwbCZQ25Ch/R00qsgTgqncA37Gz8ANvPsn1gj1Osjy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708212905; c=relaxed/simple;
	bh=4jD8pmRlv6ad2wDanogWcel3p7qGO2vS39tO6qUq8HI=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=mKqo1NFie4VO5dpU1wqT42cR/FglPTH9Ylo4GWXvc6MXFwaURX3CSGXdwAVQ9KB8ZLPOKtKjhoNEWQXNhHYT2OrkcWwaShidYPRlj2rPmD+R0z3OFVgmT1Sdo3JFBmtpUF8SEsWxB668NlZeplixueI1Ge6OCPXA6xaQOqw+1HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVzpgrE4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVzpgrE4"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4125edd1433so4020015e9.3
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 15:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708212901; x=1708817701; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dodAeWsH547xv+IK6TnuopmC6F/C6q3+GbJxPeogXcQ=;
        b=DVzpgrE4W7IWwad3/chLeguwiznnEOIXyPqCrK2gaDUjUgZaPMk7y5OfTXO/o5KlM+
         e5bQcuRizJFuCh+/Yo6HlEhHeBwQcgvjssXOq1MPf6EJw76eNpLVYnrwDKBh8gIEPi/S
         WpaIF38W6Toe3TFem1DnBnntpLb5iXvgwAfOwv7FsFS2s+HZyJS4OvMfvBABd5o32zkM
         o5OJ1RT2ubQ+dw5Rvc8g875eOVK6JSgtGRCEwPJ7xdqcLfkb2XZcf3TYfuURELtFTWxm
         wisuE8hTaf2en/E4moWJmEAjB7pLZ8PQUEojKJHyf7AcWE8SmSodG/Mkwx4hYM2p7BlM
         Cc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708212901; x=1708817701;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dodAeWsH547xv+IK6TnuopmC6F/C6q3+GbJxPeogXcQ=;
        b=qLdTKZtefdpZcpQankmXOD/ktiDRFIYCvYEuVjgejhH7FuVis0KWGcUy7M1mwEJkik
         XUQO1YewEEX2p55N/xP+V5aADiYtL0FCMn2G8qVUK2cebrI2ahXYoO8T1GKey4I6FMVx
         S+1mtIHYL9BbYIcxwb3HEk8IctWIyzjiRgxr95f4rK/4bwLtV6z3Na/REZi2imvZGZXJ
         +nkdL1muSpo2vGEOuHKVPoxuCXfIEdbHwDboInvOxelvJKzuNW2rPv2kaoS0AU0qPdda
         dDAnwON23b1rcWP6jWt4h1oY2HBfkIUbPx0c1vklcpjXesKFep1fdD7rXYP9Zv9RJuGQ
         eCDA==
X-Gm-Message-State: AOJu0YzBlY13KhToMEq/osqHCYyCSqm8IJjnp/SQoPInhBWnqx18GuRd
	tPTvlh5x9nc0CEegFFKAwd8q8NVwi/kvDEAHG6V+md/wRT72mdIxttwsgiNr
X-Google-Smtp-Source: AGHT+IEX7Y/YQNKDDnV2x8fingFPY92iAVlSsL56YdN2NFkqW3Bvn8T8v1qlzimvL6fmOrtvLInUyw==
X-Received: by 2002:a05:600c:1f17:b0:412:5efc:ef59 with SMTP id bd23-20020a05600c1f1700b004125efcef59mr1026110wmb.0.1708212901521;
        Sat, 17 Feb 2024 15:35:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b00411e5c1bcbasm6623599wmo.0.2024.02.17.15.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 15:35:00 -0800 (PST)
Message-ID: <f18435b2189bb08bcdba3b28523db1d4484f66cf.1708212896.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
References: <pull.1667.git.1708212896.gitgitgadget@gmail.com>
From: "Bo Anderson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 17 Feb 2024 23:34:56 +0000
Subject: [PATCH 4/4] osxkeychain: store new attributes
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

d208bfdfef (credential: new attribute password_expiry_utc, 2023-02-18)
and a5c76569e7 (credential: new attribute oauth_refresh_token,
2023-04-21) introduced new credential attributes but support was missing
from git-credential-osxkeychain.

Support these attributes by appending the data to the password in the
keychain, separated by line breaks. Line breaks cannot appear in a git
credential password so it is an appropriate separator.

Fixes the remaining test failures with osxkeychain:

    18 - helper (osxkeychain) gets password_expiry_utc
    19 - helper (osxkeychain) overwrites when password_expiry_utc
    changes
    21 - helper (osxkeychain) gets oauth_refresh_token

Signed-off-by: Bo Anderson <mail@boanderson.me>
---
 .../osxkeychain/git-credential-osxkeychain.c  | 68 +++++++++++++++++--
 1 file changed, 62 insertions(+), 6 deletions(-)

diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
index 9e742796336..6a40917b1ef 100644
--- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
+++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
@@ -6,10 +6,12 @@
 #define ENCODING kCFStringEncodingUTF8
 static CFStringRef protocol; /* Stores constant strings - not memory managed */
 static CFStringRef host;
+static CFNumberRef port;
 static CFStringRef path;
 static CFStringRef username;
 static CFDataRef password;
-static CFNumberRef port;
+static CFDataRef password_expiry_utc;
+static CFDataRef oauth_refresh_token;
 
 static void clear_credential(void)
 {
@@ -17,6 +19,10 @@ static void clear_credential(void)
 		CFRelease(host);
 		host = NULL;
 	}
+	if (port) {
+		CFRelease(port);
+		port = NULL;
+	}
 	if (path) {
 		CFRelease(path);
 		path = NULL;
@@ -29,12 +35,18 @@ static void clear_credential(void)
 		CFRelease(password);
 		password = NULL;
 	}
-	if (port) {
-		CFRelease(port);
-		port = NULL;
+	if (password_expiry_utc) {
+		CFRelease(password_expiry_utc);
+		password_expiry_utc = NULL;
+	}
+	if (oauth_refresh_token) {
+		CFRelease(oauth_refresh_token);
+		oauth_refresh_token = NULL;
 	}
 }
 
+#define STRING_WITH_LENGTH(s) s, sizeof(s) - 1
+
 __attribute__((format (printf, 1, 2), __noreturn__))
 static void die(const char *err, ...)
 {
@@ -197,9 +209,27 @@ static OSStatus delete_ref(const void *itemRef)
 		CFDictionarySetValue(query, kSecReturnData, kCFBooleanTrue);
 		result = SecItemCopyMatching(query, (CFTypeRef *)&data);
 		if (!result) {
-			if (CFEqual(data, password))
+			CFDataRef kc_password;
+			const UInt8 *raw_data;
+			const UInt8 *line;
+
+			/* Don't match appended metadata */
+			raw_data = CFDataGetBytePtr(data);
+			line = memchr(raw_data, '\n', CFDataGetLength(data));
+			if (line)
+				kc_password = CFDataCreateWithBytesNoCopy(
+						kCFAllocatorDefault,
+						raw_data,
+						line - raw_data,
+						kCFAllocatorNull);
+			else
+				kc_password = data;
+
+			if (CFEqual(kc_password, password))
 				result = SecItemDelete(delete_query);
 
+			if (line)
+				CFRelease(kc_password);
 			CFRelease(data);
 		}
 
@@ -250,6 +280,7 @@ static OSStatus delete_internet_password(void)
 
 static OSStatus add_internet_password(void)
 {
+	CFMutableDataRef data;
 	CFDictionaryRef attrs;
 	OSStatus result;
 
@@ -257,7 +288,23 @@ static OSStatus add_internet_password(void)
 	if (!protocol || !host || !username || !password)
 		return -1;
 
-	attrs = CREATE_SEC_ATTRIBUTES(kSecValueData, password,
+	data = CFDataCreateMutableCopy(kCFAllocatorDefault, 0, password);
+	if (password_expiry_utc) {
+		CFDataAppendBytes(data,
+		    (const UInt8 *)STRING_WITH_LENGTH("\npassword_expiry_utc="));
+		CFDataAppendBytes(data,
+				  CFDataGetBytePtr(password_expiry_utc),
+				  CFDataGetLength(password_expiry_utc));
+	}
+	if (oauth_refresh_token) {
+		CFDataAppendBytes(data,
+		    (const UInt8 *)STRING_WITH_LENGTH("\noauth_refresh_token="));
+		CFDataAppendBytes(data,
+				  CFDataGetBytePtr(oauth_refresh_token),
+				  CFDataGetLength(oauth_refresh_token));
+	}
+
+	attrs = CREATE_SEC_ATTRIBUTES(kSecValueData, data,
 				      NULL);
 
 	result = SecItemAdd(attrs, NULL);
@@ -268,6 +315,7 @@ static OSStatus add_internet_password(void)
 		CFRelease(query);
 	}
 
+	CFRelease(data);
 	CFRelease(attrs);
 
 	return result;
@@ -339,6 +387,14 @@ static void read_credential(void)
 			password = CFDataCreate(kCFAllocatorDefault,
 						(UInt8 *)v,
 						strlen(v));
+		else if (!strcmp(buf, "password_expiry_utc"))
+			password_expiry_utc = CFDataCreate(kCFAllocatorDefault,
+							   (UInt8 *)v,
+							   strlen(v));
+		else if (!strcmp(buf, "oauth_refresh_token"))
+			oauth_refresh_token = CFDataCreate(kCFAllocatorDefault,
+							   (UInt8 *)v,
+							   strlen(v));
 		/*
 		 * Ignore other lines; we don't know what they mean, but
 		 * this future-proofs us when later versions of git do
-- 
gitgitgadget
