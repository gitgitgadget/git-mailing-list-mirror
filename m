Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AE0BA39
	for <git@vger.kernel.org>; Fri, 26 Jan 2024 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706273504; cv=none; b=s5z7fLgOpyk+xRzM0doomDw4Yjum6WFcrBATZW3Jehe9xcthNxLEi6CBTIahrsDBhZP9DHPMpEEyTgTZPSNDdQXV57nmI0yBZzRqQEFyVLizGeNFmh1hCgy4HVXM1ECneHPW8R4/GTXjg4CixUDc6CaX3VTKd4qczHnXVqJBRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706273504; c=relaxed/simple;
	bh=j1Ymds+8YcI8kes1Q1TQbcjQwOEGiBMCk/erMJBvLgw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=arteTO3aS7jaE/XbL/uNHUI5Obny7M3TdSyhKPlsuEWFebj0/0wi00hSCjXWSDPlgWeiwyAa0VBzFQKzwoUF5eaxEHgjKfUwS9ToTP05WKxkhRqrUK8UTPVKSksZVUckakDIJE/FaYZGDLxoDUWZkVySKomAwsjOvlXCE0ylYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bq0lyP88; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bq0lyP88"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-339261a6ec2so482874f8f.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2024 04:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706273500; x=1706878300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fr3RRk4gJOHyZ6BRA8C6KS3vsaNA7K3KSDq5xY4nvoo=;
        b=bq0lyP88mAlpY+/nM4hVoXVeFNh+E7kmBh4AcVw5Q19HeP842y79cT7MNJcQCxtbI8
         4OdOhYngF+TJ6LTw4MaCE+RJDNzYOk3G4ffvA+Vw58AP6qG0Ok4+7dY4knc3/1JeDTG4
         EsXG0WFR5lDY4ovcOG8fUJKfrR0NJD4byl/ZYC0XKnFj+ArS70yWPGUzHtPuvSck69wB
         BqQ/xNJM32JkcMZ+Nb+A7yJ+kiBDD5ab/tan+TV9VcjMPJJEYCYxA2ITQdH2ifDpFtdz
         wouE5elhr/D3WXWoOTA3xF3c1KkPcNgF+J43SmkAszoyYZ7Ul+1awdd649w65z3GqAJB
         ix6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706273500; x=1706878300;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fr3RRk4gJOHyZ6BRA8C6KS3vsaNA7K3KSDq5xY4nvoo=;
        b=EQIuWdab2MFn8GnKcvxT2CNHnYSssU1hfgP+jwi32XZOIGd+gBquhUVQ0JpTnHhTUN
         Uh14LwpU4zasxNm3scyv0n0NBcGt5ZUjAuHiwo8EGA6XiZ2EuVtttmsMjSc3Wg5wwoeq
         RsGqSu8AlhIOqPLk62G/EQJm9eTH10hRKY0ZVsF3bFs+KI1q0Py2FzuH2oKg4cqa+bS4
         w+lS5hYOQcE9fYjtLQit74hzJeaTjzLdf0oTQTpFbfH7256OQF1tyDBT5w1vG4I49IC3
         cMLa3OuGwZdDrdNXRqM9qddtHBLPaKxGGuL4LpXWkJ3kLtnLAvSqzq0mKnmoYj12XCF1
         KPMA==
X-Gm-Message-State: AOJu0YyG7cwDvX2tga3hsR11rV+cbfnu9Ai9OlsmaVbS8F8Vv4Lgowwd
	QJ6m/wjrRS/APctpjnP/oQG53KIKIRcnIKjN8vTql+df9vmZ5S6jyBsw5tU5
X-Google-Smtp-Source: AGHT+IGrIUBh7k6Sf8Qx2W5Rhjwqyb4BB6hjDT8RNwX/NyIVGCf98EOtzKCxFdsuM7YF+VCHs6i9RQ==
X-Received: by 2002:a05:6000:18c6:b0:33a:b27d:9563 with SMTP id w6-20020a05600018c600b0033ab27d9563mr907388wrq.109.1706273500444;
        Fri, 26 Jan 2024 04:51:40 -0800 (PST)
Received: from gmail.com (77.red-88-14-198.dynamicip.rima-tde.net. [88.14.198.77])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4806000000b003392ae3aee8sm1207551wrq.97.2024.01.26.04.51.39
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 04:51:40 -0800 (PST)
Message-ID: <8c902c53-815d-43c2-8ba9-8144d8884804@gmail.com>
Date: Fri, 26 Jan 2024 13:51:27 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/4] completion: introduce __gitcomp_subcommand
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
To: Git List <git@vger.kernel.org>
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
In-Reply-To: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Let's have a function to complete "subcommands" only in the correct
position (right after the command), in commands that follow the syntax:

    git <command> <subcommand>

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 contrib/completion/git-completion.bash | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 8c40ade494..916e137021 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -554,6 +554,27 @@ __gitcomp_file ()
 	true
 }
 
+# Completion for subcommands in commands that follow the syntax:
+#
+#    git <command> <subcommand>
+#
+# 1: List of possible completion words.
+# Returns false if the current word is not a possible subcommand
+# (possitioned after the command), or if no option is found in
+# the list provided.
+__gitcomp_subcommand ()
+{
+	local subcommands="$1"
+
+	if [ $cword -eq $(($__git_cmd_idx + 1)) ]; then
+		__gitcomp "$subcommands"
+
+		test -n "$COMPREPLY"
+	else
+		false
+	fi
+}
+
 # Execute 'git ls-files', unless the --committable option is specified, in
 # which case it runs 'git diff-index' to find out the files that can be
 # committed.  It return paths relative to the directory specified in the first
-- 
2.43.0

