Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8E823BE
	for <git@vger.kernel.org>; Thu, 27 Jun 2024 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719501366; cv=none; b=joulbRHMO2zZuwpcEvtepRgVcqqewBhMvhow1ezsWcQp+7G8gV11CQgZe4FC9Fpzcihook67mdWvof8VinjSJa4ORRadLzhJRZh9ZCueFeMXHjZbVWySJcdETm3b7QGkZxQyuke5oc/X1nljawlr65BrpiQt6EiJN2N+Vt6P6XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719501366; c=relaxed/simple;
	bh=hh+J/5GCe/Id7LcjCcoKvp2sfb6YWfYz1lKq/a8Hos0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahCqlGS5xz5ikchBLYNHC0uRonz3q9OwDl+V5Lo0rqZWZwfHX3mmOluWhzTUhRDHALgeNMQhdP//Huhw08UxA8EO3jq+l7Z/VcTC55rJ3OwegXycW8dZzQAgVx+lPQ2XbBgbbtRdXV/7LapBvBKborASgT6iiQogCxpvuc5a4vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SgJVS29w; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SgJVS29w"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-706b539fcaeso536086b3a.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 08:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719501364; x=1720106164; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MJgm0No5QtyeJVi0CV5nn90CiCsprEpBKvdo1r2AKt0=;
        b=SgJVS29w5tEN8682h8jau6YADWK66qMeSuwzgORhVR7PmQrRdjlTBHCP9bZ2XHstfD
         lxqfX+zmChF75xA7UtRTFe36tnhv4GyrqND+TD1beqWnpnf8bbp4KPEVWNmJ6aSULA/Z
         UbGhQ06z1I4ZefdCFp5JgKgboYWOdh/O/Vnr52K+oh2O7FhDl0Pn+Iz3zAysocDHfn4K
         zS3h/gXXt/TEStSue+WfGSOPiTYCfrPR/kurkS6AEPI6KUT9w0Rx9e91hcFvWt+TG3AX
         q9hPmPWR/nrQNL2FzjuZ/ywfdnGS4N6fZ3EPoy5B5rSi+68Mj6GtYvVopUebFpg1gGJQ
         m9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719501364; x=1720106164;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJgm0No5QtyeJVi0CV5nn90CiCsprEpBKvdo1r2AKt0=;
        b=cNRWKGYP9vGHfmkeP94AFyA7lvggw+9vnIbV8S2bWmlkNPb1YBkKgQxBtxlRqYMieK
         orz9RnRxvWBFB6eLLtZeMiNUQfAaGWdR735t+CENexpIK+rDhUj4tFMFMgFUdz3joPIU
         ghy7VEuwb5EQV/SVeB9MqX9Bi7f6hUlvsFl/mtNKcNNksNfGCcctfECQOcpgW6YUOZE/
         RrR+7M3UH8yZdp6FRL4SXASfSwS6VKX2Ukwhd4sL4Q7JQvseUwVuwdX0pPnTKpdcYE3B
         hSIHF6iPn+YqnxDyEbznRffQXUZzFKGLUKny7FWD335i0CFC0wLHaQIDEY9U0/Tq86yp
         6UKQ==
X-Gm-Message-State: AOJu0YxKJRyiZ+r3KlI50kiic7X39xOQCMp0UyEpeCHQKiTc7IuRZP7p
	lWrS5fz2lLYX2yTd9oITn7cnZmzMldwzCcjl4lgckFqjTk2fm6TCPw4HXA==
X-Google-Smtp-Source: AGHT+IG06Rng5iBIXEQekYvynOvClHW4+KsFnkbHL0WCsVGDq0ZNg9gaigyV1ncGfvU57Zp9OJC5Qw==
X-Received: by 2002:a05:6a21:998f:b0:1be:c166:6445 with SMTP id adf61e73a8af0-1bec1666fd8mr7027580637.4.1719501363650;
        Thu, 27 Jun 2024 08:16:03 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-706b49103a9sm1480005b3a.66.2024.06.27.08.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 08:16:03 -0700 (PDT)
Date: Thu, 27 Jun 2024 23:16:01 +0800
From: shejialuo <shejialuo@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [GSoC][PATCH v5 09/12] builtin/fsck: add `git-refs verify` child
 process
Message-ID: <Zn2CMab7155p41Mk@ArchLinux>
References: <Zn2Ah3WDhtOmzrzn@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zn2Ah3WDhtOmzrzn@ArchLinux>

Introduce a new function "fsck_refs" that initializes and runs a child
process to execute the "git-refs verify" command.

Mentored-by: Patrick Steinhardt <ps@pks.im>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Signed-off-by: shejialuo <shejialuo@gmail.com>
---
 builtin/fsck.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 2a3b536c1b..a5654da62b 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -899,6 +899,21 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	return res;
 }
 
+static void fsck_refs(void)
+{
+	struct child_process refs_verify = CHILD_PROCESS_INIT;
+	child_process_init(&refs_verify);
+	refs_verify.git_cmd = 1;
+	strvec_pushl(&refs_verify.args, "refs", "verify", NULL);
+	if (verbose)
+		strvec_push(&refs_verify.args, "--verbose");
+	if (check_strict)
+		strvec_push(&refs_verify.args, "--strict");
+
+	if (run_command(&refs_verify))
+		errors_found |= ERROR_REFS;
+}
+
 static char const * const fsck_usage[] = {
 	N_("git fsck [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]\n"
 	   "         [--[no-]full] [--strict] [--verbose] [--lost-found]\n"
@@ -1068,6 +1083,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 
 	check_connectivity();
 
+	fsck_refs();
+
 	if (the_repository->settings.core_commit_graph) {
 		struct child_process commit_graph_verify = CHILD_PROCESS_INIT;
 
-- 
2.45.2

