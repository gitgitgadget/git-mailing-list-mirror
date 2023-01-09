Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1FBC5479D
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 04:58:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233886AbjAIE6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Jan 2023 23:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbjAIE6t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2023 23:58:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB268FFB
        for <git@vger.kernel.org>; Sun,  8 Jan 2023 20:58:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id v23so3388559plo.1
        for <git@vger.kernel.org>; Sun, 08 Jan 2023 20:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V77BRuE2sFi5/ZNPSXjYxkgs90xQM9KGuIBnlBoZeVI=;
        b=ILUdLWI/Gtx2CbzJ6xfBNs5l7/3oZ2IG3eq0AW/iIAV1iFt43AAMqpW9KovdLKFm/T
         mFgFWSMI1RNUXcPkeZnXPbcQvauoAmiDRubit+tJutWIsWWJqFu8cpyHKrahOxc/h2Ti
         ktjZ9jNKhnrHS1lBYS02t+ongdNrCtRo9I/Izv9LB9/KqN4TVTlMadq6mpaRM3s9XKs5
         xD7063OOyK5hHaN4ATVKCleG72rYDQo6i4EbptNfnhLul7f+/wMvIx++6QgOdvD0wCCT
         Zmy9+Ec8Ix9BWtsxO+HA92h0ZSM2YjOAa1nvhO+eWhgloSuUVSook1XhgL7rz5Rm/f3o
         jLhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V77BRuE2sFi5/ZNPSXjYxkgs90xQM9KGuIBnlBoZeVI=;
        b=7CJNA5OpKqX1ygWR9c149LE/KRrN64FQ+/ycGQVi4OuNQexcNrdkpILe2+G3eirAC7
         ThF1ylwAwhRb6boOFDEMwOKZMTQrwVRIUOVuUti34lq/sfIk2QKbixEni78lkEs0DlQA
         VE9hAPOH8ifob/2r6mqRrw5cV2AgwMpnUCrBGi0cgwUBe9g8yu+i+TaUcRwZcO0OUVJb
         MD24uF5khOQTPkJeJnV4/ty2cFKPAOplfnE3TkGf1RZVZi3tqMbPKnse+SnWUGqEeatK
         ABrjU+1p2VlKRio4AEqtXwVaENjNNoBFWt4ZopueQKjO+4B7VmSv3zhInwx73JNBzcpD
         MIaQ==
X-Gm-Message-State: AFqh2kpM9NqihcDeOGsofzQzbOYi6bQTp8b80SIA5X4kHgbaCUvZnYLE
        K9CaqZDaVenRLOXwnSNjgOo=
X-Google-Smtp-Source: AMrXdXt7gJZnfO5yqXLf+j72/h8nZ+/1PLZKnah+vp0ronQX0yY5VO+y766yyl5GZfjiHs+8HNzOEw==
X-Received: by 2002:a17:902:b192:b0:193:2d53:3fc9 with SMTP id s18-20020a170902b19200b001932d533fc9mr3058116plr.6.1673240328215;
        Sun, 08 Jan 2023 20:58:48 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00189529ed580sm5025138plg.60.2023.01.08.20.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 20:58:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Preston Tunnell Wilson <prestontunnellwilson@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] githooks: discuss Git operations in foreign repositories
References: <pull.1457.git.1673171924727.gitgitgadget@gmail.com>
Date:   Mon, 09 Jan 2023 13:58:47 +0900
In-Reply-To: <pull.1457.git.1673171924727.gitgitgadget@gmail.com> (Eric
        Sunshine via GitGitGadget's message of "Sun, 08 Jan 2023 09:58:44
        +0000")
Message-ID: <xmqqwn5wuwvs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index a16e62bc8c8..6e9a5420b7c 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -31,6 +31,17 @@ Hooks can get their arguments via the environment, command-line
>  arguments, and stdin. See the documentation for each hook below for
>  details.
>  
> +If your hook needs to invoke Git commands in a foreign repository or in a
> +different working tree of the same repository, then it should clear local Git
> +environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., which could
> +interfere with Git operations in the foreign repository since those variables
> +will be referencing the local repository and working tree. For example:
> +
> +------------
> +local_desc=$(git describe)
> +foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
> +------------
> +

It is an excellent idea to add the above, but

 * I think adding it one paragraph earlier may make it fit better.

 * The paragraph, after which the above gets inserted, can use a bit
   of enhancement.

That is, something like this?



 Documentation/githooks.txt | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git c/Documentation/githooks.txt w/Documentation/githooks.txt
index a16e62bc8c..f3d0404164 100644
--- c/Documentation/githooks.txt
+++ w/Documentation/githooks.txt
@@ -25,7 +25,20 @@ Before Git invokes a hook, it changes its working directory to either
 $GIT_DIR in a bare repository or the root of the working tree in a non-bare
 repository. An exception are hooks triggered during a push ('pre-receive',
 'update', 'post-receive', 'post-update', 'push-to-checkout') which are always
-executed in $GIT_DIR.
+executed in $GIT_DIR.  Environment variables like GIT_DIR and GIT_WORK_TREE
+are exported so that the hook can easily learn which repository it is
+working with.
+
+If your hook needs to invoke Git commands in a foreign repository or in a
+different working tree of the same repository, then it should clear local Git
+environment variables, such as `GIT_DIR`, `GIT_WORK_TREE`, etc., which could
+interfere with Git operations in the foreign repository since those variables
+will be referencing the local repository and working tree. For example:
+
+------------
+local_desc=$(git describe)
+foreign_desc=$(unset $(git rev-parse --local-env-vars); git -C ../foreign-repo describe)
+------------
 
 Hooks can get their arguments via the environment, command-line
 arguments, and stdin. See the documentation for each hook below for
