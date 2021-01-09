Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C7C433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 14:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9528223A1C
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 14:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbhAIOIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Jan 2021 09:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbhAIOIr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jan 2021 09:08:47 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB012C061786
        for <git@vger.kernel.org>; Sat,  9 Jan 2021 06:08:06 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id b26so29923843lff.9
        for <git@vger.kernel.org>; Sat, 09 Jan 2021 06:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6/QdJYCwWKwWHc9pT46zWx5ex9HfVuy57EcMGwRGrY=;
        b=hsq8lBBtBRI6JxDw9TkBQhYGcbnOdT9oqoK1ebxDMo7MkxLO/IXAlONs0qVlpSeVtg
         dYTNyF8bBu1IYhND9JegKXqWK0ED5vtz6lsty3j37R1JF621DTmcNgKfLtU+cRWyUuFI
         SsxNf+MxcY7QVVzH303s7h6hy2m0vbxf2cnB68l4IbnNpGjvGiYw1+QA5rvaY4ZyMB+T
         K6EjqLbprmUFGubgmZjmZSNRRTjhtVTyNQqU4MryJJnBjmzXD4tKf/I/0N7blxfpgbPY
         BVVqcuqOQRf1Vkx68upC7dOSpb5/I9mq/3e5ieGe95EG9KgtyYfjcxR3u7e1zScq5ek+
         gpqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6/QdJYCwWKwWHc9pT46zWx5ex9HfVuy57EcMGwRGrY=;
        b=jj5HxiQTxI3kGsWyqT3rXwb5qTDmdiaUa8ImG8bevRsTfUbN+W0rsIshs92IEbvmkm
         E0yKMEcIeznhDo/hkac2qZHJNJfmRXYHJsDfxNbvioVWnhuEWVsx54b9NOEGDEkp10Aq
         5Je+zs6XShUZiHE0dazuOiC4mvqsfNGJyvvafSAO4ze20LBpdcKsL+WAu+fgzvh1eHh1
         Q5HXDBJnDtv+aFZar0UzP4j8sSgQU/49lP/2upsMJpmEKrm203WxZpHdvJWJCnZJVmvi
         dwAMStdO1WHs8q+QrR0kT9BQz3UQAFqhXiLn1+lrNmf6EwpMOEC20uX7mKvJLrGVZGqU
         Jflw==
X-Gm-Message-State: AOAM530v1v2NvfCpoHfSs06b1KhxO12LzuURKu2iCzfTzFa/WGYSEn2Q
        Ah6uq9Ug5jCSWai6wpiTXiAxQN7it7Q1+BXX5CKniH8SNF89Pw==
X-Google-Smtp-Source: ABdhPJwmp2wrlpWHPz+naalPXkI0UG3up7kIE73OCS/E6DWom+7a0n2HmXa+rL+ByCUmbQy99uIKqEi8U149BgIBpTo=
X-Received: by 2002:a19:7e89:: with SMTP id z131mr3531293lfc.2.1610201283715;
 Sat, 09 Jan 2021 06:08:03 -0800 (PST)
MIME-Version: 1.0
References: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
In-Reply-To: <CAH8yC8mmox3fZTRO7W44whHhT0aPcNUXxrBVg1R7ttwUfVgy1A@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Sat, 9 Jan 2021 11:07:52 -0300
Message-ID: <CAHd-oW63pduiFr1pXhNZnHnnovhSGh5K=z0AQ1RAwGvbObsL4Q@mail.gmail.com>
Subject: Re: Git 2.30.0 and failed self tests
To:     noloader@gmail.com
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Jeff

On Sat, Jan 9, 2021 at 8:32 AM Jeffrey Walton <noloader@gmail.com> wrote:
>
> Hi Everyone,
>
> I'm seeing a failed self test with 2.30.0 on Alpine Linux 3.10,
> x86_64. Alpine Linux uses Musl and BusyBox, so things may be a bit
> sideways because of them.
>
> *** t4129-apply-samemode.sh ***
> ok 1 - setup
> ok 2 - same mode (no index)
> ok 3 - same mode (with index)
> ok 4 - same mode (index only)
> ok 5 - mode update (no index)
> ok 6 - mode update (with index)
> ok 7 - mode update (index only)
> ok 8 - empty mode is rejected
> ok 9 - bogus mode is rejected
> not ok 10 - do not use core.sharedRepository for working tree files
> #
> #        git reset --hard &&
> #        test_config core.sharedRepository 0666 &&
> #        (
> #            # Remove a default ACL if possible.
> #            (setfacl -k newdir 2>/dev/null || true) &&
> #            umask 0077 &&
> #
> #            # Test both files (f1) and leading dirs (d)
> #            mkdir d &&
> #            touch f1 d/f2 &&
> #            git add f1 d/f2 &&
> #            git diff --staged >patch-f1-and-f2.txt &&
> #
> #            rm -rf d f1 &&
> #            git apply patch-f1-and-f2.txt &&
> #
> #            echo "-rw-------" >f1_mode.expected &&
> #            echo "drwx------" >d_mode.expected &&
> #            test_modebits f1 >f1_mode.actual &&
> #            test_modebits d >d_mode.actual &&
> #            test_cmp f1_mode.expected f1_mode.actual &&
> #            test_cmp d_mode.expected d_mode.actual
> #        )
> #
> # failed 1 among 10 test(s)

Do you happen to have a default ACL rule or the setgid bit set on the
test directory (or a parent directory)? This test is currently failing
under these circumstances, but there are already two patches that fix
these issues:

https://lore.kernel.org/git/b734425e3235651e738e6eac47eae0db7db92e7e.1609861567.git.matheus.bernardino@usp.br/
https://lore.kernel.org/git/20201223114431.4595-1-adam@dinwoodie.org/

Thanks,
Matheus
