From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/githooks: Explain pre-rebase parameters
Date: Tue, 19 Feb 2013 09:05:58 -0800
Message-ID: <7vliak6xop.fsf@alter.siamese.dyndns.org>
References: <c19c03f51d71a58fa3795f665fe4a4c0461fa58f.1361271116.git.wking@tremily.us>
 <878v6ksars.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 19 18:06:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7qeB-0001r0-HC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 18:06:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932752Ab3BSRGD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 12:06:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47341 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758479Ab3BSRGB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 12:06:01 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 872C5A160;
	Tue, 19 Feb 2013 12:06:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/4wBnXsyT5V1OiTAiJtfXUdYCHM=; b=qD5Xhp
	kOsTUjD50jsQmYeCU0R1cXVYi/6r9CTOLoRkrZ8IKoJA0txpD+7QONs3TdL6EfBF
	NUvhVUYEwAbyFiL5o+2EaqJnU9GB0IgIBjc5cYgH7wLRVBI23gSjkDIgnloE3OjN
	bzlKUnW7s5TpXGn2SsTrs0SYEYV8UHz+7ZnxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mrtykt4USGMoUJ9qmlcX2NxkZ6X/dsvP
	PhoSjca7rMHPT3L4k25OogfizGF30LYrMSYVIXGIC+dMKSXPvMLR2keGEqfYcrf6
	18fPLDYDwvpQ8G/W+jkXl6k16dM3SshVgfa+Vb8mr2HnIfD+FTkaLrftBpAUgJ6T
	LzuEL4/Wdo8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 77F71A15D;
	Tue, 19 Feb 2013 12:06:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E9C90A15C; Tue, 19 Feb 2013
 12:05:59 -0500 (EST)
In-Reply-To: <878v6ksars.fsf@pctrast.inf.ethz.ch> (Thomas Rast's message of
 "Tue, 19 Feb 2013 14:17:43 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A245D690-7AB6-11E2-BEF3-21622E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216634>

Thomas Rast <trast@student.ethz.ch> writes:

>>   "$GIT_DIR/hooks/pre-rebase" ${1+"$@"}
> ...
> IIRC this particular usage was designed to suppress warnings about unset
> variables.

This is an old-timer's habit to work around buggy implementations of
Bourne shells where they failed to expand "$@" to nothing when there
is no parameters, feeding a single empty argument to the command.
By explicitly writing ${1+...}, the construct makes sure that when
we have no parameter (i.e. $1 is unset) we do not even look at "$@".

It is equivalent to "$@" in correctly implemented shells.
