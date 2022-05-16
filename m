Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB48C433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 19:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345294AbiEPTHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 15:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345289AbiEPTHk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 15:07:40 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694853ED1C
        for <git@vger.kernel.org>; Mon, 16 May 2022 12:07:38 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 126so13002331qkm.4
        for <git@vger.kernel.org>; Mon, 16 May 2022 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vfOAYCcty1o9Dp/b5h1NdMQZ9q0KPTdtti9vN/6P9Xc=;
        b=akS0Ey000ORkFjvh8lUK/GE+aYglnbXXtRXbXRlQPZqq1r/Qco8Z3tASZF9JOCvYpT
         /creK/jmWtOzSexVgYIjcHLtwX4RgdbQINdW0U4bwHXpkaetBIjppvn53fr7lgXngtba
         hcTxDeAr7xfjC6j7jE1RvTlwiV2Hgi2BhgmisHfs9rJ/Eu0vPY/8DVwT0+jMz1Ho99jx
         JHedUekXtU9vGKbtM+8/ouvZ2owXbvxHrmWghEES9U11ITl2ZP7BNShj3UZ/YYWE1+yD
         EOKpHk4NYiN7JAlTQifVz7c5NxIwsBBcJzQUR//cStkSV5ygKuDwMlS9nTdamxreCYEL
         PsZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vfOAYCcty1o9Dp/b5h1NdMQZ9q0KPTdtti9vN/6P9Xc=;
        b=RRyCACutSUf48SiOnh+Kiccib2IabydmtkuqKh7/bN0DHkZ8CIL4pkFq5itsjTa7VD
         5YSuMtQ18MBkwkPXGbFJtXjuBsJlK93rgJhr6G1fsmQxiH6o95rHKz/ZI91xnSXEyZTh
         gAxg0XaJXRcmcpsTY8TWicqlPelf5M4WNZOcRLS8+OwMkoBfsUQO3Y6E/recTqyJojjG
         maSJyq60vWIF4k/RyWiVTYGmKTxFurkLoV+oChVxzfjmGRybNc8cmn3psoaIuRoO/99t
         Y1NMSLB+L6cvU9Nip94sMPGKLlb3Xkt/qzgrjKxyN+iBs5IMxlsr/CTfhzDhnWSABSjF
         LnxA==
X-Gm-Message-State: AOAM530fl07hkLVLpdHwbRILBVJRU/hg2ek8X2Sh+Ipp68FqnMcPVX4y
        aDUzevDbmfBFKBu0Da7xN4oTuEvRUwfO
X-Google-Smtp-Source: ABdhPJxfkdvO3UUEiepxBwavncr9bGCHG9XH6nc5f7dLT7gcFErykasch8Qew/N7JQjUZBxeEXfOYA==
X-Received: by 2002:a05:620a:448d:b0:6a0:9838:fc16 with SMTP id x13-20020a05620a448d00b006a09838fc16mr13606689qkp.718.1652728057394;
        Mon, 16 May 2022 12:07:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a875:ee72:945f:af93? ([2600:1700:e72:80a0:a875:ee72:945f:af93])
        by smtp.gmail.com with ESMTPSA id w10-20020a37620a000000b0069fc13ce1f7sm6187878qkb.40.2022.05.16.12.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 12:07:37 -0700 (PDT)
Message-ID: <5b969c5e-e802-c447-ad25-6acc0b784582@github.com>
Date:   Mon, 16 May 2022 15:07:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 0/2] setup.c: make bare repo discovery optional
Content-Language: en-US
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>
References: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
 <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1261.v2.git.git.1652485058.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/13/2022 7:37 PM, Glen Choo via GitGitGadget wrote:
> Thanks all for the comments on v1, I've expanded this series somewhat to
> address them,...

Please include a full cover letter with each version, so reviewers
can respond to the full series goals.

Your series here intends to start protecting against malicious
embedded bare repositories by allowing users to opt-in to a more
protected state. When the 'discovery.bare' option is set, then
Git may die() on a bare repository that is discovered based on
the current working directory (these protections are ignored if
the user specifies the directory directly through --git-dir or
$GIT_DIR).

The 'discovery.bare' option has these values at the end of your
series:

* 'always' (default) allows all bare repos, matching the current
  behavior of Git.

* 'never' avoids operating in bare repositories altogether.

* 'cwd' operates in a bare repository only if the current directory
  is exactly the root of the bare repository.

It is important that we keep 'always' as the default at first,
because we do not want to introduce a breaking change without
warning (at least for an issue like this that has been around
for a long time).

The 'never' option is a good one for very security-conscious
users who really want to avoid problems. I don't anticipate that
users who know about this option and set it themselves are the
type that would fall for the social engineering required to
attack using this vector, but I can imagine an IT department
installing the value in system config across a fleet of machines.

I find the 'cwd' option to not be valuable. It unblocks most
existing users, but also almost completely removes the protection
that the option was supposed to provide.

I find neither the 'never' or 'cwd' options an acceptable choice
for a future default.

I also think that this protection is too rigid: it restricts
_all_ bare repositories, not just embedded ones. There is no check
to see if the parent directory of the bare repository is inside a
non-bare repository.

This leads to what I think would be a valuable replacement for
the 'cwd' option:

* 'no-embedded' allows non-embedded bare repositories. An
  _embedded bare repository_ is a bare repository whose parent
  directory is contained in the worktree of a non-bare Git
  repository. When in this mode, embedded bare repositories are
  not allowed unless the parent non-bare Git repository has a
  'safe.embedded' config value storing the path to the current
  embedded bare repository.

That was certainly difficult to write, but here it is as
pseudo-code to hopefully remove some doubt as to how this might
work:

  if repo is bare:
    if value == "always":
       return ALLOWED
    if value == "never":
       return FORBIDDEN;

    path = get_parent_repo()

    if !path:
       return ALLOWED
    
    if config_file_has_value("{path}/.git/config", "safe.embedded", repo):
       return ALLOWED

    return FORBIDDEN

With this kind of option, we can protect users from these
social engineering attacks while providing an opt-in protection
for scenarios where embedded bare repos are currently being used
(while also not breaking anyone using non-embedded bare repos).

I think Taylor was mentioning something like this in his previous
replies, perhaps even to the previous thread on this topic.

This 'no-embedded' option is something that I could see as a
potential new default, after it has proven itself in a released
version of Git.

There are performance drawbacks to checking the parent path for
a Git repo, which is why it is only done when in "no-embedded"
mode.

I mentioned some other concerns in your PATCH 1 about how we
are now adding the third use of read_very_early_config() and that
we should probably refactor that before adding the third option,
in order to avoid additional performance costs as well as it
being difficult to audit which config options are only checked
from these "protected" config files.

Thanks,
-Stolee
