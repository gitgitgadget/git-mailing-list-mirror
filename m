From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 0/2] Teach the --no-ff option to 'rebase -i'.
Date: Wed, 24 Mar 2010 10:13:23 -0700
Message-ID: <7vaatxskwc.fsf@alter.siamese.dyndns.org>
References: <7vzl1yd5j4.fsf@alter.siamese.dyndns.org>
 <1269445261-2941-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 18:13:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuU9H-0007np-Eb
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 18:13:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061Ab0CXRNf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 13:13:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52810 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753968Ab0CXRNf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 13:13:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C9F6A4E9A;
	Wed, 24 Mar 2010 13:13:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=AeVLplFF5oj1mbaPLooJfSPPcmQ=; b=IY779t2KvW1IuvYZCNHBTSA
	2oKHYnsQeV/cYlqr4fUYg8tBoWQYK6IWXe46Qmuf7Qi1J9pck4MPJq9eafTjnsIQ
	BJKK/naCGVGx8SdVEe1z3tWxVRObF2EJjh+QAkYNTjrhGw2c6xPOpj86OKCb43Nt
	2L/tzWHUn8DmTLChaF4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=RG69BhIo5xTNDmdKDXaMrFywrwO9R5NuoTofEQyUIh2Vj3+vw
	G8g6gBA+GWMRXGWs5fAqFk0McFE84V/9ZxsMVyG7duerBRZ4FWqZPGZvhvDHBd36
	EAO1UOhWwMDjdeo/fEBhFpeMk8UH6B2h/DtWb3RPXAwdIo0QYA4jxYehMs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 50C8AA4E94;
	Wed, 24 Mar 2010 13:13:30 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 79177A4E90; Wed, 24 Mar
 2010 13:13:25 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 91956FE8-3768-11DF-A3F8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143095>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Thanks to both Junio and Jonathan for your patience in working through this.
>
> Junio, I think I see what you mean.  I like teaching --no-ff to 'rebase -i'
> because it allows me to combine two commands into one for this situation.
>
> I've split this work into two patches:
>
> The first one simply teaches "rebase -i" to accept and ignore -f.  I feel
> this is better than adding text to the man page explaining why interactive
> rebase has --no-ff but not -f, while non-interactive has the opposite.

I am mildly against that change; I cannot explain why "rebase -i" accepts
and then ignores "-f" myself to the users.  "Non interactive one knows -f
but interactive doesn't" is not necessarily an inconsistency.  "--force"
is about forcing what would normally rejected, and if the latter doesn't
have anything that normally rejects, it doesn't need to have a "--force".

On the other hand, I wouldn't mind at all if you were to add "--no-ff" to
non-interactive rebase; that has a much easier and logical explanation.
