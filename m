Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4786A211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 01:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbeLCBPl (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Dec 2018 20:15:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50796 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbeLCBPl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Dec 2018 20:15:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 409391B527;
        Sun,  2 Dec 2018 20:15:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=xa32c5kYRe0R
        dkHsfYTes95+X0Y=; b=TthYu4N8Lv1fLnc1gOy/6HmNC1GsaKGece31FIv03FvC
        SVI3RbW6yFq3H3EyfuloxyR0tONWMQX9XjliOPOZ8S3wJXbHu4m97R7IdU8kTd1+
        pgEr5eDCD25yC0khWRcwIadE3+sKoIVgf8st2/qKEgiu8gvppHp2LFiWw9dOF6A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SR9e5N
        uuNKdbPO62u43XZIx25uXoqWQvR/ssDIZhTnew/9r0UwLeBhDxNG7yUN3gTitqWy
        b95ccG/AkQpu4RY/s93BwbG1gCONziCjZU1vyogJMn1jniMqlemrefkbehs7N8NA
        jGT33yU+Dx/cPkY+6CIAO99rwh7FbuyCL4lSo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 38C841B526;
        Sun,  2 Dec 2018 20:15:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 4D5DF1B523;
        Sun,  2 Dec 2018 20:15:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Frank =?utf-8?Q?Sch=C3=A4fer?= <fschaefer.oss@googlemail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
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
        <xmqqk1kwr5tp.fsf@gitster-ct.c.googlers.com>
        <7a4ecc75-2dc4-041b-3d12-46cddae0a27f@googlemail.com>
Date:   Mon, 03 Dec 2018 10:15:31 +0900
In-Reply-To: <7a4ecc75-2dc4-041b-3d12-46cddae0a27f@googlemail.com> ("Frank
        =?utf-8?Q?Sch=C3=A4fer=22's?= message of "Sun, 2 Dec 2018 20:31:47 +0100")
Message-ID: <xmqqmupnh0lo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: EE99CC18-F698-11E8-B6F0-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Frank Sch=C3=A4fer <fschaefer.oss@googlemail.com> writes:

> Hi Junio,
>
> Am 29.11.18 um 03:11 schrieb Junio C Hamano:
> [...]
>> This was misspoken a bit.  Let's revise it to
>>
>>  	When producing a colored output (not limited to whitespace
>>  	error coloring of diff output) for contents that are not
>>  	marked as eol=3Dcrlf (and other historical means), insert
>>  	<RESET> before a CR that comes immediately before a LF.
> You mean
> =C2=A0=C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0=C2=A0 <RESET> *after* a CR that comes immediately be=
fore a LF."
>
> OK, AFAICS this produces the desired output in all cases if eol=3Dlf.

OK, yeah, I think I meant "after", i.e. ... CR <RESET> LF, in order
to force CR to be separated from LF.

> Now what about the case eol=3Dcrlf ?

I have no strong opinions, other than that "LF in repository, CRLF
in working tree" would make the issue go away (when it is solved for
EOL=3DLF like the above, that is).

> Keeping the current behavior of '-' lines is correct.
> But shouldn't ^M now be suppressed in '+' lines for a consistent behavi=
or ?

If "LF in repository, CRLF in working tree" is done, there would not
be ^M at the end of the line, not just for removed lines, but also
for added lines, no?
