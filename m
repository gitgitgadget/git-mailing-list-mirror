Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572BDC433EF
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3354F61B64
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 01:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242197AbhKRBWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 20:22:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242174AbhKRBWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 20:22:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71FAC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:19:42 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id x7so3822653pjn.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 17:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6i9UlDU8279k4UrCMnsnb/hmYAwU8WdlzuvMkm3AocE=;
        b=MjX/YJCtgzkplukX7lSpsbgd05Dkc050eNogLqrrRFNy7yfOjXLInKvjbvJurXjI2Q
         IWHANKJuA+yVaWe58g0oAT9ILDciAo5WgH6RonFTHgS6kH8MH9MMjhpwY8HeUMCEJ1c0
         2R18fmD7ZEPzmtnDM8K/mDpLHR65RERtWD6vfWvlZ7fqwNhDc/guSkLh04md3LOOwTr/
         hoUJAS4UfGTfnmg/gvj1X1VumYvoGe11Bet8VNg87hNhwB+o+D2cVz0f/6mcdvKLDSLn
         /ufDAiryCZXmRAxtaF+CXQAxoEST2zDDkMdibNU9UE8f1EwOh/gIJ/4MnLlPRdpT0W+2
         Wwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6i9UlDU8279k4UrCMnsnb/hmYAwU8WdlzuvMkm3AocE=;
        b=C86bQO4UO3O+LNCMcOrZUXnvYTNPFVTFuzlSX1Z+NNDdUS9Mnucx8o36W/94/sV9ZB
         dcnWjITNP1OZMaB7ZAOeQ57NiMnxKtfuksr0k4w7glodhEvQXJVjQg6xo2HV3NQ7B+y9
         AC0lp0pV/X+0HUzrzbf7f4pFTQqFsoSMwo3CuIItAbjT8I5hJLEk6i9qXSnN6vrhYdy1
         +vJW8K7hGIhQnladR4dCJh+jH5jnGNvnOIs3GugdstdXArDfDRGhigbmdXO7Q+h13n89
         mxLW2DpcdZdHvOPRv0uYbuDXMM7dGm+coc8kMN9QqYJb82r0ceGJ23qtTJhbaKRSZoFG
         aioA==
X-Gm-Message-State: AOAM53305BYvFtKdCfLvHKaQJb7S5+Mua5PopPEiodoh7eRCpc5ldb++
        D5gBDwJGJkferUwLJrhGu3s=
X-Google-Smtp-Source: ABdhPJz1Wir4OmhcmoaIgKONjjxM2wdwpHlflzRmvbjStmMXexmxjuS1oejkDUxwoHZ261GA29QioA==
X-Received: by 2002:a17:90b:3b8c:: with SMTP id pc12mr5432657pjb.9.1637198382372;
        Wed, 17 Nov 2021 17:19:42 -0800 (PST)
Received: from localhost ([2402:800:63b8:c954:57f3:fdbb:8ade:b454])
        by smtp.gmail.com with ESMTPSA id j6sm685418pgf.60.2021.11.17.17.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 17:19:42 -0800 (PST)
Date:   Thu, 18 Nov 2021 08:19:39 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH] Makefile: fix parallel build race
Message-ID: <YZWqK38NRjD7aPOG@danh.dev>
References: <7d82342089a80b19e54ac8997d5765a33951499f.1637112066.git.congdanhqx@gmail.com>
 <YZR0djZbRUicXcQm@coredump.intra.peff.net>
 <nycvar.QRO.7.76.6.2111180012470.21127@tvgsbejvaqbjf.bet>
 <211118.86tuga5o68.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211118.86tuga5o68.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-11-18 00:56:35+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> On Thu, Nov 18 2021, Johannes Schindelin wrote:
> 
> > On Tue, 16 Nov 2021, Jeff King wrote:
> >
> >> I wondered if contrib/buildsystems/CMakeLists would need a similar
> >> fixup, but it doesn't have any generated header dependencies at all (not
> >> for hook-list.h, but not for the existing command-list.h). So I'll
> >> assume it's fine (as did cfe853e66b).
> >
> > The strategy we take in our CMake-based configuration is for files like
> > hook-list.h to be generated at _configure_ time, i.e. before the build
> > definition file is written, i.e. well before the build. That's why there
> > is no explicit dependency, it's not necessary.
> 
> It is necessary, otherwise how will it know to re-generate the
> hook-list.h if its source of truth changes? I.e. if we add a new
> hook. Ditto for a new built-in, config variable etc.
> 
> I understand that the answer is that cmake (or at least our use of it)
> doesn't even try to solve the same problem as the Makefile does, i.e. to
> declare dependencies and to be capable of incremental builds.

If used correctly, with correct dependencies link, cmake is fully
capable to regenerate hook-list.h upon its source mtime changed.

> It's more of a one-shot command where you'll need to run its equivalent
> of "make clean" before you recompile.

However, the current CMakeLists.txt has a bigger problem: it won't
re-run itself when a source file has been added or removed.
It couldn't be configured on Linux system, except with this diff
applied (because CMake documentation mandated <docstring> in
(set CACHE FORCE) [1]):

----- 8< ----
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 6d7bc16d05..a612217dd9 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -52,9 +52,10 @@ cmake_minimum_required(VERSION 3.14)
 #set the source directory to root of git
 set(CMAKE_SOURCE_DIR ${CMAKE_CURRENT_LIST_DIR}/../..)
 
+if(WIN32)
 option(USE_VCPKG "Whether or not to use vcpkg for obtaining dependencies.  Only applicable to Windows platforms" ON)
-if(NOT WIN32)
-	set(USE_VCPKG OFF CACHE BOOL FORCE)
+else()
+	set(USE_VCPKG OFF)
 endif()
 
 if(NOT DEFINED CMAKE_EXPORT_COMPILE_COMMANDS)
----- >8 ----

Even after it's applied, the linking step is failing.
(seems to not link with compat/linux/procinfo.o, I didn't dig further)

The traditional method to list source files in CMake (and meson)
is listing them all in the CMakeLists.txt (or meson.build).
With manual listing like that, we can avoid the current complicated
logic to parse Makefile. The bigger benefit from listing manually is:
CMake will generate an implicit dependency to CMakeLists.txt,
hence, whenever a source/header files was added/removed,
cmake will told to re-run configuring steps.

If you're interested on moving on that direction, I can provide
some patches to make the cmake buildsystem a bit less messy,
I'm not a fan of CMake, don't count too much on me, though.

[1]: https://cmake.org/cmake/help/v3.16/command/set.html#set-cache-entry

-- 
Danh
