From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git tag --no-merged?
Date: Wed, 04 Feb 2015 10:43:40 -0800
Message-ID: <xmqq61bho6ub.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Feb 04 19:44:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJ4vz-0002sP-RF
	for gcvg-git-2@plane.gmane.org; Wed, 04 Feb 2015 19:44:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161815AbbBDSoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2015 13:44:15 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1162241AbbBDSnm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2015 13:43:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 223E9346D6;
	Wed,  4 Feb 2015 13:43:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=H/0r22hq/dtPQQhlPy4v0aAtihE=; b=VA79ib
	uC/ePvMuWeUu7Dm9g2oqqK8M9Ch7YdQLnc+t+hKPxhA/qOINGkepSOJZr2BO/fGV
	OeTv44R1CI9e3MxL83U30ciKxyaEQzt83H08bRh0JDbCtwlE0arxu4KwztZYXhCu
	nVLEsu3JtF/Pfj6R2RPqyrC+bMEP7Hhjqu5Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JjoD41IwVTuaXR3TzjSsdtcgjGjeVxk3
	C05bs2pZg6GrKDAvoZrxRGXMm/4QEUoA7PFm3cHnUO0nDY40m4lvxdRYYcAY+kyr
	EPBu20HMOL8DRn+9X4kYaLcmzURIsMw1wwIjRTLhgEGqtMrtR2cssKnyuT6ROtcg
	/oAUNwVY6G8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 19BAD346D5;
	Wed,  4 Feb 2015 13:43:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 94BF0346D3;
	Wed,  4 Feb 2015 13:43:41 -0500 (EST)
In-Reply-To: <alpine.DEB.2.00.1502041615110.30476@ds9.cixit.se> (Peter
	Krefting's message of "Wed, 4 Feb 2015 16:19:59 +0100 (CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD7287E0-AC9D-11E4-B8B8-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263355>

Peter Krefting <peter@softwolves.pp.se> writes:

> Using "git branch --no-merged" I can get a list of branches that I
> have that I haven't merged into my current branch. "git tag" doesn't
> have such an option, is there a way to achieve something similar
> listing tags that point to commits that aren't in my history?

Using canned set of tools, I do not think there is anything less
complex than doing something like:

 $ git log --oneline --decorate --branches --not --tags

The longer term goal that has been floated a few times here is to
unify various logic that computes containment relationships in
"branch", "tags", etc. to one place and perhaps expose that unified
logic to "for-each-ref", but that hasn't happened yet.
