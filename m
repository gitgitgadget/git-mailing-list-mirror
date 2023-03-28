Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01619C76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 14:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjC1OEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1OET (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 10:04:19 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9E6C650
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:03:04 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o2so11751070plg.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680012167;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HkLNbb3R6R5EOeupHUL0fRYt1fFuyBx9NbrhIHcHTZk=;
        b=ioMD+4WVujvdHQsvFcrbMIEc++tGvAPhKaHRHq3mPzBy4gAex3MBjS7ieRVGGf5h8X
         1Dj2mtqCdXnbFsoPjqReDDUty6AUwUnb8iAW50OzyObJfx3K1Kdsp2jgF97eri5pCz3M
         OikFic4A4+un6Hqzad9XkYcNYugfzRsQYVqrmdjb4FmcV3d9CENX5hjIPQgUz9F7LL9t
         1JgYDp31JXiPi/64cD/k93kPF5Rl/AbwM3NLnEBdAY+ogxCMFOXMdz9pORAp4DkyaqI3
         qgNZ6gzDC7bqufl7dED+EoOlGLxn5hf3AfSEJ56LAYkiV8QaAbeVkoSLSmzaVrp+iMVX
         PUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012167;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HkLNbb3R6R5EOeupHUL0fRYt1fFuyBx9NbrhIHcHTZk=;
        b=F/lju+rZCPmZknrI4BH6sK0K0uY2HwrsH3hqIU5hW/dT+3vWlN0XNZdO6WQed2JPQe
         zT7TTFnNByWT+gRZVWENO8Pin/+5kDcZ167UTNw82D1n/Ircs4RGcu0K/8DEOuLojN3y
         cQ7iWaOr0DrQTueIriHNtYMTsCz4p0iICOiyGSkbIusv5kEKgor6hy1RgwTuw4bJCcEv
         FR0oAzb0lDwTAz7b0VE8OXA0rPgTt8ChsvG2bB0w0hmkzkJu2FOEavmburhkNdyvLSZr
         GxjwNQajdjcnET1pCXINgN/xNY/B+mg6Q5CUY466ZI65Qzp9CMPFPeqnzy9gTdHavg9J
         VJZw==
X-Gm-Message-State: AAQBX9ev6AhmpLv0Ok0zGnDS9knEtMDDOYcfEeEtf0N9sDTvk6lgHl8P
        P5x8++QPqQseNl1JzXN+pilov9XuC6s=
X-Google-Smtp-Source: AKy350YV0x8c5mFa0AqenMGhk/XPhqBkqBDdlc37aHVu5MoJiuBwpxiisnM8sFfq499iohefr83Tng==
X-Received: by 2002:a17:902:d101:b0:1a1:c671:8bc9 with SMTP id w1-20020a170902d10100b001a1c6718bc9mr12574863plw.7.1680012167473;
        Tue, 28 Mar 2023 07:02:47 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b0019cbec6c17bsm21163045plg.190.2023.03.28.07.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:02:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] sequencer: beautify subject of reverts of reverts
References: <20230323162234.995465-1-oswald.buddenhagen@gmx.de>
Date:   Tue, 28 Mar 2023 07:02:46 -0700
Message-ID: <xmqqtty5ht2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..853b4ed334 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2234,6 +2234,9 @@ static int do_pick_commit(struct repository *r,
>  		if (opts->commit_use_reference) {
>  			strbuf_addstr(&msgbuf,
>  				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
> +		} else if (starts_with(msg.subject, "Revert \"")) {
> +			strbuf_addstr(&msgbuf, "Reapply ");
> +			strbuf_addstr(&msgbuf, msg.subject + 7);
>  		} else {
>  			strbuf_addstr(&msgbuf, "Revert \"");
>  			strbuf_addstr(&msgbuf, msg.subject);

Two and half comments:

 * The hard-coded +7 looks fragile.  Perhaps use skip_prefix?

 * During transition to introduce a new version of Git with this
   feature, when reverting an existing revert of a revert, care must
   be taken.  Such a commit would begin as

	Revert "Revert ...

   and turning it to

	Reapply "Revert ...

   may not be a good way to label such a reversion of a double
   revert without end-user confusion.  As it is very likely that
   such a reversion commit was created by existing versions of Git,
   the easiest and least confusing way out would be to notice and
   refrain from touching such a commit.

 * The change lacks tests.

Removal of hardcoded +7 (i.e. the first point) may look like this.

 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git i/sequencer.c w/sequencer.c
index 853b4ed334..520113ec63 100644
--- i/sequencer.c
+++ w/sequencer.c
@@ -2227,6 +2227,8 @@ static int do_pick_commit(struct repository *r,
 	 */
 
 	if (command == TODO_REVERT) {
+		const char *original_title;
+
 		base = commit;
 		base_label = msg.label;
 		next = parent;
@@ -2234,9 +2236,9 @@ static int do_pick_commit(struct repository *r,
 		if (opts->commit_use_reference) {
 			strbuf_addstr(&msgbuf,
 				"# *** SAY WHY WE ARE REVERTING ON THE TITLE LINE ***");
-		} else if (starts_with(msg.subject, "Revert \"")) {
+		} else if (skip_prefix(msg.subject, "Revert \"", &original_title)) {
-			strbuf_addstr(&msgbuf, "Reapply ");
+			strbuf_addstr(&msgbuf, "Reapply \"");
-			strbuf_addstr(&msgbuf, msg.subject + 7);
+			strbuf_addstr(&msgbuf, original_title);
 		} else {
 			strbuf_addstr(&msgbuf, "Revert \"");
 			strbuf_addstr(&msgbuf, msg.subject);
