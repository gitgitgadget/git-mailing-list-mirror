Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5618B09
	for <git@vger.kernel.org>; Sun, 25 Feb 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708882429; cv=none; b=AWMLJRdniA9lkXKkLOogbhAUgU5W9iRxPmza9DYhHY69YoMW2n8GmYpXTKUr2dbTZWQEy4ouemlBtA67svIlyN3caMbwvHh8KxW3LfFeVT/AujRgs3Zs1Fpq9GhucRVfJWTeba0ycVnaxyBjRoIrP0qm02PSUvrW70xNrJ/QG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708882429; c=relaxed/simple;
	bh=aB1GTxUqernP4mpN2QAiF4yx77bbrFwL7h1bFa5fWcY=;
	h=Message-ID:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KFsM79Grb2KksAuiOJzqtDJhllOcGYZ1f1587J4/FYVhpcpSInTwWqlBquFBliCOw78GaIhA5AKwiDR67u1R5ObM3UlxK6SufF1UrHhtIXtqb82Gg/3Rsw5YBCDzBAvyT7zVXy9N5uwfRDEXsj50vXST/LnOXYpMOLSY7NZV5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZ223YMJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZ223YMJ"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d240d8baf6so30038691fa.3
        for <git@vger.kernel.org>; Sun, 25 Feb 2024 09:33:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708882425; x=1709487225; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B81NKUc6sttYC5VeLOVI86yWCbwTiryMiL1obUfBca4=;
        b=fZ223YMJxBhUdWJdnrpliOZaLiBMtWeaxSBnZ2qcovGYHeEwS7peIRsCSNE4kqBCkX
         quXhbTHfgYwA9gPx0rgqvSE3Ug5IhyA9+zFWYl8eqiBqWAmXbS5iLv4HaXWWq0lUjYwe
         JaYPquHklrXNCciHmGCAhlici9Enx5rWlRQ2F4B/CMIadDeOMqA2uFwYdP18ZhuaieiS
         8tYwZ/g9RLlE7AFba19DjPJNx0gYcjmSn0ywBVWkjvePzeEqXEh4ucyhe6yZlGwuXbVP
         QjcpCMMnrNFjIFG0ZUN0bxCMvC8fHD54gZN8hc1KzfDW5jm2XEDkq6OI2+XuKRvvCHyk
         Y6bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708882425; x=1709487225;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B81NKUc6sttYC5VeLOVI86yWCbwTiryMiL1obUfBca4=;
        b=wa7/txF5/VWADcAWv8Sh2P2DKaPEmPafIwwvPnYFpRLizqKxmgBX2ykpb/0v4PhEb1
         VNaZ3cOBm7ThzFRGCmk9r+TZLbuOF5Sc4TSlpe7WgLX6BFdc8WxORDdZlIaGycLN5N08
         5AqzwqRLHIi+/aQdX4FCaWV40g/W80aDu2jYzbsqN9w3lkF+SW4c5BkEYWkIkXxF0EAu
         CK8pRt/ZyfOjGYMmz80PiX+41+aZNJbmo/+PfAQr+Lf8/e+PcpCl6SMmohulwMkFCPCd
         Jm6HBzYkl6BhfaZgdWbtm5xIGND92MF3jtMJt99yh+kSIFgxZm00n+SbcEhHSPJgZG9f
         GJKQ==
X-Gm-Message-State: AOJu0YwqGFv4X9/dQBoZN8aa46ht6/5uciTCNkPCZbcGq82nBg2xwaRV
	bGZchL3R4w3cdB7J8AviX/mcOMcNS0Mg3wmc2ej2uRBJ/fQPQrqYKrjXOw0x
X-Google-Smtp-Source: AGHT+IFH9AOt2lpgocS7cDZqfJrlgVFGDSbruottd1K1Ckip76ov78McNyzU28nKIMouK5h+aDRIew==
X-Received: by 2002:a05:6512:3da9:b0:512:aa52:5cce with SMTP id k41-20020a0565123da900b00512aa525ccemr3827125lfv.12.1708882424666;
        Sun, 25 Feb 2024 09:33:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b00412a0a30cd0sm3296347wms.3.2024.02.25.09.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 09:33:44 -0800 (PST)
Message-ID: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com>
From: "Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 25 Feb 2024 17:33:43 +0000
Subject: [PATCH] userdiff: better method/property matching for C#
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
Cc: Steven Jeuris <steven.jeuris@gmail.com>,
    Steven Jeuris <steven.jeuris@3shape.com>

From: Steven Jeuris <steven.jeuris@3shape.com>

- Support multi-line methods by not requiring closing parenthesis.
- Support multiple generics (comma was missing before).
- Add missing `foreach`, `from`, `lock` and  `fixed` keywords to skip over.
- Remove `instanceof` keyword, which isn't C#.
- Also detect non-method keywords not positioned at the start of a line.
- Added tests; none existed before.

