From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Mar 2011, #04; Wed, 23)
Date: Thu, 24 Mar 2011 01:00:03 -0700
Message-ID: <7v4o6taqyk.fsf@alter.siamese.dyndns.org>
References: <7v62r9csqr.fsf@alter.siamese.dyndns.org>
 <7vpqphasbr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 09:00:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2fSv-00066h-6z
	for gcvg-git-2@lo.gmane.org; Thu, 24 Mar 2011 09:00:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933628Ab1CXIAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2011 04:00:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62625 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933596Ab1CXIAM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2011 04:00:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E2BC3E81;
	Thu, 24 Mar 2011 04:01:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MNSGttLfLSTZD1rX1o2ZfOmVxVM=; b=M+Yrxt
	oZ+6V7LYhqZtXZycJODaxHHgFwSueSsaZRzYS/hJjKIoDB9Bbr0pyNO5TvzG/v7f
	1vl8kpXH/lvYOUKINK3hW1r0UHVOqFel0JhDPq9R+QrigOtIjCh3Iy+lqw859kKv
	CxY0lyYTy0iJQySzH0uKJWVqsxaaxyGQaQe2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nqYrIld3VwQotlIlcOkmBTw+0VzQQ1Ve
	5xJpkrC1XU9YhsDTAQVjtcvd8+FCF9LpI7uGNuJ6VbBpDE2XZ/tFOV8bkz9UN5bF
	ul9gf8Q/KzyZGXoIHuyR4PCzJXhqRyaJE0plS/hHa4AhcxCRiRRzdKLNbY9ECSKc
	1vnfI/klSX0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0BAAF3E80;
	Thu, 24 Mar 2011 04:01:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 757FE3E71; Thu, 24 Mar 2011
 04:01:46 -0400 (EDT)
In-Reply-To: <7vpqphasbr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 24 Mar 2011 00:30:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F86D3D6A-55EC-11E0-A41E-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169904>

Junio C Hamano <gitster@pobox.com> writes:

> I won't be doing the tests, though.  At least not tonight.

If anybody is interested in tackling this while I am sleeping (gee, it is
almost 1am now and I am not so young anymore to pull an all-nighter),
the minimum set of things to test are as follows:

 * with no configuration, "git merge" errors out;
 * with configuration set to "false", ditto;
 * with configuration set to "true":

   - on detached HEAD, "git merge" errors out;

   - without branch.*.remote, ditto;

   - without branch.*.merge, ditto;

   - with branch.*.remote and branch.*.merge set, but without
     remote.<value of branch.*.remote>.fetch that specifies RHS
     to store the fetched value, "git merge" errors out;

   - does it work correctly when branch.*.remote, branch.*.merge and
     remote.<value of branch.*.remote>.fetch are all set reasonably?

   - does it work correctly when branch.*.remote is ".", i.e., forked
     from a local branch?

   - does it work correctly when more than one branch.*.merge are
     set for the current branch, i.e. configured to always create an
     octopus?

 * does it have any funny interaction with various command line options
   that are eaten by parse_options()?

   
