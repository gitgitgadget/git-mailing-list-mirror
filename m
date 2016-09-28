Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983171F4F8
	for <e@80x24.org>; Wed, 28 Sep 2016 21:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754361AbcI1V5l (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 17:57:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64944 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754273AbcI1V5j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2016 17:57:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C64640F14;
        Wed, 28 Sep 2016 17:57:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=E
        CPXOjxBab9Bz2BTDjKiXRhV+iE=; b=dy1To/eGmqwfF5Oej5dQ6uVtpH+wGXVWx
        UTEKfOUwVojDtWx6XfjfQwZvSeM38wMn0/zSU+KkamiPlAIVe7hP2zYOlTasI98F
        Y0H18xCQcB5qNimUVw0uNrdFFiHYKoGIlhqzZW+xmmTJWd434JAUXi19TNlGMHsE
        OP2UDMpwlU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=DO2
        YA/s1LTTtpKeuFMLHEHPyfBzHoGjoB8CEWt7cjGRkWWdfiGol/FGYlNL4KpxhLe6
        Dfhhdli/1aQa5TJEb2t1RtvxQuMHIgTqZLVVo7xfkmD9J9ayMYcHZcEO1GhlSDRj
        6r0H9UWiWKezQ//IGay/h/FV/o53XvHCCWgehaCk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43D6E40F13;
        Wed, 28 Sep 2016 17:57:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD5FD40F12;
        Wed, 28 Sep 2016 17:57:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] blame: use DEFAULT_ABBREV macro
Date:   Wed, 28 Sep 2016 14:57:35 -0700
Message-ID: <xmqq4m4zit68.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 91D2506C-85C6-11E6-8ADD-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This does not make any practical difference in today's code, but
everybody else accesses the default abbreviation length via the
DEFAULT_ABBREV macro.  Make sure this oddball codepath does not
stray from the convention.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/blame.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a5bbf91..f618392 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2111,7 +2111,7 @@ static void find_alignment(struct scoreboard *sb, int *option)
 	unsigned largest_score = 0;
 	struct blame_entry *e;
 	int compute_auto_abbrev = (abbrev < 0);
-	int auto_abbrev = default_abbrev;
+	int auto_abbrev = DEFAULT_ABBREV;
 
 	for (e = sb->ent; e; e = e->next) {
 		struct origin *suspect = e->suspect;
-- 
2.10.0-582-gfa57e49

