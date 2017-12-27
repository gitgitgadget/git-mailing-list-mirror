Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 613411F404
	for <e@80x24.org>; Wed, 27 Dec 2017 19:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751335AbdL0TPZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Dec 2017 14:15:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64302 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751145AbdL0TPY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Dec 2017 14:15:24 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C6668BCE8E;
        Wed, 27 Dec 2017 14:15:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EwMAkEDgHvsk
        dkaVbvkYPz8sVh0=; b=tanW/KJF7Cj3oDtJ7DNorsl5+YxR8Qv/HfUVHnFtVeVl
        eRM4huncVS5mRl3MwqkjzRvCEs5OVLJQhuliW3QSUsX98A/y2Sb6KSTh7/onvcSW
        JvjqGxgbraZjpZ5kde2Z1WXRgW7SeGTlqCGddPNT3a+jrg89s1V2p1ZiHh+lxSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rWJadw
        7iQvc6lpgS4ISx8G7KK6oATzLsn1To2cDyapyLOvhY5om1EjLUIlHukadvlezLMs
        34TU74E5kSOuUQ7Pu2z0c0b7rwFBKiHy59ExrBDlu+JZysDb5iUEe20Yeb2ImYnv
        hldxG/K8lVd5kFIhXSXo1Mt2zGDHxuCoGAAtI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BE7E9BCE8D;
        Wed, 27 Dec 2017 14:15:23 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 29CB7BCE8C;
        Wed, 27 Dec 2017 14:15:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Liam Beguin <liambeguin@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 8/9] rebase -i: learn to abbreviate command names
References: <20171127045514.25647-1-liambeguin@gmail.com>
        <20171203221721.16462-1-liambeguin@gmail.com>
        <20171203221721.16462-9-liambeguin@gmail.com>
        <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
Date:   Wed, 27 Dec 2017 11:15:21 -0800
In-Reply-To: <CACsJy8B3U0_sJeEt+gLy9HJKszO5-uRZsssL3ZFdkKbSM9yWDg@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 25 Dec 2017 19:48:00 +0700")
Message-ID: <xmqqmv24m186.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4989C918-EB3A-11E7-8BC9-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Dec 4, 2017 at 5:17 AM, Liam Beguin <liambeguin@gmail.com> wrot=
e:
>> +static const char command_to_char(const enum todo_command command)
>> +{
>> +       if (command < TODO_COMMENT && todo_command_info[command].c)
>> +               return todo_command_info[command].c;
>> +       return comment_line_char;
>> +}
>
>     CC sequencer.o
> sequencer.c:798:19: error: type qualifiers ignored on function return
> type [-Werror=3Dignored-qualifiers]
>  static const char command_to_char(const enum todo_command command)
>                    ^
>
> Maybe drop the first const.

Thanks.  This topic has been in 'next' for quite some time and I
wanted to merge it down to 'master' soonish, so I've added the
following before doing so.

-- >8 --
From: Junio C Hamano <gitster@pobox.com>
Date: Wed, 27 Dec 2017 11:12:45 -0800
Subject: [PATCH] sequencer.c: drop 'const' from function return type

With -Werror=3Dignored-qualifiers, a function that claims to return
"const char" gets this error:

    CC sequencer.o
sequencer.c:798:19: error: type qualifiers ignored on function return
type [-Werror=3Dignored-qualifiers]
 static const char command_to_char(const enum todo_command command)
                   ^

Reported-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com=
>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 115085d39c..2a407cbe54 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -795,7 +795,7 @@ static const char *command_to_string(const enum todo_=
command command)
 	die("Unknown command: %d", command);
 }
=20
-static const char command_to_char(const enum todo_command command)
+static char command_to_char(const enum todo_command command)
 {
 	if (command < TODO_COMMENT && todo_command_info[command].c)
 		return todo_command_info[command].c;
--=20
2.15.1-597-g62d91a8972

