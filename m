Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VscvKyUa"
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEDA310C8
	for <git@vger.kernel.org>; Fri, 24 Nov 2023 00:16:33 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5c239897895so1164537a12.2
        for <git@vger.kernel.org>; Fri, 24 Nov 2023 00:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700813793; x=1701418593; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ln32F0RjeUDLbStyPhDIHw26FCKwulDeqYiY3KxWIU=;
        b=VscvKyUaYL14bm96KBQPDjCdtF7Y48IXYY12JRUdGu+CUyFdJ1JAQU9IyJGtakyh96
         W5oK1DYX7ZbD2Xn1E8BYB5BDzIayI1A7BrROlAe3earhkyp03uFbvk3EXfT7RVn4lzeU
         bF7j288AIrshITCF86PtxO0+tMcgoyq9ncjZqKoTSjlmiOXW2a7NOkFmh5tPYAjPIcLZ
         pt70mahdnHEFHPjDkF2mDF8l23nOZk2MLSb9UYP0KYVmVefNR54UyrQlDF6EJmF12+Oe
         0GgV1QPXJsEFc0v4sX/z1N5luzibYQLVD7VjY+VfGx28iw3rzpkAKRFCSpWPfK9jGMzN
         1a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700813793; x=1701418593;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2ln32F0RjeUDLbStyPhDIHw26FCKwulDeqYiY3KxWIU=;
        b=QbIszJ95eJrNAHmB047RT9rglhWd8EtIaL3CvqnU7KfQPCoADxhR+nb+HSFZOyABD6
         6zDLAjYARQv60ixeH6RINeMLYNnDLTYCGOwwQHvZqQKNdPc83lYMuunA1nWT5sLlca1O
         RstabUkT6QwZq9muLMeUrZXv43jPzu1FAwG2celbTgnwyzw27hQM00u3WFw6NJ587lrn
         RydV6vgiSE61erynfG8KXodiP2fy6Puut1xBYZUKzYoY4g+XeHP97o1N+kM+hM+9Ltrk
         +GEsZkPWdUIBXszDYqAGJa0efmB0yRUgca2P82bsIowktvrl71EVxc9TOQR0HgjNKTIO
         YOAw==
X-Gm-Message-State: AOJu0YyQTMhK4d18jJNNOPWj1ggK5dTt8rhqgu3fNy+yFPmBemLDMUAJ
	UR/P9op+UKaSegon4MIxQsqjH91j+JOG2Q==
X-Google-Smtp-Source: AGHT+IGJakQ2bS9ECZ70LVyUiuluCwnQx7+LeUSHYTdRuNTN2CgSeTQj719KCAatH69Q8vmMHJH15A==
X-Received: by 2002:a17:90b:3443:b0:27f:f655:e14c with SMTP id lj3-20020a17090b344300b0027ff655e14cmr1769151pjb.42.1700813792873;
        Fri, 24 Nov 2023 00:16:32 -0800 (PST)
Received: from [192.168.1.90] ([58.230.107.147])
        by smtp.gmail.com with ESMTPSA id i1-20020a170902c28100b001b86dd825e7sm2617779pld.108.2023.11.24.00.16.31
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 00:16:32 -0800 (PST)
Message-ID: <8d7c8313-0f02-4218-ba2a-1716ada7956f@gmail.com>
Date: Fri, 24 Nov 2023 17:16:28 +0900
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, ko-KR
To: git@vger.kernel.org
From: scarf <greenscarf005@gmail.com>
Subject: Unable to split then edit hunk in git interactive add
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

|Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue)

1. Initialized a new repo with `git init`.
1-1. Created first commit with a file `main.txt` with the following content:
```rs
pub fn format_text(
   input_text: &str,
   format_with_host: impl FnMut(&Path, String) -> Result<Option<String>>,
) -> Result<Option<String>> {
   let parse_result = jsonc_parser::parse_to_ast(
     input_text,
     &CollectOptions {
       comments: false,
       tokens: false,
     },
     &ParseOptions {
       allow_comments: true,
       allow_loose_object_property_names: true,
       allow_trailing_commas: true,
     },
   )?;
   let Some(root_value) = parse_result.value else {
     return Ok(None);
   };

   Ok(format_root(input_text, &root_value, format_with_host))
}
```

1-2. Edited the content of the file to:
```rs
pub fn format_text(
   input_text: &str,
   format_with_host: impl FnMut(&Path, String) -> Result<Option<String>>,
) -> Result<Option<String>> {
   let parse_result = jsonc_parser::parse_to_ast(input_text, 
&COLLECT_OPTIONS, &PARSE_OPTIONS)?;

   let format_result = parse_result
     .value
     .and_then(|root_value| format_root(input_text, &root_value, 
format_with_host));

   Ok(format_result)
}
```

