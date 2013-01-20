From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/2] Hiding some refs in ls-remote
Date: Sun, 20 Jan 2013 14:08:32 -0800
Message-ID: <7vip6rjyn3.fsf@alter.siamese.dyndns.org>
References: <1358555826-11883-1-git-send-email-gitster@pobox.com>
 <20130119165042.GB12307@sigill.intra.peff.net>
 <7vpq0zn2za.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, spearce@spearce.org, mfick@codeaurora.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 20 23:08:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx34T-0002qn-89
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 23:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546Ab3ATWIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 17:08:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50669 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752498Ab3ATWIg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 17:08:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C299BA3C;
	Sun, 20 Jan 2013 17:08:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0pJF5uVRMdEDCcs3evhxV9M5Swo=; b=YLb8XS
	Pe2vnq4wiYTOqu+b1ytw4L8cGM5MNPjRH/uNjRtxQzfT3xp+0UI2DUlr9tFD3WuP
	KFTigdj5zhtFvZpnZhSuXsxCy4v0r1qcVDA6Y7VaYJDVq7r3+FkY9+vMhsxOiRZc
	WtOny2tSLN/2k8A5rUej6lFo3P3S4Otozq9Is=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J2tCEHThdlxiP7Ic2epv9qn9ScTH+aVc
	yXwdQlOfA/MEQ6IORaePRfnxt+vLh0+RtDQsLo1/LXjafnasRHMNk5JEmZhPX5RY
	WBBOETwSbKlTHYXJzTgKvtBA6Xoqw40vwq4wm8lJyHEoi0ID/eaE13NK1SHa1MLA
	ktCd7YxPY+4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F867BA3B;
	Sun, 20 Jan 2013 17:08:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B326CBA3A; Sun, 20 Jan 2013
 17:08:34 -0500 (EST)
In-Reply-To: <7vpq0zn2za.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 20 Jan 2013 10:06:33 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EEF85222-634D-11E2-9E7A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214055>

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>>> 	[uploadPack]
>>> 		hiderefs = refs/changes
>>
>> Would you want to do the same thing on receive-pack? It could benefit
>> from the same reduction in network cost (although it tends to be invoked
>> less frequently than upload-pack).
> ...
> As I said, I view this primarily as solving the cluttering issue.
> The use of hiderefs to hide these refs that point at objects I do
> not consider belong to my repository from the pushers equally makes
> sense as such, I think.

Now that raises one question.  Should this be transfer.hiderefs that
governs both upload-pack and receive-pack?  I tend to think the
answer is yes.

It may even make sense to have "git push" honor it, excluding them
from "git push --mirror" (or "git push --all" if some of the
branches are hidden); I haven't thought things through, though.
