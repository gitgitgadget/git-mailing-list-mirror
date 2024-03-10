Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFA39FC5
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097837; cv=none; b=q90WyAnVfyAY8M0u6rB7hYtv6XXku/cDI67E+bEzviZHS4up7k4LKyjjxrW8wB4anJRXrPCPmHig5DSauP6npuy9AZ2VfgCYrKNpv+cYh7EbIRaNV+UFMbuvTtLrlue6Re1zn5oeSJBWUZzGZ16cVoP6DSPaWz3Iu72LvJwdYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097837; c=relaxed/simple;
	bh=KidVfI2IkhVGVmsFjX0KdeWxickZi9XilN8IgcX6gg8=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=KH93FSBD3UEYJ6cKeGdyYqE8c4pQY+4p9uuKdNblNfmzPCe9e4jp3xymQDeR5Eg/tCX4UENdXwHaa/uwmk3UBSJor/hzGbReLaZDqXJjb7LwKDW9o1i/l/09McMEWUyLHZNapBiwVfBuJ1X5EITH3DrZmlFfQH+VfhIIp0r1mMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HYltzYcM; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYltzYcM"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4132ab0eea9so489105e9.1
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710097834; x=1710702634; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s20xuP5bGQ37kPqFLC2kcQ3WEp9FWkSn9bpExYJE0IE=;
        b=HYltzYcMocs0KrvCiQ4ckHYxdfPQHtpA6XlIMWcMrocqJ1AqoNr5pTvBlTwDvj/hjN
         4cL/G/Wvl+gpRrMAjTnSxA161x/+xdvpIycPI1Y3rRVECqQ65TeSSaOGQGHcV88dAbVS
         EwXephXeheW1RCnGd9xK3tCKqUfw20AudZ4NZ8t0VlJp2xgdHxQTn2sO3SQAem6AnjeH
         7IrTW4gYFs0zM7M+rihGM50kbKrn8RY9D3mEe9kAl0sA758zrAr6k52Oi+BmAfTD0gaU
         P0sFlSMZvx7flU0Sh19bw+gzFRAYAuqAYKkqj/DazWfv4RB+QKaaC3uCdq1lrmPCO3dw
         gsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097834; x=1710702634;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s20xuP5bGQ37kPqFLC2kcQ3WEp9FWkSn9bpExYJE0IE=;
        b=IshG1eQDsLnKgGGvVySBUdU5K3WI3e6OzORl9dqMZWGVUkTK98S2p/mUZY7grbsudB
         hti+bX59IB2lOWBIvb/Cz/ns8iW/hMWrbjsn8lp4lcPhPu7LfvWZRqwgDyEYv+d5hlpS
         wRiAuzAUbT+6F1c22nnULsDSp+0M8H8678lHDqw3eWOg2MwUrdcmFthjMz75LBER5ALp
         4eNM/Hx6Q5ZugTvoxWLFAeEAPsJUMF5rTNi79Cl9TEDZeM4UIu/t7D2VGHwsfuHn4JPp
         glnpbU2iIMlezeCYPBzcmuaMsqtOumSFUNAdBUy3Ux9oxplQo4s5XOR6JfHTRqNVgrdX
         qM1g==
X-Gm-Message-State: AOJu0YwKzWjK4HNILuvfzSURfj96ApRAjDPfyAuCYlQYHt8xP5Fi5BZ3
	SgkS0Ttu0E2UT4LQYIKl1raCfxfSu4R2XJQGm4Ww0CgbzVW3Hz9207EdPK8J
X-Google-Smtp-Source: AGHT+IEddbfei5SEe+XT9LT1inWp4N81MQWUKZlA4fJSdKHMO831cLqCppO0DDNH5sfjY0jkcGr46A==
X-Received: by 2002:a05:600c:4fd4:b0:413:16c3:b99f with SMTP id o20-20020a05600c4fd400b0041316c3b99fmr3653600wmq.16.1710097833595;
        Sun, 10 Mar 2024 12:10:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b00412b4dca795sm6552319wmo.7.2024.03.10.12.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:10:32 -0700 (PDT)
Message-ID: <df95ca4b720a86ad5c80e1a8a8cefe9abd0275b2.1710097830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:10:26 +0000
Subject: [PATCH 2/6] doc: git-init: format placeholders
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

With the new doc format conventions, we use _<placeholders>_.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/git-init.txt | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 7ff7d8e7ee0..e8fe72861dc 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -60,7 +60,7 @@ include::object-format-disclaimer.txt[]
 
 --ref-format=<format>::
 
-Specify the given ref storage format for the repository. The valid values are:
+Specify the given ref storage _<format>_ for the repository. The valid values are:
 +
 include::ref-storage-format.txt[]
 
@@ -81,7 +81,7 @@ If this is a reinitialization, the repository will be moved to the specified pat
 -b <branch-name>::
 --initial-branch=<branch-name>::
 
-Use the specified name for the initial branch in the newly created
+Use _<branch-name>_ for the initial branch in the newly created
 repository.  If not specified, fall back to the default name (currently
 `master`, but this is subject to change in the future; the name can be
 customized via the `init.defaultBranch` configuration variable).
@@ -119,8 +119,8 @@ Same as `group`, but make the repository readable by all users.
 
 '<perm>'::
 
-'<perm>' is a 3-digit octal number prefixed with `0` and each file
-will have mode '<perm>'. '<perm>' will override users'`umask(2)`
+_<perm>_ is a 3-digit octal number prefixed with `0` and each file
+will have mode _<perm>_. _<perm>_ will override users'`umask(2)`
 value (and not only loosen permissions as `group` and `all`
 do). `0640` will create a repository which is group-readable, but
 not group-writable or accessible to others. `0660` will create a repo
@@ -133,7 +133,7 @@ By default, the configuration flag `receive.denyNonFastForwards` is enabled
 in shared repositories, so that you cannot force a non fast-forwarding push
 into it.
 
-If you provide a 'directory', the command is run inside it. If this directory
+If you provide a _<directory>_, the command is run inside it. If this directory
 does not exist, it will be created.
 
 TEMPLATE DIRECTORY
-- 
gitgitgadget

