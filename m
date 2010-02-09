From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] git-imap-send: Add method to convert from LF to CRLF
Date: Tue, 09 Feb 2010 10:20:50 -0800
Message-ID: <7vbpfye0e5.fsf@alter.siamese.dyndns.org>
References: <7vaavj8h1k.fsf@alter.siamese.dyndns.org>
 <1265717345-2118-5-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <alpine.LFD.2.00.1002090918180.3829@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>, gitster@pobox.com,
	git@vger.kernel.org, Jeremy White <jwhite@codeweavers.com>,
	Robert Shearman <robertshearman@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:21:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Neui2-0005vR-Ar
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 19:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab0BISVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 13:21:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49039 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751151Ab0BISVE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 13:21:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 40878986DC;
	Tue,  9 Feb 2010 13:21:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o6ZjWsIdxOwIOi8/5gwNV1LLyb8=; b=r8OICo
	Wj+rLGZo9hZ+jhf3ht+e+xF4dabJhspdR6jzsXFjbzj+65oi18kY6BNZsz1uK6eQ
	rgQbVetbtSmuEo7MSy1JNu/s2sUgf1TS/rtB4Db2vyQLJJoRv9rhIzJ1kVSqR3Rm
	0Mgw+T/vDMZSwuHCc1uBIXbgpfgE/Cdx/CBx0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XtAdf503tAEoXBOY3/W/Zg8TumPQMeyh
	lRrZLdNNx0nasBFmnlI5KhrH8X3JizNunaJe1RdIWkL3hPoj/E80B/C/oNdxaJY3
	wsoz+cK0pBWK6Hndt3z/2cN7FBOaFNzQJ5hIaDvaeCaW6Lbmxbx2gUuzl1SdeV81
	gAKzTSiUAlo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E57C5986DA;
	Tue,  9 Feb 2010 13:20:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF2D9986D8; Tue,  9 Feb
 2010 13:20:51 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1002090918180.3829@localhost.localdomain>
 (Linus Torvalds's message of "Tue\, 9 Feb 2010 09\:24\:51 -0800 \(PST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DEFA768A-15A7-11DF-932E-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139429>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So I suspect that CRLF should be unconditional.

That matches my reading of the RFC.  Thanks.

Hitoshi, can we have a modified version of 4/4 as a separate patch, so
that we can apply it independently from the rest of the series?

As to the MD5 implementation, I am somewhat torn.

Even if your md5 implementation were vastly superiour and faster than
OpenSSL one (I don't know), the use of MD5 is not performance critical
like SHA-1 is (for which we uniformly use Linus's block SHA-1 these days);
the only thing it would be buying us to have our own implementation is one
less dependency for people who do want to use imap-send with CRAM-MD5 but
without SSL support.  How common is that combination?
