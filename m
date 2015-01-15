From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: reword --author error message
Date: Thu, 15 Jan 2015 09:48:26 -0800
Message-ID: <xmqq4mrs7x5h.fsf@gitster.dls.corp.google.com>
References: <54B7CCCD.1070708@drmicha.warpmail.net>
	<84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Gunnar Wagner <gunnar.wagner@irisgermanica.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:48:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoX3-0005mh-V2
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 18:48:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbbAORs3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 12:48:29 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60097 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751385AbbAORs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 12:48:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 26ABC2E990;
	Thu, 15 Jan 2015 12:48:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tw/9RANaBodmca3oqs1X5JGxOoY=; b=uF49qQ
	y32qekKIyqJ45FHqMtPDirhM5IqYxmqDLVzCrtphlMEHL0Vqvxji7mY6PSmOiYEU
	kaEDtU9QUXy708dznNf8M6trgCa2jrNIP5zzDVWqKSU3KF+PPUgl67n/ED/Kqcnp
	n9y4UaaByzh87Yx22RjB1aaOiSfEQjwHFqN+U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jQnQJ15pIrRMfR4CiN9QyWEyLytf6ZgL
	dQS1AgQ4eXe3qRwYF8HKsEI8sEuuVa/baRnZR3270fgkAVU1b+/lV3Dp3mGQQ2Y0
	qxCqBv++eVu17emFOLl1G7uPj6AL7urHO+Xw1Y/01NW5ulKbZRAzpkdVLO5qHv/K
	3KxjvEjw0vU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1D34F2E98F;
	Thu, 15 Jan 2015 12:48:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9722B2E98E;
	Thu, 15 Jan 2015 12:48:27 -0500 (EST)
In-Reply-To: <84cf10a22858275d6e213311c93df7f6a5408f60.1421331608.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Thu, 15 Jan 2015 15:23:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B5E49852-9CDE-11E4-AC6F-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262492>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> If an --author argument is specified but does not contain a '>' then git tries
> to find the argument within the exiting authors; and gives the error
> message "No existing author found with '%s'" if there is no match.
>
> This is confusing for users who try to specify a valid complete author
> name.

I suspect that you meant s/a valid/an invalid/, as if it is valid,
it cannot not contain '>' (after all, '>' is merely a rough
approximation to check if it is "Name <email>" format).

> Rename the error message to make it clearer that the failure has two
> reasons in this case:
> "Bad --author parameter '%s': neither completely wellformed nor part of
> an existing one"

You are trying to help a user who thought "Who www.where.com" was a
valid thing to pass to --author; "it is not completely wellformed"
is not very helpful without making her realize what in that bogus
string is not "completely well-formed".

Perhaps

  "--author '%s' is not 'Name <email>' and no existing author matches that string"

or somesuch?
