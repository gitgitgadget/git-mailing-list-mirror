From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Fri, 09 Jan 2015 11:29:33 -0800
Message-ID: <xmqqbnm7da76.fsf@gitster.dls.corp.google.com>
References: <1420496573-3260-1-git-send-email-philipoakley@iee.org>
	<xmqqbnmajwd9.fsf@gitster.dls.corp.google.com>
	<1ED88DC1DCC2463782B4F4167DC85D5D@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "GitList" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	=?utf-8?Q?Nguy=3Fn_Th=C3=A1i_Ng=3Fc_Duy?= <pclouds@gmail.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Fri Jan 09 20:29:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y9fFi-0000OA-L8
	for gcvg-git-2@plane.gmane.org; Fri, 09 Jan 2015 20:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbbAIT3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jan 2015 14:29:41 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56984 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751622AbbAIT3l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jan 2015 14:29:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 28A0C2E641;
	Fri,  9 Jan 2015 14:29:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=2Z0uLCifWono
	lv30BGbzpQ9Q+Ns=; b=avsUJILmd+gac3ObNQgs2QbRVshNDMutaaGCotjPXq2Y
	deaIhyfxx6kj9Ee56tFYD1/El0WVpAla09jSSUZ1YwiW9yapLZAJ2Jir/gISV28g
	/Tfs7hgykb2NotmN9Zw0rYypFKqq0sJvJ7WPtOX+UUABsktvc4PTj7iVOwz+MKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=B88J2m
	tU1TsjTvaA0pQXtACHSSfT7pJXws00lViINBh4GNvkDgk+H/bPNqGZX3MV9Z4npO
	w6BGlb0AMWvWbsSghddnjyuN/7HTLYWOdsJR25RoRQ8cIFizObUr+10KxIdLnert
	RcGBbMQCL6cXr5P6siCWt8NOhwtb+pmIENNnA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1CD622E640;
	Fri,  9 Jan 2015 14:29:35 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82BC32E63E;
	Fri,  9 Jan 2015 14:29:34 -0500 (EST)
In-Reply-To: <1ED88DC1DCC2463782B4F4167DC85D5D@PhilipOakley> (Philip Oakley's
	message of "Fri, 9 Jan 2015 08:48:30 -0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D7945A12-9835-11E4-8DCA-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262242>

"Philip Oakley" <philipoakley@iee.org> writes:

>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index 52eeadd..fe179d0 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -375,15 +375,18 @@ This is useful for excluding servers inside a
>>> firewall from
>>>  proxy use, while defaulting to a common proxy for external domains=
=2E
>>>
>>>  core.ignoreStat::
>>> + If true, Git will avoid using lstat() calls to detect if files ha=
ve
>>> + changed. Git will set the "assume-unchanged" bit for those
>>> tracked files
>>> + which it has updated identically in both the index and working
>>> tree.
>>
>> I wonder if this is better stated in two seemingly independent
>> sentences (like your version), or "... if files have changed by
>> setting the assume-unchanged bit ...." to clarify where the setting
>> of the bits to these files come into the big picture, but it is
>> minor.  Either way, I think it is a lot easier to understand than
>> what we have in 'master'.
>
> I had considered a number of different wordings, and wanted to keep
> the tricky parts separate to ease cognition.

Hmph, but wouldn't the result get more confusing, by stating two
"tricky" things in separate sentences without giving any clue to
guess how these two trickies are related?  That is why I suggested
to say the same two things in a way that clarifies that "avoid using
lstat(2)" is the effect and "setting the assume-unchanged bit" is
the underlying implementation detail to cause that effect, i.e.

	If true, Git will avoid using lstat(2) calls to detect if
	files have changed by setting "assume-unchanged" bit for
	these tracked paths that Git has updated identically in both
	the index and in the working tree.

> On a separte note, this patch was a development from the problem
> noticed by S=C3=A9rgio of the different actions of 'git commit .'and =
'git
> commit -a' when --assume-unchanged was used. Did you have any thought=
s
> regarding Duy's patch (05 December 2014 10:56) to his code given in
> $gmane/260865.
>
> I wasn't sure if it had just been missed, or if there was some other
> issue?

I thought the reason why we are discussing this documentation
clean-up (specifically, clarifying that assume-unchanged is a
promise the user makes not to modify the paths marked as such and is
not about telling Git to ignore changes to tracked paths), was
because we agreed that such a change is a wrong thing to do.

It is wrong for at least two reasons.

 - The "I promise not to modify them, so please omit lstat(2)
   assuming that I keep that promise" is a performance thing---we
   shouldn't add more code to cater to people who do not keep that
   promise.

 - Adding one more case of "Git will hide changes to tracked paths
   that you promised not to change" gives more chance to confuse
   users into an incorrect understanding of what assume-unchanged
   bit is about.  By not applying $gmane/260865, we keep one more
   way for the users to notice that the bit is *not* a mechanism
   to hide changes to tracked paths.


>>> +When files are modified outside of Git, the user will need to stag=
e
>>> +the modified files explicitly (e.g. see 'Examples' section in
>>> +linkgit:git-update-index[1]).
>>> +Git will not normally detect changes to those files.
>>> ++
>>> +This is useful on systems where lstat() calls are very slow, such =
as
>>> +CIFS/Microsoft Windows.
>>> +False by default.
>>
>> I think you are trying to make the result more readable by using
>> separate paragraphs for separate conceptual points, but then isn't
>> it wrong to have "False by default" as part of stating which
>> platforms are intended targets?  I wonder if we want to have that
>> last line as its own paragraph instead.
>
> I was happy with it being a simple separate sentence.

I am also _for_ a separate sentence.  But when a set of three
paragraphs, i.e.

	A, something about A, and things about A.

        B, something about B, and things about B.

        C, something about C, and things about C.

and you want to say something X that is not specific to A or B or C,
would you add that X at the end of C's paragraph, resulting in:

	A, something about A, and things about A.

        B, something about B, and things about B.

        C, something about C, and things about C.  X that applies to
        all of A, B and C.

or would it be more clear to see:

	A, something about A, and things about A.

        B, something about B, and things about B.

        C, something about C, and things about C.

        X that applies to all of A, B and C.

was the question.  I think a simple separate sentence should not be
part of the same "In what situations this is useful" paragraph.
