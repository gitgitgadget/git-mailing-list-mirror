Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697393859C2
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769684948; cv=none; b=UMMq18aEV/1a9KFo2V03+VwvlvI9uh9cWIhN2JRYV2WH7dBlcZZHF4j05noEmQGlau83WLg2d4YVOR7BGe0lz4p3/uc/t2V9VSusfXfDgK8bHtCb5sXfwTrT1p5UEqdBOXZys5xxPdTeoinDZiX9UsfA0YkgPKRY1LgyNlzEeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769684948; c=relaxed/simple;
	bh=dv9gIO1rbfttbCQGK/LgtMJhDYAOpp3tc5JHyQPgtts=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=sJ6n6IhBRMPWKb/cUQZDkpzOsbJroqHRAKnyn7JynKNgPtCIYwE7r6Hvh6xvzsNbUf2cFnltdk9CZ6Efb4AU5Ym0wNoid0haETZ40zyiVomiO/nukr5NkAmv5zAmp4IjTCQ7+ms3JYuyh7a+3v87cwlOffaEJBTvTWGn72Iabv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb51iTtA; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb51iTtA"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-894674a4c4aso15903176d6.3
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 03:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769684946; x=1770289746; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8zZSt/mlfy9UgM+EI9Wt/losGeAh9xMkIFW87e/v10=;
        b=Kb51iTtAdRUHHPC0ashHLWzd3spPrPXig8kfkxr70VpLzoT9eOrhbVxFuYBFMHmVZa
         MIVZKDD+tJGsg6R5TngMJtS4vy4JMElwT3hANjSdQesVb+oDPNxnHDmGVb7btSkOQI2z
         m0l3KjSVwddqiSprn+xB0ktZnC+nzOSAQxL7qU9wMZoVEWNot9txW9iZ2lit5LcH86NS
         UkVUyRenVHNpZVi/3oGt8hzCUkSwEhtY5bufNqUfR60MyRwA7XuCs2YIiMzL46sw5GQs
         ZHw/swxtZQrxJkbBB/xLlDdV8yYVObNGI2cbMUS6myyxvynsHsMLaWF/aZiyXDx3zV3I
         qGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769684946; x=1770289746;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o8zZSt/mlfy9UgM+EI9Wt/losGeAh9xMkIFW87e/v10=;
        b=hingntrIVn85nPNBlp9xAPagxAIO5ukjSb6/k6KuMuKKVee47nqvV9rtFzcTz95Fnw
         xWQIl9Rf/FP6eRIr1n50ULgSrhRrFlgTAw+48XnTZtd5EzqR+lMoJjQvlr4ytBwwljDh
         TedOomy5gktTv4NLm2zHQot68fg2x8saDd9AjayDj1h3VguOc2yO3JKqpkkmJ+hDtIeY
         bFVjIasJ7xkmDb1L82vb4ywHtZTKMLjL1p0Y/Wp5JRi9tHRDHvUZSw3aPrksaDtzQklL
         FFQUaO0aKZn7c765m8zBH6D+B3bC+5tp+PAvRzItcmFwuXDVfPJ0TsQcfQTJLFq9wWaF
         0bFQ==
X-Gm-Message-State: AOJu0Yxe4FcvFhV9ZnmBt4jccbYKUjjTmFKKuoT3Os1zvPQUPL6wlDEa
	jswFlnMenLGM7ZH209iWgAuG9lOTqs6r1c7UWupWAdVc84UB7cWM17n4friQ5Q==
X-Gm-Gg: AZuq6aL8RSTEjuqap3AeldHJQh1/x1s+J2qndhVGufY3x9wrtWvHdqAKF9EQFwl9NqK
	UfbRgGKd9Eft5l9DLM8iPheTl2WGCk2BGbf8rdLRo2vKoZPs6hg3Xftmf9ftZ6xLgEeQs5tpPt/
	KQKmPsXvIT8NRSbQKNvnyIWAseXEu9JRGxZ2Bp5EdJjYpDaRxm2vdtXcQlQPykTq812z9S6TbF1
	rSE2P82Yz/gf0lY/qwwQqA9WtdaC3j1WgO0u2QSHCUBWArwCu+Ikmx1z3Y4dIoFY6p3wII/XQ+G
	Lr+ZJ34ZBX1PGE3kaIf2eif66CFgoM0ScTdw8DFGFwNjUtxAh2lp44Df23iIAHGxWAN+FSulu7m
	qOC7ow8tSjsgAV8rnw2aIeIbKoYJJ7TImcMYxgu7GsntJ5Q8CT6JcWqKFCNtnbxnYgsMbMUD35K
	dz5FAs77mQYOPV3w==
