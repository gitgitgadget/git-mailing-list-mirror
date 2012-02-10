From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] Move git_version_string to help.c in preparation for
 diff changes
Date: Thu, 09 Feb 2012 16:46:33 -0800
Message-ID: <7vipjftt06.fsf@alter.siamese.dyndns.org>
References: <1328831921-27272-1-git-send-email-zbyszek@in.waw.pl>
 <1328831921-27272-2-git-send-email-zbyszek@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Fri Feb 10 01:46:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvedN-0007K6-9j
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 01:46:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758718Ab2BJAqh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 19:46:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56095 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758658Ab2BJAqg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 19:46:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6502261EA;
	Thu,  9 Feb 2012 19:46:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=+rPpd8Wfld97
	HgPWBvD5CqkezKk=; b=n5dHdZAm8UsULu4lwqnnMDZEDGO6QVBJwO3DOLi8zuyC
	FdBxKHdXPVv+8QFrNl6xqXcHoMumNKnXoEUmEMReVKLG66lT61tLI96yiVFbi1I3
	1R3RaV/nCejKSWGAPLHV/o1PBRgnpgBW6k0EAv4eQYov1i6rG+UoaPeugLhADAc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kmQ/8Y
	SuCk5S/uXsF1ioPt5X2zgjJet8gE41I4KWZ2Vl24d3fUWobR73GFdkbMieCWy60F
	3BnxRB3qIbVOyt/Uq18MnWHVrDqa+Dri+M3yYEFRjsA/33GuEwVn/00Dr/4DuZGt
	H9VoQD7ADbeZmXcjfAzCA7I6NyqajZCVB2sjg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C0AB61E9;
	Thu,  9 Feb 2012 19:46:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E816361E8; Thu,  9 Feb 2012
 19:46:34 -0500 (EST)
In-Reply-To: <1328831921-27272-2-git-send-email-zbyszek@in.waw.pl> ("Zbigniew
 =?utf-8?Q?J=C4=99drzejewski-Szmek=22's?= message of "Fri, 10 Feb 2012
 00:58:38 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AEB18A5E-5380-11E1-A515-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190355>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> git_version_string is declared in builtins.h, but lived in git.c.
>
> When diff.c starts to use functions from help.c, linking against
> libgit.a will fail,  unless git.o containing git_version_string is
> linked too.

Sorry, it is unclear what you mean by the above, nor why you need this
change in the first place. The resulting diff.o will certainly linked t=
o
git.o as it does not have its own "main()" at all.  And builtins.h is a
perfect place to declare things that are for the use of built-in comman=
ds
like implementations of diff family of commands, as they all are linked
into git.o (namely the commands[] array in handle_internal_command()) t=
o
be usable.

What am I missing from between the lines of your log message?
