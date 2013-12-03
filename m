From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] gitweb: Move check-ref-format code into separate function
Date: Tue, 03 Dec 2013 11:48:09 -0800
Message-ID: <xmqqzjohn2bq.fsf@gitster.dls.corp.google.com>
References: <1386082603-8404-1-git-send-email-krzesimir@endocode.com>
	<1386082603-8404-2-git-send-email-krzesimir@endocode.com>
	<xmqqd2ldoj0s.fsf@gitster.dls.corp.google.com>
	<CANQwDwd0_bgKfjsRFjohmzBAnN7vDm-pYYsfe0Q71Za2K7Hw4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Krzesimir Nowak <krzesimir@endocode.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 20:48:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnvxE-0003EP-EQ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 20:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754754Ab3LCTsR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 14:48:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61929 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753755Ab3LCTsP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 14:48:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B9E955FAB;
	Tue,  3 Dec 2013 14:48:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=T/NmIRFPxfCw
	hnCBRRbrzMVnEgc=; b=qoudN4n79j2p56ZuzNpSfBf4Gkn7VMUjAY2d4WN53OQk
	1br8JfzZ970AWQD7SC5lrWpvGhYgJMlF+cVs7eKL0VtCPZEO+XLQflaRKP0MWLwD
	TjqgyhQ8wnDFOJQ6yV+Ao39lnNtXrHcFRp9/YiHR8PtA+HpZGsUoP4lMGLwgLG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Y9+B+5
	K9lFhAwgYynmk5v4ci5HeaIDxEqEyklgvxY5huq1WdBGngu245Sr0vADFqoBLIxH
	f4kaYJm9vXk65UtpdwX/nDYm+FfbCZkeSXAfMTjCeO3Mu0SNtpZ+sJhDpB4tuWm0
	mHPx0I0tBn+0ytVN+nerLmatvmr57MixNpRoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA3055FAA;
	Tue,  3 Dec 2013 14:48:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCE5755FA8;
	Tue,  3 Dec 2013 14:48:11 -0500 (EST)
In-Reply-To: <CANQwDwd0_bgKfjsRFjohmzBAnN7vDm-pYYsfe0Q71Za2K7Hw4w@mail.gmail.com>
	("Jakub =?utf-8?Q?Nar=C4=99bski=22's?= message of "Tue, 3 Dec 2013 20:38:39
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D77BBCB0-5C53-11E3-8C8D-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238726>

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Stricly speaking pure refactoring (no functional change, e.g. no assi=
gn
> to $input) would be  "check_ref_format($input) or return undef;", or =
even
> "return check_ref_format($input);" if we keep check_ref_format() pass=
thru
> on valid refname.

Exactly.
