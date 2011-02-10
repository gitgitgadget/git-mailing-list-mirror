From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Wed, 09 Feb 2011 18:46:38 -0800
Message-ID: <7vd3n061yp.fsf@alter.siamese.dyndns.org>
References: <vpq1v3kopn3.fsf@bauges.imag.fr>
 <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org>
 <20110207195035.GA13461@sigill.intra.peff.net>
 <20110208100518.GA9505@neumann> <20110209210312.GB2083@sigill.intra.peff.net>
 <7vipwsomq8.fsf@alter.siamese.dyndns.org>
 <20110209234621.GA12575@sigill.intra.peff.net>
 <AANLkTi=dmqRQqBD2HZfv2x-kxaqrxvSx3r62d09KMP1k@mail.gmail.com>
 <20110210023132.GB5073@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Git ML <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 10 03:47:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnMYf-0002eB-NV
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 03:47:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754320Ab1BJCq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 21:46:56 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319Ab1BJCq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 21:46:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2F1274382;
	Wed,  9 Feb 2011 21:47:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yWX/p2q//hx3uZYyUScMb4YMFWM=; b=Cnqt6l
	G5Kk+lDrHlWSx58HDpMM3d5iu9oNPwwtNESH22A6Ug5kNrdUuMqNRRfIbiuh7Yj1
	rjOh91aO5plb8HHz30yxLE2bvT8Fa8rkf3T+qYCVU/hqfWY7e5eExxNQlK1oO7bz
	oPGyk9NVafWCCKaFtPZwhwE1bpxC42StmwCjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yNDaNvDgj+X2K670uPKRpGbRoU1SG2IC
	RsGvRCZEGjdQOUuuBRTuJJjRgNAk5KFMAKiw1MiMCE2GvAJwljEPtrYsPtO6fqNe
	Q0R4y+5weediAn6ty1B6jvvdMvRrqctAFKARw1ReBgzQow0kmcP1XD5U9tME2N+v
	CUEp+I+PJko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C12E04380;
	Wed,  9 Feb 2011 21:47:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CE323437E; Wed,  9 Feb 2011
 21:47:39 -0500 (EST)
In-Reply-To: <20110210023132.GB5073@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 9 Feb 2011 21\:31\:32 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 256DEA60-34C0-11E0-B308-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166470>

Jeff King <peff@peff.net> writes:

> ls-tree already has --full-tree (and --full-name, which just gives full
> pathnames but still restricts output to files in the current directory).
> ls-files. ls-files has --full-name, but AFAIK needs a matching
> --full-tree.

... and --no-full-tree, if we were to make the default tweakable from the
configuration mechanism for Porcelain commands.  The convoluted logic
would go like this:

 1. 'git clean' can be made default to the full-tree operation by
    setting "porcelain.fullTreeOnNoPathspec = yes";

 2. a script may want to defeat random configuration the user may have and
    'git clean --full-tree' and 'git clean --no-full-tree' are the ways to
    force the semantics it wants;

 3. 'git ls-files' will keep the default of cwd-relativeness, but will gain
    'git ls-files --full-tree'; naturally people expect --no-full-tree to
    work, even though the command will not be affected by the configuration
    variable porcelain.fullTreeOnNoPathspec.
