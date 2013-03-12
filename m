From: Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 14:47:38 -0700
Message-ID: <7vppz45lz9.fsf@alter.siamese.dyndns.org>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
 <alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
 <20130312041641.GE18595@thunk.org>
 <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
 <20130312212027.GE14792@thunk.org>
 <CA+55aFwHJtOU4Qzt3XZsER165kTc5P0ATQP2wPHvuUiVic8bnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Theodore Ts'o" <tytso@mit.edu>, James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: linux-kernel-owner@vger.kernel.org Tue Mar 12 22:48:14 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1UFX3N-0003IT-2X
	for glk-linux-kernel-3@plane.gmane.org; Tue, 12 Mar 2013 22:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933670Ab3CLVrn (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 12 Mar 2013 17:47:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57571 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933648Ab3CLVrl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Mar 2013 17:47:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F29C1AF0E;
	Tue, 12 Mar 2013 17:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Ro8ORYTpFo4sPAiCow9axGApqY=; b=djByAn
	PNThQibNewbs29bKbUPWTvfZcPrsCmT0FIklWeSDg2DsjQtram/jfM3VuNcum0Q2
	hIcr0uXzHeEYQKoG8n8VsuIenPTFMeMaFWw52F01iW8DHQIdA3hyKJRzDs10iuR3
	GnlWWY1JwpnPVkUpAn2ttn6vkLkC3Y5pVRNC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ctGvM9WZbjVTiLnoysS3vo8TTJP3ZuTY
	QUAOLzmp5xgByaSbz+YWLp6NtzQAJDDM6jj82L8AKkqlQcG2r4Xe4uYWwYszl3LN
	1Kimzauy7yuhE2CgeHv/vPAr6K06poYjlsRa+9icOT7Dw7OJtDwzaSGylW7mrodD
	g+5t9PergXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6880AF0D;
	Tue, 12 Mar 2013 17:47:40 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 66C3EAF09; Tue, 12 Mar 2013
 17:47:40 -0400 (EDT)
In-Reply-To: <CA+55aFwHJtOU4Qzt3XZsER165kTc5P0ATQP2wPHvuUiVic8bnA@mail.gmail.com> (Linus
 Torvalds's message of "Tue, 12 Mar 2013 14:28:39 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 76690B42-8B5E-11E2-829A-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218000>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>  - I do think that we might want a "--no-signatures" for the specific
> case of merging signed tags without actually taking the signature
> (because it's a "upstream" repo). The "--ff-only" thing is *too*
> strict. Sometimes you really do want to merge in new code, disallowing
> it entirely is tough.

I agree that "--ff-only" thing is too strict and sometimes you would
want to allow back-merges, but when you do allow such a back-merge,
is there a reason you want it to be --no-signatures merge?  When a
subtree maintainer decides to merge a stable release point from you
with a good reason, I do not see anything wrong in recording that
the resulting commit _did_ merge what you released with a signature.
