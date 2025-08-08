Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFBB1DF974
	for <git@vger.kernel.org>; Fri,  8 Aug 2025 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754680531; cv=none; b=lnPnlyQhe/0tZTAYymVcRgkcmknyPG3fSJ3mO3UDd9ymbDhCdFPwU8VSMhlY81jgrm5LJdC6Jd+mzomJSmiZGQL2Mmo+6IszHNL71GSctsbbqCTIJoRSV9iQ0dhCAsqdAZwiiqLTC0zmZYF7UNCg6bFtSDZ/wd1eUOe9hfaMKbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754680531; c=relaxed/simple;
	bh=7s/QGsS75quvrX0s9UXSA3K01V96l4bVb7+MMH8klgk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UaCNcW1Am0qd7PRx6NgAEGpvHAqVDJsTGTu+mCuLis727weTGPUVFJaQml6lTkY/T8sYH6s4Yhd1VFPRAKuJfyWqN4iX9LItTZCSD4AFJ71M2gTryETvQX07JyVk2PjJlwcpeP7ei5hT3zmGuQ4rOUopq8tP/G5BsACtVb8iSIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4L2x1IF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4L2x1IF"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-459e794b331so15879845e9.3
        for <git@vger.kernel.org>; Fri, 08 Aug 2025 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754680527; x=1755285327; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N58lWS3ypoOq09Qzy+qOaA7T5/5yVfJM175/RjVe940=;
        b=N4L2x1IFOPIefSeQ6/DJPhOcN2oos7LLKgy6nJMoAq61+gZRlseIbB2uSr8VV0LSPi
         KMaKH77nc7jgeo77U5vDA/ZtTK9k/3z18YVj2Qsyvd1Hb5AFTDEZ6DY6StJ110B9oDBB
         fKA6wgVTBD57Vp66qxtUm/uf5Qo7p7MQ/NEaxLXlVbscqjvkDNB5+GiRr0zdf011nELV
         yzn3lr8sFIurJjwDgLvscyq1mEBDXw9HscAu5SDf/TsxbD9AU/Mm3moonFa0hySkrTY2
         hJXt1gXQ4myCZbGApfaFsKcjGbV1UB7yADCChJ+iNqDVwjYGIpLDbtcPOIFb1lTP02LW
         zihw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754680527; x=1755285327;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N58lWS3ypoOq09Qzy+qOaA7T5/5yVfJM175/RjVe940=;
        b=ZA1b8QlryffxgMOzBaS+AW1icVNTQ0P3/X5abVK3gmS7PpCpBI6YTHRGbSr/hcwuLz
         6FewUzRkAspQcLq06pit4LtoEfVesXZOPVT3rZ7PpeyDMQ99eW0AMVVrk5YzxcEuet41
         tBqIwLU9P/IwDGJgrBnRO1Lpgz/DXkaKttz0nsmbuLK5V7iNWBusMCPj99F1zGFy0JKR
         A+7pGSVVk691Ll1q4WzEahHY3L5YISXFpvTRcV0M/VeCYvkj0fG94/sIql9RoTzncVYp
         o4NIXFpP6qqe1PBa4QDp+ZE5YohwsBgsh7U7qexGZvuHo5BGyiYHvNHqcK/yTXHlfG4W
         nq9A==
X-Gm-Message-State: AOJu0YxPpbgxyCXlYbnbrdaLEY0t8B61jBuRhHmR8b5NRJr1ricybi7D
	TVRfHJt0gh6owc3B/NKHVSEvGX4ZSZYVuVgdHV9ZBoGSlpZfASJfC7+THbNV2g==
X-Gm-Gg: ASbGnctt5SsZbPJDme/1SL2bIxT/qI2TtrSPQ62J+VC+ZoiONPPEEi7BtTzg2fMuZW7
	em4HCgwRnPfrJ8oVHCVvFYWoAndjhR0p4NW3FqWmwG8SfQYKDO5OoPnA7awjB0FyNmqC09bbo7M
	DAIviwWV6En6FbJ+sR537qnFGel0QGb5mCZ4M1FtsLykl1tOvT9lbOPyQ5fV5BweaazOVngfNyh
	xP8vwFwN50W4+vRlTnixxrSK+E0kcLN3FV4qPYyuUIx4/GB1owj0rAFbmxDitarFkZetzAvn7+Y
	7yExrCEHybheADVWQX9bR/ulXeQYkozRCJrjZ6Z+CHNKPdFYJfjZoei6gAIWJhLoizxUf24vh/c
	r5S6cHieVS3iLvaRTG7uZ3v4=
X-Google-Smtp-Source: AGHT+IEfj7uwQtuYmsP8Z+hwihk0HDFzlv7+dDdlQTS7tbiKyqI7iE5iNYXPbA+OwIGp5UQCpWtM3A==
X-Received: by 2002:a05:600c:6286:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-459f5687c58mr41952315e9.30.1754680527004;
        Fri, 08 Aug 2025 12:15:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453333sm32430435f8f.45.2025.08.08.12.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:15:26 -0700 (PDT)
Message-Id: <pull.1949.v2.git.1754680525.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
References: <pull.1949.git.1754666665.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 08 Aug 2025 19:15:20 +0000
Subject: [PATCH v2 0/5] doc: git-rebase: clarify DESCRIPTION section
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
Cc: Julia Evans <julia@jvns.ca>

