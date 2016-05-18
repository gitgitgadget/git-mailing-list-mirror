From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/21] i18n: advice: internationalize message for conflicts
Date: Wed, 18 May 2016 14:31:00 -0700
Message-ID: <xmqqd1ojqciz.fsf@gitster.mtv.corp.google.com>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
	<1463585274-9027-4-git-send-email-vascomalmeida@sapo.pt>
	<CAPig+cTgQmJG5a8dNjkYcNPG_vEHycyi19sHkO_yO-EfFQzy5A@mail.gmail.com>
	<573CD7EC.9060606@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Wed May 18 23:31:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b393e-0007E5-10
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752603AbcERVbG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 17:31:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59328 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008AbcERVbF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:31:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 386BD1C846;
	Wed, 18 May 2016 17:31:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Uroeun6s9QDH6yKXudd1pVwvoOU=; b=l/sHXe
	Pc5nIYUFTJYbby7sLHRM53dmSdmr8+2GlpaxpymeSZs27z154/IQPDk/MIx6tlSO
	NsTbXy2IMO4BlN0bPst4Cy1W4UT4R61yFIj8009EZVYtD8bq8MSbWmN/sEUtYxa8
	s8Eov//B1Hw3KYgG5dcDApkt6pah/raqKWFrA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iBlBHlB3qEf2kT3mQclTxcydMvPm6vFj
	KS1E0kW6sWTYkPG/eK1rp/6w1RAZJk6mqw7wLgfsLdCJ3JEz6DI602g8UFST5zW4
	i4RejtjU7jIjpjX/kNpuiE02c+nI4YE7pN+T+58JDlUau+gvu4vyLhwFfRyEva1n
	HotssTx/JfM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2FDED1C845;
	Wed, 18 May 2016 17:31:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9321A1C844;
	Wed, 18 May 2016 17:31:02 -0400 (EDT)
In-Reply-To: <573CD7EC.9060606@sapo.pt> (Vasco Almeida's message of "Wed, 18
	May 2016 21:00:28 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D21F962E-1D3F-11E6-929E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295012>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

>>> +       else
>>> +               error(_("%s is not possible because you have unmerged files."),
>>> +                       me);
>> 
>> Despite the commit message, I still don't understand this change. 'me'
>> is a literal git command which shouldn't be translated, so how is this
>> helping?
>> 
> I saw it as an operation that could be translated, not necessary a git
> command

The intention of who wrote this message was to tell this to the
user:

    Running the command '$X' is not possible in this situation.

implying "Don't type '$X' again; it is futile.  Correct the unmerged
status first".

Our subcommand names are English verbs, because they are designed to
be easily understandable by English speakers, so we do not exactly
say "Running the command 'commit'" in the message.  Instead we say
"commit is not possible..." for brevity.

Languages, if their grammatical rules do not allow a subcommand name
in the place in a straight-translation of that original sentence,
are allowed to (and encouraged to) translate the original "%s is not
possible" as if it were "Running the command '%s' is not possible".
That is what good translaters would do anyway.

So for this (and 05/21 for the same reasons), I do not think we want
to split and duplicate the messages.
