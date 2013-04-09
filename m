From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-am doesn't apply the rest of the email after a partial patch
 fail?
Date: Tue, 09 Apr 2013 11:57:28 -0700
Message-ID: <7v1uajsfaf.fsf@alter.siamese.dyndns.org>
References: <CAPKkNb43bWupbOaAntF8VJQ8ZJjt8SG-mZa3GohxZEAZQm-evQ@mail.gmail.com>
 <7vppy4ykse.fsf@alter.siamese.dyndns.org>
 <CAPKkNb6tbGtcpiYGpj6mSPnp_-aXO=HTvAjOEKJ1f-cgPOHBDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 20:57:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPdju-0001p1-ID
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 20:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935873Ab3DIS5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 14:57:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51327 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935844Ab3DIS5j (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 14:57:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D53015586;
	Tue,  9 Apr 2013 18:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fcu402MFZFfnWPmSNN9bX3ulcJ4=; b=Aax2JO
	a7nz7qUo4tjGe1Ue7+AlbKcT8dRLHTO1NQji9Z3G2sWT0XMPA8Itz2dUTmLqQM52
	OPelXXRMyoj0TrPQdW28hmJHzeYvlgwru5pLgdDVLSwiwqfvH1epeqNglq6kbtvD
	8RwubffPdonBFvSRXTHbqne2cDY+WkP1T/K80=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g5C+u8ynsj70o1sYDZyO2/zBZXNriX8p
	6rEn3FVxaPIdzxu2jwLYS+FEgb0eyI/ZfscTNqIO8MnfVWoXzCBpSehVLmxOfbzx
	ZZDPfVtI+AuIiDpTIFdlxO2qofF/8+ArIh3ijrc6rHUHrZgF/k4+1WO3xA/X5OCU
	Q9oudHIGOAg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 347A215584;
	Tue,  9 Apr 2013 18:57:39 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30C9A1557A; Tue,  9 Apr
 2013 18:57:38 +0000 (UTC)
In-Reply-To: <CAPKkNb6tbGtcpiYGpj6mSPnp_-aXO=HTvAjOEKJ1f-cgPOHBDA@mail.gmail.com>
 (Constantine A. Murenin's message of "Tue, 9 Apr 2013 11:34:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 58FA0D8C-A147-11E2-91DF-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220615>

"Constantine A. Murenin" <mureninc@gmail.com> writes:

> Well, I now know this, but it wasn't clear from the documentation that
> that was the behaviour.

Yes, the message "after you _resolved_, please tell me you are now done"
is too fuzzy.  What it wants to say is:

	I punted, because the patch does not apply, and it is stored
	here.  Update the index to hold contents that the sender of
	the patch would have liked to see if the patch were to apply
	cleanly.  Tell me when you are done, with "am --resolved".
	Then I'll commit that content in the index for you with the
	authorship and log message I learned from the e-mail and
	continue.
