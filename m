Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE409C54FD0
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4A4E2076C
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 19:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fTO2N4TX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgDWTiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Apr 2020 15:38:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59033 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgDWTiY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Apr 2020 15:38:24 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5C88165470;
        Thu, 23 Apr 2020 15:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UoPmWhrJO9r5
        1pNvVFU3eyrTJ3A=; b=fTO2N4TX3pjZl8qcydR6xlNFrtja4H0tRuHO7d73HYN/
        fxxPaMyK4v4EsxtQq37IAnGgkHKBShHVRXh9HcKboXISoGnlfzANxWL9qdCGLe+P
        bAVwxaaDtIxzCOSk2+vTn6KAe26+8k2iB9DB7b8TVjz3Q7hpy1U5nfKqg6yalis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=xD84h+
        umN6ejfJ4EaHYuJ1FGQgRgrc8ArcTxrGGXkc1t2v/1M6fgJnoIZqPu/6nhnM2+CF
        c279FEGlBcuWiXYYfuGiLaz5wJdob2894d6bKUFmnsGVQBuaNhpes3uLrXlPymyS
        UPGEgRqfbAkmI1b7fg6JMwa4yapF/w5RnLNGI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 546AA6546F;
        Thu, 23 Apr 2020 15:38:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CAA646546E;
        Thu, 23 Apr 2020 15:38:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Cc:     "Raymond E. Pasco" <ray@ameretat.dev>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2] ssh: add 'ssh.keyfile' option
References: <20200423064110.77258-1-ray@ameretat.dev>
        <20200423112110.45405-1-ray@ameretat.dev>
        <AM0PR04MB47715A57B110E14D6631EACDA5D30@AM0PR04MB4771.eurprd04.prod.outlook.com>
Date:   Thu, 23 Apr 2020 12:38:21 -0700
In-Reply-To: <AM0PR04MB47715A57B110E14D6631EACDA5D30@AM0PR04MB4771.eurprd04.prod.outlook.com>
        ("Matthias =?utf-8?Q?A=C3=9Fhauer=22's?= message of "Thu, 23 Apr 2020
 20:03:26 +0200")
Message-ID: <xmqqeesegfgy.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FD8B99A4-8599-11EA-AB6D-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthias A=C3=9Fhauer <mha1993@live.de> writes:

>>+		switch (variant) {
>>+		case VARIANT_AUTO:
>>+			BUG("VARIANT_AUTO passed to push_ssh_options");
>
> Why do we keep replicating this all over push_ssh_options? The wording
> very much sounds like it's a bug whenever VARIANT_AUTO gets passed to
> push_ssh_options, no exceptions. In that case ...

My reading of the code tells me that it is *not* the case.  When the
caller asks to connect only over IPv4 with CONNECT_IPV4 bit set in
the flags, we cannot translate that to an option to underlying SSH
implementation without knowing the variant.  As long as the caller
does not specify IPV4/IPV6 or custom port, I think it is OK for the
caller to leave the variant AUTO.

So you probably want a patch along the lines of...

 connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/connect.c b/connect.c
index b6451ab5e8..b02cf74c9a 100644
--- a/connect.c
+++ b/connect.c
@@ -1118,7 +1118,7 @@ static void push_ssh_options(struct argv_array *arg=
s, struct argv_array *env,
 	if (flags & CONNECT_IPV4) {
 		switch (variant) {
 		case VARIANT_AUTO:
-			BUG("VARIANT_AUTO passed to push_ssh_options");
+			BUG("VARIANT_AUTO and CONNECT_IPV4 used together");
 		case VARIANT_SIMPLE:
 			die(_("ssh variant 'simple' does not support -4"));
 		case VARIANT_SSH:
