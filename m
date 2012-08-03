From: Junio C Hamano <gitster@pobox.com>
Subject: Re: need help with syncing two bare repos
Date: Fri, 03 Aug 2012 13:00:36 -0700
Message-ID: <7vboirbva3.fsf@alter.siamese.dyndns.org>
References: <CAPZPVFax6wa9QYOMxghhWK6LJaYWS2+WCbWQLA+LE53TdNXJhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 22:00:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxO3A-0006m3-MY
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 22:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab2HCUAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 16:00:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51045 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752496Ab2HCUAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 16:00:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B33671F1;
	Fri,  3 Aug 2012 16:00:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Y1pbcFz531LA6ySCucUAUvVuPRY=; b=KY62BQ
	KCAqdnsIyrxzbzdzuvtxRMiEhlwgpn4Q89aDUApOsjsZHO5GmYPBuhGgIg/kADER
	lZBlIkEs7Gp7R8O64lJq4bLks4mX+S6CPmHmYh90f/AWgEhuwrQyTNHqY7F/wjyg
	x1wnnwP/cASrIJ+sJWJBfjWz5n4Ei/X25HPAg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ze0BzH9Oy1OlfzuYJrdUGYTPw+hhFyyD
	TJvWYqaLbKq1gFowaAvbA5YrgL66zo5qLIsJZyNTnpkUmFZjkohj4ANiZJ+r7qeG
	cfeZg0748FSgMAZLywC7ZmNNUpeDO9mq/l7rxolQsZ1TE6v3X1CWj60hwd8odlbe
	tmlZimjzMXc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 394F571F0;
	Fri,  3 Aug 2012 16:00:38 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A862271EE; Fri,  3 Aug 2012
 16:00:37 -0400 (EDT)
In-Reply-To: <CAPZPVFax6wa9QYOMxghhWK6LJaYWS2+WCbWQLA+LE53TdNXJhQ@mail.gmail.com> (Eugene
 Sajine's message of "Fri, 3 Aug 2012 14:29:44 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E4DEC768-DDA5-11E1-9819-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202854>

Eugene Sajine <euguess@gmail.com> writes:

> I think the best variant would be to do something like:
>
> $ git pull --rebase /refs/heads/*:/refs/heads/*
> $ git push origin /refs/heads/*:/refs/heads/*

You perhaps meant "worst" not "best" here.  From the point of view
of people who have pushed into the "origin" repository we see above,
their history is rewritten; you are screwing half the population by
doing this.

Not allowing B to accept pushes while it is not positively sure that
A has gone down would of course be the best solution (in your scenario,
B started serving when it merely found out that *it* cannot contact
A), but barring that, the recovery for two histories at A and B,
once they diverged, should be to "merge" corresponding branches.
