Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE566438FE2
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770307519; cv=none; b=FPjnFOD2RYsYa9n5QltdbCQQyuUQ1uNcNsL2mL/K+VVUDUHHKMq2Co71w5+L1rCE/ugKhW7qJUx3Ut14cT6Gj09VFqtL1sg0L77//xvDw1892yAm++rSENqZ8JfHYrzRC7QhZjcoF0RwyZlkAnZY9B3MGu9hUL9Gjm+A913tCSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770307519; c=relaxed/simple;
	bh=4APc/fzTnWF53ABp0SmRgr3dgC0UsIXEWMLom/pSClc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=j0r4JkrW/+IJ8/kSBPezqXhu7HoUhLJj/XAN0CO62v+mzz3/mA288DFdt4cKXdkyM1HMt+wzH3bYZUmitHDgvOY0Ra9JUOfZbogl0ae20o20tCEneC/p2R0UOwULx1QD5jpHyASPo1GbRDoj1cuFbliMZTtrABvvTJtlwKsTraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoIFzFtm; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoIFzFtm"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1540625eec.0
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770307518; x=1770912318; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iEXSLsucYL7gPUKrQcG35rkXe4PkmtieSowxyCVZqo=;
        b=XoIFzFtmjV3LfweUM6A6cYl+PEJ/dKBblwUsY7IdS3j56Cag5or4AcbzFzoz2TURm8
         5fkf65KOTCwj+Q6454v30ARIYRRnhKOGb9gc6eejrTSqYVehiB9iHJtyy+28b4hS7m8z
         eiMPI7Za4INu4epdYq8RT0xMYwlUOALZFfTAonfV4Rhb9Q0EEKYNC2hIeqeEwKp68H5X
         aCVGhi+Y2VR0v5DfKohKshQ8y7qrkwk4kMKZlUZ1/Inw0pg6ZK70nVg6wzGcboiEQFbf
         S9BLPNstMfBFqwBlspFTwBCr9huTrw3BxzN3efK6xHs3A6+l1DHyxmBXGN8xedfZezHZ
         1ifg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770307518; x=1770912318;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+iEXSLsucYL7gPUKrQcG35rkXe4PkmtieSowxyCVZqo=;
        b=F8SPRZ4VSAATdlY0i7pNqaQ5Qy9x7Khe7vNpgR+9TLr4NCNhMVhtCZA9RvRiUHkHP5
         1p2KM5qKuEbm0pXEcuTof1LV9bhYC5zboOX+hAegyWv6R7zaFgAq3VBzitjkLI4NqpYP
         LhtfT+6I5DjA8M0gL8YVwJ5GPZmzhaWmjadZmnGyHKHKYyupwNiHsN1rmRzRaadT0E0F
         ebEJFPZtHFGnX64OYu3rP9e1dlO+IncBBWjmAWyCRnASsQgEr235SoYzsJZmdXEVEAgt
         7LLIJqTx95qtV8ie+CwDCBbak11DGU5zPf6+NsPtKeC8MvFIq/vIYMjLjazOpJyKBAZs
         Vdvw==
X-Gm-Message-State: AOJu0YwYJQQ0HVUADHyiIrPUMDJrA41wlU/7QtoMWGlhnPJHVgQozLb1
	E/cWXVVDofgAXA+3dJR0R6CdiHO9iehLIaztI7VUO69cD8WX0DBVGt46VUWO4fJu
X-Gm-Gg: AZuq6aI+JwVrMIwQOhRJzLUisvpisUO2xVpf2rR2+37SpgbPmibTQUL4TNaQ808BqV2
	dqjfE1fLB2lncg5oM96BFPAZYDKiAEnqwS5TT9X/yHdWADe/gFcfU18c/jTYjhvBqC3gg+Hemgo
	fKDgh0KSSMn3O8AGmS+GJ0UD/Xm4t/cUkHme1mRkkoYhVnhEExp5blWS9ygMJPuKhg8U201liZT
	ef3bsLofw1zahBT6yEeb4qL09Uq9JSsXgP4xZiwBaQhtS/pcCnLegtjS+GQYFAhKNXZ8+wuKzNU
	HMHr4GdnKigafIOxm0Tyzu4qj1g+fAeTHrU+hkyBFs4OpjFVYE+brlU/3Hw5j88Gt8nL9QyTnY8
	Cs6NhHw06Li+alr4Qf3CnyW6VG/AK19AyUWwJabtt2x+AGV1lKk3l7XdJn4lnOR3YWvXDEADjSZ
	CdyV/waLvYehZp7QA=
X-Received: by 2002:a05:7300:f196:b0:2b7:a27f:3a6a with SMTP id 5a478bee46e88-2b8328f9f60mr3350106eec.4.1770307518333;
        Thu, 05 Feb 2026 08:05:18 -0800 (PST)
Received: from [127.0.0.1] ([172.182.194.212])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b832fb363esm3608737eec.26.2026.02.05.08.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 08:05:17 -0800 (PST)
Message-Id: <a06344dc753698ece37f8d066b0a51931b7fa16f.1770307510.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
References: <pull.2040.git.1770307510.gitgitgadget@gmail.com>
From: "Matthew John Cheetham via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 05 Feb 2026 16:05:10 +0000
Subject: [PATCH 4/4] trace2: emit cmd_ancestry data for Windows
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
Cc: gitster@pobox.com,
    stolee@gmail.com,
    johannes.schindelin@gmx.de,
    Matthew John Cheetham <mjcheetham@outlook.com>,
    Matthew John Cheetham <mjcheetham@outlook.com>

From: Matthew John Cheetham <mjcheetham@outlook.com>

Since 2f732bf1 (tr2: log parent process name) it is now possible to emit
a specific process ancestry event in TRACE2. We should emit the Windows
process ancestry data with the correct event type.

To not break existing consumers of the data_json "windows/ancestry"
event, we continue to emit the ancestry data as a JSON event.

Signed-off-by: Matthew John Cheetham <mjcheetham@outlook.com>
---
 compat/win32/trace2_win32_process_info.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/compat/win32/trace2_win32_process_info.c b/compat/win32/trace2_win32_process_info.c
index aceea05430..6a6a396078 100644
--- a/compat/win32/trace2_win32_process_info.c
+++ b/compat/win32/trace2_win32_process_info.c
@@ -172,6 +172,11 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
 		get_is_being_debugged();
 		get_ancestry(&names);
 		if (names.nr) {
+			/*
+			  Emit the ancestry data as a data_json event to
+			  maintain compatibility for consumers of the older
+			  "windows/ancestry" event.
+			 */
 			struct json_writer jw = JSON_WRITER_INIT;
 			jw_array_begin(&jw, 0);
 			for (size_t i = 0; i < names.nr; i++)
@@ -180,6 +185,9 @@ void trace2_collect_process_info(enum trace2_process_info_reason reason)
 			trace2_data_json("process", the_repository,
 					 "windows/ancestry", &jw);
 			jw_release(&jw);
+
+			/* Emit the ancestry data with the new event. */
+			trace2_cmd_ancestry(names.v);
 		}
 
 		strvec_clear(&names);
-- 
gitgitgadget
