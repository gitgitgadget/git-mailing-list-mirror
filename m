Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5329151C4F
	for <git@vger.kernel.org>; Tue, 21 May 2024 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716324589; cv=none; b=rx3uWCzFXari06EPEBphYbf/HvlzRAsksM4fUbpiqOXjltznB4JIcLGbadV2RIjSLkqrogfY1qqqS9N8l9AjFnzawLobxPTXiPz3GZvsNMqNXYS/htRyfipYJWEDzPpvlNHCtB0P4LtVnap1M4PzO2I+NBpwrHeB0v4ngFZQS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716324589; c=relaxed/simple;
	bh=6yj3E4jNIDOAaIxJIndo64Xn1fybF3lJe+u0iwWd4vk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=YqsWSBw7Ul4cyEBO325aRmhSnYqRJRu4YaLpH6izEaYtIBNB0RcsbedZuo6yUlrQkTwzDkH/1y1n5v4bPdd2yy6P5asz1bDntosEr+7+FJm7M5QwivnfIdhBcYMPcqoT4o2G9xCxRGkV75SxodEumAf9U0dRw5qOT1GH0ELeTrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdFuizbh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdFuizbh"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4202959b060so35453645e9.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716324586; x=1716929386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v45+ObHsp/aTu6bXL+trGO5CQ02eTHQJs5sYKaadUIY=;
        b=YdFuizbhNY5VKC9WZcPRJaNAr3G7IogMbB/hHiqIP/obc0puGRBC2nLh6hGMXCCbw5
         yeLX00wVKmB3FEvjFKuS+uvzAReUE5Gca5WFKRYMK1sR8CMGbj6ZJQ3XDB+F8T4QlaMy
         4zYE+iEBCdhYOjijpjTC8xn/wzq0KCXd33i+0LLxTi8bJ3uXFAI4cYdt9PzkvrvgxhJy
         kW4ZNfkJe8Swe0v1/Vvv+UI1NEQpNzkWVdMXAHtMfgj4FMO+MM4tNXrqp6/r42AajCp6
         6SQdM7qIYoG/bE5xgvBBEl8ubHXYiv1dfUwplBejHnJCZ1BGNxN1HxuhjgAXTLM/3Ky0
         Ar0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716324586; x=1716929386;
        h=content-transfer-encoding:in-reply-to:cc:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v45+ObHsp/aTu6bXL+trGO5CQ02eTHQJs5sYKaadUIY=;
        b=b6Ovs2uofjDHD/Hel1qoPrtX0PoVDh/dVMRKeyME8SITmsjiiU6i6D7L6XRnoaAGEa
         b87oonLNtTDbEHuU9hw1Msm94f7AYUPaXhH1E4gRwt9n//Kb651kGG0WjqUTB7n/yfF4
         REA62w0ObpP5RT84G4sTk5BxK8RY6X5C7YNX9JgEptAc5/DYtc95pYi00RoCyQpA+trF
         oP+0+OsCrY9SKQ6+7kxxadloaPNr4Mgj2+mJpkXE/0j9Xz2HhXIHrRyQD2h2j3vOByrp
         VclNtK2ncFE9DD+/R9gXrpkITrlkggBL0GXxaP85n6vNX/60DlkmPLa5Z+nqoxp7hioe
         qOnw==
X-Gm-Message-State: AOJu0YyRABOmrQb4oqQaQMOB9qidXZv2Fl5GM76BWfDopwpJYXVrSZ8l
	WfAdMabjSmeNL2ykHA/er1pDksBSsx/CGghsMrYyEqFD4EhCUJr5XES3Ig==
X-Google-Smtp-Source: AGHT+IEVu9kMSOS2/o7aAkidHFbBW9xGsYr7UNK3DjBnFsEvZmqdq+G0uFKJGQ/71MTZsu29uGgUVA==
X-Received: by 2002:a05:600c:570d:b0:41c:5eb:4f8f with SMTP id 5b1f17b1804b1-420fd2ffc8amr308335e9.15.1716324585452;
        Tue, 21 May 2024 13:49:45 -0700 (PDT)
