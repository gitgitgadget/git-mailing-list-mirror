Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D444C54EBC
	for <git@archiver.kernel.org>; Sat,  7 Jan 2023 17:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjAGRe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Jan 2023 12:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjAGReZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Jan 2023 12:34:25 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8124EC95
        for <git@vger.kernel.org>; Sat,  7 Jan 2023 09:34:23 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id qk9so10296744ejc.3
        for <git@vger.kernel.org>; Sat, 07 Jan 2023 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L8+d6RPPqF+wHNFWo+eGjh2iENhwevxQHjLiPRfE9IY=;
        b=KoaefYygfZSCYJSEiaqP9LoVOlPMBYZRS4OW1M3vuUnKlECA0tCNpQ1+WvqX7IwLHR
         E+BmXYSWYBDIhBthp3JEMP+pc2L9xxE9iEG7xdD7DzJnuak8Ww8NLZRaF94fEyfpZsDb
         CeHphwZwKazNccJdZO4Ihcopn/jkryYcQS4EsiNA4OZGzjqo53IGDdV8zW4vIshYJC6I
         SfJsj2uquxZGtFaQMVo3z9z0chCNrzndA0bNDQd4IagQ1HEFM0kUQSoqfB1mhcD/XXtz
         Taz1Uu0y6Z5ebrTLPOIqxkGECnWXS1hFTAFlj7m3Ng5Ma80oX+PMpASBT+wCn2TtqC4s
         AFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L8+d6RPPqF+wHNFWo+eGjh2iENhwevxQHjLiPRfE9IY=;
        b=e2/DV2Kcl3PXuAW5XOgFh4bwRLkTzxP/R0yR2hbAW8Ha5nfsjZIj+XogO06F86Ocfj
         x11UR8DfDW9GjDxJezeHO1beAvoUbu9a0TfQGV4k/VQlmZ120VasoPUxrJ6szrunWnER
         NL/HL+o9IzXoFGHlcIL+Bc2npYDFB805AhH7ubsp5OIHLAN3XlFdLgjjlJUpzce1VcDp
         O9IYiSzcD/RlLNDLQ2yPW+OvpOlnh+uCG0VzLEL3iDf1jX4HdhHDN1u382+i5ntDl2bD
         kgrSzSuyIV1O/4VVishcpcUcxegX/fw3PdN35ego9Ht2HzoCWp8JZf1kVjXanUG/UXYM
         91zA==
X-Gm-Message-State: AFqh2kq2KT5iRpR4BY2RpUc5SgcpZtrAgv8fUIJSpzoSQST8hYrsdxdR
        o0wQCz9whdfVsj+hc6csgddBAIiyKPd/stDudZnuEWWlAzs=
X-Google-Smtp-Source: AMrXdXv55mpjP5QQBtey3jZXUw1YS5LPHG8wdZAZnlAw/D2fdIJVKD8CNZ5WC9YQ3SDAT5346pAR4vVg078/1P/blEM=
X-Received: by 2002:a17:907:c00d:b0:7ae:ef99:6fb2 with SMTP id
 ss13-20020a170907c00d00b007aeef996fb2mr5664288ejc.761.1673112862194; Sat, 07
 Jan 2023 09:34:22 -0800 (PST)
MIME-Version: 1.0
From:   muzimuzhi Z <muzimuzhi@gmail.com>
Date:   Sun, 8 Jan 2023 01:34:09 +0800
Message-ID: <CAEg0tHSLyaewkgGs0dEXfwQhKmbiO65bXZVU8t7Kn4WwJ1p0Fw@mail.gmail.com>
Subject: Did config `branch.<name>.fetch` ever exist?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

(originally posted on stackoverflow: https://stackoverflow.com/q/75040372)

Git configuration `branch.<name>.fetch` is mentioned in the first
`git-fetch` example [1]:

> - Update the remote-tracking branches:
>       $ git fetch origin
>   The above command copies all branches from the remote refs/heads/ namespace and stores them to the local refs/remotes/origin/ namespace, unless the branch..fetch option is used to specify a non-default refspec.

But I can't find its doc in `git-config`'s doc. Did
`branch.<name>.fetch` ever exist?

Searching in `git-config`'s doc for configs starting with `branch.` or
ending with `.fetch`, it seems `branch.<name>.fetch` is a typo of
`remote.<name>.fetch`.

PS: That `git-fetch` example was added in commit d504f69 in 2009. [3]

[1] https://git-scm.com/docs/git-fetch#_examples
[2] https://git-scm.com/docs/git-config
[3] https://github.com/git/git/commit/d504f6975d34025ed3b5478b657789410b52cdb1

best regards,
Yukai Chou
