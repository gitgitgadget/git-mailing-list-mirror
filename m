Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1019C433F5
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238889AbiDFRVS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238830AbiDFRUo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:20:44 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2B515DABA
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:19:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m30so3775639wrb.1
        for <git@vger.kernel.org>; Wed, 06 Apr 2022 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xoG+9tWozCj6jB4z2R5PZff56P8usV0Y6HIlaKqs9QY=;
        b=jywjQgMhOktaRrSIrB7rE80Eq3Yc8dClveChe6enf0SnYZmA4/ZmUrs0oePaQt0tJo
         1YQDb5mfWWyH+85p1fi6hTTjsPtiRDcl7BCt79jBvlcVW9GstL3K76gZWcrDVMfWO0UE
         DUKYtccdF6MqJZhWcnt7lCdlTe22CsO5Fv3o3hZt5fiIurThl5DSnnLkP4CvBG2qRnlb
         4m2ZoadOjgL1qiG2l6nPoJYh6yxVlVZryJ5hxBYCIFD1QSRqtjTMC60nNnYlSIZ2sT6S
         gWn8GDf/Qpclpku7n03KPoLFpK8lgQQsjnk9aDOcfAVGoX0W9FolmifcXhXlEIQjYZUZ
         Thyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xoG+9tWozCj6jB4z2R5PZff56P8usV0Y6HIlaKqs9QY=;
        b=mylnQBmD5Iz+EwtL3yRVnfbDl9RP+F/1BH3TLecKVcTQXTDx5RRfwDynmasuvA1wU2
         UbXrPkdIXExgpMJ/6ig8zf3EmjQ7AndC1i7HoSmeOqtYs/mWmlMI0Ez5XSlnNvn7DxO0
         DFXfEfyMQs75VG6oNOHb1/rR/zKh09oNEgI2FyFGr9IFVzdNKQpRW0k/rVyNPcphYfA6
         DU7V8qhTIV0yz6AFLQVLUN2PlHYjXbEGH/gSKwBoYJM0jEsZdmu+SnVb+MsaujgCgGVB
         B20Xo5BeoD8c40uBtH+jLJ4278fU+eYy7Z8i84nTCyuE8UEgD7CTCIRSEIGmNO6/wyMS
         sL5Q==
X-Gm-Message-State: AOAM530eLMmoqgEVzYicV2oKBP7VVLmUgPlMQeDW+t+98dNGCzmgthWH
        EeXn6D56gMMqTsqu3PkVzzOyCs03pXNUGj2F
X-Google-Smtp-Source: ABdhPJyu3U4rjaWXXQWSBfJLWZ09Wyvf8mVw8AJfQVXVuPQuy+kWfGbb6gS4P4IPPx0OeK8G2sYUqA==
X-Received: by 2002:a5d:6543:0:b0:204:1475:d49a with SMTP id z3-20020a5d6543000000b002041475d49amr6834775wrv.387.1649258351331;
        Wed, 06 Apr 2022 08:19:11 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id d14-20020a056000186e00b0020405198faasm17086490wri.52.2022.04.06.08.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:19:10 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     avarab@gmail.com
Cc:     Matthieu.Moy@univ-lyon1.fr, cogoni.guillaume@gmail.com,
        derrickstolee@github.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org
Subject: [PATCH v2 0/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Wed,  6 Apr 2022 17:18:57 +0200
Message-Id: <20220406151858.5047-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <84f77a5b-5721-3583-8ed8-9d360928cf35@matthieu-moy.fr>
References: <84f77a5b-5721-3583-8ed8-9d360928cf35@matthieu-moy.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> On 6/5/22 10:54 AM, Matthieu Moy wrote:

> but I think if we (as a free software project) are
> recommending proprietary software we should put that in some context
> where we explain if/why it's needed, and if free alternatives are also
> suitable.

> If that's the case wouldn't it suffice to link to some generic getting
> started guide for debuggers? 

You got a point, it's a bit paradoxical, but I don't know any good alternatives
and I don't want to advise someone with something that I don't be familiar with.
But, in the future, if someone wants to add alternatives it will be good.

> I haven't used the VSCode integration you're documenting, but from the
> diff and the "gdb" mention I gather that this isn't using some "native"
> debugger of MSVC/VS's, but just using the VSCode editor as a wrapper for
> gdb?

It can be use as a wrapper for the following debugger:
    Linux: GDB
    macOS: LLDB or GDB
    Windows: the Visual Studio Windows Debugger or GDB (using Cygwin or MinGW)
Source : https://code.visualstudio.com/docs/cpp/cpp-debug#_gdb-lldb-and-lldbmi-commands-gdblldb


Thanks for your reviewing.


> On 6/5/22 1:59 PM, Matthieu Moy wrote:

> I'd start with the last sentence. People already familiar with VS Code
> may find the first line boring, and stop reading before reaching the
> important information.

Yeah, sure, I don't think about the expert that must just want to know
about the script.

> Acked-by: Matthieu Moy <git@matthieu-moy.fr>

Thanks.


COGONI Guillaume (1):
  contrib/vscode/: debugging with VS Code and gdb

 Documentation/MyFirstContribution.txt | 11 +++++++++++
 contrib/vscode/README.md              |  6 +++++-
 contrib/vscode/init.sh                |  1 -
 3 files changed, 16 insertions(+), 2 deletions(-)

Diff-intervalle between v1 and v2 :
1:  2a7d50ca5c ! 1:  367a478855 contrib/vscode/: debugging with VS Code and gdb
    @@ Commit message
    
    Add a mention to the README and the init.sh in Documentation/
    MyFirstContribution.txt and a part to convince a newcomer that VS Code
-   can help him.
+   can be helpful.
    
    Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
    Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>

    @@ Documentation/MyFirstContribution.txt: against the appropriate GitGitGadget/Git
+
+=== VS Code
+
++A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
++and explanation of how to use the script are available in contrib/vscode/README.md.
+Using the integrate debugger can be particularly helpful to understand how Git works internally.
+It can be used to isolate some parts of code, with this you may be able to ask more precises
+question when you are stuck. (See getting-help sections).
-+A script that creates the configuration files is available in contrib/vscode/init.sh. Useful links
-+and explanation of how to use the script are available in contrib/vscode/README.md.
\ No newline at end of file
    
    ## contrib/vscode/README.md ##
-- 
2.25.1