X-Received: by 2002:ac8:5709:0:b0:4ee:1f09:4c39 with SMTP id d75a77b69052e-5032fa030c2mr111812411cf.45.1769684945884;
        Thu, 29 Jan 2026 03:09:05 -0800 (PST)
Received: from [127.0.0.1] ([64.236.142.149])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033746eec5sm33485051cf.9.2026.01.29.03.09.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 03:09:05 -0800 (PST)
Message-Id: <pull.2179.v4.git.git.1769684944593.gitgitgadget@gmail.com>
In-Reply-To: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
References: <pull.2179.v3.git.git.1769595640008.gitgitgadget@gmail.com>
From: "Chris Idema via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 29 Jan 2026 11:09:04 +0000
Subject: [PATCH v4] git-gui: shift tabstops to account for the first column of
 context diffs
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
Cc: Chris Idema <github_chris_idema@proton.me>,
    Chris Idema <github_chris_idema@proton.me>

From: Chris Idema <github_chris_idema@proton.me>

When reviewing a file before staging you want its content aligned using
gui.tabsize. The prefixing of lines with +, - or space characters should
not change this alignment. In gitk this is done correctly. In Git Gui not.

Signed-off-by: Chris Idema <github_chris_idema@proton.me>
---
    git-gui: shift tabstops to account for the first column of context diffs
    
    cc: Johannes Sixt j6t@kdbg.org

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2179%2FChrisIdema%2Ffix-gitgui-diff-tab-alignment-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2179/ChrisIdema/fix-gitgui-diff-tab-alignment-v4
Pull-Request: https://github.com/git/git/pull/2179

Range-diff vs v3:

 1:  18d25b90c4 ! 1:  1c91363568 diff.tcl: made alignment of tabs in git-gui diff consistent with gitk
     @@ Metadata
      Author: Chris Idema <github_chris_idema@proton.me>
      
       ## Commit message ##
     -    diff.tcl: made alignment of tabs in git-gui diff consistent with gitk
     +    git-gui: shift tabstops to account for the first column of context diffs
      
     -    Tab stop width was not properly rendered in TK regardless of
     -    tab width setting. The + or minus character at start of line made
     -    tabs align incorrectly.
     +    When reviewing a file before staging you want its content aligned using
     +    gui.tabsize. The prefixing of lines with +, - or space characters should
     +    not change this alignment. In gitk this is done correctly. In Git Gui not.
      
          Signed-off-by: Chris Idema <github_chris_idema@proton.me>
      
       ## git-gui/lib/diff.tcl ##
      @@ git-gui/lib/diff.tcl: proc read_diff {fd conflict_size cont_info} {
     - 			}
     + 		#
     + 		if {[string match {@@@ *} $line]} {
     + 			set is_3way_diff 1
     ++			apply_tab_size 2
     ++		} elseif {[string match {@@ *} $line]} {
     + 			apply_tab_size 1
       		}
     - 		set mark [$ui_diff index "end - 1 line linestart"]
     -+		apply_tab_size 1
     - 		$ui_diff insert end $line $tags
     - 		if {[string index $line end] eq "\r"} {
     - 			$ui_diff tag add d_cr {end - 2c}
     + 


 git-gui/lib/diff.tcl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 442737ba4f..8be1a613fb 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -385,6 +385,8 @@ proc read_diff {fd conflict_size cont_info} {
 		#
 		if {[string match {@@@ *} $line]} {
 			set is_3way_diff 1
+			apply_tab_size 2
+		} elseif {[string match {@@ *} $line]} {
 			apply_tab_size 1
 		}
 

base-commit: 1faf5b085a171f9ba9a6d7a446e0de16acccb1dc
-- 
gitgitgadget
