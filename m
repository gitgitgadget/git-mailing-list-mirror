From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Fri, 04 Jun 2010 23:38:39 -0700
Message-ID: <7vpr060ys0.fsf@alter.siamese.dyndns.org>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <08e635cee993d97e2a38d7766ced11c064ef7d87.1275575236.git.git@drmicha.warpmail.net> <7vsk537p8k.fsf@alter.siamese.dyndns.org> <4C08AD75.6040307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Jun 05 08:40:04 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKn36-0005d9-91
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 08:40:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754588Ab0FEGit (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 02:38:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39568 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450Ab0FEGis (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 02:38:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20D53B9153;
	Sat,  5 Jun 2010 02:38:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cr6VfqE3KR88Ol5dapuMLo+06OU=; b=rNT0hO
	m1LsLtkNUtyJZ4PYE+hnQUzkKiQFFhDBVzsLK8BCqszAI87+OFBk3pdpwwlTPxtp
	OyUtCyjx4Duj6dVXJKjbCgMDJJuynzeBlxibPvxBETU4i53CLxuH2ttEXxliDK72
	QM3QEqblRsXjU/9XjhQ7DB/LDCDWzuYiZthG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KB9G366PMSq7RWs0qtTiJZlHeJjgrCi2
	Wqw79oqIwKJNQr2tkqFSShz/VkiaFpvuiNdNfLd1wBgyqZVcIJtxaGIW8YZ54K0m
	96pk179ebO2PSkeePKtdQnrmni63GHLq6SgDESWrF9duWdpd7vX6xbPSAYQ+jn91
	Qh1oVpnzvDE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA60AB9152;
	Sat,  5 Jun 2010 02:38:43 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F3E4B9151; Sat,  5 Jun
 2010 02:38:41 -0400 (EDT)
In-Reply-To: <4C08AD75.6040307@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri\, 04 Jun 2010 09\:38\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FC7DB350-706C-11DF-AE53-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148457>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> In 3/4, that "No NL at EOF" is suppressed for symlinks *when textconv is
> in effect only*, i.e. when we don't (necessarily) produce a diff fit to
> be applied anyways.

Sorry, that doesn't change a thing at all.  The presense of incomplete
line is part of the information diff gives you.

It can be done by defining a custom textconv filter that adds a trailing
LF to a blob that ends in an incomplete line, and what your patch 3/4 does
is essentially to create such a built-in textconv filter and *force* users
to use it unconditionally for all paths unless the user explicitly asks
not to use *any* textconv.
