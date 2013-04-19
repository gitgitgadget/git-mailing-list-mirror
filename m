From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 12:56:23 -0700
Message-ID: <7vr4i6z448.fsf@alter.siamese.dyndns.org>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvym30t8.fsf@alter.siamese.dyndns.org>
	<CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
	<7v8v4e1fyz.fsf@alter.siamese.dyndns.org>
	<CAMP44s2gA0JbfxA1UQW_pnizGBpmbQem3Qg0FpWP_Wi6eYwVjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 21:56:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHQ9-0006tQ-TH
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 21:56:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754020Ab3DST42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 15:56:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50147 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753962Ab3DST41 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 15:56:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6CB417797;
	Fri, 19 Apr 2013 19:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ekGJJhwdQO2hnA+P+fssmSzF5Wg=; b=fmhYqY
	hnWpfsp5to6bAY57e5D8G1xzjLsxqxc/kddg8JHJb5BJYAlWqZHgWrU7MqnGJKWn
	lWpqpmb0V/EN7ioYgD4DUo9kvneQaDRzIVZ+KGYQSbVXVVyj92ok5O4BVvUIE6Gp
	W4EP5KO3EIVaXbyPgsAvWrnhRN8o2KyBUE6mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZQsB0OSDqmhWMuGQBYW4jbw4hV5HNL6E
	Bcunf5T+dLauH/EuNd/C1w9oDr7JQR12vig6ExtaM85xnTPuT3x58Q7ejNVs8wnB
	lJlC34LbCYYWBpn+apyP78neGh6JLK3RKR3m+DQaOsSaTi7smi4HefoCBniG2kca
	Rri5RM2U/+8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A801C17796;
	Fri, 19 Apr 2013 19:56:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16CF117794;
	Fri, 19 Apr 2013 19:56:25 +0000 (UTC)
In-Reply-To: <CAMP44s2gA0JbfxA1UQW_pnizGBpmbQem3Qg0FpWP_Wi6eYwVjw@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 19 Apr 2013 14:35:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 374D4B0E-A92B-11E2-BDC7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221814>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> If this were _only_ to be used within send-email (i.e. replacing the
>> "then send it out" above with "then use send-email" to limit the
>> usecase), "git cc-cmd" would be a reasonable name.  But if that is
>> the intended use case, it would even be more reasonable to make this
>> logic part of send-email and trigger it with --auto-cc-reviewers
>> option or something.
>
> Yeap, but I wouldn't want to be the one that implements that in perl.

That is OK.  None of this has to be done by you.

And we seem to be in agreement that the feature deserves to be its
own command, so it does not have to be in Perl, either.

>> But I think it can be useful outside the context of send-email as
>> well, and having one independent tool that does one single job well
>> is a better design.  Perhaps it is better to name it less specific
>> to send-email's cc-cmd option.  "git people"?  "git whom"?  "git
>> reviewers"?  I dunno, but along those lines.
>
> 'git relevant'? 'git related'? It's not only people, also commits.

Let's let it simmer on the list for a few days so that other people
can come up with a better name.
