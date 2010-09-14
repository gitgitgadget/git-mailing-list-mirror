From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] tree_entry_interesting(): remove dependency on
 struct diff_options
Date: Tue, 14 Sep 2010 08:59:56 -0700
Message-ID: <7vr5gw8geb.fsf@alter.siamese.dyndns.org>
References: <1283961023-4491-1-git-send-email-pclouds@gmail.com>
 <1283961023-4491-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 14 18:00:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvXvd-0000sb-L9
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 18:00:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671Ab0INQAJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 12:00:09 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751712Ab0INQAI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 12:00:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DE981D5C95;
	Tue, 14 Sep 2010 12:00:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FQUuIkrXSPoZ
	RW1HICkV5f6dkps=; b=Q9BlJtBzVBVCJloLzN3tGOxAE6+FtIgdzbQ3FY6NlwCr
	bq4Kn/famOpvK95DURxFwOStkIOKQ/GCOwh/rvvygKnrAAxHZi3W/HEhTXPsGB23
	d/PO3CZNNRS4Q2Y+xcZcLQvz4+EfVh3zgRdQ8A3Fst7BgVDSuAWnYx8JWLepXLE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Jav21R
	NnOFsezCv9s/KbPkfjJFpqMsgO5B5EJAAA6strFdHUu4KnBD46t8LmKoff0xseA7
	BBMA1LfDlURdtghhadR2ihZ0aDPdPKgt4kv8msfIgd4jbveWUsWFCqgjnEIZJADk
	WwLKCbTY8a1w0vNJVZBCxvEt6elaXsQ1X+KjQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FE73D5C80;
	Tue, 14 Sep 2010 12:00:02 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DD5ED5C7F; Tue, 14 Sep
 2010 11:59:58 -0400 (EDT)
In-Reply-To: <1283961023-4491-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Thu\,  9 Sep
 2010 01\:50\:18 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 222FE36A-C019-11DF-BDC0-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156195>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This function can be potentially used in more places than just
> tree-diff.c. "struct diff_options" does not make much sense outside
> diff_tree_sha1().
>
> Moreover people seem to be agree that diff machinery should learn
> proper pathspecs too (i.e. globbing, negative pathspecs...), not just
> treating pathspecs as tree prefix.

There is nothing improper about the prefix match.  Perhaps "richer"?
I am not so sure about the need/desirability of negative match, but we
will see.=20

About naming.  Where else other than "tree" (in the "hierarchical
namespace" sense) context do you see pathspec?  Does the struct really
need to be called TREE_pathspec_list?
