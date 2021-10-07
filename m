Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D8AC433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:52:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC06A6103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 02:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbhJGCyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 22:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhJGCyX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 22:54:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5BBC061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 19:52:30 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id z40so3271794qko.7
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 19:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ejLLag36e6dDhRoCGJ+SQFY1xRv0dcDJFxmUmU8bqhg=;
        b=HhEi3OLOP0WbFMYtcpIjCGjZisP3rSZSf+L1KWUGs+i4IZ0fB46XnTa/OM6vUTYrjV
         +8SAilocO6f9/5F0uLfUf//qxWqtxEcJ9e5xArC0kFGLX8y9+ubduE21B6ByHEZoFBd9
         rIyJOY+aexa71nujn62UPzNd8dvRbiqLw5Zw7wggTWAzjd1QmoEux56+edmkxkradOgh
         MXa4zTdNYCnNhl3ScVDHMoBRcLa9lL1HWfgUq0F6GNczkh7H3f4NqNHb0AH32nebe6ZI
         DrN+SMTcjhP9veeXYSw7GK5bes5RRy5MqNe1/qlDvVE4iFWCLh15FEhFiaSTpOsFT98q
         ERqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ejLLag36e6dDhRoCGJ+SQFY1xRv0dcDJFxmUmU8bqhg=;
        b=orKxNVp/5KS/HZ5cT47P+XbA8RjUW4Vmo/MqmduMP4HjzEkNDLny2M1iCDgkNIpAma
         9qLJAwvJJwR2HLsMfbdXXoHp7u7PG/iOXQfPu3oD59JIqShIIKsVw8hMkhqbXukYJjT9
         pvBS5giwJb6PaqJ/89gAt8BthTZYZQ3vjFdkGEkUBOQVDIYok6DKrcHM11Z+wrpq5Kt1
         On+FxHk9g8Qm5HMxrSbjAJ+4PC+mStoft41NMW3p9WTe2dMjDUQayQ88BR8Wk8XNBOMP
         UTiqCtGkLE+CddvMQsd21i57iEYr/r/6bPC3D0tpdEAN6Hs6c/U8Rhg5lSmGFVLiaapN
         Chrg==
X-Gm-Message-State: AOAM533YGKn566U1RRKJkZ63HL9T3Eu0TjYTm4CdDGFRrj74FFJh1x6o
        iP0SaxgKtYaU3bUirH+ugnkWm2y8mSw=
X-Google-Smtp-Source: ABdhPJzOEIm3FSCEsS4gqpVM0tYbr4Omb/L5ubZE5KPc/3ITA01jYUXT03aklegCC4fknSAQw/vYqA==
X-Received: by 2002:a37:2e82:: with SMTP id u124mr1442118qkh.58.1633575149166;
        Wed, 06 Oct 2021 19:52:29 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 6sm12596407qkc.123.2021.10.06.19.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 19:52:28 -0700 (PDT)
Subject: Re: Git push subtree fail unknown revision or path possibly due to
 missing git-subtree-split commit
To:     Eddie Ridwan <eddie.ridwan@gmail.com>, git@vger.kernel.org
References: <CANcBuaZstymNMvbPX553kgr=FsrFFcDEivfiDPsPe3uyGLb78g@mail.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <61ee8bec-1e6c-e3c7-2cef-7520f376c18c@gmail.com>
Date:   Wed, 6 Oct 2021 22:52:27 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CANcBuaZstymNMvbPX553kgr=FsrFFcDEivfiDPsPe3uyGLb78g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eddie,

Le 2021-10-05 à 00:53, Eddie Ridwan a écrit :
> Thank you for filling out a Git bug report!
> Please answer the following questions to help us understand your issue.
> 
> What did you do before the bug happened? (Steps to reproduce your issue)
> git pull/push subtree as normal, although it is possible that one of
> the contributors to the subtree repo may have done a force push.

I think that is indeed what happened (see below).

> 
> What did you expect to happen? (Expected behavior)
> git push subtree to update the remote subtree repo.
> 
> What happened instead? (Actual behavior)
> Failed to update the remote subtree repo. Error message:
> 
>         fatal: ambiguous argument
> '3f44cc87ceb87df1d9171096596a824fc3050a27^{commit}': unknown revision
> or path not in the working tree.
>      Use '--' to separate paths from revisions, like this:
>      'git <command> [<revision>...] -- [<file>...]'
>      could not rev-parse split hash
> 3f44cc87ceb87df1d9171096596a824fc3050a27 from commit
> 8577911bf6183497cc246aa620e7be1b6becec29

It would be easier to help you if you gave a URL for your repository :)
(or at least for the subtree). I managed to find you Stack Overflow
post [1] by Googling these commit hashes (!). Fortunately you mention
the subtree URL in your question, and that's enough to go by in this case.

> 
> What's different between what you expected and what actually happened?
> 
> Failed to update the subtree repo, as expected;
> 
> Anything else you want to add:
> 
> I am not able to find the commit/hash
> 3f44cc87ceb87df1d9171096596a824fc3050a27 in the repo. In gitx, I can
> see that the commit is a git-subtree-split. But it appears to no
> longer exist in the repo.

Here, I'm assuming that by "in the repo" you mean in a clone of the subtree
repo, i.e. a clone of https://github.com/OpenSID/tema-natra.

Indeed the commit with hash 3f44cc87ceb87df1d9171096596a824fc3050a27 does not exist in
such a clone. But, it still exists on GitHub:

https://github.com/OpenSID/tema-natra/commit/3f44cc87ceb87df1d9171096596a824fc3050a27

GitHub almost never removes commits in practice. This is good news, because
it means you can fetch it locally.

> How can I bypass or recover from this apparent missing commit? Any
> help would be greatly appreciated.

The git-subtree script does need the commit locally to work. So, just fetch
the commit by its hash. In your project repository (the one which uses tema-natra as
a subtree), run:

git fetch https://github.com/OpenSID/tema-natra.git 3f44cc87ceb87df1d9171096596a824fc3050a27

This will download the needed objects. After that, you *should* be able to
run your 'git subtree push' command.

Note: I think that the 'premium' branch (mentioned in your Stack Overflow question)
was indeed force-pushed, since 'git log --oneline dadcd0167^..' does not show the two
commits that appear in your image [2] that read "Update statistik_pengunjung.php"

Hope that helps,

Philippe.

[1] https://stackoverflow.com/questions/69431546/git-push-subtree-fail-unknown-revision-or-path-possibly-due-to-missing-git-subtr
[2] https://i.stack.imgur.com/1tMln.jpg
