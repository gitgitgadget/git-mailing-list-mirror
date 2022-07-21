Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B5EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 15:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbiGUPw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiGUPwy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 11:52:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8C045F61
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:52:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id oy13so3923957ejb.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 08:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eDcqjch1X1fCpbTp/fHgpcNDencSWChk6DVM87QKGdE=;
        b=j6UhucF70b2lQ/0Bi2yO1pM748Tga9r1fpyg7YzTpfR2+93kFuhAE3xJ4k5OKzL0Ev
         RWV5hGjQkd0a0FT5lPPdXrehzem3qxW0k4SINOPcSlR0S+TfRRaWrUmexuoAirPTNlxZ
         3AkC0lXOaxIUQJhKuYcis2hlic+08go7FPbnrt5N6Fm//A8j1eVji4ddWQqYQeJCmfwL
         9d8kgadApKfCxK/BFtyXzBcSlnPQYiiRj7uwamnsmextIMH2nyM3pMUmpIzW4fbWmZz+
         uL1SqL67iH+YIOjNlOXct3dPe/iNtiJH5fneKTtZsNfLfExfWqS64RrbFg0pJPHdgmAl
         1wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eDcqjch1X1fCpbTp/fHgpcNDencSWChk6DVM87QKGdE=;
        b=Lm2WvOqhAq5wmHF0jTWsvdtObyCfQoHZxaf3EmaE1eR/DqfptuTftCwc+n9Esu5VMf
         d1OVP/1QZgTW6+rrTIU3iyu1LGIz26MInGQCKzg2sjSnMz2tgJ0cYd4RTONp4NaVejDU
         7pDGmHQ+rHP4W78rym5BhkPwVXkmhOxKt3DkcAn232lXgpaFV35PU3Hwwiy81+Wh6V/+
         /X/Hc+s8HtkVgXj1Hul+5gvhW/6YnETb113YcxF0UM3g2DhO5mWDz83Fn4EiQNvmkR3Q
         ndz4Db2M5DpPToinmvMNeexEC4Jj5ocUTDk8tS41iLfkKggNakVLbq4mC1/yOri2f3r4
         Oo6w==
X-Gm-Message-State: AJIora8ipBsrw8m0TfucQaHsD9rNCLjL26vfJVEIhkfBu4Cvr05LHAP+
        6aes/yaJCcR0JAnDFeDUlddXnPBGddkGqA==
X-Google-Smtp-Source: AGRyM1tx2S5pToflxXMpT3+xyAa/aV2ZMY1WGWWqYi/+ecEolmVKnYpLN81w+I8eWsrCdknlCzhSpA==
X-Received: by 2002:a17:907:7637:b0:72b:3a3b:7d68 with SMTP id jy23-20020a170907763700b0072b3a3b7d68mr39518287ejc.566.1658418772040;
        Thu, 21 Jul 2022 08:52:52 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id a17-20020a50ff11000000b00435a62d35b5sm1171389edu.45.2022.07.21.08.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 08:52:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oEYTq-004foV-3i;
        Thu, 21 Jul 2022 17:52:50 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: On-branch topic description support?
Date:   Thu, 21 Jul 2022 16:53:18 +0200
References: <xmqqilnr1hff.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqilnr1hff.fsf@gitster.g>
Message-ID: <220721.86mtd2tqct.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 20 2022, Junio C Hamano wrote:

>  * When you are almost finished with the initial draft of your
>    topic, you'd write a cover letter, and record it as the log
>    message of an empty commit at the tip of the topic.

Isn't thu DAG topology of creating a merge that encompases the given
range a more clear marker for this sort of thing?

	# Create a topic branch
	git checkout -b topic -t origin/master
	for f in A B C; do echo $f >$f && git add $f && git commit -m$f; done

	# I forget if there a way to make the porcelain do this, not this or --ff...
	git merge @{u}
        # ... that's better!
	git reset --hard $(echo My CL here | git commit-tree -p @{u} -p HEAD HEAD:)

To steal and amend a diagram from git-merge(1), we now have turned this:


              A---B---C topic
             / 
        X---Y
             \
              master

Into this:

              A---B---C---M topic
             / \         /
        X---Y   ---------
             \
              master

I vaguely recall having actually used this for something in the past.

I tried now with "git rebase --rebase-merges -i", and it supports it
properly, i.e. I could re-arrange it so that it's:

              A---C---B---M topic
             / \         /
        X---Y   ---------
             \
              master

And it still gave me a merge commit whose parents were my branch tip,
and my @{upstream}.

The advantage of doing it this way is that it's obvious from the
topology what the lower bound of this "summary so far merge" is, with an
empty commit on top it:

 A) isn't distinguishable from other uses of empty commits, but this
     merge structure is rather unusual, so it sets it apart.

 B) You don't know what the lower bound is if your @{upstream} ref
    moves.

    I could see it being useful to e.g. offer to update the CL if
    there's conflicts, or if upstream has integrated part of my commits.




