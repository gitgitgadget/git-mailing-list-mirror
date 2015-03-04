From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 2/2] commit/status: show the index-worktree diff with -v -v
Date: Wed, 04 Mar 2015 13:13:57 -0800
Message-ID: <xmqqr3t479ey.fsf@gitster.dls.corp.google.com>
References: <54B8C82E.8000707@drmicha.warpmail.net>
	<33591b47a7ea8cfa23a3bee05fbf8c0ce4a00b3d.1425390756.git.git@drmicha.warpmail.net>
	<xmqqmw3tai1q.fsf@gitster.dls.corp.google.com>
	<54F6E87F.2010605@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ivo Anjo <ivo.anjo@ist.utl.pt>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 04 22:14:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTGcK-0001xQ-Re
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 22:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbbCDVOC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2015 16:14:02 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:54245 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751670AbbCDVOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2015 16:14:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D68883C0E2;
	Wed,  4 Mar 2015 16:13:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9ogk7OgrG2ZzcCQFBQwgqyguw/8=; b=jLybL2
	o9hXeJcMmyyEvqjMxM/VdmntKn/mTLFwGahWtOwdA0mOvcHqzJAkIbMtdx3xGFSA
	rZzehXjvww3S5ZtKwciiU+KbbCIrJfwZ3RzBjeKzFepmgOVE/gPk1IJv6m/5fJuW
	p5na1sPMy0RQBpx3cLTEwzYyg132GgZjKh0wM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X1wb2MvDTUt9A4bDpQKRe6OwQMCzl9Xa
	8dAn4sPV+sxYp7sKmT46KFETvSkYBaW3edidAytkJ+wLGvU7SpXpSDRc7FolKKxz
	8zZSNz4AWqY+jZYqnEzmcBaFezDGkB1bXA7dUZpoJLJ39MuERSjRTksStqny3uyD
	jYs3CoRGfvc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDC943C0E1;
	Wed,  4 Mar 2015 16:13:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1037B3C0DF;
	Wed,  4 Mar 2015 16:13:59 -0500 (EST)
In-Reply-To: <54F6E87F.2010605@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 04 Mar 2015 12:11:59 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5FE14FA4-C2B3-11E4-B6C0-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264777>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 03.03.2015 22:26:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> +diff --git INDEX=staged-for-commit/dir1/modified
>>> WORKTREE=not-staged-for-commit/dir1/modified
>>> +index e69de29..d00491f 100644
>>> +--- INDEX=staged-for-commit/dir1/modified
>>> ++++ WORKTREE=not-staged-for-commit/dir1/modified
>> 
>> This might be OK for a project like Git itself, but I suspect people
>> with long pathnames (like, eh, those in Java land) would not
>> appreciate it.
>> 
>> Wouldn't mnemonic prefix, which the users are already familiar with,
>> be the most suitable tool for this disambiguation?  After all that
>> was what it was invented for 8 years ago.
>
> Well...:
>
>> or it may want to even be like this:
>> 
>> 	diff --git a/A b/A
>>         ...
>>         diff --git to-be-committed/A left-out-of-the-commit/A
>>         ...
>>         diff --git a/B b/B
>>         ...
>> 
>> by using a custom, unusual and easy-to-notice prefixes.
>
> Your idea was to use these verbous prefixes so that one recognizes the
> different types of diffs, and so that we don't need to sort them by file.

Yeah, but I can become wiser over time and change my opinion, no
;-)?

As to pairing the diffs by paths so that c/i and i/w diffs for the
same path come together, which I mentioned in the older message you
quoted, I think what you said in response made sense, i.e. "the
intention was to show the diff for the two categories of changes
which "git status" lists without diff already".  So I'd prefer
showing c/i diff and then optionall i/w diff like you did, without
mixing them together.

> I'm happy with c/,i/ and i/,w/ and without sorting. Maybe we would need
> headings between the two diffs then?

Yup.  The i/w diff is a new thing and a heading before it to explain
what it is would be very helpful for the users to understand what
they are looking at.  A new heading before c/i diff might help but
it may be OK without.  E.g. something along the following lines


    Changes to be committed:
        modified: foo

    Changes left in the working tree:
        modified: bar

    --------------------------------------------------
    Changes to be committed
    diff --git c/foo i/foo
    ...

    
    --------------------------------------------------
    Changes left in the working tree
    diff --git i/bar w/bsar
    ...

    
