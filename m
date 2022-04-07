Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0E1C433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 20:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiDGUsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 16:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbiDGUru (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 16:47:50 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF8304622
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 13:40:14 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d3so9571772wrb.7
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 13:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=im8si4vr/yq4ekkLLFuC4PmUPpma3LaPX5lstEPMThk=;
        b=J6Saml4ktHK9gRWpzbSCBHvdapfY6ws+bZKnAF1k+m21pCPlnwh6UrNbTZTmt1wAfm
         t9W5HNngoQq0ufVMRCEZ1HHWR+eLKqI+jwL2JV3Dbjw3yXE/SI2f1zKjYE7M30tGvGEx
         6k/WxNpGaA7y/b5nbbm9jkfw6obH+stHhwJp8sijtnWWp/Mvkftm1Ad5UCJcToSXgJ7T
         kTe8s3Ydqyks/+nitEDrntSklnVFsx5SkMtRH4gBP+hgRl4bnMnhRQTuJX2oPiQP5gZi
         5sokzoD0eWNJ26cZ7JhJ/E5XpqbF9W/KXwxOHNHIbafZOTXYA2L40jKVqplx9qxw0hiP
         BGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=im8si4vr/yq4ekkLLFuC4PmUPpma3LaPX5lstEPMThk=;
        b=XGxiAA7dCrNvFeQMDYKEzYbwU0uOctIWevuuYcxvOj7eGOcKeOLOPayX9a6ENs+xaS
         1dzlSwcDWhNppfLJlgjlFiQ80EJ8otr9aRyxlyieOXDVP0wnnRu3CAvksR9ZYJ0+9KlK
         11HmHogTOPzr7qnJ8zAJPNU9d+KfLLChTRepxHewcUrAJ+yngYotppeOKXwgdsDqApw2
         m28+Bs+mpD//GZ91f4HeA1665QPpXGt05d7V5ZEKMHOkd2wm52ISXRvubBFXl23XkOuc
         ZR7RxrbYTxEQWBc0xQGlm+Luyfx3UUOa8Q+E9nX5dR5uxRiLcHTflaOoEYwvJ/Hyk3+u
         PMmg==
X-Gm-Message-State: AOAM5325XH5KUUDTqClSolmErQ2zh25tTsUJpKAlwMfQkyXCFSly+SEf
        sMT+7rMOehFVE9s3wpgmYsg=
X-Google-Smtp-Source: ABdhPJwikQwXwktiuqRWEzsOnsFSreqec/cxmwjN2Ueup2j+WiGnPUuBdc8Q9LI8w9V7XA7SRrRg2g==
X-Received: by 2002:a5d:5507:0:b0:206:1828:251 with SMTP id b7-20020a5d5507000000b0020618280251mr12078864wrv.655.1649364012439;
        Thu, 07 Apr 2022 13:40:12 -0700 (PDT)
Received: from localhost.localdomain (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id f9-20020a05600c4e8900b0038cc29bb0e1sm10276793wmq.4.2022.04.07.13.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 13:40:11 -0700 (PDT)
From:   COGONI Guillaume <cogoni.guillaume@gmail.com>
To:     gitster@pobox.com
Cc:     Matthieu.Moy@univ-lyon1.fr, avarab@gmail.com,
        cogoni.guillaume@gmail.com, derrickstolee@github.com,
        git.jonathan.bressat@gmail.com, git@vger.kernel.org
Subject: [PATCH v4 0/1] contrib/vscode/: debugging with VS Code and gdb
Date:   Thu,  7 Apr 2022 22:40:00 +0200
Message-Id: <20220407204001.112287-1-cogoni.guillaume@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <xmqqmtgwu9n7.fsf@gitster.g>
References: <xmqqmtgwu9n7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=[UTF-8]
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> Cogoni: In conclusion, I think that if you remove the change to
> MyFirstContribution.txt, then your patch can be merged pretty
> quickly (probably, that's not my decision). 
> I expect this discussion about a potential "WorkingOnGit" file to continue, 
> but if it come to fruition, your section on VS Code would be welcome.

Yes, I got the same conclusion, from the discussion between you and
Ævar Arnfjörð Bjarmason. So, I remove the change to MyFirstContribution.txt.
It sounds like the best plan for now.

But, I agreed on some point with Ævar Arnfjörð Bjarmason, we have to try 
to recommending also free alternatives.

And, yes, a new file is the best option. So, I keep my change somewhere, and 
I will come again with a new patch but not in its thread because it seems to 
be out of the scope now.


> Sounds like a good thing to have, but would there truly be hints and
> tips so specific to this project, I have to wonder. I do not think
> we are in the business of making "how to hack on and debug a project
> code that is mostly written in C and whose history is managed in
> Git" tutorial for each IDE, so I am not sure how well it would fly
> (not opposed to, but skeptical).

I think, it can help a newcomer, but not necessarily people with a 
lot of experience on various projects. But, we can give it a try and 
see where it goes.

Thanks everyone for your reviews, your ideas and help.


COGONI Guillaume (1):
  contrib/vscode/: debugging with VS Code and gdb

 contrib/vscode/README.md | 6 +++++-
 contrib/vscode/init.sh   | 1 -
 2 files changed, 5 insertions(+), 2 deletions(-)

Diff-intervalle vs v3 :
1:  0600ab64f8 ! 1:  59de991a2d contrib/vscode/: debugging with VS Code and gdb
    @@ Commit message
         Add useful links in contrib/vscode/README.md to help the user to
         configure VS Code and how to use the debugging feature.
     
    -    Add a mention to the README and the init.sh in Documentation/
    -    MyFirstContribution.txt and a part to convince a newcomer that VS Code
    -    can be helpful.
    -
         Helped-by: Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
         Helped-by: Derrick Stolee <derrickstolee@github.com>
         Co-authored-by: BRESSAT Jonathan <git.jonathan.bressat@gmail.com>
         Signed-off-by: COGONI Guillaume <cogoni.guillaume@gmail.com>
     
    - ## Documentation/MyFirstContribution.txt ##
    -@@ Documentation/MyFirstContribution.txt: against the appropriate GitGitGadget/Git branch.
    - If you're using `git send-email`, you can use it the same way as before, but you
    - should generate your diffs from `<topic>..<mybranch>` and base your work on
    - `<topic>` instead of `master`.
    -+
    -+[[Bonus-useful-tools]]
    -+== Bonus - useful tools
    -+
    -+=== Visual Studio Code (VS Code)
    -+
    -+The contrib/vscode/init.sh script creates configuration files that enable
    -+several valuable VS Code features. See contrib/vscode/README.md for more
    -+information on using the script.
    -+
    -+In particular, this script enables using the VS Code visual debugger, including
    -+setting breakpoints, logpoints, conditional breakpoints in the editor.
    -+In addition, it includes the ability to see the call stack, the line of code that
    -+is executing and more. It is possible to visualize the variables and their values
    -+and change them during execution.
    -+
    -+In sum, using the built-in debugger can be particularly helpful to understand
    -+how Git works internally.
    -+It can be used to isolate certain parts of code, with this you may be able to ask
    -+more precises question when you are stuck. (See getting-help sections).
    -
      ## contrib/vscode/README.md ##
     @@ contrib/vscode/README.md: code editor which runs on your desktop and is available for
      [Windows](https://code.visualstudio.com/docs/setup/windows),
-- 
2.25.1

