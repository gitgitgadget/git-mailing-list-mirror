Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D8DF1F97E
	for <e@80x24.org>; Sun,  7 Oct 2018 01:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbeJGInE (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 04:43:04 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:37164 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJGInE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 04:43:04 -0400
Received: by mail-wm1-f54.google.com with SMTP id 185-v6so5089325wmt.2
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 18:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=B2gXarTe8yhE4re1YQMkHoh3iMtzlujT1SOjrRLvekY=;
        b=SS0Q/vcHkBOeAWA6LDV+YGZRSJMR14qLuoUolilSR4fS1OoOf5Sc75u+HZBjH4cWtF
         9os15CqMltn7bRA6DUvh7DBPYqxodtSqkxtMtCmwfA5otwxgAlxeYL0drz/hy1v+fkWK
         MyZmqpemADo+n5Zdj0Z9ns3mLN4CTd9UgqjfJpemT9qy9qo91QnIpQcQyqIdSridy77Z
         lehj4zk/c8v5rSGlvrRlWxiEbXjGPYviFfXNW77dYfd7oX/RZulDBLJisah/UhhjSPw1
         pv0dLlwYtJdoTK8inTrgrI0CQMkTmgC6xAEvaC53o6YWk6IHphYrczVu7dTRAcbD7MHA
         V2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=B2gXarTe8yhE4re1YQMkHoh3iMtzlujT1SOjrRLvekY=;
        b=Ubj2guFYj3YtJeoHsCDqyww85IeldrRpCNUoby9Q5x5JC4HqkWfzvRKNehZ/t4CSSX
         i7n66b/estf8K7En/dTEuZnsVIkv/yTheQhGr66CMvG23Ax+LaAYRy8G/LdeTzZZbes6
         iJqQ4JdhYoc/fqPdDamWGUIas/2kDVkS5+eM49h+SEkeWUseTR0HwONi5IwWeByudi5/
         0i5d+Fg7Mp8wbfGFTgiHWHrtBl0+KRGohaSf2yMc5+rTR6InP/0C/9MDjaRz2NFl3bAq
         dQ1aVMtZbYRxe6rJjFl1gUvmWozz5D8E8EKrFxSB42Gs6Bty9IWx2leA+tA8gHyRCPZD
         lGSQ==
X-Gm-Message-State: ABuFfojYX0l+ebXsvm9GUmzHag+mz5BWu2kBXo8ShiD0XC/ucigrnWIX
        if2EvirTljJRDBi2ue0NZuc=
X-Google-Smtp-Source: ACcGV613WNAl+WWH3mcMCe2KmOnD/KKRQFczMeELNxNpayMrl0PI7dVTyOpnB62q2VydUcoY+r/5DA==
X-Received: by 2002:a1c:cfcb:: with SMTP id f194-v6mr10856259wmg.98.1538876255092;
        Sat, 06 Oct 2018 18:37:35 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i7-v6sm3529563wmd.41.2018.10.06.18.37.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 18:37:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, peff@peff.net,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 3/8] refs: new ref types to make per-worktree refs visible to all worktrees
References: <20180922180500.4689-1-pclouds@gmail.com>
        <20180929191029.13994-1-pclouds@gmail.com>
        <20180929191029.13994-4-pclouds@gmail.com>
Date:   Sun, 07 Oct 2018 10:37:32 +0900
In-Reply-To: <20180929191029.13994-4-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 29 Sep 2018 21:10:24 +0200")
Message-ID: <xmqqva6etu3n.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 2dd77f9485..9ca2a3706c 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> ...
>  	case REF_TYPE_PSEUDOREF:
>  		strbuf_addf(sb, "%s/logs/%s", refs->gitdir, refname);
>  		break;
> +	case REF_TYPE_OTHER_PSEUDOREF:
> +		return files_reflog_path_other_worktrees(refs, sb, refname);
> +	case REF_TYPE_MAIN_PSEUDOREF:
> +		if (!skip_prefix(refname, "main-worktree/", &refname))
> +			BUG("ref %s is not a main pseudoref", refname);
> +		/* passthru */

Correct spelling of the colloquial phrase is fallthru, but see
1cf01a34 ("consistently use "fallthrough" comments in switches",
2017-09-21) that encourages use of "fallthrough" fully spelled out.

Otherwise you'd see something like this.

    CC refs/files-backend.o
refs/files-backend.c: In function 'files_ref_path':
refs/files-backend.c:203:6: error: this statement may fall through [-Werror=implicit-fallthrough=]
   if (!skip_prefix(refname, "main-worktree/", &refname))
      ^
refs/files-backend.c:206:2: note: here
  case REF_TYPE_OTHER_PSEUDOREF:
  ^~~~
refs/files-backend.c: In function 'files_reflog_path':
refs/files-backend.c:181:6: error: this statement may fall through [-Werror=implicit-fallthrough=]
   if (!skip_prefix(refname, "main-worktree/", &refname))
      ^
refs/files-backend.c:184:2: note: here
  case REF_TYPE_NORMAL:
  ^~~~
cc1: all warnings being treated as errors
Makefile:2289: recipe for target 'refs/files-backend.o' failed
make: *** [refs/files-backend.o] Error 1
