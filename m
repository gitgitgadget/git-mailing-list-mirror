From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] - Updated usage and simplified sub-command action invocation
Date: Fri, 11 Jan 2008 17:38:57 -0800
Message-ID: <7vk5mfzutq.fsf@gitster.siamese.dyndns.org>
References: <1199938045-16289-1-git-send-email-imyousuf@gmail.com>
	<7v8x2y8ahw.fsf@gitster.siamese.dyndns.org>
	<7bfdc29a0801092251p3d46a3cau3db4d57c4f705043@mail.gmail.com>
	<7vzlve6t69.fsf@gitster.siamese.dyndns.org>
	<7bfdc29a0801092341j60dcb081xe4bf6c22cbaf30f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Imran M Yousuf" <imyousuf@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 02:39:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDVLa-0002gN-HY
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 02:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762797AbYALBjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2008 20:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762613AbYALBjO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jan 2008 20:39:14 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64174 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757472AbYALBjO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2008 20:39:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B0EC93EAB;
	Fri, 11 Jan 2008 20:39:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 30A4D3EAA;
	Fri, 11 Jan 2008 20:39:10 -0500 (EST)
In-Reply-To: <7bfdc29a0801092341j60dcb081xe4bf6c22cbaf30f2@mail.gmail.com>
	(Imran M. Yousuf's message of "Thu, 10 Jan 2008 13:41:08 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70246>

"Imran M Yousuf" <imyousuf@gmail.com> writes:

>> > Actually module_$command is not possible because only add's module is
>> > module_add rest are modules_$command....
>>
>> Is there a fundamental reason why you cannot rename them to be
>> more consistent?
>
> In fact it is consistent, add works on a single module only, whereas
> rest of the command works either on 1 or more. Thus having plural
> (modules) is logical.

It certainly is consistent in _that_ meaning of the word, but I
was not talking about that consistency, which is less useful in
this context.

The consistency I was talking about was "A subcommand called $foo
is always handled by a shell function called cmd_$foo".  That is
also a consistency, and it is of much more useful kind in a
situation like this, namely, a command dispatcher.

If you have show_blobs() and show_commit() subroutines, former
of which takes 1 or more blobs while the latter of which can
only take 1 commit, being consistent in your meaning might help
the programmers avoiding a mistake to pass two or more commits
to a non-existent show_commits().  In that sense, your kind of
consistency is not totally useless.

However, it is not so useful in a context where there is one
call site for each of the functions, like a command dispatcher
scenario.
