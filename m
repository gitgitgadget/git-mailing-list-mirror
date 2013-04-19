From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 12:24:20 -0700
Message-ID: <7v8v4e1fyz.fsf@alter.siamese.dyndns.org>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvym30t8.fsf@alter.siamese.dyndns.org>
	<CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 21:24:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTGv7-0007ZM-1n
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753890Ab3DSTYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:24:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753711Ab3DSTYY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:24:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B787D1884A;
	Fri, 19 Apr 2013 19:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CE1gpRYBwhjTRMQOM5sAR0vAAxE=; b=QkngEQ
	vwFEIFV31vcizG/3K5/m5WbG6VzRRpkIBoAWNhJZ9uPP/4DeExMYZ7HfjHGkJW1f
	nBgDtK7F5DG0irxvABTy8YCekwZPmhi1GLHjE1j0sUx2doAKfg4713MPhWyx9er7
	1MZ04oHarbDRz5on5XQipqu8G47MP8lUrwA3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pXnQBWXWhuwU3snW+Y7OD+1kP8vlewnx
	4SuJ8j9gnsjSSIZATj2JPFseUJyoKiCVWjDyVz1f7lT2DKdrlTFBiIAOBDE2yFWP
	CSuPUgTlXgnq7PG+MYlCRN0ACLpVCvwO66gc+EcgUlY6ubtlmC6brGsnykrHw4Tj
	EQxmkdcgS2s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD5AD18849;
	Fri, 19 Apr 2013 19:24:22 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 090D318847;
	Fri, 19 Apr 2013 19:24:21 +0000 (UTC)
In-Reply-To: <CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 19 Apr 2013 12:35:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD122B42-A926-11E2-A4AE-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221796>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Fri, Apr 19, 2013 at 12:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>> The code finds the changes of a commit, runs 'git blame' for each chunk
>>> to see which other commits are relevant, and then reports the author and
>>> signers.
>>
>> In general, I am not all that interested in adding anything new to
>> contrib/ as git.git has matured enough, but even if this will stay
>> outside my tree, there are a few interesting things to note to help
>> its eventual users.
>
> Why not add it to mainline git then? This tool, or a similar one,
> would certainly be useful in the git arsenal.

As to this particular "feature" (the goal it tries to achieve, not
necessarily the implementation), that actually was the first thing
that came to my mind.  It helps the "develop, review locally,
format-patch, decide whom to ask reviews and then send it out"
workflow in general to have a tool that tells you who are the people
involved in the code you are touching.

If this were _only_ to be used within send-email (i.e. replacing the
"then send it out" above with "then use send-email" to limit the
usecase), "git cc-cmd" would be a reasonable name.  But if that is
the intended use case, it would even be more reasonable to make this
logic part of send-email and trigger it with --auto-cc-reviewers
option or something.

But I think it can be useful outside the context of send-email as
well, and having one independent tool that does one single job well
is a better design.  Perhaps it is better to name it less specific
to send-email's cc-cmd option.  "git people"?  "git whom"?  "git
reviewers"?  I dunno, but along those lines.

It is OK for a design demonstration prototype to be written in any
language others (who can comment on the design) can read, but the
version to be a first-class citizen needs to be written in one of
the languages such as C, POSIX shell, or Perl to avoid adding extra
dependencies to the users.
