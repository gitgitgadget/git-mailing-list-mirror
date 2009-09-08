From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Improving merge failure message
Date: Mon, 07 Sep 2009 23:47:25 -0700
Message-ID: <7vbplmhr0i.fsf@alter.siamese.dyndns.org>
References: <20090908153101.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 08:47:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkuUP-0007Pi-69
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 08:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562AbZIHGrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 02:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753512AbZIHGra
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 02:47:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753408AbZIHGra (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 02:47:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E3282AFDB;
	Tue,  8 Sep 2009 02:47:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=J+QwebfdMt7zvv6ytiacoE4yWIg=; b=OLa/eedIveAl37vZa0ehUvw
	296x2FZOSWwYKl0jJoVJFUjrB2VFKv/fIH/1PDd5JJ3jeIQ7feC0UCfQ2zlOC2j0
	BkLCCLoQBcv1O70KI9MQH2j/AsC2DkRQeRR3MwpgXX2fqdt5tD1vFCAKS9bOSY9d
	24dJXo7Xe33g7B+q2kik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=uAwc+v8W9C6NCDdZg/WiRR2LKANHMQFgDJAiQLZCZpxO+wQtQ
	MXdNaASyUy4NdQeANzZiYpNJOuJT0+Mx+zIHtNmZMWzpq/PLI8uJZVHr41Bn/ker
	5r5GdjCF/6Rm8tdYgR+5cKRRch7T8S6VcI1jDNpjqw8wQ2906kP8AUOpDw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 515E12AFD7;
	Tue,  8 Sep 2009 02:47:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 73FE82AFD4; Tue,  8 Sep
 2009 02:47:27 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7AB12634-9C43-11DE-9D31-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127974>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> [2]% git merge feature
> error: Entry 'cool' not uptodate. Cannot merge.
> fatal: merging of trees 8ec1d96451ff05451720e4e8968812c46b35e5e4 and aad8d5cef3915ab78b3227abaaac99b62db9eb54 failed
>
> ... the messages look unnecessarily scary, with two
> "error" and "fatal" comments, and long sha1 commit names.

Just a technical nit.  I think these are tree object names.

> Those of us who used git for some time can tell what it wants to say.
> The merge checked the files in the working tree before doing anything,
> found that the user has uncommitted change to a file that is involved in
> the merge, and it stopped. And it didn't change anything. It may be "fatal"
> but the user has much less reason to be scared about this failure than
> the conflicting case.
>
> It would be nice if the message in the latter case can be toned down.

Yeah, it would be nice.  This actually was something that bothered me as
well while trying to explain the recovery procedure for these two cases.
Give me half an hour or so to cook up something...
