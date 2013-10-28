From: Ben Walton <bdwalton@gmail.com>
Subject: Re: [PATCH] Avoid difference in tr semantics between System V and BSD
Date: Mon, 28 Oct 2013 21:12:10 +0000
Message-ID: <CAP30j17Qv7DrrbgZTsCQB8gxsfQTfVy35s9sDkW0=pHz9F+W3Q@mail.gmail.com>
References: <CAP30j17OCrYjsVK+W_TR-g99YmzY3d9TnYfwHXK7+6vPrVjDaQ@mail.gmail.com>
	<1382951633-6456-1-git-send-email-bdwalton@gmail.com>
	<526EA7C8.2020607@kdbg.org>
	<20131028182718.GA4242@google.com>
	<xmqqk3gxfc20.fsf@gitster.dls.corp.google.com>
	<CAP30j179XPZqTGiZuvyZEL94Q14ocas+r8mP_R4gLetWwikkwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	git <git@vger.kernel.org>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:12:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vau6h-0005Qs-H5
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:12:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab3J1VMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:12:12 -0400
Received: from mail-qe0-f50.google.com ([209.85.128.50]:57329 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751042Ab3J1VML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 17:12:11 -0400
Received: by mail-qe0-f50.google.com with SMTP id 1so4411913qee.9
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ByQvDtrzdVyNu7LPizuA5b4LFao4Ii1CYRSDZlXPuVM=;
        b=pjYd3ksmn41vG49blUFaCyuWYpdfFIyFnefRSAAnpKtZARr186ie3P2W7+Sk0hfiYY
         C8aK77ibxu3DmoWz2Z8PpVo/Lr3Ej+I+Ix7J994UKcfeeoyd4cG7MGjarSZsdwYMs9eF
         vdTGVgsIZx6HxjVPrKB5G8xZZ60sEljrc+qkWjPEDkjZolLiV8uvQTztXuKhGe4B88JK
         EzOCWmMp8NdKc4roq4ti0MKGIjaW2qfhqi5hpBelqDEBWfJMvz2UOEMLNfO9A7kPVDiB
         9iukvCCoJQorKV/e7rJ9owuLJ8kTJkjdrK43B1FjAJ88Je8Cl0JVZoZCHyAp89GI/1G/
         MKwQ==
X-Received: by 10.229.109.193 with SMTP id k1mr31967895qcp.9.1382994730563;
 Mon, 28 Oct 2013 14:12:10 -0700 (PDT)
Received: by 10.224.189.12 with HTTP; Mon, 28 Oct 2013 14:12:10 -0700 (PDT)
In-Reply-To: <CAP30j179XPZqTGiZuvyZEL94Q14ocas+r8mP_R4gLetWwikkwA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236863>

On Mon, Oct 28, 2013 at 9:04 PM, Ben Walton <bdwalton@gmail.com> wrote:
> I'm happy to defer to your judgement on this - If you'd like the tests
> wrapped, I'll do so.
>
> Thanks
> -Ben
>
> On Mon, Oct 28, 2013 at 7:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Johannes Sixt wrote:
>>>
>>>> In other tests, we check for prerequisite PERL, i.e., we are prepared
>>>> that perl is not available. Shouldn't we do that here, too?
>>>
>>> I think the tests assume there's a perl present even when the PERL
>>> prereq isn't present already.  E.g.:
>>>
>>>       nul_to_q () {
>>>               "$PERL_PATH" -pe 'y/\000/Q/'
>>>       }
>>>
>>> So in practice the PERL prereq just means "NO_PERL wasn't set", or
>>> in other words, "commands that use perl work".  Maybe something
>>> like the following would help?
>>>
>>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>>>
>>> diff --git i/t/README w/t/README
>>> index 2167125..54cd064 100644
>>> --- i/t/README
>>> +++ w/t/README
>>> @@ -629,11 +629,20 @@ See the prereq argument to the test_* functions in the "Test harness
>>>  library" section above and the "test_have_prereq" function for how to
>>>  use these, and "test_set_prereq" for how to define your own.
>>>
>>> - - PERL & PYTHON
>>> + - PYTHON
>>>
>>> -   Git wasn't compiled with NO_PERL=YesPlease or
>>> -   NO_PYTHON=YesPlease. Wrap any tests that need Perl or Python in
>>> -   these.
>>> +   Git wasn't compiled with NO_PYTHON=YesPlease. Wrap any tests that
>>> +   need Python with this.
>>> +
>>> + - PERL
>>> +
>>> +   Git wasn't compiled with NO_PERL=YesPlease.
>>> +
>>> +   Even without the PERL prerequisite, tests can assume there is a
>>> +   usable perl interpreter at $PERL_PATH, though it need not be
>>> +   particularly modern.
>>> +
>>> +   Wrap tests for commands implemented in Perl with this.
>>
>> Sounds like a sensible thing to address, but I first parsed it as
>>
>>     Wrap (tests for (commands implemented in Perl)) with this.
>>
>> while I think the readers are expected to parse it as
>>
>>    Wrap ((tests for commands) implemented in Perl) with this.
>>

Per the other discussion about replacing all PERL_PATH with a shell
function named perl, should I update this patch to use $PERL_PATH in
the meantime so that it can be batch updated when the function is
added in a separate patch?

Thanks
-Ben
-- 
---------------------------------------------------------------------------------------------------------------------------
Take the risk of thinking for yourself.  Much more happiness,
truth, beauty and wisdom will come to you that way.

-Christopher Hitchens
---------------------------------------------------------------------------------------------------------------------------
