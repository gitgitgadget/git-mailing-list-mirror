From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/9] t5520: fixup file contents comparisons
Date: Fri, 15 May 2015 11:37:55 -0700
Message-ID: <xmqq7fs9hekc.fsf@gitster.dls.corp.google.com>
References: <1431508136-15313-1-git-send-email-pyokagan@gmail.com>
	<1431508136-15313-2-git-send-email-pyokagan@gmail.com>
	<xmqqk2wcbmq5.fsf@gitster.dls.corp.google.com>
	<xmqqa8x8bkuc.fsf@gitster.dls.corp.google.com>
	<CAO2U3QgD0-tAwGnMeeMR5aqbUuqDsdWy0Sw8dQBPUpUNwJZpHg@mail.gmail.com>
	<xmqq4mnf8358.fsf@gitster.dls.corp.google.com>
	<CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 15 20:38:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YtKUq-0004JJ-5S
	for gcvg-git-2@plane.gmane.org; Fri, 15 May 2015 20:38:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946051AbbEOSiC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2015 14:38:02 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:36342 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946047AbbEOSh6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2015 14:37:58 -0400
Received: by iepk2 with SMTP id k2so124007283iep.3
        for <git@vger.kernel.org>; Fri, 15 May 2015 11:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=3M6LcHwTnRWU8ku76PLAxjqFwzg4Z4tEqrAWgoL/IBo=;
        b=JcVZuuf/yejTj9IyiNgk+2u79fqD78hha6xPi4kI13gh2c3o51laSrH+Q4/s+mnBm/
         RPiVt/CQxdZN3gf6biLII9yixAGZM83tqVykhazQ6QWEpnTpFY0U/TaUk5v11xwnDhtV
         mQf/todCCWJrl01UZKs/JgbUgBpoK/5Ufn6Vn3nJiMplQFqZHUTL7CjnGbt9FGIg8PmT
         oZ54nuLW3+TpjiDwTPSETgT08kWVWziudihccUQVfUjFmuOPLXqDMSvtPv1rCPCnyrzU
         EFHuUeFc3d1013za26SM2VHAYl3yy7AMQi/pAXjls3IOL+5DFHJ3TIgeHh5oqe0/oxl8
         xo+A==
X-Received: by 10.50.143.97 with SMTP id sd1mr9591553igb.10.1431715077450;
        Fri, 15 May 2015 11:37:57 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1148:d596:44de:a92d])
        by mx.google.com with ESMTPSA id a139sm1672477ioa.14.2015.05.15.11.37.56
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 15 May 2015 11:37:56 -0700 (PDT)
In-Reply-To: <CACRoPnSbekLANNiGOyxN70TCUd1c=wcrU_6Gfew5pp5EBpSEsA@mail.gmail.com>
	(Paul Tan's message of "Fri, 15 May 2015 19:41:39 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269172>

Paul Tan <pyokagan@gmail.com> writes:

> Hi Junio,
>
> On Fri, May 15, 2015 at 1:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Change that 'verbose test' line to
>>
>>         verbose test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
>>
>> i.e. losing the double-quotes around $().
>
> Noted and fixed. Interesting quirk though :-).
>
>> By the way, thanks for a fine demonstration that the 'verbose test'
>> is not very useful.
>>
>> This output
>>
>>> command failed:  'test' '1' '=' '       1'
>
> Personally, I find that the quoting provided by "verbose" helps make
> it clear that it's a whitespace issue, which might be a bit harder to
> spot with the output of set -x I think.

To be fair, yes, because of the leading SP in the RHS, I immediately
knew that this was a "wc -l" from that without running the test one
more time with "-i -v -x".  The "rev-parse --sq-quote" did help.
Without the --sq-quote trick, i.e. "command failed: test 1 = 1",
would actually make the debugger suspect that there would be a
quoting issue anyway, so it is not a very big deal, though.

In any case, that "test 1 = 1" (with or without quoting) helped only
because I had to deal with "wc -l" issues in the past.  Without
telling how that ' 1' ended up compared with '1' by showing "wc -l"
on that 'command failed:' line, it wouldn't have helped much if the
debugger were not me.

> Other than that, I'm also convinced that "verbose" doesn't really
> offer much. Will remove in the re-roll.

Just to avoid misunderstanding, please do not remove 'verbose '
blindly without thinking while doing so, as you already did 1/3 of
the necessary job to make things better.

You might have noticed, while adding them, there were something
common that we currently do with a bare 'test' only because we
haven't identified common needs.  As I already said, it may be that
we often try to see a file has a known single line content (I didn't
check if that were the case; I am just giving you an example) and
only because there is no ready-made test_file_contents helper to be
used, the current tests say

	test expected_string = "$(cat file)"

And if that were the case, it is a good thing to have a new helper
like this

	test_file_contents () {
		if test "$(cat "$1")" != "$2"
		then
			echo "Contents of file '$1' is not '$2'"
                        false
		fi
	}

in t/test-lib-functions.sh and convert them to say

	test_file_contents file expected_string

That would be an improvement (and that is the remaining 2/3 ;-).

Thanks.
