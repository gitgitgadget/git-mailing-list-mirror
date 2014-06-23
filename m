From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: git grep -P and multiline mode
Date: Mon, 23 Jun 2014 10:42:18 -0700
Message-ID: <xmqqa993cykl.fsf@gitster.dls.corp.google.com>
References: <53A7CF25.7060508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Noel Grandin <noelgrandin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:42:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz8GO-000439-T0
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:42:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbaFWRmh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:42:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63764 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756633AbaFWRmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:42:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 218B322CA2;
	Mon, 23 Jun 2014 13:42:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p9yra6DpDv1JLf8UEOamIf1mNKU=; b=DfAzEA
	HEGzzZI0ltT05vZT1hy5sv/75av2o53Zq3bDmH7ezxCqIeZ5kgBD4sOQYpKDo4Uz
	SYqCbndGC7/EGdVrYI1NIQw78M73jtE//Wez9PsNzgurYEhq09MKZ/7jn4Ifu8nM
	TO1OhtJdj2aESmKbs0jA7iaUNX1LT3KZJ8v2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pnaTTtIHk04a0GE7T4PF2+NLFwN9ziAi
	GhcXvnoSWVscA4PJyxTufN1G9O1frfnn20jTL+Cf9LwLa58PAoUCLR0gi1Op85YP
	XHzjYzwgE6CzYQ4SmdT+MWk2gkHrkQj7fjU57MTBh1izFO9upS0OzpPS/FOyTWF8
	F4bpcuYfbkw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 17D8D22CA1;
	Mon, 23 Jun 2014 13:42:20 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A9B9A22C9E;
	Mon, 23 Jun 2014 13:42:15 -0400 (EDT)
In-Reply-To: <53A7CF25.7060508@gmail.com> (Noel Grandin's message of "Mon, 23
	Jun 2014 08:54:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B71CE6E4-FAFD-11E3-8D13-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252361>

Noel Grandin <noelgrandin@gmail.com> writes:

> It looks like the perl regular expression multiline mode does not work with 'git grep'

Yes, and deliberately so, to avoid having to think about things like
"how would a multi-line match interact with 'grep -n'?"

We behave as if we feed each line of the contents one line at a time
to the matching engine that is chosen by the -P/-E/-G/-F optoins, so
this limitation is unlikely to change.
