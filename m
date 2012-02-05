From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] send-email: add extra safetly in address sanitazion
Date: Sun, 05 Feb 2012 13:52:21 -0800
Message-ID: <7vbopdeyne.fsf@alter.siamese.dyndns.org>
References: <1328373162-25188-1-git-send-email-felipe.contreras@gmail.com>
 <87sjipxe5u.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	<git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:52:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuA0a-0001Za-M9
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103Ab2BEVwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 16:52:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52418 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753020Ab2BEVwX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 16:52:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 305D35EDE;
	Sun,  5 Feb 2012 16:52:23 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4eRjyP04tsxib1G1t2YNCiEOd/A=; b=bREHee
	JG+PxyjazN7bXVLdR3Ngc8DNAW9wVZ6NVPosDCtCHTmDdxGhtFsbJAfrJtQCZ6YU
	nJSa7DLfn5HKKX7iNTvydE0f22sMjQ+3kFoPn1OlkCVy5F32/pnlcXpOINzeDA90
	PzcU2YqKX5dvxJjSLhx4AXHziNNucCrKGcTkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UaCTxDm1yG08dS9eLONfj1pEeTRmQXgS
	AT1mkDCgmJmEVI0c5VUaGwic4ozHU6Fg3KlAJGuLwlzYq0djAwhM+kkzQVwOTR62
	kuNebg1Ur0DfCHfNeG1OTC5RaINO6MjUIc5tecohzuM3Q+A9c/IC9lPc3IbJeRlz
	+oOM2dW4wcc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2770E5EDD;
	Sun,  5 Feb 2012 16:52:23 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A71A95EDC; Sun,  5 Feb 2012
 16:52:22 -0500 (EST)
In-Reply-To: <87sjipxe5u.fsf@thomas.inf.ethz.ch> (Thomas Rast's message of
 "Sun, 5 Feb 2012 20:39:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AF052762-5043-11E1-9032-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189971>

Thomas Rast <trast@inf.ethz.ch> writes:

> Am I the only one who stared at this for ten seconds, only to then
> realize that there is no sanitizing whatsoever going on here?
>
>>   'Foo Bar <foo@bar.com>>' -> 'Foo Bar <foo@bar.com>'
>>   '"Foo Bar" <foo@bar.com>>' -> '"Foo Bar" <foo@bar.com>'
>>   '<foo@bar.com>>' -> 'foo@bar.com'
>
> All of these are the same underlying issue.  Does your patch fix any
> other malformed addresses, or just this particular type?

Just this particular type, as long as the code handles it correctly, would
be better than nothing.

On the recieving end in mailinfo, I think we also support

	gitster@pobox.com (Junio C Hamano)

although it does not seem to be used by many people these days (the only
one I can remember seeing on this list was merlyn), so we may want to be a
bit more consistent between sending and receiving end, though.
