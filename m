From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 07:59:28 -0700
Message-ID: <7vzk8z0wq7.fsf@alter.siamese.dyndns.org>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
 <1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
 <CAOnadRGgduprp_Dbjzf_TsyQQQjivzKxCgUq4y_HevvtKd7h7Q@mail.gmail.com>
 <CAMP44s0jLdNo89+c7+fBSokdxhCvPRnRKfhgVKnziMmv0vySXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ted Pavlic <ted@tedpavlic.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	Ville =?utf-8?Q?Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 16:59:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXD2I-0004bi-4C
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 16:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933534Ab2EWO7b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 10:59:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35871 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933593Ab2EWO7a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 10:59:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5914187DA;
	Wed, 23 May 2012 10:59:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ock7wa3OPpufH66eOYUqMUHW3jY=; b=ijM3Bq
	buDbFvXwPXAH0j7SUVrJitCQg89KALRTBr+5t40SsfkMC8vcvdyt08uEQ0cUu8We
	/8P91VP4SDQwTN1718nBW0qt7KVtAT+VykuOypRmaqKfMtBae/TniRFaH67dW89l
	t/gwNF3VxPniX9A9Tmn6crCW6Gw/V5gryQnE0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DU2TMEjfrqnpFvg0tMU24PdaSPxbS6hu
	ALF9z1XGah0j81VEHA5/l0Aek7Pw49jTpbkEOSRchEONQApuAflvMvQQUTmWTx8M
	iCkjdeQAi4IIWb3WgdlFe8gil3PpqVuVlmIwL3Yn5PujNglxtAPQHPnk2Cn6piYP
	7VO5I9SEew0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D2D487D9;
	Wed, 23 May 2012 10:59:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A134687D5; Wed, 23 May 2012
 10:59:29 -0400 (EDT)
In-Reply-To: <CAMP44s0jLdNo89+c7+fBSokdxhCvPRnRKfhgVKnziMmv0vySXw@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 23 May 2012 13:53:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5C57F56-A4E7-11E1-A59B-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198294>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Wed, May 23, 2012 at 12:27 AM, Ted Pavlic <ted@tedpavlic.com> wrote:
> ...
>> Moreover, every time the subject of splitting __gitdir out comes up, a
>> side discussion about all of the complications that could cause comes
>> up... and people give up and hope that the folks upstream (i.e., here)
>> will come up with a better solution.
>
> This is the reply Kerrick got to his suggestion from Jeff King:
> http://article.gmane.org/gmane.comp.version-control.git/194230
>
> I also agreed, and so did Jonathan Nieder:
> http://article.gmane.org/gmane.comp.version-control.git/194950
>
> So I don't see what you mean by those side "discussions" I recall
> Junio objecting to this, but...

A comment just on this part to avoid misunderstanding.  I do not recall
objecting to the above two articles, and after reading them again, I am
happy with the direction.  The message from me in the thread they are in
was merely me asking clarifications.
