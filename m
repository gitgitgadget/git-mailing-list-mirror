From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase documentation: explain the exit code of custom commands
Date: Tue, 30 Dec 2014 12:54:26 -0800
Message-ID: <xmqqtx0crh8d.fsf@gitster.dls.corp.google.com>
References: <1419892207-26687-1-git-send-email-sbeller@google.com>
	<xmqqr3vhrqjn.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZsQpvNzGPYuS64Cx2hFoozcb2HxU9Chd1__5=kkE-WjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 21:54:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y63oH-0000za-46
	for gcvg-git-2@plane.gmane.org; Tue, 30 Dec 2014 21:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbaL3Uy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 15:54:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51103 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751321AbaL3Uy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 15:54:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDE3C2ADE8;
	Tue, 30 Dec 2014 15:54:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4fUV4pyY7qFKdq19WDRUqTD2V+Q=; b=FIarNr
	XB5wpBn/tt+sFnXml58+IyDk2I5/rTD9I+j0R9qpGDUkMZd7w/I8AsYymmVbvdvw
	1JAqv79vDY1wMXJyLGtdvDa8179hhNVN6FRoasm9w/N4cLTt1so8x+vLarCcvnTb
	8KR8cDv4QBUDNhFArBYiWBcEIiIgraAD0x0Js=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AfbZZtZVJdEGUL1YEjehu4VmhGRIfDTC
	SOyNu5bd0mOhhPfZTg8IuXtV09qdHNLYeOTxeoxBfA43pEFTO70q0SNtQcSYH7A8
	yJ0Y2igIjTEhYZqRxik10QnWfrzqirSV4prrPHkcZEWcj2Me3ywW9Jy9B5HK7rlz
	Na903b+OhCM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C540C2ADE7;
	Tue, 30 Dec 2014 15:54:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31CB32ADE6;
	Tue, 30 Dec 2014 15:54:27 -0500 (EST)
