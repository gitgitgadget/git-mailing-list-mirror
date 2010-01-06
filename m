From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Filename quoting / parsing problem
Date: Tue, 05 Jan 2010 17:32:30 -0800
Message-ID: <7vljgcm30x.fsf@alter.siamese.dyndns.org>
References: <201001011844.23571.agruen@suse.de>
 <7v8wcge4kr.fsf@alter.siamese.dyndns.org> <201001022148.47841.agruen@suse.de>
 <201001060104.25737.agruen@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Gruenbacher <agruen@suse.de>
X-From: git-owner@vger.kernel.org Wed Jan 06 02:32:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSKlQ-0005tJ-6y
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 02:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755149Ab0AFBci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 20:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755026Ab0AFBci
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 20:32:38 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755101Ab0AFBch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 20:32:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BDC328E459;
	Tue,  5 Jan 2010 20:32:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5ZVZoGtAtSV+HgbMpZMSGESY7Lk=; b=F7ysiR
	StDGA1fE56IYyeIvxuTLUxfZWjNgTlPRCk+5yV2nrPVIM5+fWtKIBLwrTzlrXVx9
	N7pNMx1RHdsS+CF1mi3JC0lLy3ti7ELf9iinSoPouFDwyMSOTopRDKxMeFmdT4iV
	zN9O4su9gQQF+QpBBF0MlNe9R94iW5NfhrH8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pwlH4QUxoxhgLjw4VjNI7fo6JUm6ngUy
	+Q90zxLWqG6oSwcKLv9YA2PAYDNR6sLhFHJOB0Md9htKdVUNgORH3YbcKbpPohZm
	AojMz5gbPrHWBJ3lfOYomkZCYkNfpsufp0I6krlzf0mjseIBUR3ExB7+mdBhrkBb
	wBom5GFKQE4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 958418E457;
	Tue,  5 Jan 2010 20:32:34 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EED988E454; Tue,  5 Jan
 2010 20:32:31 -0500 (EST)
In-Reply-To: <201001060104.25737.agruen@suse.de> (Andreas Gruenbacher's
 message of "Wed\, 6 Jan 2010 01\:04\:25 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5D8AEF4E-FA63-11DE-877B-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136234>

Andreas Gruenbacher <agruen@suse.de> writes:

>  * sha1 checksums are not verified right now.  I'm not sure when that
>  should happen: always by default, or only optionally?

preimage and postimage sums are not something you would "verify" with
anyway, and they are not useful unless you are dealing with binary patch,
so I wouldn't worry too much about them.

>  * Similarity and dissimilarity headers are ignored.

I think it is fine to ignore them; even git doesn't use this information
other than parroting them in "apply --summary --stat" output.

>  * Binary diffs are no supported.  I think GNU patch should recognize
>  them and give a reasonable message for now.

Nice.
