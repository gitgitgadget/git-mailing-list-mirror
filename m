Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E32E3DAADC
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787259842; cv=none; b=nt2E+UdOy2QMG8SmyZSABj/tz3cy0PH8+pME+7rNh/jlLqYXST3YHjldrJkydQn/QHHGg5vJdhgBt3QMSrL9kUwiUCZYN7KS4qd6Y8X7PvFFAZPhvWcg33ym2Ec6CyPJiC93wA6TrZBmGN0ARiNQzr+DfR0gA1k4yTqeQyLezZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787259842; c=relaxed/simple;
	bh=9TEn4ZmDZXFeXUdR/N/oWv7Rt0Nw71zbMQWPHhzrc2I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Fwlb31EfVj2oVEVOrGI2Vayd+zpBCTWI68KTHiPQZTnx/gU726jrZqtB4Eoo/DaxLhbsh0hwFi5mztwpAas82CUJRdmyhlby6G2Uy+OS8TZrHVe+9a+YbE9VFdEKMqX+iXmQaXrBCcHMnUr+rXyJVw5tKnOKArKA19MWQbJGqpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVrppA1P; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVrppA1P"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc16c6dcae2so329753a12.2
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787259841; x=1787864641; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=TVrppA1P3o9MMvgwVES+j8y/ZIkiTNsZIfijBVJstvoknwaa0V8UcbYeiuJR13HSYa
         SW7Xxl87jHL5HEWANAumJp/l2EiCHmGe/KmP5/UrPN3c0LUGg7oKi0luesAttqbuFBpL
         7zJYNieF7iwTfdIxPB/JW38p0sqDUKCbiN8BojH207gxVX+/Pq2RBChaT+ldBXtHoJUL
         I+lHZvrLrK4BsLIrc/2rGkML07alYnlmyfGPB0ejX2u051ICN+KJSoZsMzuBbkmTBhBG
         ipRhZzwRy+MKwI+ZoGzxuubTld3PgaOjg3KDeHnpzKSKsOQmW4kicPacBidsTP74meB7
         KHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787259841; x=1787864641;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=igX4ScQhVcKIUKOi+hnrGtHVpigj/MZsgio+JOhg6CU=;
        b=ro9ZiMHlTckJJxi9uqtpiIaE9FggFSffF4SOYPMn9vmROGRuDA5NIF3WARlrji+0lg
         y3st75pG9VuhM/FPAUS1g5qEkf3cKF4tgJSOqAx2zueKskYmUsOdf9L+kiiM038ysHH0
         1KtkF1jOx5ZjMwdrvF/GvBDtkzJXFZOJuyULIvGGQO4dP7Fu3BBEa897wp8tHgIsb62W
         Fg18Nvw47ahyODAhZR7eCKyagcnsU8Zceldi8NSi3AP3q9nVfSAwv/7xFpt4s623pYp6
         As0slvLSdyOa5GbHaBS3iigFacT7Zp6n6n6gaBSYksC6Vmq7ZfLzbh5k3ZGInVHbzGqu
         yrgQ==
X-Gm-Message-State: AFuF++mqKOKVcNQoVNL3F0Z4Mkq5GB+vgAUZ+31EIq/VCyo36JmX4EWG
	7YL0KRbope0s5CK+mNOi3e+Z2ByQMyzipNy8VP/ylM5yRKoqsH9ZTGyfCHaDQw==
