From: Junio C Hamano <gitster@pobox.com>
Subject: Re: v1.7.0-rc0 shows lots of "unable to find <sha1>" on git-stash
Date: Sat, 30 Jan 2010 12:25:56 -0800
Message-ID: <7vvdejmjaj.fsf@alter.siamese.dyndns.org>
References: <57518fd11001290712s2585e468o73b746b7ca27e1f1@mail.gmail.com>
 <7vzl3wiz59.fsf@alter.siamese.dyndns.org>
 <57518fd11001291646l5b0b581dm553689232b0910e8@mail.gmail.com>
 <4B642696.2070501@web.de>
 <57518fd11001300523xf7d931by254581c8494171af@mail.gmail.com>
 <4B643DEF.8010809@web.de>
 <57518fd11001300836v7f21a8a9qc09953d9091a4513@mail.gmail.com>
 <7v8wbfnyz9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan del Strother <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 21:26:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbJtX-0003y7-4m
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 21:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752285Ab0A3U0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 15:26:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232Ab0A3U0I
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 15:26:08 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752196Ab0A3U0F (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 15:26:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C40759567A;
	Sat, 30 Jan 2010 15:26:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9eJGDtm7YkeXM8ietgd9Ajvo/m8=; b=GbriVO
	quHKPEkvCqq6fc008xpVONb1mxuDV2NQO3uV+/qk94g0fDnjwnA3eFHrXi+80OrJ
	6qJYafH3YD35tSjUleAjvGk7NcWz0honOfbc18AdumsaGVsqUavKwj/wlCdDAom3
	CU8+4zqVO25kGKubmpJLHhcnoXSOdZLqMa65w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=u3OPVA3h71/ynTMbRHXMk7Fgrb3HByrV
	Aa/IHat4rD2JCOBfLYxzmwlOeJCzouPLfktjGSHywGbqImrZghdjwByz3aDApK7y
	tvwEl9xCbwocADO8zsvZkp1VOf0CXXR0PrDIpRCO4kSMK/aC7oDyAMRRFFg/ox9h
	w1KLI1TxDoQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B69095674;
	Sat, 30 Jan 2010 15:26:01 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C168295673; Sat, 30 Jan
 2010 15:25:57 -0500 (EST)
In-Reply-To: <7v8wbfnyz9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat\, 30 Jan 2010 12\:01\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AEC06C30-0DDD-11DF-A86B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138499>

Junio C Hamano <gitster@pobox.com> writes:

> Please try this.

oops, but with this, too.

> diff --git a/submodule.c b/submodule.c
> index ca0527f..8bd0a30 100644
> --- a/submodule.c
> +++ b/submodule.c
> ...
> @@ -142,7 +142,9 @@ int is_submodule_modified(const char *path)
>  	env[0] = strbuf_detach(&buf, NULL);
>  	strbuf_addf(&buf, "GIT_DIR=%s/.git", path);
>  	env[1] = strbuf_detach(&buf, NULL);
> -	env[2] = NULL;
> +	strbuf_addf(&buf, "GIT_INDEX_FILE=");

This should be:

	strbuf_addf(&buf, "GIT_INDEX_FILE");

> +	env[2] = strbuf_detach(&buf, NULL);
> +	env[3] = NULL;
>  
>  	memset(&cp, 0, sizeof(cp));
>  	cp.argv = argv;
