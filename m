Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA3B3C432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 05:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EB8F60F4F
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 05:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhH0FiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 01:38:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50011 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhH0FiG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 01:38:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3A1EE15A195;
        Fri, 27 Aug 2021 01:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=0Ju4GpmNKcof
        4xG5ms//dqpHBLgw072FtOeg73hiapk=; b=dVqL3AnNSXuPt48e7XNbA+Wyibea
        66PBDjYB9JO+pgjm3enV8StfyKynJuf7dbdzD5uC4s51goBjF5xyo3fnFJItL8AM
        hayxQHWYgRctnHRQMqVcaoKdcrCkiU70mHQtflvlKprDpcjaSG2WwpThSivyeFH3
        RwttAjJoFNrm0GU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3423F15A194;
        Fri, 27 Aug 2021 01:37:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7A81E15A193;
        Fri, 27 Aug 2021 01:37:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH 0/2] fsmonitor: fixup to avoid warnings from pedantic
References: <20210809063004.73736-1-carenas@gmail.com>
        <42dce285-9599-4c7c-d351-44c1e338337e@jeffhostetler.com>
        <xmqqpmumftry.fsf@gitster.g>
        <b554c82a-4da1-9676-4d93-b769ab6bbcbd@jeffhostetler.com>
Date:   Thu, 26 Aug 2021 22:37:13 -0700
In-Reply-To: <b554c82a-4da1-9676-4d93-b769ab6bbcbd@jeffhostetler.com> (Jeff
        Hostetler's message of "Tue, 10 Aug 2021 09:41:07 -0400")
Message-ID: <xmqqsfyvbg8m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D6179864-06F8-11EC-BE52-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 8/9/21 12:49 PM, Junio C Hamano wrote:
>> Jeff Hostetler <git@jeffhostetler.com> writes:
>>=20
>>> On 8/9/21 2:30 AM, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>>>> seen with both clang 12 and gcc 11 in seen (including jh/builtin-fsm=
onitor)
>>>> as of a5a42b9f76 (from Jul 1)
>>>> it should be squashed into the corresponding patch from the series
>>>> as shown
>>>> in the subject and reroll IMHO; notice Junio also has some bandaid s=
parse
>>>> fixes for t/helper/test-touch.c that should be included.
>>>> a similar additional fix for C89 compatibility to be send as a reply
>>>> later
>>>> Carlo Marcelo Arenas Bel=C3=B3n (2):
>>>>     fixup! fsmonitor-ipc: create client routines for git-fsmonitor--=
daemon
>>>>     fixup! fsmonitor--daemon: implement handle_client callback
>>>>    builtin/fsmonitor--daemon.c | 2 +-
>>>>    fsmonitor-ipc.h             | 2 ++
>>>>    2 files changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>
>>> Thanks!
>> Thanks, both.
>> Jeff, I understand that this is planned to be rerolled post release,
>> so I'll not touch these fixups and let yuou worry about them ;-)

Here is what I had to do to work around

 https://github.com/git/git/runs/3438543601?check_suite_focus=3Dtrue#step=
:5:136

I also have another SQUASH??? fix queued on the topic, but I think
you've already seen it.

---
 fsmonitor-ipc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fsmonitor-ipc.h b/fsmonitor-ipc.h
index 837c5e5b64..7e02c7285a 100644
--- a/fsmonitor-ipc.h
+++ b/fsmonitor-ipc.h
@@ -1,6 +1,8 @@
 #ifndef FSMONITOR_IPC_H
 #define FSMONITOR_IPC_H
=20
+#include "simple-ipc.h"
+
 /*
  * Returns true if built-in file system monitor daemon is defined
  * for this platform.
--=20
2.33.0-205-g1b5b9d966b

