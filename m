From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/4] i18n.patchencoding: introduce a new config
 variable
Date: Mon, 29 Nov 2010 12:23:21 -0800
Message-ID: <7vlj4b3mme.fsf@alter.siamese.dyndns.org>
References: <1290971417-4474-1-git-send-email-r0bertz@gentoo.org>
 <1290971417-4474-3-git-send-email-r0bertz@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "ZHANG\, Le" <r0bertz@gentoo.org>
X-From: git-owner@vger.kernel.org Mon Nov 29 21:23:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNAG7-0001Kf-Sv
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 21:23:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab0K2UX3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 15:23:29 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751501Ab0K2UX3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 15:23:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DE5A3779;
	Mon, 29 Nov 2010 15:23:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=pWswMURrnHXUh1ExKMC2/wUfQoQ=; b=Tx4uXFuvEtZTF6obDK5zaFn
	2S4D3ewCsOeeDRDj/XmI3xrRqaWK8fhomGEVsLcj3JUcsmDslEVVdrm+QepvI/uj
	dnov92hXsS4j0uQBjxEfZfrP/eQv8IJm5GM675ttw+HE3EQ7KkHPSyOZSj54fjvQ
	G+Q1jdABVy7RekuXIrPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MVCC4zjWV78muWpU4WG20yypxtmgiuXDkApdTV8zlSeskyCPG
	JtwES8WS96nFEhGUhNZ3PjAfw5Zn4nYAHrEg8aiJ/3iM5PlqfGk97JywxdVu+e6h
	ItKtQjrtxzxTbSTMRRHtohvQjndOg3CCMDaaiA+RsVPGDdnV+MplVqCLuU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4B5633778;
	Mon, 29 Nov 2010 15:23:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 35CA53777; Mon, 29 Nov 2010
 15:23:40 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 901B5B52-FBF6-11DF-AE80-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162422>

"ZHANG, Le" <r0bertz@gentoo.org> writes:

> This varible will be used by git mailinfo's --recode-patch parameter only.

I have a few complaints and observations about this:

 - The patch order is screwed up in the series.  Without knowing what
   the --recode-patch option does, the reader is forced to look-ahead
   before judging this patch.

 - No documentation in the same patch as the feature is added.  I am
   guessing that the new configuration variable (and the new option we
   will see laster) means "the patchfile I got is in this encoding but the
   mail header does not mark it as such, so I am giving what encoding it
   is", but this forces the reader to look-ahead.

 - "It will be used by ... only", says who?  In an environment where
   people send patches in a local encoding but want to keep their
   repository in a different encoding, it may not be totally implausible
   to wish "format-patch" to pay attention to this variable to _produce_
   the output in that encoding, especially given the name of the variable
   that does not say anything about in which direction it is used, no?

 - Assuming that I guessed the meaning of this option and parameter right,
   I am not sure if this should be a configuration variable.  It implies
   that the majority of patches, if not all, are in this single local
   encoding that is different from the encoding used in the repository.
   Is it common?  I dunno.
