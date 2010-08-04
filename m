From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] ll-merge: let caller decide whether to renormalize
Date: Wed, 04 Aug 2010 11:12:05 -0700
Message-ID: <7vvd7qfdsa.fsf@alter.siamese.dyndns.org>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino> <20100804032144.GD19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 20:12:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgiS0-0004j5-Gd
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 20:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314Ab0HDSMT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 14:12:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:46490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0HDSMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 14:12:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 64109CAFA0;
	Wed,  4 Aug 2010 14:12:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Nu14yyZCp/pnXKHS/5EyfqEZCBg=; b=clSrF2naHq3USG05JvA7J/3
	DrG/22g8/nv47nIZsFoRoQbAe0SGy5fFEjz6aj65nSp6rWeIHahro0A5nvvBgM2Z
	ZZWVvp2z8xK4gMx5cWCdrZOJUVDjli0ZiwWFdjW3G950Tczm/VbK8pAa5GpMupx1
	o4fojmVZX1wj2rxs8HSo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=WTiEAeTTHf0UaNpUT28+eDEjU8yFTVMFLVVGSFhBU+wh+cZqQ
	oRxOiR9D9LoxXoJCY8Vo/CMcGTKPLVEqugvykIog5yXFpP/0wMfPSWJCh1UH29Ag
	rHIMx8fjcLGSK1sLZa/Scsezqg1xm6xeV2KKIRQMJ6WUf6kW3cLu24YQQk=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DA2ACAF99;
	Wed,  4 Aug 2010 14:12:13 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B712CAF96; Wed,  4 Aug
 2010 14:12:06 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CE3B5112-9FF3-11DF-AE23-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152588>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Add a "renormalize" parameter to ll_merge so callers can decide on a
> case-by-case basis whether the merge is likely to have overlapped with
> a change in smudge/clean rules.  This reveals a few commands that have
> not been taking that situation into account, though it does not fix
> them.
>
> No change in behavior intended.

Looking nice so far; I however think a separate "renormalize" parameter
should be folded into "flag" word, perhaps with a few new macros to make
it easier to access renormalize, virtual-ancestor, and favor-side parts
it.
