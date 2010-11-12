From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHi v4] git-send-email.perl: make initial In-Reply-To apply
 only to first email
Date: Fri, 12 Nov 2010 12:53:35 -0800
Message-ID: <7veiaqfels.fsf@alter.siamese.dyndns.org>
References: <7v62w5hsd4.fsf@alter.siamese.dyndns.org>
 <1289573708-18573-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Stephen Boyd <bebarino@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Antonio Ospite <ospite@studenti.unina.it>
X-From: git-owner@vger.kernel.org Fri Nov 12 21:54:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH0dH-0003Nf-Cc
	for gcvg-git-2@lo.gmane.org; Fri, 12 Nov 2010 21:54:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127Ab0KLUx6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 15:53:58 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50636 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab0KLUx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 15:53:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1C35135C1;
	Fri, 12 Nov 2010 15:54:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=flNyGnHxBS1xevQ1NedJvl3Mrns=; b=ahfWJS
	Mh7U7KBaD0dzthLeYHMfSsGCMqbAp5HbV4tPtqgsbLYS6gZ/RXNwJq4SDZ9M9RCu
	qRtjlWnNR9iU7ILLCJNBVwiWyiyCiIt/zmdxSU3Qb1WDpLgwrWjgr4vdE2s1TBDl
	AMU1KagpCcEz44zUHo+bnejZorJ5WmhJKBHEE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pgisBn78+iWnh3+Lc2PMXE8PSfSv7j29
	/n9P0BU7LwhqH95fBxVPQANG32WvVrqjjzxNd8TN7T+vgoZkEl/uFrhBGAPTwmV1
	ERBeyzgSa8Y2Kvou55MuvQlJIRE5KxiI9smdUCdyrlXCliJS9OVBpxTTHk0lw1WJ
	xg8VJWgkFyE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 93C2C35BF;
	Fri, 12 Nov 2010 15:53:52 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 77C2E35BB; Fri, 12 Nov 2010
 15:53:42 -0500 (EST)
In-Reply-To: <1289573708-18573-1-git-send-email-ospite@studenti.unina.it>
 (Antonio Ospite's message of "Fri\, 12 Nov 2010 15\:55\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F4EACF64-EE9E-11DF-AF21-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161361>

Antonio Ospite <ospite@studenti.unina.it> writes:

> When an initial In-Reply-To is supplied it should apply only to the
> first email, second and subsequent messages should behave just according
> to the --[no-]chain-reply-to setting; this is also what the man page
> says about the --[no-]chain-reply-to option and this is also how the
> correspondent git-format-patch option behaves.
>
> This is the typical behaviour we    |
> want when we send a series with     | [PATCH 0/2] Here is what I did...
> cover letter in reply to some       |   [PATCH 1/2] Clean up and tests
> discussion, the new patch series    |   [PATCH 2/2] Implementation
> should appear as a separate subtree |   [PATCH v2 0/3] Here is a reroll
> in the discussion, look at the v2   |     [PATCH v2 1/3] Clean up
> series in the illustration on the   |     [PATCH v2 2/3] New tests
> right to see what the new behaviour |     [PATCH v2 3/3] Implementation
> ensures.                            |

Yuck.

It is a common trap to think that everybody already knows what you have
been suffering from.  It certainly is sufficient to show the output after
your patch to convince them that your change is a good thing.

IOW, if you do two-column, please do it right ;-).  The LHS should show
how the output _used to_ look like, so that even people who didn't
particulary care (because they never hit the issue) can see why the
updated behaviour is desirable.
