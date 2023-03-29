Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2A8C6FD18
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 20:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbjC2UC1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 16:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2UC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 16:02:26 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6DA126
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 13:02:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m6-20020a056902118600b00aeb1e3dbd1bso16300392ybu.9
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 13:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680120144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=15SZKHv3Jdxx8sWOL4+bc+Dg4UGvOrWN46EtNNrhevk=;
        b=TD4b5nhcW84Eoco+qYUGnhwumdNK+9Dk2AfAePCcnTWinVjwpA9i+Foa+cjMnSNHcF
         1Dqv3bLZR021QAgqeerc5LiyrZSla2NADFswiaTbHpU+/BdvcvpEv8/rSYNwSMdhl7Dp
         DbwTXWIvdXHswbjOr/E5D/ASCsUXexPDXTfguusAqZSvVZS8NRTx3WwPiOXzLXUJu4RF
         aAvXM6VwH0TpDbJPUOcpQ5CoS7nfyKZpLEx23qOCoxN+aNf4hlCHoRTmUySudVr55r7a
         KrRiNUCB6qD076yzQj+K2X4Iy7iCKvhUNJIV96ARZuSyFyAWhvdTMrjJWR8fbPGlv1Tn
         nxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680120144;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=15SZKHv3Jdxx8sWOL4+bc+Dg4UGvOrWN46EtNNrhevk=;
        b=nFwdBaiFaqOlGCq8rSiZPvNZfdvIvjUYSCtp8r/BfPaCMi+5PRCoVbAg8HuHkfnvWn
         kB4jX8HAyzThmU6oTzM/bFxdrPF3d1IYpkPNMZMBljwDA0TYMD+2zMKtCFeESXViVoS1
         Jw88Ucp1hV2trWpmh4r9D22v0kJM4tlpSbfptlRC+h2AiKbvNmJx0h9HRe5PVHXbx3NW
         JbaTTWG4YrPXfMm4I0JJ23Xuk5dGLceqhuaMa/BhyhxbvrgGfFnWS3i9W9aEZrvC6928
         u3oLjvKtipeEfZr41HOTL1tnBk9Yeqi1J/M8zSERaA+j7Oq+wUr050sgeLwUxkzR2+o9
         UtNA==
X-Gm-Message-State: AAQBX9etHsMF9I3ZW2SJy9nP19Ouuaxq1j3t/2kaEzrtsRcj1krxC7SH
        Y5u7i3GeQ5HPvS3LYEViq58n056XMATgZQ==
X-Google-Smtp-Source: AKy350beFmSSUok7FBd/ReTvvPgBM4NTnUimAYt8ggtGTrA63DaNf7L/li/7gti+vlCNAbdaoVTUFqnion6F+g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6902:1586:b0:b33:531b:3dd4 with SMTP
 id k6-20020a056902158600b00b33531b3dd4mr10694232ybu.1.1680120144499; Wed, 29
 Mar 2023 13:02:24 -0700 (PDT)
Date:   Wed, 29 Mar 2023 13:02:15 -0700
In-Reply-To: <xmqq7cuz9yhp.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com>
 <pull.1463.v3.git.git.1680025914.gitgitgadget@gmail.com> <72774fd08f3eb9ff1d449814637e584692ba2bfc.1680025914.git.gitgitgadget@gmail.com>
 <230329.86sfdnvlke.gmgdl@evledraar.gmail.com> <xmqq7cuz9yhp.fsf@gitster.g>
Message-ID: <kl6lfs9ncomw.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 3/8] config.c: create config_reader and the_reader
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>> I.e. we actually *do* have a repo there, we just haven't bridged the gap
>>> of "ignore most of its config" so we can use config_with_options()
>>> there.
>> 	 struct config_options {
>> 	        unsigned int respect_includes : 1;
>> 	+       unsigned int ignore_system : 1;
>> 	+       unsigned int ignore_global : 1;
>> 	        unsigned int ignore_repo : 1;
>> 	+       unsigned int ignore_local : 1;
>> 	        unsigned int ignore_worktree : 1;
>> 	        unsigned int ignore_cmdline : 1;
>> 	        unsigned int system_gently : 1;
>
> That does look (I am not sure about _local bit, though) well
> organized, but I suspect that it can be left for a follow-on
> clean-up series, perhaps?

Makes sense, I did suggest something similar previously:

  https://lore.kernel.org/git/kl6ly1oze7wb.fsf@chooglen-macbookpro.roam.corp.google.com

But I think that's a follow up series for sure.
