From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2012, #08; Tue, 31)
Date: Thu, 09 Feb 2012 20:09:19 -0800
Message-ID: <7vhayzs51s.fsf@alter.siamese.dyndns.org>
References: <7vlion3tr5.fsf@alter.siamese.dyndns.org>
 <7vsjijs9rq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tbushnell@google.com, tytso@google.com,
	=?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 05:09:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvhnn-00035Z-OU
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 05:09:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758234Ab2BJEJW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 23:09:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754786Ab2BJEJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 23:09:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5EDB9743E;
	Thu,  9 Feb 2012 23:09:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/lS+iHAeQllm4/tYdfkeZHkFbic=; b=qIrirl
	RmLXbtKRZvKHqvE8YfZkgn3gGUpSDkFvX+UO+FBWqxRYpCymD5O6NqBdKMgDH4MG
	fAWEIhVivXCR5UevaZDcW6AkY0ZzB2Mr91kZKetPjkCeS61/+x5cQZoAOt5NR2Fi
	JlOs2o71Xl8kipICeXBJjMads8mrVkLwwxJxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QGMT0SzgdQB9qKH+37lFK2/83fJyhCPu
	+zfQfYCrmaBBQ5fGxsPeeqLfcj2zy6z0FXIn0yn+iwH5qZPuwZW+xU3eHZbgA9j2
	83jhxifpL7IaIb3v9O62Tz72wFeP3ZlSaKL1Yq/mhdTcbWaKt6DpHcc9qqqTF7aS
	VTRFWbs0KNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C6C743C;
	Thu,  9 Feb 2012 23:09:21 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D1DAE743A; Thu,  9 Feb 2012
 23:09:20 -0500 (EST)
In-Reply-To: <7vsjijs9rq.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 09 Feb 2012 18:27:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 022420CC-539D-11E1-8958-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190377>

Junio C Hamano <gitster@pobox.com> writes:

> It turns out that this series, as a side effect, fixes a long-standing bug
> that the --branch option cannot be used with the --mirror option.
>
> I am tempted to merge it also to 1.7.9.1 maintenance track. The issue is
> minor (you can always clone with --mirror and then switch the branch with
> "checkout") and it does not look like it warrants further backpointing to
> 1.7.8 and older releases, though.
>
> Comments and/or objections?

Replying to myself.

Regardless of "'refs/heads/$branch' is not found because we do not look
for in the right place" issue, shouldn't the use of the --mirror without
the --bare option forbidden or at least warned about?

Cloning as --mirror, with a working tree with a current branch, would mean
the next fetch would directly try to update it by overwriting.  We do pass
the --update-head-ok from pull, so "git pull" in such a repository should
be "sort of" safe, as long as the repository is never used to create its
own commits on whatever local branches set to be overwritten by --mirror,
but still I have this gut feeling that such an arrangement should at least
be discouraged.

Comments and/or opinions?
