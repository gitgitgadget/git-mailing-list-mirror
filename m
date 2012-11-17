From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] Add support for a 'pre-push' hook
Date: Sat, 17 Nov 2012 07:39:28 +0100
Message-ID: <50A73120.9040301@alum.mit.edu>
References: <CAJwKrPYwCE4ExmK09PURMfjYezn6vdCH_BBXU4WCwrnotyV9CA@mail.gmail.com> <7vvcd5l290.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Aske Olsson <askeolsson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 07:39:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZc4C-00067h-Gt
	for gcvg-git-2@plane.gmane.org; Sat, 17 Nov 2012 07:39:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433Ab2KQGje (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2012 01:39:34 -0500
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:65177 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751102Ab2KQGjd (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Nov 2012 01:39:33 -0500
X-AuditID: 12074414-b7f846d0000008b8-60-50a7312480a5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id A5.4C.02232.42137A05; Sat, 17 Nov 2012 01:39:32 -0500 (EST)
Received: from [192.168.69.140] (p57A245D1.dip.t-dialin.net [87.162.69.209])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id qAH6dTSf005263
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 17 Nov 2012 01:39:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <7vvcd5l290.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqKtiuDzAoP+RlcWRj1NYLLqudDNZ
	NPReYXZg9tg56y67x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGesOj6JqWCPXMW8l/wNjB0S
	XYycHBICJhKvp8xihrDFJC7cW8/WxcjFISRwmVFi5r0bUM4ZJomd0/8xglTxCmhL/Ht5EayD
	RUBV4tPus+wgNpuArsSinmYmEFtUIExizZ5DTBD1ghInZz5hAbFFBNQkJrYdArOZBawlWuYd
	YQWxhQXMJJZv62QDsYUEqiR6/ywCq+EEip9Zf4cZol5H4l3fAyhbXmL72znMExgFZiFZMQtJ
	2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Vro5WaW6KWmlG5ihISuyA7GIyflDjEK
	cDAq8fAWVS0LEGJNLCuuzD3EKMnBpCTKm6S/PECILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO+G
	7UDlvCmJlVWpRfkwKWkOFiVx3m+L1f2EBNITS1KzU1MLUotgsjIcHEoSvFEGQEMFi1LTUyvS
	MnNKENJMHJwgw7mkRIpT81JSixJLSzLiQZEaXwyMVZAUD9DetyA38RYXJOYCRSFaTzHqcmxY
	3/6EUYglLz8vVUqct0wPqEgApCijNA9uBSxRvWIUB/pYmDcB5BIeYJKDm/QKaAkT0JItMktA
	lpQkIqSkGhgNtReU345dYNpRI5AsYshpvCR8SfzTgj8qUhF74xdfr7oc8iUjsZS38M29lFWH
	/i1tvvdDfF7g5MjJx1h/f9oWV/JF5/LGH1HycT9OFOZ5Hv13uvF12r0nQpXPLO8p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209930>

On 11/16/2012 09:30 PM, Junio C Hamano wrote:
> Aske Olsson <askeolsson@gmail.com> writes:
> 
>> If the script .git/hooks/pre-push exists and is executable it will be
>> called before a `git push` command, and when the script exits with a
>> non-zero status the push will be aborted.
>> The hook can be overridden by passing the '--no-verify' option to
>> `git push`.
>>
>> The pre-push hook is usefull to run tests etc. before push. Or to make
>> sure that if a binary solution like git-media, git-annex or git-bin is
>> used the binaries are uploaded before the push, so when others do a
>> fetch the binaries will be available already. This also reduces the
>> need for introducing extra (git) commands to e.g. sync binaries.
>>
>> Signed-off-by: Aske Olsson <askeolsson@gmail.com>
>> ---
>> ...
>> +[[pre-push]]
>> +pre-push
>> +~~~~~~~~
>> +
>> +This hook is invoked by 'git push' and can be bypassed with the
>> +`--no-verify` option. It takes no parameter, and is invoked before
>> +the push happens.
>> +Exiting with a non-zero status from this script causes 'git push'
>> +to abort.
>> ...
>> + if (!no_verify && run_hook(NULL, "pre-push")) {
>> + die(_("pre-push hook failed: exiting\n"));
>> + }
> 
> NAK, at least in the current form.  At least the system should tell
> the hook where it is pushing and what is being pushed.

I agree.

> Besides, there are five valid reasons to add a new hook to the
> system, but your version of pre-push does not satisfy any of them:
> 
>      http://thread.gmane.org/gmane.comp.version-control.git/94111/focus=71069

Here I disagree.  I think it satisfies (1):

>  (1) A hook that countermands the normal decision made by the
>      underlying command.  Examples of this class are the update
>      hook and the pre-commit hook.

pre-push would be very similar in spirit to pre-commit: pre-commit is a
filter that can prevent a "bad" commit from getting into the local
repository; pre-push is similarly a filter between the local repo and
remote repositories.

I also think it satisfies (2) and/or (5b):

>  (2) A hook that operates on data generated after the command
>      starts to run.  [...]

>  (5) [...]  Another example is the post-checkout
>      hook that gets information that is otherwise harder to get
>      (namely, if it was a branch checkout or file checkout --
>      you can figure it out by examining the command line but
>      that already is part of the processing git-checkout does
>      anyway, so no need to force duplicating that code in the
>      userland).

It would not be trivial for a wrapper script to figure out what branches
and commits are about to be pushed.  But "git push" could tell the hook
script what branches are to be pushed.  And if the pre-push hook is run
after negotiation between client and server of what commits need to be
transfered, the hook could also be provided that information and use it
to figure out which commits it should vet.


Although a pre-receive script on the remote repository could do most of
the same things as a pre-push script, the latter would sometimes have
advantages because it is run "client-side":

* When the user doesn't have the ability to change the pre-receive
script on the server (think public git hosting services).

* For user-specific actions that are not wanted by all users pushing to
the same server (for example, maybe I add the string "WIP" to commit
messages for commits that are not ready to be pushed; my pre-push script
could verify that I don't push such a commit by accident).

* Preventing "secret" info (password files, proprietary branches) from
being pushed.  Even if the remote repo were taught to reject them, they
would have already traversed the internet.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
