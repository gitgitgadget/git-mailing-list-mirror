Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131E140E47
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 20:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709756499; cv=none; b=aKNrgRxtLFygL/fReHEcUPDALVOwlJ5BLm2/pVJuhQncndWVAaVhgCcjk1GrKAE4+yyNvh1I05JhveP5vZsBnUySSpTsdBdDhqBZObf+EOQIDJ+CeAvpEKtHwEJRup183MdcUwsppFFw3N2GuNTLjRyGJJNuMS4WUN/d1C1NEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709756499; c=relaxed/simple;
	bh=gQn5TB8I0J70Kn8J7yuSjIVlsz6kW9+g3qE89QLoPX0=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Kad9J7MfWsjL9NuLv8/x4kVEeBgTLN9CXVtnl6Aj4Fm1pkKO14KuZ2GihjFbbxLxum5puqMOhyqpjeR48aq5cv/7Lwd/3EVi1kIw6uGzhiAFB+5u6Sm176T7yL/3timvRqyaVeIGSnCHDdjcrtipnnfP2CZXkfZDFeb77Htv8+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auJfTd9L; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auJfTd9L"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412fe981ef1so905415e9.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 12:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709756495; x=1710361295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+s9FYy4lcc4cYXifTX4hYxOrCuOE68inY3iWXRK48E=;
        b=auJfTd9LIn1nNncdhos0DE2MyA43jQgMZbuCysk8wWNro6WreiVblGB9l7p+XqhjNp
         KhkrcuqMOFyhfYF1AXrmZm2CQTK/kqvmfljiE69HfsHBfIvYWsfRxDWT9FflXcs/lPDQ
         Mhk3WqArY571Sw40KS3/5OY+6DHNaGKt+pVbpOPQfROH5pC0X3C9ExM5wEYDySaxKKgs
         KAag3EAr8GGqPd+G9+1kfyGOM7M3AqAMSqqwJ0lxYNA/WVoYsCdR5V5//4nf4KDQxYXy
         eGlaSD3DtB4rCE+g0YPNrZg5LwadYjjw3y21c80WxDqh8ncxNSq0MAr9kTEHYWgl2rQy
         goEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709756495; x=1710361295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+s9FYy4lcc4cYXifTX4hYxOrCuOE68inY3iWXRK48E=;
        b=gLAQA3ydQMfjACz5c969127M+Qyhf/8WQfgZuMm2REg7w8/nIPnzT4L6tgx8ADjOlp
         4psaOAe8oTbtPnnwa8nj8H6/8OEd9GUf0h7KJcZlK5zkvtgvxykOgY+u9DYGlNjYIRi/
         ya2MZADgEQApCGu21cXzhn4pt5/ssdL9ZiZ99PhV8+6PJxo03hz9btDQRlfA7x0t+sxq
         DqNYOXu7nUWv2f/s9MWKxIQYPFDmII3GRrYYLBWCtPyl5mtVyXUiubstPLMXG+tnjbVE
         McOVetJdFjp4as6vhHJL/M+lVdlpTtQZZVAlT+DPR/LMXAVzHuO/acOnwEybI9wtM3m9
         86CQ==
X-Gm-Message-State: AOJu0Yygcjc4segIkbvYmw52hlCNue0vRcWHPPIkC2nBtv+lNpMbz5xZ
	lLsvfBsHGo/iP/bK3PQaC4cIj9bNwAIki6ZXtwmUAYw7tlnhAbbitVrNJ6uL
X-Google-Smtp-Source: AGHT+IEs9k6oqjxGHulFVTOOfIuY1XnlfJ5Oi6aThzTKgWLZv6uTcUJCWPsVI/pU39t1IgdjdE0Rmw==
X-Received: by 2002:a05:600c:34d4:b0:412:eddd:12c1 with SMTP id d20-20020a05600c34d400b00412eddd12c1mr5354666wmq.14.1709756494983;
        Wed, 06 Mar 2024 12:21:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id hg9-20020a05600c538900b00412f855bcc2sm296222wmb.43.2024.03.06.12.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 12:21:34 -0800 (PST)
