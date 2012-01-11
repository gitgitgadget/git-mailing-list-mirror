From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC] commit: allow to commit even if there are
 intent-to-add entries
Date: Wed, 11 Jan 2012 00:08:24 -0800
Message-ID: <7vr4z67jbb.fsf@alter.siamese.dyndns.org>
References: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 09:08:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RktEX-0001pK-Iq
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 09:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755776Ab2AKII3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Jan 2012 03:08:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57145 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab2AKII1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Jan 2012 03:08:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB2F959C7;
	Wed, 11 Jan 2012 03:08:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HxO+049qIw34
	Y6SIKDtNghDhjEY=; b=RSoS9pYtFLX7hAlf/1t3EaONNLedC89hQRbqxT+KnW7k
	DhVaPDnpd5wkIr19pacSgFhQb1d4TT1bHhOS0W/Bu+qVZcbcE5qiGA8fXLXpqJhT
	DrTY9JLBmADMw9QZ9IVIdBHBkILuQyFAsXGUEUCTbUswFUO9YxfkaLKRfUhrMj0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DXEtLV
	DiWNM2YjMl9Q0iGotnKBL8J0tcCi6PHRg+vqYu6TiMHN1Lj0zbJDiedVgr/sMGZO
	4QZ4W4tUKBIJhrMjA9smBiQjBKvQhtcB8X3gYylczVanGUGwkH7yvtbOh91Z2bRO
	mrdHUU/RtR+U6/YEa8/woPuSEOyr8SW13QjOE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D1FA759C5;
	Wed, 11 Jan 2012 03:08:26 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 627FF59C2; Wed, 11 Jan 2012
 03:08:26 -0500 (EST)
In-Reply-To: <1326261707-11484-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 11 Jan
 2012 13:01:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 705BAB02-3C2B-11E1-822F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188340>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This patch replaces the approach in 331fcb5 (git add --intent-to-add:
> do not let an empty blob be committed by accident) regarding i-t-a
> entries: instead of forbidding i-t-a entries at commit time, we can
> simply ignore them.

I have a mild suspicion that in earlier incarnation of the patch we use=
d
to let empty blobs committed, and then we used to instead not commit
anything at all for such a path, and the real users were bitten by eith=
er
of these approaches, forgetting to add the contents to the final commit=
=2E

So I am not sure if this is such a good idea.
