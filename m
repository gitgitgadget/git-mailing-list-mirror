Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F100EB64DD
	for <git@archiver.kernel.org>; Thu,  6 Jul 2023 18:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjGFSY4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jul 2023 14:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFSYz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2023 14:24:55 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813E71BC3
        for <git@vger.kernel.org>; Thu,  6 Jul 2023 11:24:54 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53450fa3a18so1482052a12.0
        for <git@vger.kernel.org>; Thu, 06 Jul 2023 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688667894; x=1691259894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLMiCmkd7EDOiVk9Dnc/2cyZWoFySRNRaPVmbKpFbXc=;
        b=fZjcoE7pp4PXoohpkom9U43lMxd+zPAAjeDe6hvcOKn+7qxO+q6EqK8Ja2VDIgSiBO
         D4VGBQkn1xkUWZeZI2SPwcyrjJByLJjJM4FFgNEGyTqq+BePPemiWhGpCXqYA2pbGSU8
         oEc7nvs97m1g4nAhBMeJfKS//MovIYQ0JIps859PxeyYKWTApcn6FEmsXTF0LgdJmeD+
         9c8j9L+Wn82cTB+x5ITF/eMxxTA4tc1WoiI6zvfiVLTmtN+BFxFhyOZ8KGwS94wi+VVo
         mxGicYj4OAZa5Yak8T/LbAd1rSe6SnYTirc08JdzyUjw1Xx1M9LXOBx5N7QxneQ/opiq
         FFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688667894; x=1691259894;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLMiCmkd7EDOiVk9Dnc/2cyZWoFySRNRaPVmbKpFbXc=;
        b=UF40lug0wdjMzQcHyNzfSO/WdftynlEDu0nfE0fbu13opuAiYSpQzj3Yi3rd0lA99m
         z6NO+XIMq4fqSnVq1AkUK89AAsaDTabDPhVfrk6DGjfHHyTSGHlljxpOLmrtcWTMsvcQ
         YPEAxEYSrjRAqmxxdF5AZ+j3QtV86jbBpXFZMifzQg1AxqSkSj5lvNzZtYRawkXtYis/
         AaOe54QevDi0rMEkAp6rpAUcfYXSPxTRVzYDHl16XxHudrVczlv/Z2tFT3+6N5kThKr3
         AIKpiremSbZeX0bzaa6LgwAwE4tpAvQB0pQl3Bq7SfEMnjjjcgvqguZ5/VFS7KluBp9K
         cbyQ==
X-Gm-Message-State: ABy/qLbCTK7U2d3sdMuYmbq5qcdsj0WcjXm+t04kEeVgZoor0r3asSw+
        6nGDcjqiQJiDX0QVihInQktyNFhwYniWqQ==
X-Google-Smtp-Source: APBJJlHKu6QRNyvdCdKhO7ukAw0WNPgtVQOMw+Ll5o0sFwosU+zLpx+Z840K0ewOiW++lHv6V6BGJqJ05aVNZQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2d06:b0:668:95c1:b507 with SMTP
 id fa6-20020a056a002d0600b0066895c1b507mr3283589pfb.6.1688667894003; Thu, 06
 Jul 2023 11:24:54 -0700 (PDT)
Date:   Thu, 06 Jul 2023 11:24:44 -0700
In-Reply-To: <owlywmzk7nnb.fsf@fine.c.googlers.com>
Mime-Version: 1.0
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <owlybkgy837j.fsf@fine.c.googlers.com> <ZJ3uGBEEvYmbPnoQ@google.com> <owlywmzk7nnb.fsf@fine.c.googlers.com>
Message-ID: <kl6l1qhkrj83.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver <linusa@google.com>,
        Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Arver <linusa@google.com> writes:

> Josh Steadmon <steadmon@google.com> writes:
>
> Sorry, one more thing worth considering is the ability to add tests
> inline with production code (where the test code can be removed in
> production builds). There are a number of benefits to this and, I think
> it is a useful feature to have. I saw this feature being advertised for
> a C++ testing framework called doctest [1], but I assume it is also
> possible in C. Could you include it as another (nice to have?) feature
> under the "Developer experience" category? (Or, reject it if this
> "inlined tests" style is not possible in C?)
>
> [1] https://github.com/doctest/doctest

I suspect it's possible in C, but it's not that desirable for Git.

- Inline tests are, by nature, non-production 'noise' in the source
  file, and can hamper readability of the file. This will probably be
  exaggerated in Git because our interfaces weren't designed with unit
  tests in mind, so tests may be extremley noisy to set up.

- The described inline approach seems to be to build the same executable
  but with different flags. But for libification, we'd want to verify
  that we can build a separate executable with only a subset of files. A
  natural way to do that is to have unit tests in a separate file and
  for that to depend on only the subset we want.
