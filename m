From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: Break annotated tag ties by tagger date
Date: Sat, 10 Apr 2010 19:36:10 -0700
Message-ID: <7vwrwera05.fsf@alter.siamese.dyndns.org>
References: <0B8BD2B7-E6F9-4EFC-BCD6-2B2E876AD1FC@spy.net>
 <20100402183147.GA20007@spearce.org> <4BBB0377.8080007@op5.se>
 <20100411002825.GA23075@spearce.org> <20100411015433.GB23075@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>, Dustin Sallings <dustin@spy.net>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Apr 11 04:36:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0n2Q-0008EN-92
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 04:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751748Ab0DKCgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 22:36:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48518 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab0DKCgX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 22:36:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 766F6A96FD;
	Sat, 10 Apr 2010 22:36:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qHZmBCmfe+u9SDBWMR3XmDOKX7g=; b=KHWPKp
	DmZXcT53HMCQPiVP2NfaUoedEfNUFMhL8ezFH7IUf5WbTo0jcKjZIDvHT9Lvgbxf
	XCRCtXxQsRlDT00bJU4k5KNfp09d4xXl3n7r4LLyqiE+iXhjefGVSu/+fZqYRfzl
	yD9Uf41zc413xxU2ZDgEx3zKVZr4in51EFPbc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qpBE8ej2HaRppdD6bCR5AqNbXdNErbTR
	cnjTE7tpdWhl+aQ/bvsxozM5iI0nHqgxGuGNQTSMXE6OF9K0KQZApolS/bzSazoC
	xv/fVO61DD+Q3UxKue49LuZljSwgjXA/wuVah69jzmIXGq68drq7nz6LDeLZnvCt
	9z8QszaPj74=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAEA5A96F7;
	Sat, 10 Apr 2010 22:36:17 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0BDD3A96F4; Sat, 10 Apr
 2010 22:36:11 -0400 (EDT)
In-Reply-To: <20100411015433.GB23075@spearce.org> (Shawn O. Pearce's message
 of "Sat\, 10 Apr 2010 18\:54\:33 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0170A65E-4513-11DF-9B97-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144626>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> If more than one annotated tag points at the same commit, use the
> tag whose tagger field has a more recent date stamp.  This resolves
> non-deterministic cases where the maintainer has done:

I think it is a good idea to introduce this tiebreaker to give the listing
some degree of stability.  And I also notice that you prepared a patch
that can easily apply to an older codebase like 1.6.6 maintenance track.

I have anything against this as an incremental and low impact improvement,
but at the same time I think we might want to consider adding the tagger
date to "struct tag".
