From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/4] show: obey --textconv for blobs
Date: Wed, 06 Feb 2013 15:49:44 -0800
Message-ID: <7vr4kt9f53.fsf@alter.siamese.dyndns.org>
References: <20130205201106.GA29248@sigill.intra.peff.net>
 <cover.1360162813.git.git@drmicha.warpmail.net>
 <883f0163cb732932061a368ea9bc187c13e4ecca.1360162813.git.git@drmicha.warpmail.net> <7vmwvhmli7.fsf@alter.siamese.dyndns.org> <20130206221240.GC27507@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 07 00:50:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3Ekl-000600-AC
	for gcvg-git-2@plane.gmane.org; Thu, 07 Feb 2013 00:50:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758005Ab3BFXts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2013 18:49:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52399 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755489Ab3BFXtr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2013 18:49:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BB011B2F5;
	Wed,  6 Feb 2013 18:49:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5VhmSZ0lsD70/R/wwoTil0YDVuU=; b=II+aWR
	ML6rB4Wl4a4nIGDsgMbKPow7Pi/vo5oyjfVG8YP4EUyfsYria7GaInw6TESwnTPt
	WRE2QoSKMr3GVSJrOsQchlsJIuugfk8AlQJ7cs4cv80/fIKupHD0pdxQL5SgKtXt
	ORv6qLRKRQVKKP6Crc29Gs+huwjktKfrwToQQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A066B1ZpaasOA5U54ICdvR7SWEnvFVML
	4lvPt8Nai4tw4OsADeTkmorMIyhQ7jCXtFsJrd1pTFSudBiVOIageDrL+lhv64JF
	CAroNMANTfb9JJFqzjtFrRU0S6H/P/HnNLteZt8caoZflllY8vUm/3F83+Qn3jk3
	xKFDjM4EeTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE1F7B2F4;
	Wed,  6 Feb 2013 18:49:46 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 313E1B2F0; Wed,  6 Feb 2013
 18:49:46 -0500 (EST)
In-Reply-To: <20130206221240.GC27507@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 6 Feb 2013 17:12:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2DEA2BC-70B7-11E2-984A-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215665>

Jeff King <peff@peff.net> writes:

> And stating it that way makes it clear that there may be other missing
> steps (3 and up) to apply other gitattributes. For example, should "git
> show $blob" respect crlf attributes? Smudge filters?

Yeah, I think applying these when path is availble may make sense.

Are we going to teach cat-file to honor them with "--textconv" and
possibly other new options?

Or should the "--textconv" imply application of these other filters?
I am tempted to say yes, but I haven't thought things through...
