Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF972C54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6F72075A
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpLsu3eG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbgDXRei (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726813AbgDXReh (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 24 Apr 2020 13:34:37 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FECC09B047
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:34:37 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g2so3987397plo.3
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ytfsKlL0AnPXHlT/rg+ok3lXNCHmWNi7hLnuf1OTu8Y=;
        b=NpLsu3eGiNof65uxRZDNmsOXpt/C4TQ3+NVs+viC0Zg+8ZQGp4oTpBk6iI31EEA6vn
         2eRwZVeL2sb5kleDu3e2pBjQoLl9i5y1HfBW0IFvQjOwZjezxBiwbGC9+KLumSa2m7xR
         H9kzwoxsJths5gOGFiv8LD5AQhZwzb+H6aNKCBWIPm24QvtQpQqjZVKnF8nPYmtEsGbO
         KIaOtBrI42GHcscX4rrDf+7zj+D+0b4ouSnblO2MnGkDIS/WU7Skt3Zk8IXf+1zULzVM
         VTe9EEMGuwIK/p0jS/hZOntAj+FYsUOQVthuVODgwvrPdPIoirHqiKoRsGOs+9Luskmt
         j45A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ytfsKlL0AnPXHlT/rg+ok3lXNCHmWNi7hLnuf1OTu8Y=;
        b=rYTVqj1q+a9ANAEySUYZJ56WB3CtiwWAJorfAx8T/sNUsH9n0/T3sVmO2StM22Ga3N
         6RmXxuvU4VdyRpgc5uASVMN2qo47MPsmZLJFPsiM6i3Vo8oFc6juIrXOPKOj2ZmFMxQV
         sVsw9qisNH5Ybf3Yzz029t7ps+NByhaIBhWXdSv7WSZB0FlJyMWAGdkikWso+kzvRP10
         kXCvBsI7G0gijNYAjpsuV52e8g7XXRgYRJtDqH/TIkf5sDbNX4VBFN+K4Fp9J2xzZGax
         k8S6VzjTHkSDyHqAmkKgzVKaijhk1bBO9wLIngXVQWlveDHAXNFHfL/hhY2zXBNt6EZB
         jLbw==
X-Gm-Message-State: AGi0PuakBnuwXltv+PEeqLB0xIhSAeAbjge+UB8Bn6CUaUV+Ph9l+XW8
        XAKwr+ow25kBG8Pyrz3fqng=
X-Google-Smtp-Source: APiQypIijGF4j4ZZHwMDQrfZSx17Ca4mPDuWFP/dSMdmrD+Cyln28oIDevJDsD24VFdLwY4nrUhwvQ==
X-Received: by 2002:a17:90a:fd89:: with SMTP id cx9mr7210881pjb.64.1587749676027;
        Fri, 24 Apr 2020 10:34:36 -0700 (PDT)
Received: from localhost ([2402:800:6374:f359:1ce8:a621:5f80:1116])
        by smtp.gmail.com with ESMTPSA id x63sm6447907pfc.56.2020.04.24.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:34:35 -0700 (PDT)
Date:   Sat, 25 Apr 2020 00:34:33 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Subject: Re: [PATCH 5/8] cmake: support for testing git when building out of
 the source tree
Message-ID: <20200424173433.GL1949@danh.dev>
References: <pull.614.git.1587700897.gitgitgadget@gmail.com>
 <166b78f71755bb3f9967b32bfe282210c2bb240d.1587700897.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166b78f71755bb3f9967b32bfe282210c2bb240d.1587700897.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-24 04:01:34+0000, Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> 
> This patch allows git to be tested when performin out of source builds.
> 
> This involves changing GIT_BUILD_DIR in t/test-lib.sh to point to the
> build directory. Also some miscellaneous copies from the source directory
> to the build directory.
> The copies are:
> t/chainlint.sed needed by a bunch of test scripts
> po/is.po needed by t0204-gettext-rencode-sanity
> mergetools/tkdiff needed by t7800-difftool
> contrib/completion/git-prompt.sh needed by t9903-bash-prompt
> contrib/completion/git-completion.bash needed by t9902-completion
> contrib/svn-fe/svnrdump_sim.py needed by t9020-remote-svn
> 
> NOTE: t/test-lib.sh is only modified when tests are run not during
> the build or configure.
> The trash directory is still srcdir/t
> 
> Signed-off-by: Sibi Siddharthan <sibisiddharthan.github@gmail.com>
> ---
>  CMakeLists.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index 141ccefa559..29a23eb11f7 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -812,6 +812,25 @@ file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_GETTEXT='${NO_GETTEXT}'\n"
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "RUNTIME_PREFIX='${RUNTIME_PREFIX}'\n")
>  file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
>  
> +#Make the tests work when building out of the source tree
> +if(NOT ${CMAKE_BINARY_DIR} STREQUAL ${CMAKE_SOURCE_DIR})

IIRC, CMake recommends _NOT_ expand variable inside if()
This very inconsistent recommendation of CMake (when should I use
${var} and when should I use var?) is one of reason I hate CMake

> +	file(RELATIVE_PATH BUILD_DIR_RELATIVE ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/CMakeCache.txt)
> +	string(REPLACE "/CMakeCache.txt" "" BUILD_DIR_RELATIVE ${BUILD_DIR_RELATIVE})

I don't know what is going on here!

> +	#Setting the build directory in test-lib.sh before running tests
> +	file(WRITE ${CMAKE_BINARY_DIR}/CTestCustom.cmake
> +		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh GIT_BUILD_DIR_REPL REGEX \"GIT_BUILD_DIR=(.*)\")\n"
> +		"file(STRINGS ${CMAKE_SOURCE_DIR}/t/test-lib.sh content NEWLINE_CONSUME)\n"
> +		"string(REPLACE \"\${GIT_BUILD_DIR_REPL}\" \"GIT_BUILD_DIR=\\\"$TEST_DIRECTORY\\\"/../${BUILD_DIR_RELATIVE}\" content \"\${content}\")\n"
> +		"file(WRITE ${CMAKE_SOURCE_DIR}/t/test-lib.sh \${content})")
> +	#misc copies
> +	file(COPY ${CMAKE_SOURCE_DIR}/t/chainlint.sed DESTINATION ${CMAKE_BINARY_DIR}/t/)

So, some sed will be used in Windows without POSIX-like system,
interesting!

> +	file(COPY ${CMAKE_SOURCE_DIR}/po/is.po DESTINATION ${CMAKE_BINARY_DIR}/po/)
> +	file(COPY ${CMAKE_SOURCE_DIR}/mergetools/tkdiff DESTINATION ${CMAKE_BINARY_DIR}/mergetools/)
> +	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-prompt.sh DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
> +	file(COPY ${CMAKE_SOURCE_DIR}/contrib/completion/git-completion.bash DESTINATION ${CMAKE_BINARY_DIR}/contrib/completion/)
> +	file(COPY ${CMAKE_SOURCE_DIR}/contrib/svn-fe/svnrdump_sim.py DESTINATION ${CMAKE_BINARY_DIR}/contrib/svn-fe/)
> +endif()
> +
>  file(GLOB test_scipts "${CMAKE_SOURCE_DIR}/t/t[0-9]*.sh")

Remember cmake won't be re-run if nothing was changed in CMakeList.txt
If I only change some code, and I decided the change I make should be
tested by a-new-and-independent-test-script.
I need to re-run cmake manually! I don't like it, at all.


-- 
Danh