In-Reply-To: <CAGZ79kZsQpvNzGPYuS64Cx2hFoozcb2HxU9Chd1__5=kkE-WjQ@mail.gmail.com>
	(Stefan Beller's message of "Tue, 30 Dec 2014 10:25:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0AE9F110-9066-11E4-A242-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261945>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Dec 30, 2014 at 9:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  Documentation/git-rebase.txt | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>>> index 924827d..ffadb0b 100644
>>> --- a/Documentation/git-rebase.txt
>>> +++ b/Documentation/git-rebase.txt
>>> @@ -372,7 +372,8 @@ idea unless you know what you are doing (see BUGS below).
>>>  --exec <cmd>::
>>>       Append "exec <cmd>" after each line creating a commit in the
>>>       final history. <cmd> will be interpreted as one or more shell
>>> -     commands.
>>> +     commands. Rebasing will stop for manual inspection if the command
>>> +     returns a non zero exit code.
>>>  +
>>>  This option can only be used with the `--interactive` option
>>>  (see INTERACTIVE MODE below).
>>
>> This is not wrong per-se, but I wonder if it belongs here, or
>> "INTERACTIVE MODE below" may be a better place for it.
>
> I asked around in office yesterday for the --exec command and Jonathan
> thought it was documented, but both him and me skimming over the man page
> not find it. Maybe we stopped reading as we'd not expect it deep down
> there any more?
>
> Thanks for pointing out the place where it is documented actually.
>
>>
>> In fact, I notice that "INTERACTIVE MODE below" already touches it,
>> like this:
>>
>>     Reordering and editing commits usually creates untested intermediate
>>     steps.  You may want to check that your history editing did not break
>>     anything by running a test, or at least recompiling at intermediate
>>     points in history by using the "exec" command (shortcut "x").  You may
>>     do so by creating a todo list like this one:
>>
>>     -------------------------------------------
>>     pick deadbee Implement feature XXX
>>     fixup f1a5c00 Fix to feature XXX
>>     exec make
>>     pick c0ffeee The oneline of the next commit
>>     edit deadbab The oneline of the commit after
>>     exec cd subdir; make test
>>     ...
>>     -------------------------------------------
>>
>>     The interactive rebase will stop when a command fails (i.e. exits with
>>     non-0 status) to give you an opportunity to fix the problem. You can
>>     continue with `git rebase --continue`.
>>
>> I further notice that this section mentions various insns you can
>> use in prose, but does not have a list of vocabulary.  A new user,
>> when using "rebase -i" for the first time, will only see a series of
>> "pick"s; there needs to be a short list of the available insns and
>> what each of them do somewhere in the documentation, organized in a
>> way similar to how command line options are listed and explained.
>>
>> As a starting point, here is what I came up with.  I am not
>> committing this to anywhere in my tree yet---this is primarily for
>> discussion.
>>
>> One thing that I find a bit troublesome is that we overuse the word
>> "command" to mean three different things.  In general, when we say
>> "The command does X" in a documentation for individual subcommand,
>> we mean that subcommand (i.e. "git rebase" in this case).  "Replace
>> the command 'pick' with Y" here however refers to an instruction
>> taken from the vocabulary the new list presents here with the word.
>
> I like "instruction" being part of the vocabulary here.
>
>> And "exec stops when the command fails" refers to whatever shell
>> scriptlet you give 'exec' insn with the same word.  This (not just
>> the new text I am introducing, which follows the usage of the words
>> in the existing text, but the way we refer to "command" and mean
>> three different things in the entire text) needs to be cleaned up.
>>
>>
>>
>>  Documentation/git-rebase.txt | 56 ++++++++++++++++++++++++++++++++++----------
>>  1 file changed, 44 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 924827d..718300c 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -509,20 +509,52 @@ By replacing the command "pick" with the
>> command "edit", you can tell
>>  the files and/or the commit message, amend the commit, and continue
>>  rebasing.
>>
>> -If you just want to edit the commit message for a commit, replace the
>> -command "pick" with the command "reword".
>> -
>> +Here are the commands that can appear in the instruction sheet and
>> +their explanations.
>> +
>> +pick <commit> <subject>::
>> +       Replay the named commit on top of the current state.
>
> I remember using git for the very first time (in 2010 to give you some
> perspective)
> and I had trouble with the rebase command in particular. If the
> instruction sheet pops
> up, there is a lot of text and as a novice user I was very unsure what
> I was allowed to
> touch, such that it doesn't break horribly.
>
> In one of the moments I did not think properly through what I was doing,
> I made the following change to the instruction sheet:
>
> -pick deadbee Implement feature XXX
> +pick deadbee file-xyz.c: implement feature XXX/
>
> Notice I did not change the instruction nor the "named
> commit"(deadbee) as you put it.
> I tried to rename the subject line of the commit in place. This did
> not work of course, but still
> picked up the commit the way it was.
>
> I am telling this story now as I am a bit troubled with "named
> commit". It actually means
> the commit with the given sha1 value (side question: Could I also use
> the full git language to
> describe commits like: "pick topicbranch^2~3" ?) The text after the
> abbreviated sha1 seems
> only commentary to me.
>
> So as another thought we may want to introduce a "reword subject
> line", which replaces the
> subject line of the "named commit" by the comment in the rest of the
> line of the instruction sheet.
>
>> +
>> +edit <commit> <subject>::
>> +       Replay the named commit and then stop, so that the user can
>> +       edit the working tree files and "git rebase --continue" to
>> +       record the modified changes made to the working tree files
>> +       while tweaking the log message.
>
> This is not complete. If I edit the working tree files and then "git
> rebase --continue",
> I am told
>     Documentation/SubmittingPatches: needs update
>     You must edit all merge conflicts and then
>     mark them as resolved using git add
>
> The way I see the edit instruction is more like a "stop", so mentally
> I translate
>      pick c0ffeee The oneline of the next commit
>      edit deadbab The oneline of the commit after
>      pick c0ffaaa Another commit
> to:
>      pick c0ffeee The oneline of the next commit
>      pick deadbab The oneline of the commit after
>      stop # change files and amend changes to the previous commit or
> hack&commit new stuff
>      pick c0ffaaa Another commit
>
> How about:
>     Replay the named commit and then stop, such that the user can
>     modify the commit by ammending changes or add new commits in between.
>
>> +
>> +reword <commit> <subject>::
>> +       Replay the named commit and then open the editor to tweak
>> +       the log message (i.e. without modifying the changes made to
>> +       the working tree contents).
>> +
>> +squash <commit> <subject>::
>> +       Modify the current commit by squashing the change made by
>> +       the named commit, and then open the editor to modify the log
>> +       message using existing messages from the current commit and
>> +       the named commit.  The authorship of the resulting commit is
>> +       taken from the current commit.
>> +       See `--autosquash`.
>
> Should this be s/current/previous/. Technically the current commit seems
> correct to me,...

My primary focus was to suggest a way to revamp the overall
structure of the documentation for a better organization, and didn't
think about details of word choice in individual sentences; I wasn't
meaning to come up with the final wording anyway.

> Overall I like that change as it would help finding the behavior for
> exec easier.

Yeah, as long as we can agree that it would make the result easier
to read to revamp the overall structure to have a list of insns and
their description in an enumerated list, I'd be happy ;-).
