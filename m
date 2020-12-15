Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEAC4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 06:32:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FCAD22258
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 06:32:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbgLOGbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 01:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgLOGb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 01:31:29 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEC5C06179C
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 22:30:44 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id h18so18337639otq.12
        for <git@vger.kernel.org>; Mon, 14 Dec 2020 22:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=yl0X1LMPH4w2f2PeK3KvsB0cktvTF80nevyw6N5gHxc=;
        b=WHpkxX1WkScgsv8NusVXq5dSiePXlZVzwe9SDjqXzUBnrUTV4ogdUYf6/B+s1Q3HrR
         HeM297nj97oGuaF0IWbAPV1sjZ39xpgWwAFjLCFuivY9H73HFuxeWOKf8n1YSs733Yi7
         b9tMpL8P97pl9g+ire8NezbLPlB0Do6zG2hsnk0BgE6v2+14EHsar9pfeAlYnh13uLKx
         W/P1VFpQ9iE5Khwj/a20MPRIqnsqOjhLD9vZZVlR3H3Pm4I2tpzkI1BOnCHLTk7t2q82
         iJV7jJvsyq1aDdxmjEdUrNSDCnpMkTkB+cA99EizERuEM3wK9s4/blXI0Jg3t5+ozLUD
         9eNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=yl0X1LMPH4w2f2PeK3KvsB0cktvTF80nevyw6N5gHxc=;
        b=BUPDeuMGxozUD4mMTb8xarWhkKW8ksMLjzS61wuJkCmj8+ume5/1bkbIHdCPKDdfgI
         bvLrwpYhonP4NrFjsssDF3Miw7sgE9I8sWwiMRCfm/sxpXuBgMhmFkDEYat3CIdscA/f
         uP4biGrPiOmgDMRrhrWpbLDAcbkkSkc4/M2raKoq0nXSssREZ6sxkseiEXHIijSMZykB
         CYjvpzNZF+mMW3DQ4EXE/fsBkcg8/MejmCrBl/+1c1TVJZ65Pr+UqhxOCYOSK9J0zORZ
         lznQBpskA66e1u9Fy+S8Bat4IiB0oyGy/j8P4jMPQStw7YLPrJYIpxXRscciDlCD2+i1
         Qu8A==
X-Gm-Message-State: AOAM530qKNz0q7HRNjRTHD5r6vQaXDZfcfrvVp5OasYw7YvHJ8b9RNlu
        dWTn96o5o/09QRUfutDLMfjFFb2fzkuk0A==
X-Google-Smtp-Source: ABdhPJxCmdkuYQYrll9mmJfp3X1NUvr1GzEeJlGhsvpsiMl+F8+Cah+jdX6D7MbNepMpyWgKaDBI6Q==
X-Received: by 2002:a05:6830:1d71:: with SMTP id l17mr22540204oti.269.1608013843052;
        Mon, 14 Dec 2020 22:30:43 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 109sm218094otj.12.2020.12.14.22.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 22:30:42 -0800 (PST)
Date:   Tue, 15 Dec 2020 00:30:41 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <5fd85811c3a6_d7c48208aa@natae.notmuch>
In-Reply-To: <20201214202647.3340193-1-gitster@pobox.com>
References: <20201214202647.3340193-1-gitster@pobox.com>
Subject: RE: [PATCH v7 0/5] making pull advice not to trigger when unneeded
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Just to show what was pushed out on 'seen' while I was cutting the
> preview release...
> 
> This is based on Felipe's v6 (which was mislabled as v5 but sent on
> a different day from the true v5), with two clean-up commits
> inserted between Felipe's second step (now 2/5) and the third step
> (now 5/5, with necessary adjustments).
> 
> Even with the "correct condition" clean-up, I am not quite happy
> with the clarity of the logic around there.
> 
> I think !opt_ff does not exactly belong to the condition, if we
> consider that the eventual endgame should be to stop non-ff
> operation without merge or rebase by default with an error, and that
> should happen in this block.  The error message there should say
> "unable to fast-forward; must merge or rebase", which should equally
> apply to those who gave "--ff-only" explicitly, even though they may
> not need the advice message.

Agreed. Additionally it doesn't make sense that --ff skips the warning
entirely, even though the user has not specified a merge or a rebase (as
you yourself noted in a review of the test cases).

> To avoid the ugly-looking "strcmp()" in the above, we may need to
> adjust "--ff" (fast-forward without creating an extra merge commit)
> and "--no-ff" (create an extra merge commit when the history could
> be fast-forwarded) to imply "merge", though.  It would automatically
> make rebase_unspecified would become false.  With such a tweak, we
> can then simplify it further to
> 
> -	if (rebase_unspecified && !can_ff &&
> -	    (!opt_ff || !strcmp("--ff-only", opt_ff))) {
> +	if (rebase_unspecified && !can_ff) {

Currently this is a rebase:

  git pull --rebase --ff

With your proposed change it would be an implied merge. I think it makes
sense, but it's still a change in behavior.

This patch should do the trick:

--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -973,6 +973,11 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
        if (opt_rebase < 0)
                opt_rebase = config_get_rebase(&rebase_unspecified);
 
+       if (opt_ff && (!strcmp(opt_ff, "--ff") || !strcmp(opt_ff, "--no-ff"))) {
+               opt_rebase = 0;
+               rebase_unspecified = 0;
+       }
+
        if (read_cache_unmerged())
                die_resolve_conflict("pull");
 
Or do you mean --ff doesn't override --rebase? Therefore it's more of an
internal conceptual change.

-- 
Felipe Contreras