1-3. Running `git status` will show
```rs
On branch main
Changes not staged for commit:
   (use "git add <file>..." to update what will be committed)
   (use "git restore <file>..." to discard changes in working directory)
         modified:   main.txt
```

2. To reliably reproduce the error:
2-1. run `git add --patch`
2-2. (s)plit once
2-3. (e)dit first hunk. the content of `addp-hunk-edit.diff` is:
```diff
@@ -2,19 +2,5 @@ pub fn format_text(
    input_text: &str,
    format_with_host: impl FnMut(&Path, String) -> Result<Option<String>>,
  ) -> Result<Option<String>> {
-  let parse_result = jsonc_parser::parse_to_ast(
-    input_text,
-    &CollectOptions {
-      comments: false,
-      tokens: false,
-    },
-    &ParseOptions {
-      allow_comments: true,
-      allow_loose_object_property_names: true,
-      allow_trailing_commas: true,
-    },
-  )?;
-  let Some(root_value) = parse_result.value else {
-    return Ok(None);
-  };
+  let parse_result = jsonc_parser::parse_to_ast(input_text, 
&COLLECT_OPTIONS, &PARSE_OPTIONS)?;
```

2-4. undelete(remove '-') L18-L20, move L21 up so it goes right before 
L18. the edited content of `addp-hunk-edit.diff` is:
```diff
@@ -2,19 +2,5 @@ pub fn format_text(
    input_text: &str,
    format_with_host: impl FnMut(&Path, String) -> Result<Option<String>>,
  ) -> Result<Option<String>> {
-  let parse_result = jsonc_parser::parse_to_ast(
-    input_text,
-    &CollectOptions {
-      comments: false,
-      tokens: false,
-    },
-    &ParseOptions {
-      allow_comments: true,
-      allow_loose_object_property_names: true,
-      allow_trailing_commas: true,
-    },
-  )?;
+  let parse_result = jsonc_parser::parse_to_ast(input_text, 
&COLLECT_OPTIONS, &PARSE_OPTIONS)?;
    let Some(root_value) = parse_result.value else {
      return Ok(None);
    };
```

2-5. it fails with `hunks do not overlap` error. full error message is:
```
error: hunks do not overlap:
    input_text: &str,
    format_with_host: impl FnMut(&Path, String) -> Result<Option<String>>,
  ) -> Result<Option<String>> {
-  let parse_result = jsonc_parser::parse_to_ast(
-    input_text,
-    &CollectOptions {
-      comments: false,
-      tokens: false,
-    },
-    &ParseOptions {
-      allow_comments: true,
-      allow_loose_object_property_names: true,
-      allow_trailing_commas: true,
-    },
-  )?;
+  let parse_result = jsonc_parser::parse_to_ast(input_text, 
&COLLECT_OPTIONS, &PARSE_OPTIONS)?;
    let Some(root_value) = parse_result.value else {
      return Ok(None);
    };


         does not end with:


error: patch failed: main.txt:20
error: main.txt: patch does not apply
error: 'git apply --cached' failed
```

3. to side-step the error,
3-1. run `git add --patch`
3-2. follow 2-1 to 2-4 from above
3-3. it works without error

What did you expect to happen? (Expected behavior)

I expected editing splitted hunk to work without errors.

What happened instead? (Actual behavior)

Editing hunks will only work if the hunk is not splitted.

What's different between what you expected and what actually happened?

This behavior is inconsistent and undocumented in 
https://git-scm.com/docs/git-add,
which lead me to believe this is a bug.

Anything else you want to add:

I apologize for the long wall of demo snippets.
I wasn't sure whether it's allowed to send repository as tarball or link 
the formatted content.

This stackoverflow post shows the exact same error: 
https://stackoverflow.com/q/62896307/13503626
its comment in https://stackoverflow.com/a/62897311/13503626 mentions 
sending a bug report on mailing list,
however after searching through mailing list archive at 
https://lore.kernel.org/git/?q=b%3A"split"+b%3A"edit"+b%3A"hunk"
I couldn't find any bug report related to this issue.

[System Info]
git version:
git version 2.40.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 6.5.0-10-generic #10-Ubuntu SMP PREEMPT_DYNAMIC Fri Oct 13 
13:49:38 UTC 2023 x86_64
compiler info: gnuc: 12.3
libc info: glibc: 2.38
$SHELL (typically, interactive shell): /usr/bin/fish


[Enabled Hooks]
None.

|
