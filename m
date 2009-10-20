From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Tue, 20 Oct 2009 13:28:23 -0700
Message-ID: <7viqe9n72w.fsf@alter.siamese.dyndns.org>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com>
 <7vbpk2sg6m.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0910200615x5d487cdk6f50e11c96f2cb6c@mail.gmail.com>
 <7vbpk2ovio.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0910201304j2730e6f3j1ebc5c17be07dd12@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:28:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LJz-0005a3-4H
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbZJTU2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 16:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZJTU2b
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:28:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44831 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751987AbZJTU2a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 16:28:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2AB460E27;
	Tue, 20 Oct 2009 16:28:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=9XWpu0REC2Gl
	p24PPc65jhONj84=; b=GJjN/pHgmnpBQ7DuULlUBSZvMox2FzFj3WM8nnaDpbjZ
	oinw18cZ5oIo8KYVZoFT0mUrKKPsrclphvX6mUxRChHjWQ5UH1LIEmV7grmuiYTS
	HGzn4uWoDrCM5XuTxF7TI+/DrcPhxCyOWzkCjDGRS6CJDfyrK4TNYF0/8GrU2mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Kyjz9S
	UVBIAUA8mgVMFnQ3SrLs1Di9cb2tu/8xSgtRx19SRYFZbDgL3T5TH7uVHoHqZfKw
	Pk6nlTwLDLavRY92CVHhjDymG1sv/swMow3yIBUM3T0c0zM3QT71wSibiXeX5xhO
	EVYo9VdNn7VRa6s9ydZK8NfotK57jnB6Auev0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B375F60E26;
	Tue, 20 Oct 2009 16:28:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B0E3560E22; Tue, 20 Oct
 2009 16:28:25 -0400 (EDT)
In-Reply-To: <fabb9a1e0910201304j2730e6f3j1ebc5c17be07dd12@mail.gmail.com>
 (Sverre Rabbelier's message of "Tue\, 20 Oct 2009 15\:04\:05 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 218A4A28-BDB7-11DE-B525-1B12EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130836>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Tue, Oct 20, 2009 at 11:55, Junio C Hamano <gitster@pobox.com> wro=
te:
>> That is kind of surprising ;-) as I do remember that I never thought=
 about
>> this issue of dealing with the incomplete lines while writing the bl=
ame
>> algorithm. =C2=A0I actually didn't even think about "well this will =
not work
>> because I am ignoring the incomplete lines".
>
> I used the following repo for testing:
>
> $ git init
> Initialized empty Git repository in /home/sverre/code/test/.git/
> $ echo "first line" > test
> $ git add test
> $ git commit -m "initial"
> [master (root-commit) d573d06] initial
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 test
> $ echo -n "second line, no newline" >> test
> $ git add test
> $ git commit -m "second"
> [master 76ad2f9] second
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> Regular output looks good:
>
> $ git blame test
> ^d573d06 (Sverre Rabbelier 2009-10-20 12:30:56 -0500 1) first line
> 76ad2f90 (Sverre Rabbelier 2009-10-20 12:31:57 -0500 2) second line, =
no newline
>
> Porcelain output looks good too:
>
> $ git blame -p test
> d573d06f0dd50148ba8e59bf8f1ef8fa7ee9fc88 1 1 1
> author Sverre Rabbelier
> author-mail <srabbelier@gmail.com>
> author-time 1256059856
> author-tz -0500
> committer Sverre Rabbelier
> committer-mail <srabbelier@gmail.com>
> committer-time 1256059856
> committer-tz -0500
> summary initial
> boundary
> filename test
>         first line
> 76ad2f90bde689a65715e37afd37d45942c74954 2 2 1
> author Sverre Rabbelier
> author-mail <srabbelier@gmail.com>
> author-time 1256059917
> author-tz -0500
> committer Sverre Rabbelier
> committer-mail <srabbelier@gmail.com>
> committer-time 1256059917
> committer-tz -0500
> summary second
> previous d573d06f0dd50148ba8e59bf8f1ef8fa7ee9fc88 test
> filename test
>         second line, no newline


Thanks.

=46or both styles of output, adding an extra LF after "no newline" woul=
d be
necessary to make the output legible (for human) and parsable (for
scripts).

In addition, it would help Porcelains to re-construct the final text if
you added a boolean "incomplete-line" (put it on its own line, immediat=
ely
after "filename test" line).  Then they will know that LF after "second
line, no newline" was not there in the original and was added for
parsability.

I am not sure what we want to do for non-porcelain output (other than
adding the extra LF at the end).  Assuming that they are meant to be re=
ad
by humans (and casual scripts that do not bother reading --porcelain
format), it might be best not to add any extra marking.
