From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: Allow extracting revisions into directories
Date: Mon, 04 Feb 2013 08:52:29 -0800
Message-ID: <7v7gmo3tte.fsf@alter.siamese.dyndns.org>
References: <1359901085.24730.11.camel@t520>
 <510F9907.7010107@drmicha.warpmail.net> <1359980045.24730.32.camel@t520>
 <1359982065-ner-9588@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Clausecker <fuzxxl@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 04 17:53:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2PHw-0007so-J2
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 17:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab3BDQwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 11:52:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50873 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756393Ab3BDQwc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 11:52:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DAC12C8F0;
	Mon,  4 Feb 2013 11:52:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lsBf+ZxWt+mbx0KIpmGQVWxTjdw=; b=eqHiEE
	SrX0yORZ94trCNJ1jX7il6Ht4gIFuD1zFcBZWsQwk9vpNo5e/8mFFC1yoOVVkDcl
	3rS+cLHEWEa4kK4OugWSaQXA+tm9BIWCt4xv9MVE4aDuy72cCCG8888x/FbvY0VZ
	z0ouyTbx613LEhZ22/TDOBYj9DM2FYlYAWSvw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=APqhCIR5DzXxAipOXkq9+Cag+DcwJQbF
	ItKB1hY0E0YqOA4E7SwHTj7Pplzi4PKvwhsyB4sp5mPc+9ebPisDPHFFF5W6h9Iq
	qiQaRcP0l/RURTpFDJXP/tH3g3tvktki9XpzDJihEx22qoFKCkjIc+zzVGFGttTF
	y+dlnv5dP/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CEB99C8EF;
	Mon,  4 Feb 2013 11:52:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4FF66C8EB; Mon,  4 Feb 2013
 11:52:31 -0500 (EST)
In-Reply-To: <1359982065-ner-9588@calvin> (Tomas Carnecky's message of "Mon,
 04 Feb 2013 12:47:45 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 441871B2-6EEB-11E2-832A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215394>

Tomas Carnecky <tomas.carnecky@gmail.com> writes:

> That's what `git checkout` is for. And I would even argue that it's the better
> choice in your situation because it would delete files from /var/www/foo which
> you have deleted in your repo. git archive|tar wouldn't do that.

The point about removal is an interesting one.  From that /var/www
location I guess that you are discussing some webapp, but if you let
it _write_ into it, you may also have to worry about how to handle
the case where an update from the source end that comes from the
checkout and an update by the webapp collide with each other.

You also need to maintain the .git/index file that corresponds to
what should be in /var/www/foo/ if you go that route.

Just to be sure, I am not saying "checkout" is an inappropriate
solution to whatever problem you are trying to solve. I am just
pointing out things you need to be aware of if you take that
approach.
