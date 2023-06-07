Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 727ACC7EE25
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 22:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbjFGWaI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 18:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbjFGW3x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 18:29:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F948213D
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 15:29:28 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso4540522b3a.3
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 15:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686176967; x=1688768967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkGofLq5QlojYHVO0QH+y0KJmiv2AVNJVZ69ushkfn8=;
        b=aAjI9qkzbE15anvdkaIy2ZsjQzsacZEiuGMwGyep0Y3ToyurYpYZADOnrD/noYU93l
         8oDRo/dw9ff5e39fVd46FHDu5M6h6sTiZD47eSxQV5T+rFLa515/smhq6qqebU/qfX1V
         wJ1hLtEbUIKfuekP9dQKnLdm3rli1KVbwnJlWG6duXUGwy1PD/uPoMb3ZZpzCDb4uHFN
         MDfXodZrJjL/SjBi8Vij282njFF2fjqlcdVZYbYVaAU1ayPvThmF8WX1YfZ7EQk7LdNA
         dR5nSgLbE0pbjH26ypn8yWP7AcAfioh8as3TI8+eb+cGi1PwO+XGxSyq9fExO7A2fTzf
         p5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686176967; x=1688768967;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkGofLq5QlojYHVO0QH+y0KJmiv2AVNJVZ69ushkfn8=;
        b=Tw3uv/RbiBPz00GEO7ayPVG/b0sio01H/TwT8DIO7Pfw68p+rBzdnvhBuT6GuVa1L3
         FfxelDW/ns84UrCh4Cq8EKIERxBJ2aCz+s8ZI1L7e1I3z+KkOEkCfLTF4CjIqkEHZxEJ
         8eeNUktSN6eazEcCQIj6bQ/BVbAIvjVcTRQLhy2xxVHrRIXUAHX1T/xhmIRGpHsL6kta
         zCHbRP6G7JPdbzmNdPJXcIaviq2KK/6zDg6QgMeNb/ZN1B1O2eaNUVfthkTDx9wTgEuk
         JOlHDXl77SeqHmDxP5YZgtk5rQok+bU1+ELJZyGCRpEa9eK4oCGpbIqeg3qnAwNSiVtd
         KekA==
X-Gm-Message-State: AC+VfDxcgtvLY+roEZ671OP48x3UbPdKens8iBsqJegC5HabomPHg04Z
        qNcjgrN3kiL1/r6zxVK2oo6E
X-Google-Smtp-Source: ACHHUZ5/KSar2/ohzEnua0QGAhhZ7BMXGCHsSWXKdd2p/FN8+UJNQ4UilIODAwOFWpYFyHnxGWaMpA==
X-Received: by 2002:a05:6a21:3993:b0:111:366:eeb2 with SMTP id ad19-20020a056a21399300b001110366eeb2mr2226548pzc.9.1686176966739;
        Wed, 07 Jun 2023 15:29:26 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id j14-20020aa7928e000000b0063a04905379sm8836271pfa.137.2023.06.07.15.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 15:29:26 -0700 (PDT)
Message-ID: <49509708-c0a1-2439-a551-cab05d944b66@github.com>
Date:   Wed, 7 Jun 2023 15:29:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v2 3/3] repository: move
 'repository_format_worktree_config' to repo scope
Content-Language: en-US
To:     Glen Choo <chooglen@google.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Cc:     derrickstolee@github.com, gitster@pobox.com
References: <pull.1536.git.1684883872.gitgitgadget@gmail.com>
 <pull.1536.v2.git.1685064781.gitgitgadget@gmail.com>
 <506a2cf8c73549bc8f9761b56532ef08ed220da4.1685064781.git.gitgitgadget@gmail.com>
 <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <kl6lr0qwno2q.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo wrote:
> This patch adds another instance of copying fields from "struct
> repository_format" to "struct repository", so I think that we should
> start doing this with a helper function instead of copy-pasting the
> logic.
> 
> As for what should be in the helper function, the above hunks suggest
> that we should copy .hash_algo, .partial_clone, and .worktree_config.
> However...
> 

...

> 
> This hunk does not copy .hash_algo. I initially wondered if it is safe
> to just copy .hash_algo here too, but I now suspect that we shouldn't
> have done the_repository setup in discover_git_directory() in the first
> place. It isn't used by the setup.c machinery - its one caller in "git"
> (it's used by "scalar") is read_early_config(), which is supposed to
> work without a fully set up repository, and bears a comment saying that
> "no global state is changed" by calling discover_git_directory() (which
> stopped being true in ebaf3bcf1ae). It looks like
> discover_git_directory() is just a lightweight entrypoint into the
> setup.c machinery. 16ac8b8db6 (setup: introduce the
> discover_git_directory() function, 2017-03-13)) says "Let's just provide
> a convenient wrapper function with an easier signature that *just*
> discovers the .git/ directory. We will use it in a subsequent patch to
> fix the early config."
> 
> If I'm wrong and we _should_ be doing the_repository setup, then I'm
> guessing it's safe to copy .hash_algo here too. So either way, I think
> we should introduce a helper function to do the copying, especially
> because we will probably need to repeat this process yet again for
> "repository_format_precious_objects".

Thanks for pointing this out & sharing your findings! 

I agree with the desire to reduce code duplication, but the reason I avoided
that refactor when putting these patches together is because of the subtle
differences across the different repository format assignment blocks.

For example, in addition to what you mentioned here w.r.t. '.hash_algo',
there are also differences in how 'repository_format_partial_clone' is
assigned: it's deep-copied in 'check_repository_format', but shallow-copied
(then subsequently NULL'd in the 'struct repository_format' to avoid freeing
the pointer when the struct is disposed of) in 'discover_git_directory()' &
'setup_git_directory_gently()'. 

If we were to settle on a single "copy repository format settings" function,
it's not obvious what the "right" approach is. We could change
'check_repository_format()' to the shallow-copy-then-null like the others:
its two callers (in 'init-db.c' and 'path.c') don't use the value of
'repository_format_partial_clone' in 'struct repository_format' after
calling 'check_repository_format()'. But, if we did that, it'd introduce a
side effect to the input 'struct repository_format', which IMO would be
surprising behavior for a function called 'check_<something>()'. Conversely,
unifying on a deep copy or adding a flag to toggle deep vs. shallow copy
feels like unnecessary complexity if we don't actually need a deep copy.

Beyond the smaller subtleties, there's the larger question (that you sort of
get at with the questions around 'discover_git_directory()') as to whether
we should more heavily refactor or consolidate these setup functions. The
similar code implies "yes", but such a refactor feels firmly out-of-scope
for this series. A smaller change (e.g. just moving the assignments into
their own function) could be less of a diversion, but any benefit seems like
it'd be outweighed by the added churn/complexity of a new function.

In any case, sorry for the long-winded response. I'd initially tried to
implement your feedback, but every time I did I'd get stopped up on the
things I mentioned above. So, rather than continue to put off responding to
this thread, I tried to capture what kept stopping me from moving forward -
hopefully it makes (at least a little bit of) sense!