The overall strategy is to focus more on what isn't expected for
method/property definitions, instead of what is, but is fully optional.

Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>
---
    userdiff: better method/property matching for C#

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1682%2FWhathecode%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1682/Whathecode/master-v1
Pull-Request: https://github.com/git/git/pull/1682

 t/t4018/csharp-method               |  10 +++
 t/t4018/csharp-method-explicit      |  12 +++
 t/t4018/csharp-method-generics      |  11 +++
 t/t4018/csharp-method-modifiers     |  13 ++++
 t/t4018/csharp-method-multiline     |  10 +++
 t/t4018/csharp-method-params        |  10 +++
 t/t4018/csharp-method-skip-body     | 115 ++++++++++++++++++++++++++++
 t/t4018/csharp-method-special-chars |  11 +++
 t/t4018/csharp-method-with-spacing  |  10 +++
 t/t4018/csharp-property             |  11 +++
 userdiff.c                          |  16 ++--
 11 files changed, 224 insertions(+), 5 deletions(-)
 create mode 100644 t/t4018/csharp-method
 create mode 100644 t/t4018/csharp-method-explicit
 create mode 100644 t/t4018/csharp-method-generics
 create mode 100644 t/t4018/csharp-method-modifiers
 create mode 100644 t/t4018/csharp-method-multiline
 create mode 100644 t/t4018/csharp-method-params
 create mode 100644 t/t4018/csharp-method-skip-body
 create mode 100644 t/t4018/csharp-method-special-chars
 create mode 100644 t/t4018/csharp-method-with-spacing
 create mode 100644 t/t4018/csharp-property

