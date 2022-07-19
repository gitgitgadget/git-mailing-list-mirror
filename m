Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31975C43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 13:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243421AbiGSNSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237976AbiGSNRs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 09:17:48 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3C952DE6
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 05:34:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id q43-20020a17090a17ae00b001f1f67e053cso2098823pja.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=atWfqfWcIElWOxA5awoQIX+uZb2TSLtP200Tkd/MLs4=;
        b=Q5/fDTpsaU2zy0nw6E/+35LBKx9MvG1+2jy7mamqNMJKmjjYE9qxZKSeUFolxcDPTS
         t+Af0lVwnXac5Ezcowp8lDHChdaegoCl5lHPSvul4RjdDmBa/QZS50c4luYzhxPE/TzF
         9no/9S4N26JUYb7e02+fx+1VCqUvVAQwYtP1LP19fOPNL9A8sWepVD1wQZtfIETHGn67
         jbSDzGvYPK5rZRYX3+mW0gXgBo169mqxnZLWuGBwAhXuRvFx/D6ZgCZhSHKCuOwcfmE7
         DbulA52gGX1I+7qiPXxr2j8auCVnt8BbRt92lGt4df1ZfakZbwnFwUYxClqnSd70UErt
         AiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=atWfqfWcIElWOxA5awoQIX+uZb2TSLtP200Tkd/MLs4=;
        b=5pcaapG+wR8QEglpwYbIxfxVdrhbj2ZKh4WdTCPVRxZWY2YOs/fOKA1+RloX2cyF4z
         5vCtwfqIeSZH9AgUBZOEDffpa6ayVM5xHWuZK4EWRs2osUwT9vX0lwHjmtuHNB2CJOEO
         21+nxBiAAc6LNXVxnKT9F0Xr+h44M4Oytu5Q4S1pXXYiu42rko0Ncgtu/VXQx61tDl54
         lvMpCFe9Nn1lzfUkKhLIRKhSM8Is6pTisss3HvAqFEg9uhIsx5+8LrpRmrM8Vrm8n9cl
         IbiVCeIxoF1t6abRp45eSQfcdTEtbcZMFHCPPJcdzQ5MPKIeOJ+QNHFqMnR51mT9smv5
         6HOA==
X-Gm-Message-State: AJIora/m4tcSiA1s3Yk2rU4JDh4pkCXTsIc+6F29kh6i2jTtpxf5mzeI
        0jz5EMfky0ZZsgo8GbwngXM=
X-Google-Smtp-Source: AGRyM1s7yBcA6fH5kP2pnjrf7YIupzs46kd/cTBiEvwAmN/b68IWxK6E3Z+m+S+4cbA51OnpCqTbvw==
X-Received: by 2002:a17:90b:1e0e:b0:1ef:97f9:dfb5 with SMTP id pg14-20020a17090b1e0e00b001ef97f9dfb5mr45055181pjb.217.1658234064104;
        Tue, 19 Jul 2022 05:34:24 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.97])
        by smtp.gmail.com with ESMTPSA id ml16-20020a17090b361000b001ef76dbae28sm11394992pjb.36.2022.07.19.05.34.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jul 2022 05:34:23 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     avarab@gmail.com
Cc:     derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, gitster@pobox.com,
        me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 0/7] trace2: dump scope when print "interesting" config
Date:   Tue, 19 Jul 2022 20:34:16 +0800
Message-Id: <20220719123416.51367-1-tenglong.tl@tenglongtldeMacBook-Pro.local>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <220719.86tu7duxl3.gmgdl@evledraar.gmail.com>
References: <220719.86tu7duxl3.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> We generally submit patches on a single "topic", what a "topic" is is
> often fuzzy, and sometimes a topic that's mostly trying to do X will fix
> or change some unrelated Y "while at it".
>
> But patch or patches at the end of a series don't depend on anything
> that comes before them, and could be "cherry-pick"'d directly on top of
> "master" that's generally a sign that you should be submitting two sets
> of patches, not one.
>
> Per
> https://lore.kernel.org/git/2016ef2e342c2ec6517afa8ec3e57035021fb965.1650547400.git.dyroneteng@gmail.com/
> the "let's log config" is just something you happened to run into on
> this topic, but it might have just as well been some other command.
>
> So I think it's better to split it up into its own topic.

Make sense.

> Yes, that sound good, although I'd make that "scope" line be:
>
> 	"scope": "global" | "worktree" | <add more things to the list here>
>
> Or just say:
>
> 	"scope": <a string that 'git config --show-scope' would return>,
>
> Which covers all the possibilities, without hardcoding them there.

I think I'd like to prefer the second way, thanks for the input.

> I mean that part of what you're adding is about this new "scope"
> feature, but another part just seems to be explaining how the
> trace2.configParams works in general.
>
> For the "works in general" let's either link to git-config(1), or if
> that explanation is lacking improve it & link to it.

Yes, I think the current explanation is OK for me in git-config[1], so
I add the link as in previous reply (Search: 2db47572d4462e3788a92fd355b97df13b9bcc39) :

+`trace2.configparams` can be used to output config values which you care
+about(see linkgit:git-config[1).

> Yes, something like that, although it's a bit odd to discuss "scope"
> here and not have the trace show it yet, but that's fixed below.:

Yes, because I want the result to be more obvious, if a config only in single
scope maybe it's a litter harder to remember "Wo, what looks like if config is
in multiple scopes?(although it's intentional)"

> Yes, exactly! That makes it much clearer what the functional change was
> about, i.e. we can see what parts of the trace are now different (the
> scope is added to the trace).

Yes.

Thanks.
