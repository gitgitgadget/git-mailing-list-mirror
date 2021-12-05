Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825CFC433EF
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 20:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238658AbhLEU3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 15:29:50 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63157 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238568AbhLEU3t (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 15:29:49 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95C5A17721F;
        Sun,  5 Dec 2021 15:26:21 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sr/fiiYkDeqkQjpKRjjSxMWXKU+gxKzyx2ubed
        TS7LQ=; b=OzdCidr38NF0F9DcJ+zxyKdRP6BtSy/3Bkzw6y0mu6oN0unc0i1R/q
        UHkYgbPSceKjOhIyphxpjXQjeBnK2eFzZjCD7mY4AuV9VmgSjhXyGwk7l6N7bMnw
        8jdIovtgyhJDvdDZhU+AC9JxkRyLKSYitcHE0R8MuiNHK9R8TL+mo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D90617721E;
        Sun,  5 Dec 2021 15:26:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9644B17721D;
        Sun,  5 Dec 2021 15:26:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Altmanninger <aclopte@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: [PATCH v2] grep: clarify what `grep.patternType=default` means
References: <xmqq7dcq62af.fsf@gitster.g>
        <20211205133352.ukucgvynpuvypfnn@gmail.com>
        <xmqqy24ykdel.fsf_-_@gitster.g>
Date:   Sun, 05 Dec 2021 12:26:16 -0800
In-Reply-To: <xmqqy24ykdel.fsf_-_@gitster.g> (Junio C. Hamano's message of
        "Sun, 05 Dec 2021 12:25:06 -0800")
Message-ID: <xmqqtufmkdcn.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99C75592-5609-11EC-AD39-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We documented that with grep.patternType set to default, the "git
grep" command returns to "the default matching behavior" in 84befcd0
(grep: add a grep.patternType configuration setting, 2012-08-03).

The grep.extendedRegexp configuration variable was the only way to
configure the behavior before that, after b22520a3 (grep: allow -E
and -n to be turned on by default via configuration, 2011-03-30)
introduced it.

It is understandable that we referred to the behavior that honors
the older configuration variable as "the default matching"
behavior.  It is fairly clear in its log message:

    When grep.patternType is set to a value other than "default", the
    grep.extendedRegexp setting is ignored. The value of "default" restores
    the current default behavior, including the grep.extendedRegexp
    behavior.

But when the paragraph is read in isolation by a new person who is
not aware of that backstory (which is the synonym for "most users"),
the "default matching behavior" can be read as "how 'git grep'
behaves without any configuration variables or options", which is
"match the pattern as BRE".

Clarify what the passage means by elaborating what the phrase
"default matching behavior" wanted to mean.

Helped-by: Johannes Altmanninger <aclopte@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

1:  39afc16050 ! 1:  b6a542173b grep: clarify what `grep.patternType=default` means
    @@ Metadata
      ## Commit message ##
         grep: clarify what `grep.patternType=default` means
     
    -    Back in the days when the "return to the default matching behavior"
    -    part was written in 84befcd0 (grep: add a grep.patternType
    -    configuration setting, 2012-08-03), grep.extendedRegexp was the only
    -    way to configure the behaviour since b22520a3 (grep: allow -E and -n
    -    to be turned on by default via configuration, 2011-03-30).
    +    We documented that with grep.patternType set to default, the "git
    +    grep" command returns to "the default matching behavior" in 84befcd0
    +    (grep: add a grep.patternType configuration setting, 2012-08-03).
     
    -    It was understandable that we referred to the behaviour that honors
    +    The grep.extendedRegexp configuration variable was the only way to
    +    configure the behavior before that, after b22520a3 (grep: allow -E
    +    and -n to be turned on by default via configuration, 2011-03-30)
    +    introduced it.
    +
    +    It is understandable that we referred to the behavior that honors
         the older configuration variable as "the default matching"
    -    behaviour.  It is fairly clear in its log message:
    +    behavior.  It is fairly clear in its log message:
     
             When grep.patternType is set to a value other than "default", the
             grep.extendedRegexp setting is ignored. The value of "default" restores
    @@ Commit message
     
         But when the paragraph is read in isolation by a new person who is
         not aware of that backstory (which is the synonym for "most users"),
    -    the "default matching behaviour" can be read as "how 'git grep'
    +    the "default matching behavior" can be read as "how 'git grep'
         behaves without any configuration variables or options", which is
         "match the pattern as BRE".
     
         Clarify what the passage means by elaborating what the phrase
    -    "default matching behaviour" wanted to mean.
    +    "default matching behavior" wanted to mean.
     
    +    Helped-by: Johannes Altmanninger <aclopte@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/config/grep.txt ##
    @@ Documentation/config/grep.txt: grep.patternType::
      	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
      	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
     -	value 'default' will return to the default matching behavior.
    -+	value 'default' will use the settings of `grep.extendedRegexp` option
    -+	to choose between `basic` and `extended`.
    ++	value 'default' will use the `grep.extendedRegexp` option to choose
    ++	between 'basic' and 'extended'.
      
      grep.extendedRegexp::
      	If set to true, enable `--extended-regexp` option by default. This

 Documentation/config/grep.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 44abe45a7c..182edd813a 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -8,7 +8,8 @@ grep.patternType::
 	Set the default matching behavior. Using a value of 'basic', 'extended',
 	'fixed', or 'perl' will enable the `--basic-regexp`, `--extended-regexp`,
 	`--fixed-strings`, or `--perl-regexp` option accordingly, while the
-	value 'default' will return to the default matching behavior.
+	value 'default' will use the `grep.extendedRegexp` option to choose
+	between 'basic' and 'extended'.
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
-- 
2.34.1-308-g0a2b0356a8

