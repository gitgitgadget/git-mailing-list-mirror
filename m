From: Junio C Hamano <gitster@pobox.com>
Subject: Re: help: the question about relative path in the
 objects/info/alternates
Date: Mon, 01 Aug 2011 10:44:56 -0700
Message-ID: <7vr555hvqf.fsf@alter.siamese.dyndns.org>
References: <4E366F08.2060808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Jason Wang <jason77.wang@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 19:45:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwY7-00013K-6Y
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 19:45:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841Ab1HARpB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 13:45:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59239 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753598Ab1HARpA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 13:45:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E116345B5;
	Mon,  1 Aug 2011 13:44:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=i9V1SthlEMskuwhuATOKZrId4KM=; b=Z1Bh8t
	6rWywCg8YK5iVuIk489nORZIIbAbIngymqjDHHDPX4TQwU/yI4SFquGOJBjS3QNH
	S1x6Rx9wovBM4xX9z777myp/MBeoP9ailp3AErel+O+NqCd+Hdg6dhLkkGhldeS0
	sEATXP3TmSXZIApVNAwjhSmG5UYCmSncTZ7EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tIUQG65Y5uKAQi+yJeAEqxi9zYKWKAgh
	aZhDupLav+VHSwCxwHxLFokGKWiBAcH/Ptw9usQGClNlQ73vjv526vc6Jt+lX64h
	iez//3gZEozwejgBwhQjD6O3oqcfuDTnEJIzXjlLX8uXJqbuRscTdP2OCpT74TIT
	DVSvcDESccQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CAB5345B4;
	Mon,  1 Aug 2011 13:44:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 329A545B0; Mon,  1 Aug 2011
 13:44:58 -0400 (EDT)
In-Reply-To: <4E366F08.2060808@gmail.com> (Jason Wang's message of "Mon, 1
 Aug 2011 17:16:56 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F958CCF0-BC65-11E0-926E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178361>

Jason Wang <jason77.wang@gmail.com> writes:

> From the objects/info/alternates part of this URL
> http://www.kernel.org/pub/software/scm/git/docs/gitrepository-layout.html,
> it says it will work if alternates has relative path in it.

It does not just say "relative path", but "relative to the object
database".  It expresses where the "objects" directory you are borrowing
from is, relative to your own "objects" directory.

For example, if you have /src/ib/{objects,refs,HEAD} as your repository
that borrows from elsewhere, say /src/base/, then objects/info/alternates
file in the borrowing repository should say either /src/base/objects/, or
"../../base/objects".

An easy way to make sure you do not make typo is to go to your borrowing
objects directory, and then let your shell completion to type your path,
like this:

    $ cd /home/jason/source/incremental-bare
    $ cd objects
    $ echo ../../base-bare/objects >info/alternates

While formulating that "echo" command line, you would type ../../ <TAB>
and pick base-bare, <TAB> and pick objects.
