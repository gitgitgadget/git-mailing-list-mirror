From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Wed, 09 Feb 2011 14:40:47 -0800
Message-ID: <7vipwsomq8.fsf@alter.siamese.dyndns.org>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann> <20110209210312.GB2083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 09 23:41:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnIio-0003Rx-2p
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 23:41:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab1BIWlD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 17:41:03 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:62866 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754265Ab1BIWlC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 17:41:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 158834875;
	Wed,  9 Feb 2011 17:42:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JbepynKWlxzs5nzxXtJXWbIv7xg=; b=eombpt
	w+C61UZCsda4yx4IDTOyGZMyXVd245GpmFE9pF+FaKE0nDqXFS/lvM7JY3/EorT/
	/6UrabwQHJ5dB2n9YJ9gREESoGGMPpClNPxGF3P0nrWoKTz4xUyfuCw33iByAcPk
	O/Gbm0kswxXcCUUIw7cKDrg4+wm4JSmH5oPF8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VgHR58btNy51pMhGJx2eoNN4NrnaepuS
	WHNcSgLg9u1RcpdfReEtUP5BEBQIfrstd0AIkONdkEltLvFDtR3qg4kWzuLaBp7R
	k1IvL7G4TprAO2CWV94jifa+nW1R3S8KuiCKLH+XdPyTyrFDfT3w8sF1Nafx/t6S
	0RoEjs7PISs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B190F486E;
	Wed,  9 Feb 2011 17:41:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2B3984868; Wed,  9 Feb 2011
 17:41:48 -0500 (EST)
In-Reply-To: <20110209210312.GB2083@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 9 Feb 2011 16\:03\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CBEC3BA8-349D-11E0-A0CB-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166450>

Jeff King <peff@peff.net> writes:

> The most compelling I have seen is "you tend to notice accidental
> full-tree sooner than accidental relative behavior". Which you mentioned
> in your email.

Hmph.  You earlier mentioned "oops, I just pushed this commit and it turns
out that I screwed up "git add" five minutes ago and it only had half of
the files I intended" problem, but "oops, I just pushed this commit and it
turns out that I screwed up "git add" five minutes ago and it had more
changes than I intended" problem would be equally annoying, and I don't
think one is inherently more likely to be noticed than the other; IOW, it
is not compelling, but is just an arbitrary and a biased observation, no?

The most compelling, especially if we _were_ designing from scratch to
make things consistent across the command set, would be "limiting to cwd
with single dot is a lot easier to type than counting ../, using / to mean
the root of the working tree is confusing, and saying --full-tree is
annoying".  I fully agree with that.

Can somebody volunteer to come up with a comprehensive list of operations
that will change their behaviour when we switch to "full-tree without
pathspec" semantics?  We mentioned "grep" and "add -u" already.