Received: from gmail.com (96.red-88-14-210.dynamicip.rima-tde.net. [88.14.210.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42012d9ace5sm371809905e9.2.2024.05.21.13.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 May 2024 13:49:45 -0700 (PDT)
Message-ID: <199072a9-a3fb-4c8d-b867-b0717a10bacc@gmail.com>
Date: Tue, 21 May 2024 22:49:44 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/5] use the pager in 'add -p'
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Language: en-US
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
 Jeff King <peff@peff.net>
In-Reply-To: <1d0cb55c-5f32-419a-b593-d5f0969a51fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Invoke the pager when displaying hunks during "add -p" sessions, to make                                                                     
it easier for the user to review hunks longer than one screen height.                                                                        
                                                                                                                                             
This iteration, v2, reduces the use of the pager to the 'print' command
when invoked using a capital 'P'.                 

Rubén Justo (5):
  add-patch: test for 'p' command
  pager: do not close fd 2 unnecessarily
  pager: introduce wait_for_pager
  test-terminal: introduce --no-stdin-pty
  add-patch: render hunks through the pager

 add-patch.c                | 14 ++++++++++---
 pager.c                    | 41 ++++++++++++++++++++++++++++++++------
 pager.h                    |  1 +
 t/t3701-add-interactive.sh | 37 ++++++++++++++++++++++++++++++++++
 t/test-terminal.perl       | 32 ++++++++++++++++-------------
 5 files changed, 102 insertions(+), 23 deletions(-)

Range-diff against v1:
1:  340b090e64 = 1:  05edb72326 add-patch: test for 'p' command
2:  7cb16742ef = 2:  8fe915a820 pager: do not close fd 2 unnecessarily
3:  207faad1b1 = 3:  fc629a7334 pager: introduce wait_for_pager
4:  a3815e20c3 = 4:  d2bd591e65 test-terminal: introduce --no-stdin-pty
5:  d5886bf9cd ! 5:  d3c11dbb1d add-patch: render hunks through the pager
    @@ Metadata
      ## Commit message ##
         add-patch: render hunks through the pager
     
    -    Invoke the pager when displaying hunks during "add -p" sessions, to make
    -    it easier for the user to review hunks longer than one screen height.
    +    Make the print command to trigger the pager when invoked using a capital
    +    'P', to make it easier for the user to review long hunks.
     
         Signed-off-by: Rubén Justo <rjusto@gmail.com>
     
    @@ add-patch.c
      #include "read-cache-ll.h"
      #include "repository.h"
      #include "strbuf.h"
    +@@ add-patch.c: N_("j - leave this hunk undecided, see next undecided hunk\n"
    +    "/ - search for a hunk matching the given regex\n"
    +    "s - split the current hunk into smaller hunks\n"
    +    "e - manually edit the current hunk\n"
    +-   "p - print the current hunk\n"
    ++   "p - print the current hunk, 'P' to use the pager\n"
    +    "? - print help\n");
    + 
    + static int patch_update_file(struct add_p_state *s,
    +@@ add-patch.c: static int patch_update_file(struct add_p_state *s,
    + 	struct hunk *hunk;
    + 	char ch;
    + 	struct child_process cp = CHILD_PROCESS_INIT;
    +-	int colored = !!s->colored.len, quit = 0;
    ++	int colored = !!s->colored.len, quit = 0, use_pager = 0;
    + 	enum prompt_mode_type prompt_mode_type;
    + 	enum {
    + 		ALLOW_GOTO_PREVIOUS_HUNK = 1 << 0,
     @@ add-patch.c: static int patch_update_file(struct add_p_state *s,
      		strbuf_reset(&s->buf);
      		if (file_diff->hunk_nr) {
      			if (rendered_hunk_index != hunk_index) {
    -+				setup_pager();
    ++				if (use_pager)
    ++					setup_pager();
      				render_hunk(s, hunk, 0, colored, &s->buf);
      				fputs(s->buf.buf, stdout);
      				rendered_hunk_index = hunk_index;
    -+				wait_for_pager();
    ++				if (use_pager) {
    ++					wait_for_pager();
    ++					use_pager = 0;
    ++				}
      			}
      
      			strbuf_reset(&s->buf);
    +@@ add-patch.c: static int patch_update_file(struct add_p_state *s,
    + 				hunk->use = USE_HUNK;
    + 				goto soft_increment;
    + 			}
    +-		} else if (s->answer.buf[0] == 'p') {
    ++		} else if (ch == 'p') {
    + 			rendered_hunk_index = -1;
    ++			use_pager = (s->answer.buf[0] == 'P') ? 1 : 0;
    + 		} else if (s->answer.buf[0] == '?') {
    + 			const char *p = _(help_patch_remainder), *eol = p;
    + 
     
      ## t/t3701-add-interactive.sh ##
     @@ t/t3701-add-interactive.sh: test_expect_success 'print again the hunk' '
    @@ t/t3701-add-interactive.sh: test_expect_success 'print again the hunk' '
     +test_expect_success TTY 'print again the hunk (PAGER)' '
     +	test_when_finished "git reset" &&
     +	cat >expect <<-EOF &&
    -+	PAGER <GREEN>+<RESET><GREEN>15<RESET>
    -+	PAGER  20<RESET>
    ++	<GREEN>+<RESET><GREEN>15<RESET>
    ++	 20<RESET>
     +	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>PAGER <CYAN>@@ -1,2 +1,3 @@<RESET>
     +	PAGER  10<RESET>
     +	PAGER <GREEN>+<RESET><GREEN>15<RESET>
     +	PAGER  20<RESET>
     +	<BOLD;BLUE>(1/2) Stage this hunk [y,n,q,a,d,j,J,g,/,e,p,?]? <RESET>
     +	EOF
    -+	test_write_lines s y g 1 p |
    ++	test_write_lines s y g 1 P |
     +	(
     +		GIT_PAGER="sed s/^/PAGER\ /" &&
     +		export GIT_PAGER &&
-- 
2.45.1.221.gd3c11dbb1d
