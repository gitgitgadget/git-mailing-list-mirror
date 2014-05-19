From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] replace: add --graft option
Date: Mon, 19 May 2014 10:25:10 -0700
Message-ID: <xmqqvbt11y15.fsf@gitster.dls.corp.google.com>
References: <20140518182939.5260.91202.chriscool@tuxfamily.org>
	<5379D1EF.8040203@alum.mit.edu>
	<20140519111940.GB17492@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 19:25:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmRJi-0000Lf-D5
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 19:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932804AbaESRZU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 13:25:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50244 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752784AbaESRZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 13:25:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 13733168DD;
	Mon, 19 May 2014 13:25:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Sn1Id08rn1aujbq/l1bRuDqUEs=; b=Grn8bC
	qJv1L2xQVclFY80jPxbgugZSQolgzvOKFbkOVzurYdP9IchjFL3ndRQsyts7r6k0
	8CZTpB0wf9TxswSrdBbibqxq6FxT3GtFdE4BfrlkZ9/T2S5YW7JzwdevSBE+SZOE
	6seqU1iUSpx66VwnHXMv0J0wYd/D3VSVbu9GM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rMWfufZ9UEtYtQx2RlC2B6TsttTf9dhi
	weapnQCSQRTMDpGS7gDdHvWullbyGOAJUKI74XMyOd8+bKwoN5MxSFei7eiJxj15
	pL/ABDiaa+qotzsGrS5P9ewK++Pbey9RmnhNDHvv7CUBYEtoVu45Nrg0xqcY3KLO
	KGEU0lKYAGw=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 04937168DC;
	Mon, 19 May 2014 13:25:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B497F168D9;
	Mon, 19 May 2014 13:25:13 -0400 (EDT)
In-Reply-To: <20140519111940.GB17492@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 19 May 2014 07:19:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8985FE9E-DF7A-11E3-B5FC-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249606>

Jeff King <peff@peff.net> writes:

> It might make sense to just teach parse_commit_header to be a little
> more thorough; it has to read past those lines anyway to find the author
> and committer lines, so it would not be much more expensive to note
> them.  And then of course the code needs to be pulled out of the
> pretty-printer and made generally accessible.

I notice that you said "might" above.

> That's more or less what Christian's function is doing, though it
> assumes things like that the parents come immediately after the tree,
> and that they are all in a group. Those are all true for objects created
> by git, but I think we can be a little flexible.

The headers up to committer are cast in stone in their ordering, and
I do not immediately see how loosening it would be beneficial.

Unless you are trying to give users a new way to record exactly the
same commit in twenty-four (or more) ways with their own object
names, that is ;-)
