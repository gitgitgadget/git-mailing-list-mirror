From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 8/8] send-email: do not prompt for explicit repo ident
Date: Thu, 15 Nov 2012 21:17:30 -0800
Message-ID: <7vzk2i6s9h.fsf@alter.siamese.dyndns.org>
References: <20121115003029.GA17550@sigill.intra.peff.net>
 <20121115003640.GH17819@sigill.intra.peff.net>
 <CAMP44s0d+g7bXCnOf55jZNNFS6uJ+4BDowx5uYxWBP4xA+-0zA@mail.gmail.com>
 <20121115083315.GA23377@sigill.intra.peff.net>
 <CAMP44s2NBGDRLUKhBTU+kNy7Fyn8T6qm3nneSbS4rrNN1oPgdw@mail.gmail.com>
 <20121115104345.GA32465@sigill.intra.peff.net>
 <20121115111334.GA1879@sigill.intra.peff.net>
 <7vvcd6954q.fsf@alter.siamese.dyndns.org>
 <20121115172845.GA20298@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 16 06:17:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZEJO-0002DU-II
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 06:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826Ab2KPFRf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 00:17:35 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab2KPFRe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 00:17:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 574D083F0;
	Fri, 16 Nov 2012 00:17:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YaLs4rXFQQivXRwihp/yWlE4z+8=; b=XbqV4R
	8BfWc0t9MOR7FC/uPDJdgMYpFeuR1Ru+ymZQkjux/rNI6qTPftTweruepi84UeAM
	9ZmnF8JB7QVQ2yyA4st7Zd5RudZZZNrcDYOv7h51+yxiNT14B4fmf+j4G67LJStZ
	FOIOLFhwv9bY7CA3KH3O6ODccp4gQf6eYioiA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ij2yi1E9wjNcea/A94gO8qr3iyNZvtYC
	1lrzy3T0IeORiBqAa4Jls8ovthmJFl5jEKkYZrpvz5dtnTb/V7bxOkWBtlUaRjFc
	J7PPRXqK+43vZZrcbfjlzfiZ4Pe+/P/cw3berCB+Zz6UU/FlpNBbVnPWMAszFBvt
	JHZoHTwu3JU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36C3983EF;
	Fri, 16 Nov 2012 00:17:33 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A40D083EE; Fri, 16 Nov 2012
 00:17:32 -0500 (EST)
In-Reply-To: <20121115172845.GA20298@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 15 Nov 2012 09:28:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ECBB85F8-2FAC-11E2-BC94-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209862>

Jeff King <peff@peff.net> writes:

> That is a good question. That confirmation step does come after they
> have typed their cover letter. However, if they are using --compose,
> they are dumped in their editor with something like:
>
>   From Jeff King <peff@peff.net> # This line is ignored.
>   GIT: Lines beginning in "GIT:" will be removed.
>   GIT: Consider including an overall diffstat or table of contents
>   GIT: for the patch you are writing.
>   GIT:
>   GIT: Clear the body content if you don't wish to send a summary.
>   From: Jeff King <peff@peff.net>
>   Subject: 
>   In-Reply-To: 
>
> which I think would count as sufficient notice of the address being
> used.

OK.  Tentatively I replaced your old series with these 8 patches
including the last one, as I tend to agree with the value the
earlier clean-up in the series gives us in the longer term.  As you
and Felipe discussed, we may want to replace the last one with a
simpler "don't bother asking" patch, but I think that is more or
less an orthogonal issue.

Thanks.
