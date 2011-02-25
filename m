From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/73] gettext tests: add GETTEXT_POISON to simulate
 unfriendly translator
Date: Fri, 25 Feb 2011 09:52:21 -0800
Message-ID: <7vvd08atnu.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
 <1298418152-27789-3-git-send-email-avarab@gmail.com>
 <20110225070834.GB23037@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 25 18:52:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pt1qL-0004Gy-1G
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 18:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab1BYRwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 12:52:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51077 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742Ab1BYRwf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 12:52:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D99603E8A;
	Fri, 25 Feb 2011 12:53:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8W12TkvC/6kWCs7Wrf4gu6Qc2pI=; b=TfrabL
	F3STCgW7bg9VksUmLnkfWyNG9ENuk+i+rgkJZntZ3imSXoQfU642ItnVlef12GQO
	hPuBRMKnFLLlJDkjhzy/oAtE+zkGFm8asYESSE0XSDauOp9KFccNroiRc7IqisoV
	dT+DwqYt7iCeyVMuq12BtKNaDQO60fkAEbHUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s9KyVF4ysFXwwW6VhKzQcJUsGd96U9dG
	TI/iwzdj/qFiDP4RWaa9+syWQIbuWJQh08SKXfZS6iUZ1+Lbj7ZJPzB2dreR7LZy
	sVxw9v1+quA7yVo5VEDPiZMVOoHWbr4Ia6ZD9l+BwcOMlZ1Il+mBBQkHQMeNcW6X
	QL+Q7bmF+Hs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 987993E86;
	Fri, 25 Feb 2011 12:53:42 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4044D3E85; Fri, 25 Feb 2011
 12:53:36 -0500 (EST)
In-Reply-To: <20110225070834.GB23037@elie> (Jonathan Nieder's message of
 "Fri\, 25 Feb 2011 01\:08\:35 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2F0A11C6-4108-11E0-B8E9-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167915>

Jonathan Nieder <jrnieder@gmail.com> writes:

[offtopic: why is Jakub on the CC list? -- I don't recall him saying much
on this topic yet...]

> The idea of the GETTEXT_POISON facility is to simulate a worst-case
> translation, so that strings marked for translation that cause trouble
> can be noticed and dealt with.

I've never thought this was about a "worst-case translation".

Isn't this about emitting all the strings marked for translation in a form
significantly different from the original, in the hope that such an output
would help us find messages that should never be marked for translation by
triggering test failures?  I do not see any "worst-case", just different
enough for the plumbing tests to break.

IOW, I don't think this is about helping translators in l10n, but about
helping coders in i18n department.

> A string starting with "#" does not seem particularly well suited
> for that purpose, since it makes '#' characters that mark a comment
> and that translators must be careful not to remove harder to find.

Hence, I would suggest an alternative phrasing of the above part (and
alternative way of thinking): '... since it easily hides a mistaken
marking of a line that _has_ to always start with "#" followed by a
translatable string.'