Thanks for the review comments, here are the new changes which:

 * make the intro to the man page less dry, with the suggested wording
 * clarify the merge conflict resolution explanation & fix the HTML
   formatting issues
 * move the explanation of the git rebase <upstream> <branch> syntax up into
   the intro

I'm still curious about the intention for the git rebase master topic
syntax, since I'd never heard of it before. Is it just to save on typing,
since it's fewer characters than git switch topic and then git rebase
master? I ask because someone mentioned to me on Mastodon
(https://hachyderm.io/@simontatham/114988051822317920) that they sometimes
use git rebase HEAD main as part of their workflow, which is not equivalent
to git checkout main && git rebase HEAD. That made me think that there might
be some broader intent to enable rebases that wouldn't otherwise be possible
without that syntax.

I'll wrap my text to 80 characters in the future, still learning the process
for emailing a plain-text mailing list :)

Julia Evans (5):
  doc: git-rebase: start with an example
  doc: git rebase: dedup merge conflict discussion
  doc: git rebase: clarify arguments syntax
  doc: git-rebase: move --onto explanation down
  doc: git-rebase: update discussion of internals

 Documentation/git-rebase.adoc | 285 ++++++++++++++++------------------
 1 file changed, 137 insertions(+), 148 deletions(-)


base-commit: 2c2ba49d55ff26c1082b8137b1ec5eeccb4337d1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1949%2Fjvns%2Fclarify-rebase-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1949/jvns/clarify-rebase-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1949

Range-diff vs v1:

 1:  ac3a91c04bf ! 1:  26b742eb49f doc: git-rebase: start with an example
     @@ Documentation/git-rebase.adoc: SYNOPSIS
       -----------
      +Transplant a series of commits onto a different starting point.
      +
     -+For example, assume the following history exists and the current branch is `topic`:
     ++For example, imagine that you have been working on the `topic` branch in this
     ++history, and you want to "catch up" to the work done on the `master` branch.
      +
      +------------
      +          A---B---C topic
     @@ Documentation/git-rebase.adoc: SYNOPSIS
      +    D---E---F---G master
      +------------
      +
     -+Then `git rebase master` will find all of the commits since `topic` diverged
     -+from `master` and copy the changes in each of those commits on top of the
     -+`master` branch.
     ++You want to transplant the commits you made on `topic` since it diverged from
     ++`master` (i.e. A, B, and C), on top of the current `master`.  You can do this
     ++by running `git rebase master` while the `topic` branch is checked out.  If you
     ++want to rebase `topic` while on another branch, `git rebase master topic` is a
     ++short-cut for `git switch topic && git rebase master`.
      +
      +------------
      +                  A'--B'--C' topic
 2:  f4f0a5a1172 ! 2:  249a5127904 doc: git rebase: dedup merge conflict discussion
     @@ Commit message
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-rebase.adoc ##
     -@@ Documentation/git-rebase.adoc: from `master` and copy the changes in each of those commits on top of the
     +@@ Documentation/git-rebase.adoc: short-cut for `git switch topic && git rebase master`.
           D---E---F---G master
       ------------
       
      +If there is a merge conflict during this process, `git rebase` will stop at the
     -+first problematic commit and leave conflict markers. If this happens, you can:
     ++first problematic commit and leave conflict markers. If this happens, you can do
     ++one of these things:
      +
      +1. Resolve the conflict. You can use `git diff` to find the markers (<<<<<<)
      +   and make edits to resolve the conflict. For each file you edit, you need to
     -+   tell Git that the conflict has been resolved. Typically this would be
     -+   done with
     -+
     -+   git add <filename>
     -+
     -+   You can then continue the rebasing process with
     ++   tell Git that the conflict has been resolved. You can mark the conflict as
     ++   resolved with  `git add <filename>`. After resolving all of the conflicts,
     ++   you can continue the rebasing process with
      +
      +   git rebase --continue
      +
 3:  b27117ea19a ! 3:  ce7ab74ea0f doc: git rebase: clarify arguments syntax
     @@ Metadata
       ## Commit message ##
          doc: git rebase: clarify arguments syntax
      
     -    I found this extremely hard to understand as it was and this seemed like
     -    a clearer wording to me.
     +    This removes the explanation of `git rebase <upstream> <branch>`, since
     +    it was already explained above that it's shorthand for `git switch
     +    <branch> && git rebase <upstream>`
      
          Signed-off-by: Julia Evans <julia@jvns.ca>
      
       ## Documentation/git-rebase.adoc ##
     -@@ Documentation/git-rebase.adoc: first problematic commit and leave conflict markers. If this happens, you can:
     +@@ Documentation/git-rebase.adoc: one of these things:
       
          git rebase --skip
       
     -+`git rebase <upstream> <branch>` is shorthand for `git switch <branch>`
     -+followed by `git rebase <upstream>`.
     - 
     +-
      -If `<branch>` is specified, `git rebase` will perform an automatic
      -`git switch <branch>` before doing anything else.  Otherwise
      -it remains on the current branch.
 4:  28b00d3b32f = 4:  590d7486d3d doc: git-rebase: move --onto explanation down
 5:  7d4dc6d2c04 = 5:  ad97cd9e671 doc: git-rebase: update discussion of internals

-- 
gitgitgadget
