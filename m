From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: do not cleanup template
Date: Sat, 07 May 2011 15:31:40 -0700
Message-ID: <7vei4auoqb.fsf@alter.siamese.dyndns.org>
References: <1304783624-9919-1-git-send-email-billiob@gmail.com>
 <7vwri2uv4m.fsf@alter.siamese.dyndns.org>
 <BANLkTinvwjoa4z2JEiuPD44BV2V_m50VYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org
To: "Boris 'billiob' Faure" <billiob@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 08 00:32:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIq2f-0002h4-JW
	for gcvg-git-2@lo.gmane.org; Sun, 08 May 2011 00:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756143Ab1EGWbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2011 18:31:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62136 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029Ab1EGWbr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 18:31:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBABE4FC4;
	Sat,  7 May 2011 18:33:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X64KTKwbrecKrKuzYwF3KiAHdtw=; b=NslfCZ
	3OLRAqBWXhZA8r3JUuQSmkEaO+a93QAFe25f/XO8c72KFzrSenrUNwzUqwgDIxX9
	ygM5cMSZK0rsCG0leB4IZw+JhM1VxOkwNocJSBIYRFGpcYfC/ldhVQdhf8HvKYGP
	CO5yC90XsmjhO5EGtJCAythvK2YvqTrD1sGXI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dE0pAXSTTKKyPxMdRcl2uquJP+4rxkQD
	h/W5Wgilm3Cb28zVdluxLmCnliV2LHuWHpHCPL0i+BVoYHu5rmyxRMewjtMT9x0l
	xvuhq/+L7Si9iBXIHYr0uURRJoTxlStzO2T9WsOtZCt68G1ExnBYkpewL8ZO94s4
	D56PqZTcp1k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 98A234FC3;
	Sat,  7 May 2011 18:33:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A9F924FC2; Sat,  7 May 2011
 18:33:46 -0400 (EDT)
In-Reply-To: <BANLkTinvwjoa4z2JEiuPD44BV2V_m50VYQ@mail.gmail.com> (Boris
 Faure's message of "Sat, 7 May 2011 23:17:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 14192F3A-78FA-11E0-9F07-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173070>

"Boris 'billiob' Faure" <billiob@gmail.com> writes:

> On Sat, May 7, 2011 at 22:13, Junio C Hamano <gitster@pobox.com> wrote:
>> […]
>> My gut feeling is that it is relatively easy to justify [1/2]. We prepare
>> the message file to be edited by the committer in sb by reading from
>> different message sources, and usually we would want to clean up what is
>> in sb before writing it out, but you may want to enforce a particular
>> format by using the template (such as having a leading whitespace) and the
>> way to tweak and fix that appearance should be by editing the template,
>> not by automatically running stripspace() here [*1*] when the message came
>> from the template.
>
> That's exactly my point of view.

Please describe these things in the proposed commit log message.  A
submitted patch should not force reviewers and future readers of "git log"
to guess why this change was made.

While reviewing, reviewers can ask what problem you are trying to solve,
why you did things in one particular way, etc., and they may be able to
extract the necessary information from you like I just did during this
exchange.

But people who are reading "git log" in the future and bisecting the code
to see why this change was made 6 months ago will not have that luxury,
and even if they manage to find you and asked, you may not remember why.

Without having enough clue to understand what you wanted to achieve, they
may make changes that breaks your unstated expectation, and they would not
even know they broke things.
