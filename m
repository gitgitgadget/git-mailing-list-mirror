From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Refspec wildcards for remotes require trailing slash
Date: Tue, 10 Dec 2013 11:14:33 -0800
Message-ID: <xmqqzjo8tt5y.fsf@gitster.dls.corp.google.com>
References: <3B290FD1-EF2B-4419-8845-45C5A3B4A3D3@sweattechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Monte Goulding <monte@sweattechnologies.com>
X-From: git-owner@vger.kernel.org Tue Dec 10 20:14:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqSlW-0004hP-VA
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 20:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689Ab3LJTOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Dec 2013 14:14:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab3LJTOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Dec 2013 14:14:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC9E55A0AC;
	Tue, 10 Dec 2013 14:14:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ECe8h2LsL9/QmB1xdSOmcjgcA5Y=; b=wNNJrt
	qJ7E+bK898iwC+DBCsaqx7xuw8pKhiXbpjFR+zQV1fvHDpC4Ss9w/GaF6Zewl/gq
	r7wiXRtEqyAc+ED1txjUOJkruXdv8GDq0F0yFj/QS5HrUIX0HlnEpUXLmTbojVpg
	+kJW9yaG5PkUhMGS2WLXiH7GLyooZw6+aowpA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BiIMGGYD20EObe+RH+omn2DS0bR1jbzx
	Ido2Ue47MQMnFjBCWl/2iknvFBXUDrlAQ9dkLcQVsE+x4Q2vt2c7O74d2fIiu8JG
	zsW8sFHEcQLe98Xje7rX87COj6fMt4IuS0gPZs0cb4YOcRXfCwm2Tnng0H/sDJb5
	NLoU41Um6NA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 832A75A0A9;
	Tue, 10 Dec 2013 14:14:37 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D0985A0A8;
	Tue, 10 Dec 2013 14:14:36 -0500 (EST)
In-Reply-To: <3B290FD1-EF2B-4419-8845-45C5A3B4A3D3@sweattechnologies.com>
	(Monte Goulding's message of "Tue, 10 Dec 2013 13:32:26 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4EE96042-61CF-11E3-856D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239152>

Monte Goulding <monte@sweattechnologies.com> writes:

> Before I go ahead and look at what needs to be done for a patch I
> thought it would be polite to ask if there is any reasoning behind
> the trailing slash rule that I'm missing? Or if you are interested
> in changing this behavior at all.

The log messages of the two commits you cited in your message says
that "refs/a/b/* should not match refs/a/b1, but the old code
mistakenly allowed to".  As long that fix is not broken, allowing
"refs/a/b*" to match "refs/a/b1" is OK, I would think.

But it is debatable if such a change should allow "refs/a/b*" to
match "refs/a/b/2".  Arguments can be made in both ways, and my
knee-jerk reaction is it shouldn't.
