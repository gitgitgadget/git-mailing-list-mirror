From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Internationalization and yes/no prompts
Date: Tue, 24 Feb 2015 12:32:35 -0800
Message-ID: <xmqq1tlfqcd8.fsf@gitster.dls.corp.google.com>
References: <20150212085211.9112780692@smtp-out.fingerprint.fr>
	<54EB4B3F.6080706@fingerprint.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pierre-Olivier Vares <pierre-olivier.vares@fingerprint.fr>
X-From: git-owner@vger.kernel.org Tue Feb 24 21:32:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YQM9q-0006mC-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 24 Feb 2015 21:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739AbbBXUci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2015 15:32:38 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61558 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752700AbbBXUch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2015 15:32:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CD8A73A59D;
	Tue, 24 Feb 2015 15:32:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=llZDHQf9VKmeNJ55g9+FCZDyn/A=; b=gPJS8v
	jJ0VsfYOgbTsUjfdljG3+Si/1KIU7Im051j47TATwz3WFAyYttl5LI7vgT3SHsqv
	fVJbR6cp9MyExmgDTj4zOoFbIH2ghAKbG4sVO8PLDhE0nABTGGCtO744TaG5UYsv
	1J1BWhcW8kqX0Kjv4Lx/H/ne2Um2cBMpGyMQA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xAJux7r77UkcbgmszLb6HvXRlt9K2LdY
	R8Uf05pXitiDIFkiFgz6Bq6z1RrieMHP+S/edCrcUpWfsq9omOF6VwVAxX9wP2oT
	irvspkahd1SLdTRlwiy1+CkqfM/PUZRl1QrscN6e6/ewLHgRyIIEnmi4ET1SVFsq
	2prNs9n5xQ0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C577E3A59C;
	Tue, 24 Feb 2015 15:32:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4CB423A59A;
	Tue, 24 Feb 2015 15:32:36 -0500 (EST)
In-Reply-To: <54EB4B3F.6080706@fingerprint.fr> (Pierre-Olivier Vares's message
	of "Mon, 23 Feb 2015 16:46:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44B27B04-BC64-11E4-AC63-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264343>

Pierre-Olivier Vares <pierre-olivier.vares@fingerprint.fr> writes:

> /Supprimer //premier_fichier ? [Remove first_file ?]/
> Natural answer to this question is 'Oui' [Yes], so I type 'o', rather
> than 'y'.
> Once finished, I see no file has been removed (since 'o' has been
> considered as 'different than yes')
> Whereas it's not an end-of-the-world thing*, it's annoying as at first
> sight I didn't understand why it has 'not worked'.
>
> I thought of a few possibilities (some easy to implement, others more
> complex; some are stricter for the user) :

> - explicitly put "y/n" in the message. Translaters should be warned to
> let "y/n",

This may be suboptimal from the end-user's point of view, but it is
the least risky of breaking anything.

And it is way better than the status quo.

> - only allow y and n answers (and variants : yes, no), and reject
> everything else with a message

This is not helpful to the users if it does not say why (O)ui was
rejected, which would mean we would be better off saying [Y/n] in
the message in the first place.

> - use as 'n', but echoes a message : 'Answer considered as /no/'

Unhelpful without stating why (O)ui was considered as 'no'; same
conclusion as above.

> - accept answers depending on the language used to echo the prompt
> (y/n for english, o/n for french, j/n for german, ...)

This would be the best for languages where translations for Yes and
No begin with different letters, but I suspect it might be tricky to
implement.
