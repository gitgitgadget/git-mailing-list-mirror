From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] tree_entry_interesting(): remove dependency on
 struct diff_options
Date: Mon, 27 Sep 2010 15:20:02 -0700
Message-ID: <7vtylavnfx.fsf@alter.siamese.dyndns.org>
References: <1284938514-16663-1-git-send-email-pclouds@gmail.com>
 <1284938514-16663-6-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:20:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0M3b-0006jY-C9
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760242Ab0I0WUN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 18:20:13 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374Ab0I0WUK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 18:20:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7642BDA380;
	Mon, 27 Sep 2010 18:20:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=j4MuJg57D4xFHDTp2CQpTRn1t
	28=; b=s+c859KbAjh520uNrxPYPM324+mCqTbCCIZbLNAd+eD0DSjRUpvw4h/kv
	l50/Tby/fGTfmj6JY3tOkLcdtBCHrzKOroaJhhvJxKgB0g7jBmQoP2YLFyoley/J
	FSGTdV5WLeX2a6l2/t4r0q1eZ8dYZpIUEvEIBSlsNxAT2ZvBDE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=wB9TPTf4AeVe1cf9trg
	D1/SlPPmmLUfMkchjovHazrUHhKs32ZPOJjKwP+a22K1I+eY9Ih8zDcQjovpMs8U
	GcaoC+0FYi/QwLR5WX33Ral9oV86/s5VH8mi32pNg8nZWWi6mnTfSVNdfA4Mx7Tf
	+7DwI5qC058geUsuCoEJ9aLQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F260DA37E;
	Mon, 27 Sep 2010 18:20:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F612DA379; Mon, 27 Sep
 2010 18:20:03 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6240EA50-CA85-11DF-B929-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157375>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This function can be potentially used in more places than just
> tree-diff.c. "struct diff_options" does not make much sense outside
> diff_tree_sha1().

This does a bit more than that; it does not call tree_entry_extract()
anymore, and instead uses the knowledge of its underlying implementatio=
n.
The mode of the entry that is passed to S_ISDIR() check is not cleansed
with canon_mode() anymore.

I do not think these are necessarily bad changes, but they should be
documented.