X-Gm-Gg: AR+sD10fWOIRCZ1wqGMkCaf1uxTgPa3Issu2VeG6DVJqsnMl2Gyzhllwkp98ZMhr0Af
	3jrGhtx+f65y4VBscwyOBMbZjuxJPcXetABHQN4xTzEd2zhqXzLOJoUpQnbiCJPBM4UxqDUgzmS
	Gx9Sfm5COprXkFkV4LPI2RgsQ/zGKbQpuHUwKO4M4PqbMrFsaQxepMYIpDM4807E9kZQj3Bi0Qn
	EOQZIkyXxOpOjsBKu+qy+gXBkNg8LwGBeeXgTtyDhbaD3kVYy8NymQym3Bj2wOFTKq/d9VEFi6D
	asn4xILQdSsNtolx3UkWZ7C+TNPK3vOkfIWViO82fuEh4eVUP9usTxbNY+hTfClabhMpDxXNhyb
	7gshD3aE3Eibvbj9Zb8F9wdDe4UIWYie21ZqfDi5tmpm7ftuOWYLuyb4HWu0fZPLW2mYHifOchq
	xvAcCjP3LaOnPl9ElZ1umv0CBTOFsg5bkLj7V9KIrKrPhCPRALPlyeeuMSzCtH
X-Received: by 2002:a17:90b:1c0a:b0:395:4290:46e0 with SMTP id 98e67ed59e1d1-395c336c815mr1810817a91.5.1787259841063;
        Thu, 20 Aug 2026 14:04:01 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.3.244])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ac3d1bfsm18169520c88.0.2026.08.20.14.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:04:00 -0700 (PDT)
Message-Id: <e3f7d885209e6cf9487bea296bc81df43f3758db.1787259838.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
	<pull.2197.v6.git.1787259838.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 21:03:56 +0000
Subject: [PATCH v6 1/3] checkout: extract function to display advice for
 ambiguous remotes
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
 builtin/checkout.c | 62 ++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 55e3a89a85..650eda735f 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1343,6 +1343,34 @@ enum checkout_command {
 	CHECKOUT_RESTORE = 3,
 };
 
+static void advice_disambiguating_remotes(enum checkout_command which_command)
+{
+	const char *cmdname;
+
+	switch (which_command) {
+	case CHECKOUT_CHECKOUT:
+		cmdname = "checkout";
+		break;
+	case CHECKOUT_SWITCH:
+		cmdname = "switch";
+		break;
+	default:
+		BUG("command <%d> should not reach parse_remote_branch",
+		    which_command);
+		break;
+	}
+
+	advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
+		 "you can do so by fully qualifying the name with the --track option:\n"
+		 "\n"
+		 "    git %s --track origin/<name>\n"
+		 "\n"
+		 "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
+		 "one remote, e.g. the 'origin' remote, consider setting\n"
+		 "checkout.defaultRemote=origin in your config."),
+	       cmdname);
+}
+
 static char *parse_remote_branch(const char *arg,
 				 struct object_id *rev,
 				 int could_be_checkout_paths,
@@ -1358,35 +1386,11 @@ static char *parse_remote_branch(const char *arg,
 	}
 
 	if (!remote && num_matches > 1) {
-	    if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
-		    const char *cmdname;
-
-		    switch (which_command) {
-		    case CHECKOUT_CHECKOUT:
-			    cmdname = "checkout";
-			    break;
-		    case CHECKOUT_SWITCH:
-			    cmdname = "switch";
-			    break;
-		    default:
-			    BUG("command <%d> should not reach parse_remote_branch",
-				which_command);
-			    break;
-		    }
-
-		    advise(_("If you meant to check out a remote tracking branch on, e.g. 'origin',\n"
-			     "you can do so by fully qualifying the name with the --track option:\n"
-			     "\n"
-			     "    git %s --track origin/<name>\n"
-			     "\n"
-			     "If you'd like to always have checkouts of an ambiguous <name> prefer\n"
-			     "one remote, e.g. the 'origin' remote, consider setting\n"
-			     "checkout.defaultRemote=origin in your config."),
-			   cmdname);
-	    }
-
-	    die(_("'%s' matched multiple (%d) remote tracking branches"),
-		arg, num_matches);
+		if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
+			advice_disambiguating_remotes(which_command);
+
+		die(_("'%s' matched multiple (%d) remote tracking branches"),
+		    arg, num_matches);
 	}
 
 	return remote;
-- 
gitgitgadget

