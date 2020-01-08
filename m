Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD93BC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56F720678
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:05:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VoD+xV2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgAHTFi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:05:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63654 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbgAHTFi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 14:05:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4023998BA7;
        Wed,  8 Jan 2020 14:05:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=W09LXSnBNt8L4iI7//NxSP8NhVA=; b=VoD+xV
        2OOFPP/I+kIYBs0Qiv5UciXWzXlxZRhgq3/I6eOLyrb9K4Rm8NfUo9XRR9q1rLJD
        InXmCbe/j7CYKCvCFRXy32BeJn4GJJptvf5RxW8otW0oySlx5sd31cmDm+e8NM9q
        6YYXwwGz9OGyo1s9wnYSJ6ydJq/0lKVFvse5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=H2q3cRA1B7AGPVFHQPz8k4Svlgsq174p
        5ePEZBvY6RVUW8DrLs9qTQQJ6fkxxBBkbm6r/oMoe/TBf+M5h7iPeFEu4jkQ5w+O
        qmZ/57wkxF48tBbMa6BnHYPPH3FpH7pU5sgR/oUxirhbuCwMq1jGsWK7A9ImBkmD
        RiRYu2Ah6II=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24AB398BA6;
        Wed,  8 Jan 2020 14:05:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2D33398BA3;
        Wed,  8 Jan 2020 14:05:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heba Waly <heba.waly@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 1/1] branch: advise the user to checkout a different branch before deleting
References: <pull.507.git.1577933387.gitgitgadget@gmail.com>
        <pull.507.v2.git.1578370226.gitgitgadget@gmail.com>
        <19a7cc1889d6094e4f8a94c19c43ad554662e8d8.1578370226.git.gitgitgadget@gmail.com>
        <CAPig+cQ0qY8KDZrQ8khuz34DqPimorN7JHHn0Ms=KpvJYtxJoA@mail.gmail.com>
        <CACg5j26jyWnAtM+mZ-FuN7OQWHpKk5nADG+7J-=metJMdO6+2Q@mail.gmail.com>
        <CAPig+cTDayF0hHn7wSPGNS8h2qPUYhhg9Z8fY_rLQnWmAg-NKQ@mail.gmail.com>
        <CACg5j260h88bd=W_4EzAn7B0TiU02Y8BzKDQ7w3UJiHkhL60NQ@mail.gmail.com>
Date:   Wed, 08 Jan 2020 11:05:30 -0800
In-Reply-To: <CACg5j260h88bd=W_4EzAn7B0TiU02Y8BzKDQ7w3UJiHkhL60NQ@mail.gmail.com>
        (Heba Waly's message of "Thu, 9 Jan 2020 07:06:26 +1300")
Message-ID: <xmqqwoa122h1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D859EC88-3249-11EA-AFA9-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heba Waly <heba.waly@gmail.com> writes:

> On Wed, Jan 8, 2020 at 10:28 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
>>
>> advice seems simple on the surface, but every new piece of advice
>> means having to add yet another configuration variable, writing more
>> code, more tests, and more documentation
>
> This raises a question though, do we really need a new configuration
> for every new advice?
> So a user who's not interested in receiving advice will have to
> disable every single advice config? It doesn't seem scalable to me.
> I imagine a user will either want to enable or disable the advice
> feature all together. Why don't we have only one `enable_advice`
> configuration that controls all the advice messages?

The advice mechanism was a way to help new people learn the system
by giving a bit of extra help messages that would become annoying
once they learned that part of the system, so by default they are
on, and can be turned off once they learn enough about the specific
situation that gives one kind of advise.  Hence, "[advice] !all" to
decline any and all advice message, including anything that would be
introduced in the future, is somewhat a foreign concept in that
picture.

Having said that, I am not opposed to add support for such an
overall "turn all off" (or on for that matter).  Totally untested,
but something along this line, perhaps?  The idea is that

 - the config keys may come in any order;

 - once advice.all is set to either true or false, we set all the
   advice.* variables to the given value,

 - for any other advice.* config, we interpret it only if we haven't
   seen advice.all



 advice.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/advice.c b/advice.c
index 098ac0abea..b9a8fe1360 100644
--- a/advice.c
+++ b/advice.c
@@ -3,6 +3,8 @@
 #include "color.h"
 #include "help.h"
 
+static int advice_all_seen = -1; /* not seen yet */
+
 int advice_fetch_show_forced_updates = 1;
 int advice_push_update_rejected = 1;
 int advice_push_non_ff_current = 1;
@@ -142,13 +144,22 @@ int git_default_advice_config(const char *var, const char *value)
 	if (!skip_prefix(var, "advice.", &k))
 		return 0;
 
-	for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
-		if (strcasecmp(k, advice_config[i].name))
-			continue;
-		*advice_config[i].preference = git_config_bool(var, value);
+	if (!strcmp(var, "advise.all")) {
+		advice_all_seen = git_config_bool(var, value);
+		for (i = 0; i < ARRAY_SIZE(advice_config); i++)
+			*advice_config[i].preference = advice_all_seen;
 		return 0;
 	}
 
+	if (advice_all_seen < 0) {
+		for (i = 0; i < ARRAY_SIZE(advice_config); i++) {
+			if (strcasecmp(k, advice_config[i].name))
+				continue;
+			*advice_config[i].preference = git_config_bool(var, value);
+			return 0;
+		}
+	}
+
 	return 0;
 }
 
