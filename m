Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57E1C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 02:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbiDYCER (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Apr 2022 22:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238869AbiDYCEO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Apr 2022 22:04:14 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506851CB25
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 19:01:11 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id e17so10781032qvj.11
        for <git@vger.kernel.org>; Sun, 24 Apr 2022 19:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mONhFP6vVCksMrK+HYwFUPaCuTY5M3iPGw2uO3H6FYs=;
        b=oJYac0tFhXTCtuJgbol3XtVMml2ZNkNzDhhtVCJFWrhIUS3H3hZxNT4MQXtXvp+DeL
         jX+Cyl/1GPe768wd4YylszriX8oH5n5wCYbJgECR9qt8pgW8kyENXuocv9b4z4/FIWIO
         gkgf3Pr6tAs/7490SRFok1aEvE7VNghQrL6hqTCUkcvOv1w72fatz3mcdWPiO6hbFeMw
         LLlN2Sk6zmN0rb0Otx0Co8AyqJiJ/14436ywGTnsNhilIfIV00elZ4yWq2mIgX0/sWKK
         g27U8Nt4Sr0euv8HldcAwAYALFHJ/fY8PsOeZZa3HrEu9S3gyrXR9L4+H70CZK/L+lVN
         2ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mONhFP6vVCksMrK+HYwFUPaCuTY5M3iPGw2uO3H6FYs=;
        b=FyhiH/ZSN4RWgiVrWNHsezWyqLFY08UeqGzgLY1HdjUp6s3BMN+Eu31BOiTnmHAwlB
         vtpD34Hfm9HTqHgixj16zXO3cL5Pkbe4A2aH3cPj2IzVTu2nUWXmqEJw3Is2Wf+yCgOB
         lsUgV8dcElMrF8VqWIqxQgVu1bI5EcpfvxwZ1K4dQNGnC6UVgLG/lzUeKSHSI4AwIz8F
         FpznZHyWZK2+IuAaayyIwtzfp0uEcA/To2zWd6T3THf1IXewlOef9x2dukXJVL7KRbbO
         uVjwjDwa3b/1DEckN4ffmU4kauYbtMY4rh3jtUdW0ACKpXF2B8iKZgkHiSASDRMGDbTd
         ugiA==
X-Gm-Message-State: AOAM530RLWW/PGAlkLTnpKbMssXyBtqjetLsL/rdgBd1ekhB3dXbJfm3
        PbZ7v6EKcQLt7nxIa3AjyLc=
X-Google-Smtp-Source: ABdhPJxrpY2x2cLhqrc7IWsHST7x4AFV0MaDKFOYN36zhYPCwxb2p0a8EJspfjaYRpprYIMLqRXiAw==
X-Received: by 2002:a05:6214:e4e:b0:446:5514:1697 with SMTP id o14-20020a0562140e4e00b0044655141697mr11239577qvc.2.1650852070908;
        Sun, 24 Apr 2022 19:01:10 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm1247749qkb.110.2022.04.24.19.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 19:01:10 -0700 (PDT)
Date:   Sun, 24 Apr 2022 19:01:08 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
Message-ID: <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
 <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0bf1i12.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 23, 2022 at 04:44:57PM -0700, Junio C Hamano wrote:
> 
> Actually, not quite.  when "git" runs in "sudo git", the real
> identity has long lost

Right, but in this specific case, the terminal is still a good indication
of who the user is, so the following would work.

diff --git a/git-compat-util.h b/git-compat-util.h
index 58fd813bd01..5d5d91688ee 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -442,6 +442,11 @@ static inline int is_path_owned_by_current_uid(const char *path)
 	struct stat st;
 	if (lstat(path, &st))
 		return 0;
+	if (isatty(1)) {
+		struct stat ttyst;
+		if (!stat(ttyname(1), &ttyst))
+			return st.st_uid == ttyst.st_uid;
+	}
 	return st.st_uid == geteuid();
 }
 
It obviously needs more polishing and portability work, though, and I don't
like that it makes the general case more complicated, so maybe would be better
to only do it running as root?

At that point, though you might as well excempt root from this check

Carlo
