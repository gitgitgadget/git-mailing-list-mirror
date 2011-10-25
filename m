From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 04/11] tree-walk.c: do not leak internal structure in
 tree_entry_len()
Date: Tue, 25 Oct 2011 12:20:21 -0700
Message-ID: <7v8vo85156.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-5-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 25 21:20:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RImY0-0007FJ-0W
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 21:20:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752217Ab1JYTUX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 15:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019Ab1JYTUX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 15:20:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E69405DB8;
	Tue, 25 Oct 2011 15:20:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=peT0GLZqP5VL
	kJ47nhFqvrIwB04=; b=EJXycydX0Edp9p/4owe0lvYhQnXdepnXCZmZmK52h4Hv
	pwuC9Vyco9K3GCDgkH05R10UYA+Ma58ueTqR1/qkWDdUbBwAhJNIOBCGpS0+a+F/
	B7A5hkh/h5cr2OjXQcp6RA7SmIvZicdtThPpGPKB+Q3+8ivAKaEyvoSNz3vjVLM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xbwofN
	fz7rtBIAGkX9drmxDHKrk1MIGYnwj25B4ZFvgYBIfB6QigsetXOmlaUuhabc60pB
	nz4PNdjG4ihaSqFw0AmaGoZYYcmZZL8mW0mhnjcNLflwzmDvhr9CL289YtHIMIW+
	BeWCJcGA85eeUvCRvIUAXhRZFYLiQEuaCmvcE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DDF8A5DB7;
	Tue, 25 Oct 2011 15:20:22 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 789D45DB4; Tue, 25 Oct 2011
 15:20:22 -0400 (EDT)
In-Reply-To: <1319438176-7304-5-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 24 Oct
 2011 17:36:09 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62666606-FF3E-11E0-A53C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184232>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> tree_entry_len() does not simply take two random arguments and return
> a tree length. The two pointers must point to a tree item structure,
> or struct name_entry. Passing random pointers will return incorrect
> value.
>
> Force callers to pass struct name_entry instead of two pointers (with
> hope that they don't manually construct struct name_entry themselves)

Makes quite a lot of sense.
