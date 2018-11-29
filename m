Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3C81F609
	for <e@80x24.org>; Thu, 29 Nov 2018 02:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbeK2NPD (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 08:15:03 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52449 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeK2NPD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 08:15:03 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9FBFD3AF95;
        Wed, 28 Nov 2018 21:11:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kH9uvmKbN9o2A26tzQD+pm40Hbk=; b=rb74lq
        wtYK+a9FD7nm5llPDHXjJAY0W9hlYHWNcgqdCC2Qpfgc7VbwahBnhwzr5oO3j54N
        S5i62CDUj9T1YQrLzYCxX4wl9xEJ20Aa91P3jytvvJZDw7lN4JkdeZ7Pp2GNuayw
        8bKRRdXDoO3dQ1fviIsHBqoo1LgOMF4L4OJPo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T+hojcUjnQdxW/FUwPfLY2c1SI1lBBrD
        b1Upca5BSuOHwoC7QunAttGlgj0KCDZBZE+Nj8HMrRN7/QRwiHRtJ44mvmBDtBr8
        vAlWzs+myqdbJDEIbKH8ea0L2BX1PmK0lUPUTiRIopwEGGu4/WAygCZi/xo8CmHN
        gni29pvWM9E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 986863AF94;
        Wed, 28 Nov 2018 21:11:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BB4E3AF93;
        Wed, 28 Nov 2018 21:11:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Frank =?utf-8?Q?Sc?= =?utf-8?Q?h=C3=A4fer?= 
        <fschaefer.oss@googlemail.com>, git@vger.kernel.org
Subject: Re: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the ending of the removed line is CR+LF
References: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
        <4dca3f64-4851-6d48-8266-dfe55f597739@kdbg.org>
        <edadf857-2d4b-f058-5e07-286afb312901@googlemail.com>
        <80ffe850-b966-a37b-09bd-44e04d769944@kdbg.org>
        <2858f03b-89a7-be52-501f-55b6d281bebc@googlemail.com>
        <30442f9c-a1cb-4635-d8e3-a301d94a56fd@kdbg.org>
        <xmqqzhtwzghr.fsf@gitster-ct.c.googlers.com>
        <f06b734a-fc8e-221a-c983-f2ab9daba17f@kdbg.org>
        <xmqqva4jv2kc.fsf@gitster-ct.c.googlers.com>
        <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org>
Date:   Thu, 29 Nov 2018 11:11:14 +0900
In-Reply-To: <3e24a770-47fc-50e4-d757-1e4a28dcd019@kdbg.org> (Johannes Sixt's
        message of "Tue, 27 Nov 2018 19:15:31 +0100")
Message-ID: <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DB8DDA2-F37C-11E8-AFED-F5C31241B9FE-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 27.11.18 um 00:31 schrieb Junio C Hamano:
>> Johannes Sixt <j6t@kdbg.org> writes:
>>> Am 26.11.18 um 04:04 schrieb Junio C Hamano:
>>> ... this goes too far, IMO. It is the pager's task to decode control
>>> characters.
>>
>> It was tongue-in-cheek suggestion to split a CR into caret-em on our
>> end, but we'd get essentially the same visual effect if we added a
>> rule:
>>
>> 	When producing a colored output (not limited to whitespace
>> 	error coloring of diff output), insert <RESET> before a CR
>> 	that comes immediately before a LF.

This was misspoken a bit.  Let's revise it to

 	When producing a colored output (not limited to whitespace
 	error coloring of diff output) for contents that are not
 	marked as eol=crlf (and other historical means), insert
 	<RESET> before a CR that comes immediately before a LF.

to exempt CR in CRLF sequence that the contents and the user agree
to be part of the end-of-line marker.

> I wouldn't want that to happen for all output (context lines, - lines,
> + lines): I really am not interested to see all the CRs in my CRLF
> files.

So your CRLF files will not give caret-em.

>> And a good thing is that I do not think that new rule is doing any
>> decode of control chars on our end.  We are just producing colored
>> output normally.
>
> But we already have it, as Brian pointed out:
>
>    git diff --ws-error-highlight=old,new
>
> or by setting diff.wsErrorHighlight accordingly.

Not really.  If the context lines end with CRLF and the material is
not CRLF, I do not think CR at the end of them should be highlighted
as whitespace errors (as we tell to detect errors on "old" and "new"
lines), but I think we still should make an effort to help them be
visible to the users.  Otherwise, next Frank will come and complain
after seeing

	-something
	 some common thing
	+something_new^M

With the suggested change, you can distinguish the following two
(and use your imagination that there are many "some common thing"
lines), which would help the user guide if the file should be marked
as CRLF file, or the contents mistakenly has some lines that end
with CRLF by mistake.  The corrective action between the two cases
would vastly be different.

	-something^M          	-something          
	 some common thing^M  	 some common thing
	 some common thing^M  	 some common thing
	 some common thing^M  	 some common thing
	+something_new^M      	+something_new^M      

Without, both would look like the RHS of the illustration, and with
the "highlight both", you'd only get an extra caret-em on the
removed line, and need to judge without the help from common context
lines.

Besides, --ws-error-highlight shows all whitespace errors, and
showing CR as caret-em is mere side effect of the interaction
between its coloring and the pager.