Message-ID: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
In-Reply-To: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com>
References: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com>
From: "Steven Jeuris via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 06 Mar 2024 20:21:33 +0000
Subject: [PATCH v2] userdiff: better method/property matching for C#
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
Cc: =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason <avarab@gmail.com>,
    Jeff King <peff@peff.net>,
    Steven Jeuris <steven.jeuris@gmail.com>,
    Steven Jeuris <steven.jeuris@3shape.com>

From: Steven Jeuris <steven.jeuris@3shape.com>

- Support multi-line methods by not requiring closing parenthesis.
- Support multiple generics (comma was missing before).
- Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
- Remove `instanceof` keyword, which isn't C#.
- Also detect non-method keywords not positioned at the start of a line.
- Added tests; none existed before.

The overall strategy is to focus more on what isn't expected for
method/property definitions, instead of what is, but is fully optional.

Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>
---
    userdiff: better method/property matching for C#
    
    Change since v1: I removed "from" from the list of keywords to skip.
    First, I considered adding "await", but I discovered both "await" and
    "from" are "contextual keywords", which unlike the other keywords
    currently listed, aren't reserved, and can thus cause false negatives.
    I.e., it is valid to have a method named "await" or "from". In edge
    cases, this may lead to false positives, but a different exclusion rule
    will need to be added to handle these.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1682%2FWhathecode%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1682/Whathecode/master-v2
Pull-Request: https://github.com/git/git/pull/1682

Range-diff vs v1:

 1:  cdd8dd4d871 ! 1:  00315519014 userdiff: better method/property matching for C#
     @@ Commit message
      
          - Support multi-line methods by not requiring closing parenthesis.
          - Support multiple generics (comma was missing before).
     -    - Add missing `foreach`, `from`, `lock` and  `fixed` keywords to skip over.
     +    - Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
          - Remove `instanceof` keyword, which isn't C#.
          - Also detect non-method keywords not positioned at the start of a line.
          - Added tests; none existed before.
     @@ t/t4018/csharp-method-skip-body (new)
      +		{
      +		}
      +		int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
     -+		var test =
     -+			from num in Numbers(
     -+		 	) select num;
      +		
      +		// Control
      +		if (false)
     @@ userdiff.c: PATTERNS("cpp",
      +	  * Jump over keywords not used by methods which can be followed by parentheses without special characters in between,
      +	  * making them look like methods.
      +	  */
     -+	 "!(^|[ \t]+)(do|while|for|foreach|from|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
     ++	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
      +	 /* Methods/constructors:
      +	  * the strategy is to identify a minimum of two groups (any combination of keywords/type/name),
      +	  * without intermediate or final characters which can't be part of method definitions before the opening parenthesis.


 t/t4018/csharp-method               |  10 +++
 t/t4018/csharp-method-explicit      |  12 +++
 t/t4018/csharp-method-generics      |  11 +++
 t/t4018/csharp-method-modifiers     |  13 ++++
 t/t4018/csharp-method-multiline     |  10 +++
 t/t4018/csharp-method-params        |  10 +++
 t/t4018/csharp-method-skip-body     | 112 ++++++++++++++++++++++++++++
 t/t4018/csharp-method-special-chars |  11 +++
 t/t4018/csharp-method-with-spacing  |  10 +++
 t/t4018/csharp-property             |  11 +++
 userdiff.c                          |  16 ++--
 11 files changed, 221 insertions(+), 5 deletions(-)
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
index 00000000000..c8c9621634d
--- /dev/null
+++ b/t/t4018/csharp-method-skip-body
@@ -0,0 +1,112 @@
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
index e399543823b..5a9e8a0ef55 100644
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
+	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
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
