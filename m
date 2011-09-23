From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diff_index: honor in-index, not working-tree,
 .gitattributes
Date: Fri, 23 Sep 2011 14:48:50 -0700
Message-ID: <7vfwjnszel.fsf@alter.siamese.dyndns.org>
References: <1316727861-90460-1-git-send-email-jaysoffian@gmail.com>
 <1316727861-90460-2-git-send-email-jaysoffian@gmail.com>
 <7v8vpgxkvb.fsf@alter.siamese.dyndns.org>
 <CAG+J_DzUQ3OGfiX=vHVGC7SHvwToVjD7uwFyDa8Tq6t7YwX12Q@mail.gmail.com>
 <CAG+J_Dyh=t2VAZ6rAqcF2meEgBCN5c+J_m_YvVQbKfvXeJ8WGA@mail.gmail.com>
 <7vobybw6mv.fsf@alter.siamese.dyndns.org>
 <CAG+J_DwGuR6bqE4iG26-xwc0_TuRRKUDmmJZ44Qr+y5EEzTnNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 23:49:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7DcZ-000847-SI
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 23:49:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532Ab1IWVsz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 17:48:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62110 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468Ab1IWVsy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 17:48:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E3CF6DF4;
	Fri, 23 Sep 2011 17:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iP+JjnG5dBVXH2gOMdClgdMrf3E=; b=U4/5mn
	Nyv3mw9BS3Q51K4dwTDfFAEenl+Hw3UwDdj0VVxTWAdY6mYv7E3b65OQRPQcQllt
	rFJLiOdi1eBiQEJAxWfTNzfWa2AxQcX9GZcAgPcPhCfWAuZtTKuwsBmO9JSVxLIW
	rvRAM23SRsPJbfEreuavLfXe8JxrzChhyfxUY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BNDYhCDzOCWHUpAjERHGje57EaAXlaQ3
	0Vl+ZquUdRQ/PpP86FsWPQhSujk2wWejFxmHYdiEFLZ5mf9QThH3v67No1Zi3qr6
	wz5LMriqsObl5FeRZe2xjGxZNQaI7uBbLIs7CnuEB4s/dIfTgg0lpPmIwvrWnYvN
	XzCFv9WW3I0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74CC16DF3;
	Fri, 23 Sep 2011 17:48:52 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01A0D6DF2; Fri, 23 Sep 2011
 17:48:51 -0400 (EDT)
In-Reply-To: <CAG+J_DwGuR6bqE4iG26-xwc0_TuRRKUDmmJZ44Qr+y5EEzTnNA@mail.gmail.com> (Jay
 Soffian's message of "Fri, 23 Sep 2011 17:32:20 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D3AE6B58-E62D-11E0-B8B0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182004>

Jay Soffian <jaysoffian@gmail.com> writes:

> Hmm, I looked at that, but then it would work for git-diff, but not
> git-diff-tree.

Why not?

The same helper function that you would write for calling from
builtin_diff_tree() would certainly be usable in git-diff-tree, no?
