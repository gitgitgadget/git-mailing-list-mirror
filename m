From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/21] t9003: become resilient to GETTEXT_POISON
Date: Fri, 20 May 2016 10:59:17 -0700
Message-ID: <xmqqh9dsehl6.fsf@gitster.mtv.corp.google.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-20-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cT3yf7D4xOmOhy5Y21qwHuA5Ny9ULEJhC1OBgrhiayQ3g@mail.gmail.com>
	<573E30C8.4070600@sapo.pt>
	<CAPig+cRo3tjt9N0YO8sNn90dL3dP0asfmKTr5rerS9YLO6QBtw@mail.gmail.com>
	<xmqqbn40fzu8.fsf@gitster.mtv.corp.google.com>
	<573F4BEC.7000906@sapo.pt>
	<xmqqoa80ei03.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Fri May 20 19:59:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3ohp-0007Kk-CW
	for gcvg-git-2@plane.gmane.org; Fri, 20 May 2016 19:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbcETR7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2016 13:59:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64641 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750818AbcETR7V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2016 13:59:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ADAB41A45A;
	Fri, 20 May 2016 13:59:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vUCPzNQeJu0QOH7Untk2bBeQb2c=; b=mWIX9y
	NjJe+ZSAkRe4hXGNRvda9FT9sDe2/ujfIZLb3uvRF3Y8gmzUAAzR/dUcLj22KCCs
	NqaCJVVeGAkd06dD9BI3wDXa+sdKqTa6dris/Bp4t7yJDQCtwA3lvKoPCactClGp
	qIp0CuWm7zRt9auhsHIi0PVfJ1LiGoXw+zstY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Me7aCbfwOoCNvvWZe4+g2WX/iegA+8xA
	jN6LtV3fYgU9/J057s9A2OzJmWBretT30IoKaeoOKYCLYjnfguLRXM7wvzGd/rBC
	KC1Y4R6+OTysRQ2dNNEQA3X58La83bEd2zKSvjSU2ycMjdubIkeaQwG0g6Q7P0Ya
	DMa6MQQRvlw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2DA31A451;
	Fri, 20 May 2016 13:59:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 307081A44F;
	Fri, 20 May 2016 13:59:19 -0400 (EDT)
In-Reply-To: <xmqqoa80ei03.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 20 May 2016 10:50:20 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9317EF46-1EB4-11E6-ADFA-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295195>

Junio C Hamano <gitster@pobox.com> writes:

> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>
>> Alternatively, we could leave sed alone as it were before this patch and
>> use test_i18ngrep instead of grep to fake success under GETTEXT_POISON.
>> I think I prefer this way. What do you think?
>
> That is equivalent to saying that "we would translate 'lgf' to
> end-user's language", which does not make much sense to me.
>
> Wouldn't the introductory explanation, up to "Did you mean this?",
> be the only thing that is translated?

I just checked the code ;-)  We do this:

	fprintf_ln(stderr,
		   Q_("\nDid you mean this?",
		      "\nDid you mean one of these?",
		   n));

	for (i = 0; i < n; i++)
		fprintf(stderr, "\t%s\n", main_cmds.names[i]->name);

Using test_i18ngrep would mean we would not be able to catch a
potential future bug that does an equivalent of

	for (i = 0; i < n; i++)
		fprintf(stderr, "\t%s\n", _(main_cmds.names[i]->name));

in the loop, i.e. marking something that is not meant to be
translated as translatable.

As long as translators do not translate "Did you mean..." to begin a
line with a tab (which I do not think there is any reason to), it is
going to work reliably to grep for "^ lgf$" here, and it will catch
such a potential future bug under GETTEXT_POISON build.
