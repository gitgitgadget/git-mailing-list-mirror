From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 30/48] merge-recursive: Fix deletion of untracked file in
 rename/delete conflicts
Date: Thu, 21 Jul 2011 11:43:14 -0700
Message-ID: <7vaac73265.fsf@alter.siamese.dyndns.org>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
 <1307518278-23814-31-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jgfouca@sandia.gov
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 20:43:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QjyDR-0004qK-J6
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 20:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab1GUSnR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jul 2011 14:43:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752481Ab1GUSnQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2011 14:43:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A483303C;
	Thu, 21 Jul 2011 14:43:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=z6hwZm+M1wbp51tv1eesNJaDcCs=; b=Q7T0g6xUfEVRSAEftE5U
	23gfvHTkKU5Rngh5TZeMt2sJ2GlvEPUHVvOpgpYPy9MPWiBgyXpFw64FiGgx/wPo
	CsQAW1E+VUJ9WHV7yBSOR7jknk4jHHxF5s22mlaZCYnX+Ev9ZBm4g8U1hXkHB5M3
	5oa1GzoyM0zVeQPBJtxEPAQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=HQ2mGaasIXofiXbhRj0X+wMqPRUip2W3f9uwaRLq4vLihG
	0snSSZBiGAVAJ98SZrUie2x3+GjJZa4b2q1WPZzrksknxlAaK/dFQdqlAbxGz5lF
	wptHQGhsv06bAVQ/EeFOd7NZc4vq6oeSrdgxUAO9xZHByF0GKJ6DOqRMFkkao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2069C303B;
	Thu, 21 Jul 2011 14:43:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9E817303A; Thu, 21 Jul 2011
 14:43:15 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4B70C5E2-B3C9-11E0-A69E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177609>

Elijah Newren <newren@gmail.com> writes:

> In summary:
>   Change <expression> from "o->call_depth || renamed_stage == 2" to
>   "renamed_stage == 2 || !was_tracked(ren1_src)", in order to
>   remove unnecessary code and avoid deleting untracked files.
>
> 96 lines of explanation in the changelog to describe a one-line fix...

Beautifully written analysis, though ;-)
