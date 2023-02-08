Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C03C05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 17:07:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjBHRHu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 12:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBHRHt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 12:07:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1654648581
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 09:07:47 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so1962702wmb.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 09:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxssPppJbb7hhffFhqMXSh2aZ1g9/sORjlfw1PAc4GM=;
        b=GmRcY0CQLfYXotJO2rn1IqrKrZURe+gU6rUjM1RgkzS6bDo3czu0PXHL4MwwGT+Nsp
         e4LQKTOFN255S8YojgS0sc+Ku2MicNHIkxySJOOV3aUbOCM5stR51RQf0BGmVxfcQGqe
         qKB85RX1obciaBMjvsk2yRPxDXNyQbA+eEjBnZjN37qNhCOu+tNVc1dPhAKXNedAYQr4
         8kjT8y3Mp3/xkwbfTHMIi+D0FyPSInbWX9D1yOatRTDzwf0/IM2L2GFJrxGynjG+9A0e
         RJXc9lYnlZXni8cHFI8kqaVcPJhRUChv7YBwHWzW5dN0kgtLt3mhKmJgs9YPl4TFgTmV
         +LOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxssPppJbb7hhffFhqMXSh2aZ1g9/sORjlfw1PAc4GM=;
        b=XSdg1HEYcVxWL0RYTJEWsvv0zM/i/ri8KBv7pi+q9A0HiZIHkn+ffj8pMZuQbk90DH
         DEMTuFd6Eox3ld36mR76sYaiwu8WKIHjKteBCz7Wd8rFZdw03x9uPr8xKs9a0IlozQpO
         GzDpzNbXxZBb83THyBtfbT9as/CwQVralC9Ase7V4uMzLmTKIbnPpEJE1MDTY1pWa4tc
         dbKh/ohqrUeOO8P2/ZnVu3mKXWuWyZs3RY8vEHtJYNaPHH/SKApGO3/u6IEy9L5oZU6E
         GFVlQxecZj8WD5ywAHEalYXgfFqqqV/Ejeky1LBiQdaCZ2ySsNKSiO+yXoJzI6CYE23K
         aVNg==
X-Gm-Message-State: AO0yUKViSMHJPiJvxq7QJl7jBFO0U3Cbo4fx2ntVcovMh6+ahx6ViHYV
        zKHyxm/HSIUtf9ArX/hhBcQ=
X-Google-Smtp-Source: AK7set/ZGDox3U0RryxeBdn251IegzalSn0ZAtkoZOHRGDSL04SUGt6RkwiEVVYjf0jcDXzkE7xMng==
X-Received: by 2002:a05:600c:2e96:b0:3df:7948:886b with SMTP id p22-20020a05600c2e9600b003df7948886bmr6878369wmn.31.1675876065561;
        Wed, 08 Feb 2023 09:07:45 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id o5-20020a1c7505000000b003dc48a2f997sm2500924wmc.17.2023.02.08.09.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 09:07:45 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <66bf75bd-b14f-2658-5f6f-8a368c1d429b@dunelm.org.uk>
Date:   Wed, 8 Feb 2023 17:07:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v7 6/7] diff-lib: refactor match_stat_with_submodule
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-7-calvinwan@google.com>
 <230208.861qn01s4g.gmgdl@evledraar.gmail.com>
In-Reply-To: <230208.861qn01s4g.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/02/2023 08:18, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Feb 07 2023, Calvin Wan wrote:

> Anyway, having looked at this closely I think this patch should be
> dropped entirely. I don't understand how this refactoring is meant to
> make the end result easier to read, reason about, or how it helps the
> subsequent patch.

That's my feeling too c.f. 
<19f91fea-a2a9-7dc6-d940-cc10f384fe76@dunelm.org.uk>. This patch has 
improved since that comment on v4 but I still think we'd be better off 
without it.

Best Wishes

Phillip


