Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217AFC0015E
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 19:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjGETyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 15:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbjGETyn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 15:54:43 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521EB19BE
        for <git@vger.kernel.org>; Wed,  5 Jul 2023 12:54:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A93B433024;
        Wed,  5 Jul 2023 15:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LXYm2zH1AWWnEU+/g9Od6vItbYJhk3rDyGZntz
        Jrsug=; b=S6PXX01aUvSM0jN0rHL7/dQ4s6jyZRCN+PZC8NmMqE1oAx2YjL2KbQ
        mCngJuFTJ/2hLseo57ZeG1/2UtE4RQezAAjs/UiXtWRMekDsNzDGI/7OWi4MFl7u
        dv13LOJif7mC6glC4L0xsQBnGHMclhZeQXYcsqQ4TkDMc+ACUOQ/c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1BF733023;
        Wed,  5 Jul 2023 15:54:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.233.135.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E86033022;
        Wed,  5 Jul 2023 15:54:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3] t0091-bugreport.sh: actually verify some content of
 report
References: <AN0heSrMCnygWUC5Sh1UA9v2JGtjcxYDKPFE0xUPddGEW29c3w@mail.gmail.com>
        <20230705183532.3057433-1-martin.agren@gmail.com>
        <xmqqv8eyyw2g.fsf@gitster.g>
Date:   Wed, 05 Jul 2023 12:54:28 -0700
In-Reply-To: <xmqqv8eyyw2g.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        05 Jul 2023 12:53:11 -0700")
Message-ID: <xmqqr0pmyw0b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C12D1A4C-1B6D-11EE-921F-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I notice that "git version:" does not have its value on its line.
> Isn't it a bug we would rather fix before writing this "sanity check"
> test, I have to wonder.

 builtin/bugreport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/builtin/bugreport.c w/builtin/bugreport.c
index daf6c23657..af34dd6e1f 100644
--- c/builtin/bugreport.c
+++ w/builtin/bugreport.c
@@ -19,7 +19,7 @@ static void get_system_info(struct strbuf *sys_info)
 	char *shell = NULL;
 
 	/* get git version from native cmd */
-	strbuf_addstr(sys_info, _("git version:\n"));
+	strbuf_addstr(sys_info, _("git version: "));
 	get_version_info(sys_info, 1);
 
 	/* system call for other version info */