diff --git a/t/t4018/csharp-method b/t/t4018/csharp-method
new file mode 100644
index 00000000000..85ff0cb8b5b
--- /dev/null
+++ b/t/t4018/csharp-method
@@ -0,0 +1,10 @@
+class Example
+{
+	string Method(int RIGHT)
+	{
+		// Filler
+		// Filler
+		
+		return "ChangeMe";
+	}
+}
diff --git a/t/t4018/csharp-method-explicit b/t/t4018/csharp-method-explicit
new file mode 100644
index 00000000000..083aa094ce2
--- /dev/null
+++ b/t/t4018/csharp-method-explicit
@@ -0,0 +1,12 @@
+using System;
+
+class Example : IDisposable
+{
+	void IDisposable.Dispose() // RIGHT
+	{
+		// Filler
+		// Filler
+		
+		// ChangeMe
+	}
+}
diff --git a/t/t4018/csharp-method-generics b/t/t4018/csharp-method-generics
new file mode 100644
index 00000000000..c472d4a18df
--- /dev/null
+++ b/t/t4018/csharp-method-generics
@@ -0,0 +1,11 @@
+class Example<T1, T2>
+{
+	Example<int, string> Method<TA, TB>(TA RIGHT, TB b)
+	{
+		// Filler
+		// Filler
+		
+		// ChangeMe
+		return null;
+	}
+}
diff --git a/t/t4018/csharp-method-modifiers b/t/t4018/csharp-method-modifiers
new file mode 100644
index 00000000000..f1c008a4749
--- /dev/null
+++ b/t/t4018/csharp-method-modifiers
@@ -0,0 +1,13 @@
+using System.Threading.Tasks;
+
+class Example
+{
+	static internal async Task Method(int RIGHT)
+	{
+		// Filler
+		// Filler
+		
+		// ChangeMe
+		await Task.Delay(1);
+	}
+}
diff --git a/t/t4018/csharp-method-multiline b/t/t4018/csharp-method-multiline
new file mode 100644
index 00000000000..0a20b0cb49c
--- /dev/null
+++ b/t/t4018/csharp-method-multiline
@@ -0,0 +1,10 @@
+class Example
+{
+	string Method_RIGHT(
+		int a,
+		int b,
+		int c)
+	{
+		return "ChangeMe";
+	}
+}
diff --git a/t/t4018/csharp-method-params b/t/t4018/csharp-method-params
new file mode 100644
index 00000000000..18598449008
--- /dev/null
+++ b/t/t4018/csharp-method-params
@@ -0,0 +1,10 @@
+class Example
+{
+	string Method(int RIGHT, int b, int c = 42)
+	{
+		// Filler
+		// Filler
+		
+		return "ChangeMe";
+	}
+}
diff --git a/t/t4018/csharp-method-skip-body b/t/t4018/csharp-method-skip-body
new file mode 100644
index 00000000000..95e93ea995c
--- /dev/null
+++ b/t/t4018/csharp-method-skip-body
@@ -0,0 +1,115 @@
+using System.Linq;
+using System;
+
+class Example : IDisposable
+{
+	string Method(int RIGHT)
+	{
+		// Method calls
+		MethodCall();
+		MethodCall(1, 2);
+		MethodCall(
+			1, 2);
+		
+		// Assignments
+		var constantAssignment = "test";
+		var methodAssignment = MethodCall();
+		var multiLineMethodAssignment = MethodCall(
+			);
+		
+		// Initializations/disposal
+		new Example();
+		new Example(
+			);
+		new Example { };
+		using (this) 
+		{
+		}
+		var def =
+			this is default(
+				Example);
+		
+		// Iteration statements
+		do { } while (true);
+		do MethodCall(
+			); while (true);
+		while (true);
+		while (true) {
+			break;
+		}
+		for (int i = 0; i < 10; ++i)
+		{
+		}
+		foreach (int i in Enumerable.Range(0, 10))
+		{
+		}
+		int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
+		var test =
+			from num in Numbers(
+		 	) select num;
+		
+		// Control
+		if (false)
+		{
+			return "out";
+		}
+		else { }
+		if (true) MethodCall(
+			);
+		else MethodCall(
+			);
+		switch ("test")
+		{
+			case "one":
+				return MethodCall(
+					);
+			case "two":
+				break;
+		}
+		(int, int) tuple = (1, 4);
+		switch (tuple)
+		{
+			case (1, 4):
+				MethodCall();
+		}
+		
+		// Exceptions
+		try
+		{
+			throw new Exception("fail");
+		}
+		catch (Exception)
+		{
+		}
+		finally
+		{
+		}
+		try { } catch (Exception) {}
+		try
+		{
+			throw GetException(
+				);
+		}
+		catch (Exception) { }
+		
+		// Others
+		lock (this)
+		{
+		}
+		unsafe
+		{
+			byte[] bytes = [1, 2, 3];
+			fixed (byte* pointerToFirst = bytes)
+			{
+			}
+		}
+		
+		return "ChangeMe";
+	}
+	
+	public void Dispose() {}
+	
+	string MethodCall(int a = 0, int b = 0) => "test";
+	Exception GetException() => new Exception("fail");
+	int[] Numbers() => [0, 1];
+}
diff --git a/t/t4018/csharp-method-special-chars b/t/t4018/csharp-method-special-chars
new file mode 100644
index 00000000000..ec3565fd000
--- /dev/null
+++ b/t/t4018/csharp-method-special-chars
@@ -0,0 +1,11 @@
+class @Some_Type
+{
+	@Some_Type @Method_With_Underscore(int RIGHT)
+	{
+		// Filler
+		// Filler
+		
+		// ChangeMe
+		return new @Some_Type();
+	}
+}
diff --git a/t/t4018/csharp-method-with-spacing b/t/t4018/csharp-method-with-spacing
new file mode 100644
index 00000000000..4143929a711
--- /dev/null
+++ b/t/t4018/csharp-method-with-spacing
@@ -0,0 +1,10 @@
+class Example
+{
+		string   Method 	( int 	RIGHT )
+	{
+		// Filler
+		// Filler
+		
+		return "ChangeMe";
+	}
+}
diff --git a/t/t4018/csharp-property b/t/t4018/csharp-property
new file mode 100644
index 00000000000..1792117f964
--- /dev/null
+++ b/t/t4018/csharp-property
@@ -0,0 +1,11 @@
+class Example
+{
+	public bool RIGHT
+    {
+        get { return true; }
+        set
+        {
+            // ChangeMe
+        }
+    }
+}
diff --git a/userdiff.c b/userdiff.c
index e399543823b..a6a26a97e4c 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -89,12 +89,18 @@ PATTERNS("cpp",
 	 "|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"
 	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
 PATTERNS("csharp",
-	 /* Keywords */
-	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
-	 /* Methods and constructors */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
+	 /*
+	  * Jump over keywords not used by methods which can be followed by parentheses without special characters in between,
+	  * making them look like methods.
+	  */
+	 "!(^|[ \t]+)(do|while|for|foreach|from|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
+	 /* Methods/constructors:
+	  * the strategy is to identify a minimum of two groups (any combination of keywords/type/name),
+	  * without intermediate or final characters which can't be part of method definitions before the opening parenthesis.
+	  */
+	 "^[ \t]*(([][[:alnum:]@_<>.,]*[^=:{ \t][ \t]+[][[:alnum:]@_<>.,]*)+\\([^;]*)$\n"
 	 /* Properties */
-	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
+	 "^[ \t]*((([][[:alnum:]@_<>.,]+)[ \t]+[][[:alnum:]@_]*)+[^=:;,()]*)$\n"
 	 /* Type definitions */
 	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
 	 /* Namespace */

base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
-- 
gitgitgadget
