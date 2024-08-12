Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A3B187840
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481914; cv=none; b=n9UUCohBkIrjtvBycha5tzTaq6MQa4rG0GDukcn+yI7LWqoHEh4x1v0U97giV+ceyP8CwUpX/oGNvHGZllBQDrYFHONOGQe0mwAM2lxmhTL86dxq3tB/7XPsZclFPcCG1TE8o6qvgR4BXPJRw2F9Ub+F7/sozy3b7/mmp4HBSfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481914; c=relaxed/simple;
	bh=7d1BU0VSGwykTS462FYTf76TfKy7EIYTwNVtCzCoiSY=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=i1oJyrv1iLVD9rJluwd3EHxdnc9PewzwdZtxuwtwWhXtUU+4xFQevvTI+7JOGdT61jWnab9n8mufigCODsjHlMn1cc/tt3b/MBLpAuia+wUecoE4tlwq+Tq3cfT+QCqosdiCdug4E8X4WFJZ2JmIrpeJukKRgIwz/kgi/yThbDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbfjTBCF; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbfjTBCF"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5320d8155b4so1462114e87.3
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 09:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723481910; x=1724086710; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVXQr2LzxTXIaQHVxsdr6zPMrImZTMZcgrnEqtZIIjY=;
        b=UbfjTBCFK3VkhXVh5YHOnyy2k0pcFcClBH5A1Vn47SQzKaG/w2i6qXDCdDRrfN/yS1
         gaYg+cve6V3LenqCOqu2klxL2GQ0Ql2ayF7oZFKqSuZUxNn6UbNii6pO4xJ43dGeGYZj
         sU47Jej716Pc5fqPM0T92z2KVhlzWXi/xxDxHqiuFT4xEVki7mRzihimqi6zBQpu4Kwk
         HHbuS9UIMXujYD6nT/2/QmYE6mQF6ak5huIoO5y/7gHsMkeOW6Kb7f26HhhsRtXlqlNJ
         uZ2/34Wojl/+IhChUyV3MmeGCb2NpBiu0hNGjVUmyo4Onhjlw7dFW2p2x9EChHcj5IW+
         CqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481910; x=1724086710;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVXQr2LzxTXIaQHVxsdr6zPMrImZTMZcgrnEqtZIIjY=;
        b=U6EjMnuGrhpFkQNW6cClt5a1VGs/IZuD1CHlUXMTLf38ghWbcMI952GNOISFDfoaZI
         PHDBsCLuT8CtiUitYu/9TCVzx+Or7EGSU4oIRjmKPRjDZtY2Ala7e4PJkslXr8lyr/gL
         eHOsPCExPwFuds0DsR2C5NvWSRy5RVD5nN2wXO21c55pQC7//FRwNt3/CNjlS7UVBp2R
         ZpsMKPqVl+utp5fbN7hARyrU8HwXSXQ+xtuDYHy/0dVmCBe2w4Wd8rlagXqjWd7t96uK
         P38kGWamtQqjl4lyrUo8Powj6L3Lhj1VLE+XGk712AkAHpuhqmacnV+lcu5w9wzetcSL
         B3hw==
X-Gm-Message-State: AOJu0Yz8clCNvZzCux/cR7Ucq7aQBJAMc22uyYEnmWqh7hAyXAbUpW1U
	ldrTYm09X2YknTnBjfy8vJVsc/qmA5Inu3TotLV10N2rBs78Wfdqjc4+Sw==
X-Google-Smtp-Source: AGHT+IFCRGOsmn7Hg+79kOPZMiPp4nXC9LaOwLo9NsmyPcFZKtaOMlzltJNZc/d1F5A39oKbgNrIsw==
X-Received: by 2002:a05:6512:1316:b0:52e:9f76:53dc with SMTP id 2adb3069b0e04-532135acecemr659594e87.0.1723481910100;
        Mon, 12 Aug 2024 09:58:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53200f428b3sm806058e87.288.2024.08.12.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 09:58:29 -0700 (PDT)
Message-Id: <pull.1747.v3.git.git.1723481908.gitgitgadget@gmail.com>
In-Reply-To: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
References: <pull.1747.v2.git.git.1721335657.gitgitgadget@gmail.com>
From: "Alex Galvin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 12 Aug 2024 16:58:25 +0000
Subject: [PATCH v3 0/3] git-svn: use svn:global-ignores when creating .gitignores
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
Cc: Alex Galvin <agalvin@comqi.com>

Git-SVN does not currently use the svn:global-ignores property added in
Subversion 1.8 when showing or creating .gitignore files. This causes
Git-SVN to track files that are ignored by this directive in Subversion.

The following patches add svn:global-ignores to the list of public svn
properties, and update git svn show-ignore and git svn create-ignore to use
this attribute (as well as svn:ignore).

Alex Galvin (3):
  git-svn: add public property `svn:global-ignores`
  git-svn: use `svn:global-ignores` to create .gitignore
  git-svn: mention `svn:globalignores` in help

 git-svn.perl    | 49 +++++++++++++++++++++++++++++++++----------------
 perl/Git/SVN.pm |  2 +-
 2 files changed, 34 insertions(+), 17 deletions(-)


base-commit: c2b3f2b3cdbf5ad9feb978dd367d77561a1271f7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1747%2Fav-gal%2Fgit-svn-global-ignores-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1747/av-gal/git-svn-global-ignores-v3
Pull-Request: https://github.com/git/git/pull/1747

Range-diff vs v2:

 1:  002750ea47a = 1:  002750ea47a git-svn: add public property `svn:global-ignores`
 2:  7735afb32af = 2:  7735afb32af git-svn: use `svn:global-ignores` to create .gitignore
 -:  ----------- > 3:  18dffbe992e git-svn: mention `svn:globalignores` in help

-- 
gitgitgadget