> In addition to the above diff in 7/7 you do (and that's the change this
> is meant to help):
> 	
> 	 static int match_stat_with_submodule(struct diff_options *diffopt,
> 	 				     const struct cache_entry *ce,
> 	 				     struct stat *st, unsigned ce_option,
> 	-				     unsigned *dirty_submodule)
> 	+				     unsigned *dirty_submodule, int *defer_submodule_status,
> 	+				     unsigned *ignore_untracked)
> 	 {
> 	 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> 	 	struct diff_flags orig_flags;
> 	+	int defer = 0;
> 	
> 	 	if (!S_ISGITLINK(ce->ce_mode))
> 	-		return changed;
> 	+		goto ret;
> 	
> 	 	orig_flags = diffopt->flags;
> 	 	if (!diffopt->flags.override_submodule_config)
> 	@@ -86,11 +92,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
> 	 		goto cleanup;
> 	 	}
> 	 	if (!diffopt->flags.ignore_dirty_submodules &&
> 	-	    (!changed || diffopt->flags.dirty_submodules))
> 	-		*dirty_submodule = is_submodule_modified(ce->name,
> 	+	    (!changed || diffopt->flags.dirty_submodules)) {
> 	+		if (defer_submodule_status && *defer_submodule_status) {
> 	+			defer = 1;
> 	+			*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
> 	+		} else {
> 	+			*dirty_submodule = is_submodule_modified(ce->name,
> 	 					 diffopt->flags.ignore_untracked_in_submodules);
> 	+		}
> 	+	}
> 	 cleanup:
> 	 	diffopt->flags = orig_flags;
> 	+ret:
> 	+	if (defer_submodule_status)
> 	+		*defer_submodule_status = defer;
> 	 	return changed;
> 	 }
> 
> But if I rebase out this 6/7 patch and solve the conflict for 7/7 it
> becomes:
> 	
> 	@@ -65,14 +66,20 @@ static int check_removed(const struct index_state *istate, const struct cache_en
> 	  * Return 1 when changes are detected, 0 otherwise. If the DIRTY_SUBMODULES
> 	  * option is set, the caller does not only want to know if a submodule is
> 	  * modified at all but wants to know all the conditions that are met (new
> 	- * commits, untracked content and/or modified content).
> 	+ * commits, untracked content and/or modified content). If
> 	+ * defer_submodule_status bit is set, dirty_submodule will be left to the
> 	+ * caller to set. defer_submodule_status can also be set to 0 in this
> 	+ * function if there is no need to check if the submodule is modified.
> 	  */
> 	 static int match_stat_with_submodule(struct diff_options *diffopt,
> 	 				     const struct cache_entry *ce,
> 	 				     struct stat *st, unsigned ce_option,
> 	-				     unsigned *dirty_submodule)
> 	+				     unsigned *dirty_submodule, int *defer_submodule_status,
> 	+				     unsigned *ignore_untracked)
> 	 {
> 	 	int changed = ie_match_stat(diffopt->repo->index, ce, st, ce_option);
> 	+	int defer = 0;
> 	+
> 	 	if (S_ISGITLINK(ce->ce_mode)) {
> 	 		struct diff_flags orig_flags = diffopt->flags;
> 	 		if (!diffopt->flags.override_submodule_config)
> 	@@ -80,11 +87,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
> 	 		if (diffopt->flags.ignore_submodules)
> 	 			changed = 0;
> 	 		else if (!diffopt->flags.ignore_dirty_submodules &&
> 	-			 (!changed || diffopt->flags.dirty_submodules))
> 	-			*dirty_submodule = is_submodule_modified(ce->name,
> 	-								 diffopt->flags.ignore_untracked_in_submodules);
> 	+			 (!changed || diffopt->flags.dirty_submodules)) {
> 	+			if (defer_submodule_status && *defer_submodule_status) {
> 	+				defer = 1;
> 	+				*ignore_untracked = diffopt->flags.ignore_untracked_in_submodules;
> 	+			} else {
> 	+				*dirty_submodule = is_submodule_modified(ce->name,
> 	+									 diffopt->flags.ignore_untracked_in_submodules);
> 	+			}
> 	+		}
> 	 		diffopt->flags = orig_flags;
> 	 	}
> 	+
> 	+	if (defer_submodule_status)
> 	+		*defer_submodule_status = defer;
> 	 	return changed;
> 	 }
> 	
> 
> I can see how there's some room for *a* refactoring to reduce the
> subsequent diff, but not by mutch.
> 
> But this commit didn't help at all. This whole "goto ret", and "goto
> cleanup" is just working around the fact that you pulled "orig_flags"
> out of the "if" scope. Normally the de-indentation would be worth it,
> but here it's not. The control flow becomes more complex to reason about
> as a result.
> 
