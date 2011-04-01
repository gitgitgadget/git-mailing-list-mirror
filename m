From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] sha1_name: Suggest commit:./file for path in subdir
Date: Fri, 01 Apr 2011 12:11:37 -0700
Message-ID: <7vfwq1g51y.fsf@alter.siamese.dyndns.org>
References: <4D94322A.8030409@drmicha.warpmail.net>
 <4ff35194dc52fa969049f555f8d9358cb7ba0c1a.1301562935.git.git@drmicha.warpmail.net> <7vsju3jdm2.fsf@alter.siamese.dyndns.org> <4D957648.8070008@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5jlF-0004IP-UI
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 21:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057Ab1DATLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 15:11:53 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33582 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750767Ab1DATLw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 15:11:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C1F574FDA;
	Fri,  1 Apr 2011 15:13:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gQ1IkXwYBhrendsbRBoRHpQNDo0=; b=D23a4C
	5V7yFmzqksdC9pkKT2mQ+2N0ppBPtyPYil4R1Xax1Iy+wycMRRuvAT81+aPgVKXI
	WErJNxljYsMpUWAJkd5kQMo9rQ6g6QB/r59P6DOqH4tXCpUyTlB2gguMUFMtj5hm
	tOR+WllvrY83tXOi05AetRwAQscJCP0p0eB38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H73uOVD30CMcPr/3DgDQYGQKlvVNKPEt
	Xu6udQ2R9w1qn+CNBcc6iyEXLI0hqHywOZl+sgLuPkb22PcV6awLtgqqmV8lqkul
	aCvdIFGH5C2Qx8FQP6VFnMEhv+ZinQ1liZLPij/Ibinv5mkjnqYTPdHTqRoZ80TA
	P9UNiQHqFrw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 889F84FD8;
	Fri,  1 Apr 2011 15:13:35 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 565E44FD7; Fri,  1 Apr 2011
 15:13:30 -0400 (EDT)
In-Reply-To: <4D957648.8070008@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 01 Apr 2011 08:52:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23EF3F12-5C94-11E0-ADDC-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170607>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 31.03.2011 21:26:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>> 
>>> Currently, the "Did you mean..." message suggests "commit:fullpath"
>>> only. Extend this to show the more convenient "commit:./file" form also.
>> 
>> If we were to do this, I suspect that with non-empty prefix we should only
>> show "./$file" form for brevity without aka.  This is a end-user facing
>> message and not meant to help scripts, no?
>
> ENOPARSE

Sorry.  What I meant was to show only "$commit:./$file" (with $commit and
$file substituted appropriately so that the user can cut&paste from the
output) when we issue this advice in a subdirectory.

This is meant to be a direct and immediate advice to the user who typed it
from the command line to tell what he might meant.  It is beneficial to
teach the user that there are two different ways to spell it, and that in
different contexts one of these two ways may be easier to use over the
other way, but this is not a place to do so.

We know the context and what the user wanted to do (iow, the command is
run in a subdirectory, and we already guessed that the user probably
wanted to name the path in that subdirectory), so we already know between
two forms, ./$path_around_here form, not the $prefix/$path_around_here
form, is more appropriate, no?
