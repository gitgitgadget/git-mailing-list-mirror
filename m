From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Bug - diff in commit message.
Date: Thu, 08 Sep 2011 10:27:14 -0700
Message-ID: <7v39g7x7v1.fsf@alter.siamese.dyndns.org>
References: <1315493353942-6772145.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: anikey <arty.anikey@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 09 01:02:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1nbo-0007Gg-DU
	for gcvg-git-2@lo.gmane.org; Fri, 09 Sep 2011 01:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754102Ab1IHXB4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Sep 2011 19:01:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756688Ab1IHXBk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Sep 2011 19:01:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B11546F4;
	Thu,  8 Sep 2011 13:27:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qgYk3yeZ20dAlgyWWFbRXWfYcU8=; b=NHJ+gf
	I9G/ryZLU0fXebwqB0earq3o9LpxzKSLtqMXsgBu0AzuXzUkhADt5J+csVQ3XU2B
	KKHfSfReqREcALGKbXz8gLEEw9F4T8HJgDNLnEHVDgfq0cDw8PKlwBcRF6f+K5eL
	SUke0lnQCzFVEtOalj/wzN25mOApHwOqQezVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OK2xa5K67+XfdDHnXkulk3Sy4X/LuG68
	hN15Nbq2c/aw2jVpebX5ltZ/3fT/wXHKzyLG2nxYylNweCNyGPEaL4TLIbzDEcwF
	Gq9vaj37gBOPyKAuOX8BexQ4AzjkXMi7nA69VjT6/Qp5/b3DMUL/csDvZAMeEPwK
	tmXU/2Gn8HA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53D4146F3;
	Thu,  8 Sep 2011 13:27:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C222646F2; Thu,  8 Sep 2011
 13:27:15 -0400 (EDT)
In-Reply-To: <1315493353942-6772145.post@n2.nabble.com> (anikey's message of
 "Thu, 8 Sep 2011 07:49:13 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBCC0520-DA3F-11E0-943A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180994>

anikey <arty.anikey@gmail.com> writes:

> Hi, peops. I'm pretty much sure that's a bug.

I am not Peops, but will try to help ;-).

As "rebase" is essentially "format-patch" output piped into "am",
unindented diff in a random place inside the commit message will be
indistingushable from the beginning of the patch. You cannot have an
unadulterated "diff" output in your commit message for this reason, and
this is not likely to change.

Often what people do is to indent them, as the reason they quote patch in
the message is to make it serve as a supporting material. Incidentally,
that makes the resulting commit log message easier to read as well; e.g.

        Fix bloop bug

        An earlier commit had this patch that is quite bogus.

            diff --git a/bloop.php b/bloop.php
            index 937da74..0e8440d 100644
            --- a/bloop.php
            +++ b/bloop.php
            @@ -42,7 +42,7 @@
            ...

        The assignment to frotz in the above hunk should happen after
        nitfol variable is initialized.

        This patch fixes it.

        Signed-off-by: Cont Ributer <contributor@example.com>
