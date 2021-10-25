Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B6DC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20614604E9
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 20:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhJYUOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238292AbhJYUOp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 16:14:45 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0251EC053A6B
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:36:29 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id m26-20020a62a21a000000b0041361973ba7so7012534pff.15
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 12:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zT7/JTMZs8uHX/WCCne/iJxhxiARm1BG+nbYlLrxKRs=;
        b=XrQdg8596LKOkBvP2R+drjk2mPfLVSHjxnRy+OOT8uWsPS5llj2z5kG2a24/mbgMxG
         aMRHk+Ch/taoOHuBO2LSJUz8iQ5MoFr+5IGvWIOQykgqc6yqxfF65uRTQp3M6VlIGOxC
         tCEQRkztpiagiPY16AzbfGyYnZt6zQrHw4BdAvQD0DknuO2vF7K0ROJLXWAmF1ctfiXS
         kPGRDVOHvSwxI40Pnrk8WxT63Il5+NmEV5YUs6pDIq1Rg5H8j1SJUjidxx2jbcnpKQxx
         qob5DY9VJMu3c6E3GBR+DZpJRYgMgzyMpfsj+/50Zv2zTwizSzatcQldXCSgMIatTFZQ
         tlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zT7/JTMZs8uHX/WCCne/iJxhxiARm1BG+nbYlLrxKRs=;
        b=EAaUkWMaVOu72RTQNmgVgKHfI3RfcIw3IPHkEAiq+J9OSoIRFJNmOFx6MEW5YnrnKl
         l7RTMh21HT+DeZtnRovYI008n9n7ew4lpv+rPOULMl1aSteuwF60XdxIwWSutlnxahzN
         C7Nr2BUL13B1fGbG1CgShjaifJPUnw8HAm8w6pgEsTuk565zvdz8O5gPtTmY4WYdaMiv
         oIjZ+05k1akNbY1qM16rHwOSiBASKagcdFiZOGvbt6BMMn2wb6NOyQCj0eM+CZfT3+Eg
         ngdik51VmDNaNtc/C+sHAzDZLRnP6zbzGN5why7QGVM8dtfVLmHhchKpDYZ4Hq57xi0E
         zXVg==
X-Gm-Message-State: AOAM533nJQ5nvc1dIjqkrFwAP/8fYJ8K/Idk7YHcCfu+E3SV10oKX6sm
        svEqSNiPX4qByB1O9ssdFvaRS1KZmsz/5A==
X-Google-Smtp-Source: ABdhPJzi0jssuQBfllJ9w4vMEJn/tcK8nPg5pVRBuvkLFzgEekVGyFBoSbcCj2bYw28zl6EiYz5bf+LWdy11gw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:60d:: with SMTP id
 gb13mr144640pjb.0.1635190588196; Mon, 25 Oct 2021 12:36:28 -0700 (PDT)
Date:   Mon, 25 Oct 2021 12:36:26 -0700
In-Reply-To: <kl6l35opasd1.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lzgqwaocl.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20211013193127.76537-1-chooglen@google.com> <20211019224339.61881-1-chooglen@google.com>
 <20211019224339.61881-3-chooglen@google.com> <xmqqzgr3o4yw.fsf@gitster.g>
 <xmqqtuhbo2tn.fsf@gitster.g> <kl6l35opasd1.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> The caller is remote_get_1(); this funciton was called with
>> "current_branch", which can be NULL until you have a repository and
>> you've called read_config(), but otherwise shouldn't be.

One possible culprit is working with detached HEAD, are you pushing with
detached HEAD?

"current_branch" is allowed to be NULL when HEAD does not point to a
branch. From read_config():

	if (startup_info->have_repository) {
		const char *head_ref = refs_resolve_ref_unsafe(
			get_main_ref_store(repo), "HEAD", 0, NULL, &flag);
		if (head_ref && (flag & REF_ISSYMREF) &&
		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
			repo->remote_state->current_branch = make_branch(
				repo->remote_state, head_ref, strlen(head_ref));
		}
	}

This condition fails in detached head and "current_branch" is not set:

  head_ref && (flag & REF_ISSYMREF) && skip_prefix(head_ref, "refs/heads/", &head_ref)

>> The direct culprit is this part:
>>
>>     const char *pushremote_for_branch(struct branch *branch, int *explicit)
>>     {
>>             if (branch && branch->pushremote_name) {
>>                     if (explicit)
>>                             *explicit = 1;
>>                     return branch->pushremote_name;
>>             }
>>             if (branch->remote_state->pushremote_name) {
>>
>> where the second if() statement used to check "pushremote_name", but
>> now unconditionally dereferences "branch".
>>
To work with branch = NULL, it seems obvious that branch should be
conditionally dereferenced in pushremote_for_branch, i.e.

  - if (branch->remote_state->pushremote_name) {
  + if (brnach && branch->remote_state->pushremote_name) {

However, if you are not using detached HEAD, the problem might be
elsewhere..
