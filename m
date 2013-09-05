From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/5] Disable "git status" comment prefix
Date: Thu, 05 Sep 2013 12:13:44 -0700
Message-ID: <xmqqhadzhyjb.fsf@gitster.dls.corp.google.com>
References: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Sep 05 21:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHf0A-0003oO-IQ
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 21:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756951Ab3IETNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 15:13:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41935 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752581Ab3IETNx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 15:13:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69E3E3F0F9;
	Thu,  5 Sep 2013 19:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wpCkAmbsd8uSA4qAIXsCfR7gu4M=; b=MDrc+u
	J6VW9flgOKLPMbC0mirgYK90/4GdVGP3Fy+kohkwVvBWcB+jNruT2294iRcomg6H
	EqPzTv5tRIHtqZFrvZTBlsRiobKp1YFaPS3y7yinmiyZVB8iN1bUOKszD+dcrWn3
	IMujepZcWBk3WE/UG4DAqMrazVNNMrfqf5vAo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a3epZTLVRu9s4chlOQgE+eZCtN0GRn7l
	aatS/m7xlsGt9U1PE61Kf85A4orkR2c2sOdzE+AUSpQjoqNcj9r00gaJ9Irr/SGA
	Yd8Oarir7yDWI+omYXUsHA148ypgNOZeoaugnXSfy6X5rc0KBKVFjxr3S6gfQpaz
	/zlyMPK6cG4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C50B3F0F7;
	Thu,  5 Sep 2013 19:13:51 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 521393F0F0;
	Thu,  5 Sep 2013 19:13:49 +0000 (UTC)
In-Reply-To: <1378374618-31439-1-git-send-email-Matthieu.Moy@imag.fr>
	(Matthieu Moy's message of "Thu, 5 Sep 2013 11:50:13 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4B75BCE6-165F-11E3-9EA6-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233983>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Compared to v2, this changes essentially:
>
> * The prefix is actually disabled by default in this version. As a
>   consequence, the option is renamed to status.oldStyle.
>
> * Since this is the default, the tests are updated to test the new
>   defaults. In a first patch, I'm setting status.oldStyle=true in test
>   files that require it (to keep the patch short), and the last patch
>   actually updates the test expected results. This was actually useful
>   as I did find (and fix) a few bugs updating the tests:
>
>   - the --columns option was still showing the comment prefix
>
>   - "git commit --dry-run" and failed "git commit" were still
>     displaying comments to stdout.
>
> * The --for-status option is kept as a no-op.

Much nicer.  Will replace and queue.

One caveat, though.  The name "oldStyle" will become problematic,
when we want to remove some wart in the output format long after
this "no comment prefix by default" series lands.  Some people may
expect setting oldStyle=true would give output from 1.8.4 era, while
some others would expect that it would give output from 1.8.5 era
that does not have comment prefix but still has that wart we will
remove down the line.

It is a common mistake to make to think that one is making the final
change to the code and the result of that final change will stay the
latest forever.  I am sure I've done that for a few times and later
regretted them.
