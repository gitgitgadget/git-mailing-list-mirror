From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] convert: Safer handling of $Id$ contraction.
Date: Tue, 02 Mar 2010 17:10:57 -0800
Message-ID: <7vljeamcpq.fsf@alter.siamese.dyndns.org>
References: <1267460218-1172-1-git-send-email-grubba@grubba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Henrik =?utf-8?Q?Grubbstr=C3=B6m?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Wed Mar 03 02:11:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmd7K-0006rZ-S1
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 02:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963Ab0CCBLM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Mar 2010 20:11:12 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48201 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434Ab0CCBLL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Mar 2010 20:11:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 677329ECCA;
	Tue,  2 Mar 2010 20:11:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=XLEUbl6K6KMYUHSFQqsrfqAam
	80=; b=YxL1XCyn+Vfw2bJztR4Fwf+EWUi/Or4tNdL9vmjJZJnfe5bCTt8KaPBZh
	6LWj8Op13OM9zgwt4lVz6AMzDG4GXJ08OzQWnOVj5pDiI+nAxPbF6JyQQqDwvqAq
	v0AoBfDNCjlWHLDCIcwbrAWsJhJ0vHvDB9P/jzl/hPHaxOIWLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=UjJ4M/Y0/kY60uAlOvu
	6Gw8wwAQ9I19q2AMWniSTu4SF6QPQNbGO0ioDaQ3uuSg5ULK6tZLzjuEoTh4pRFf
	q3Lg/ldhauBHkrnOlTRIXATnN1DQVQNIugfAK3DKxZFeqvhdLrIH3Rx7ZchIJeTS
	AI6pHdVbE5nY4TyNX8pk/1ik=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE06E9ECC5;
	Tue,  2 Mar 2010 20:11:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C85AD9ECBC; Tue,  2 Mar
 2010 20:10:58 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A34A3C22-2661-11DF-AF11-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141426>

Henrik Grubbstr=C3=B6m <grubba@grubba.org> writes:

> From: Henrik Grubbstr=C3=B6m (Grubba) <grubba@grubba.org>

You can omit this line, as it is the same as your From: header.

> The code to contract $Id:xxxxx$ strings could eat an arbitrary amount
> of source text if the terminating $ was lost. It now refuses to
> contract $Id:xxxxx$ strings spanning multiple lines.

Hmm, at least when going from working tree to the index, shouldn't the
code refuse _and_ die(), instead of silently pass the garbage through?
