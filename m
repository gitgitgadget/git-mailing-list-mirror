From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Thu, 16 Apr 2015 06:35:04 -0700
Message-ID: <xmqq618wjiwn.fsf@gitster.dls.corp.google.com>
References: <552E9816.6040502@gmail.com>
	<1429117174-4968-1-git-send-email-karthik.188@gmail.com>
	<xmqqtwwhjg8b.fsf@gitster.dls.corp.google.com>
	<xmqqiocxjeqn.fsf@gitster.dls.corp.google.com>
	<552F6429.9050304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sunshine@sunshineco.com
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 16 15:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yijwp-0004Zv-KP
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 15:35:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757434AbbDPNfN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 09:35:13 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59669 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755242AbbDPNfK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 09:35:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E5FA74817A;
	Thu, 16 Apr 2015 09:35:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+5gfvM6Kjyc3ji9GleaU2JiYGuQ=; b=KFeZ3b
	OW/hBw48TY2AoVAVD0IVK3Upb3A+rI7DhjVpdUfpu5OoBnqdCtXItI0oUQE19Q2w
	X77sSkRIGos6RI4YKZ/tibaQadM8fSLkk4Hur3iQd07dm2PgY0y4/j7lhtUonlJq
	zsP23qEcahbiad6rKEpWVjrAgbDfI8OQ9MpnA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UnBCyb77pcbiy9b1qUmC+hIsZQCo84PV
	GeoplXQThMqpHELkwFXox1FzjPK2fSOPZPacW72MkcfaIXwSQYVFjvL5dSV1XjtU
	Uv9XnTsl9egXZCOgeAJ0O7yneu9sY47apF/qpaquF9L8GduKedT4ImwujSsxGTOj
	aWwO1BjY9Gs=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DF0C148179;
	Thu, 16 Apr 2015 09:35:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 694E048170;
	Thu, 16 Apr 2015 09:35:05 -0400 (EDT)
In-Reply-To: <552F6429.9050304@gmail.com> (karthik nayak's message of "Thu, 16
	Apr 2015 12:56:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 64477644-E43D-11E4-8B5F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267287>

karthik nayak <karthik.188@gmail.com> writes:

> On 04/16/2015 02:22 AM, Junio C Hamano wrote:
>
>> This is a tangent, but while we are in the vicinity, we may want to
>> rethink the help message we attach to the '-e' option.  Technically
>> the current message is _not_ wrong per-se, but it misses the point.
>> The primary thing the option does is to check the (e)xistence of the
>> named object, and the fact that it does so silently is merely a
>> detail of the operation.  The current help text omits the more
>> important part of what the option is.
>
> Would you rather check '-e' and go on to check '-p' or do you merely
> just want a different message.

I meant just a different message.  The point of -e is to see if the
thing exists.  It is good to mention _how_ the result is reported
back to the user (i.e. via the exit code, not via an output to the
standard output "exists" vs "missing", for example), but that is
secondary.  Telling how it reports is meaningless without telling
what it reports in the first place.

> ... when a user is giving the '-e' option he just expects a silent
> output if the object exists, hence we rather have the option '-e'
> behave as a mutually exclusive option...

Yes, and that is in line with the switch to OPT_CMDMODE.
