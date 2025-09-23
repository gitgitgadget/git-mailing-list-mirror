Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0CA2848BE
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758649479; cv=none; b=lYOzCB8DgIVbOdFYQMOts7ZM7Xz/fwaHjStJfhO7J5LUeqMrxHMmSYsh6b3aiXJkXIv+9U4HA1OJTxOZ6joX49wQIcutqlvCn1y3+GzGBE/fsb7ZToze80LmPQ4Q6whs/Jk3UrEGdMllri7ICEoc42jiLNmGHwexZNQDeoMLX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758649479; c=relaxed/simple;
	bh=55DJASOpaSeo5tHatmGd/+jQ4xh4WwrvINnecJgKjKg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iF6VyXY/IVq1/5vYBAK60g/o3IOm04PpkdcbY+/tlpYT7bdqDX6m0k8fXMyBfD/0LH/ZQMUQmlOcippxNM4qhcK4E0CnzKWH/zgkzDcGx4Pa5CXkoxILGF/uY61Jm6olYoIUGTHxgkBdyDKlQorIX0mrbz6JglBVE7SQ/X+41Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQPfK4Xu; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQPfK4Xu"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-8ca2e53c37bso206968239f.3
        for <git@vger.kernel.org>; Tue, 23 Sep 2025 10:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758649477; x=1759254277; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGdIcmZns6U85XDYnW+k/aIiGwf4itNWqcFr9Jns37k=;
        b=dQPfK4Xu/3aZsKE9osAVGJ5M2XLlf3OpGpN9PpQErMtbH2885HfAQcH5s8BgEczTcG
         J+FqY6kRiT477vOi5H007HK4631wqttPLQbyeYt1vgt2peiwbTgLEusgiotLyOkujfAP
         nw3ZYoodSlAsBtHqO+5eCZfg8Fm0lGYKePc6l7nVhWKNE/AhTZQCkUiaZsX4Jorpp6a2
         EKFegkpaBBpSZMVje0c06tKwaZog1r5KYa0lBRNzcLHOZF46bpJNlvvkK71zrS4HJkCE
         6qoeRIyS5e+SvQB2rMPdRDV7KpqYWa9B6Mi9l22fcdOfLgK5To3JZJoyKpO1Q6Z4BPDp
         f39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758649477; x=1759254277;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kGdIcmZns6U85XDYnW+k/aIiGwf4itNWqcFr9Jns37k=;
        b=iklwTmAmtLz6k2CVMhLQOvcW7N2YRYv3x2dpwtJ8qCHq7u3R5ubu4t+X7fDxq8LDWb
         7YBS1PO6/n6+fe51HZhA0xzwd+we4cwYUi3EHOSOco39TnJAWQkckKnS6AnsGO5plUzw
         tHIeMJ6QD1NM2HfWc7PiGGtjJs8JqzfHyfvIVWcXpwlyMq3521niHDcqbV6oWu6mBCDx
         s74TG46yJRAk9d3M8sCuAnXj75wSo87Nf4czAqg2s7RCzZMw91wh5pi6H8fgRv9MMi9W
         uMU50XIwPfWngd6atihWk+KixGwNPsIgaQhILAyXcG0l0zO/Mjsad6q2ZXnJDGIZdPZt
         0hoQ==
X-Gm-Message-State: AOJu0Yx9W/XY0VFGzgP5GI9pgllLM/ZuEE9/ZrBMRizxYC6poAKj5VLw
	oKIu1IxMjPXTEhtlnKpmgtzhh1J3AriZP2IYJCjM2rg8Y4+OktQulW4F2ZAG0idZ
X-Gm-Gg: ASbGncuLJWy5sgaG/Sm8gyqpDoqms1/UxoWj+AwsZxroCREPAGTxt+cG+V/k9KjoQoE
	WkzLN2TDn5yKYuetAl7b8IJ36vbf81ww7FVU7EqzUPpjqC8kCLnFzrAmrOQY2XksdQGnkU5JNSj
	/ehp6HLAwJ2mC5lWgaGfdYQdOPEDjtx0wQS9FhZGlSHt4K3aowNKA9RGdKRM+x7/l0gZzoS+4oM
	PG1P226OXQ2VRPCn1tnG/SPLjK1UO2o+CA35IekTHkVPjbL/+pixKT1H0acHar7tgl+3NY9iNQQ
	QQ7pamejYGPmK8SLBoval814yOYzyRLB70cSxf9j5jcoINa34tQW9sH7uMo/K+4jZMax67D51I7
	wdwwdn63J2oEiQQttCB5Zd/2i
X-Google-Smtp-Source: AGHT+IFsFG9vWKMZpCN9GKdl4KajmowtALMZyOQ6H2+IYyLAnna2kM9+ltnOH+9A6mAnYMRTO3vsEA==
X-Received: by 2002:a05:6602:1502:b0:893:65c1:a018 with SMTP id ca18e2360f4ac-8e1b8fc4b13mr673716639f.3.1758649476949;
        Tue, 23 Sep 2025 10:44:36 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.177.97])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8d60c03a069sm163855139f.6.2025.09.23.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 10:44:35 -0700 (PDT)
Message-Id: <2870c77e80870b440079dab8259194fe009eeee4.1758649472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
References: <pull.1964.v2.git.1757703309.gitgitgadget@gmail.com>
	<pull.1964.v3.git.1758649472.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 23 Sep 2025 17:44:29 +0000
Subject: [PATCH v3 1/4] doc: git-push: clarify intro
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

From user feedback, 5 users are unsure what "ref" and/or "objects" means
in this context. 3 users said they don't know what "complete the refs"
means.

Many users also commented that receive hooks do not seem like the most
important thing to know about `git push`, and that this information
should not be the second sentence in the man page.

Use more familiar language to make it more accessible to users who do
not know what a "ref" is and move the "hooks" comment to the end.

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-push.adoc | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index d1978650d6..25d972f248 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -19,12 +19,9 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-Updates remote refs using local refs, while sending objects
-necessary to complete the given refs.
-
-You can make interesting things happen to a repository
-every time you push into it, by setting up 'hooks' there.  See
-documentation for linkgit:git-receive-pack[1].
+Updates one or more branches, tags, or other references in a remote
+repository from your local repository, and sends all necessary data
+that isn't already on the remote.
 
 When the command line does not specify where to push with the
 `<repository>` argument, `branch.*.remote` configuration for the
@@ -44,6 +41,10 @@ corresponding upstream branch, but as a safety measure, the push is
 aborted if the upstream branch does not have the same name as the
 local one.
 
+You can make interesting things happen to a repository
+every time you push into it, by setting up 'hooks' there.  See
+documentation for linkgit:git-receive-pack[1].
+
 
 OPTIONS[[OPTIONS]]
 ------------------
-- 
gitgitgadget

