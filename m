From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: accept trailing "/" in $project_list
Date: Wed, 04 Jan 2012 09:51:14 -0800
Message-ID: <7v39bvqru5.fsf@alter.siamese.dyndns.org>
References: <1325671665-16847-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Jan 04 18:51:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiUzh-0005cN-9s
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 18:51:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946Ab2ADRvR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 12:51:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36578 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab2ADRvQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 12:51:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D7C7958BC;
	Wed,  4 Jan 2012 12:51:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=owzF7zG8yofgsaf4c3sSQXghlcc=; b=rG4+o5
	VyhDe/OhE/DPqcQnFzzfxbO7f2kF7PtTxYgwHhueVHDl/jfx16Dyy2S86t3r0hfE
	BGFev5Vso4ajy2eXumxbMV25p08ncfVtBNFpiZe5NdiALhZ52np2Ubt9CqH7DbyW
	XtD9wAdNsueShM5n1XVnRs/7FwvenaW2KAeDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L3HE4QTBMLK47WChr7c6vyKIB5GTamun
	qyp7uttS54XYKa1JsRJswDp4R2m+CsTUWhBmw4BZIL1SuFo7hlUAelaKH+mTpueW
	VwQvfpwGva1++Uwc5ZhmO5X1H0OXr+YioH+NvgzWizu4EiVAO7FY1YGYl4JEANPX
	l6qH770Iv+s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC10758BB;
	Wed,  4 Jan 2012 12:51:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 61D9558BA; Wed,  4 Jan 2012
 12:51:15 -0500 (EST)
In-Reply-To: <1325671665-16847-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Wed, 4 Jan 2012 11:07:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B29CFB58-36FC-11E1-9822-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187935>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The current code is removing the trailing "/", but computing the string
> length on the previous value, i.e. with the trailing "/". Later in the
> code, we do
>
>   my $path = substr($File::Find::name, $pfxlen + 1);
>
> And the "$pfxlen + 1" is supposed to mean "the length of the prefix, plus
> 1 for the / separating the prefix and the path", but with an incorrect
> $pfxlen, this basically eats the first character of the path, and yields
> "404 - No projects found".
>
> While we're there, also fix $pfxdepth to use $dir, although a change of 1
> in the depth shouldn't really matter.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> I'm not fluent in Perl, and not familiar at all with gitweb, but this
> sounds a rather obvious (too obvious?) fix.

Yeah, probably not many people use $project_maxdepth with a meaningful
value.
