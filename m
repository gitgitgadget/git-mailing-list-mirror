From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 11/19] bash prompt: use bash builtins to find out current
 branch
Date: Wed, 09 May 2012 14:25:46 -0700
Message-ID: <7vehqtqc6d.fsf@alter.siamese.dyndns.org>
References: <1336524290-30023-1-git-send-email-szeder@ira.uka.de>
 <1336524290-30023-12-git-send-email-szeder@ira.uka.de>
 <7vzk9hqg0u.fsf@alter.siamese.dyndns.org> <20120509211143.GE6958@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Wed May 09 23:25:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSEOQ-0003oU-6m
	for gcvg-git-2@plane.gmane.org; Wed, 09 May 2012 23:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758650Ab2EIVZt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 May 2012 17:25:49 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38912 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758077Ab2EIVZs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 May 2012 17:25:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0CCC27197;
	Wed,  9 May 2012 17:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hiJQr3VDFMWZ
	V23SKWDe2p1hsgo=; b=SYm4GgT9uOpb12WXbntmV2op6vxWBAnLUwKub4f6ntdn
	sS5J1bs0VGLIIKAn/rsXto1xsWWWEfbMhehgMOx5dU+amXZhLy26cBkGaXtYKr//
	VCd+s8AUif+QZIWPtu/vMnjvXEeDCLkzbC8Sj+QX8TFGqd2OJKa81YDFAIa9lZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=iLPPAB
	eaWzS64LauaSsDbl/EXCLE+EPT4Tt11/YXI8zzJn/uUr7ApGdS+EmjoTgPw0CuHx
	LjvQf7fuc3+R+2PPREd64uUjkFNiZrn1rm15HPYgyqWEnU9PIqZdD4RxLf/r+mT+
	n210iS9kZ+5uS8ZJ6fJomDtpYWcM6r/nWU7A0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0164E7196;
	Wed,  9 May 2012 17:25:48 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6CB067195; Wed,  9 May 2012
 17:25:47 -0400 (EDT)
In-Reply-To: <20120509211143.GE6958@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1b?=
 =?utf-8?Q?or=22's?= message of "Wed, 9 May 2012 23:11:43 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8AFF7600-9A1D-11E1-B38C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197515>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> If the above is right, then we could check with bash builtins whether
> HEAD is a symbolic link, which is cheap, and stick to '$(git
> symbolic-ref HEAD)' if it is, or use bash builtins if it isn't, right=
? =20

Sure.  Alternatively, you could run "readlink" on it if that is availab=
le
built-in, and manipulate the result in string builtins, but that is a b=
/c
slow path anyway, so I wouldn't bother.

Thanks.
