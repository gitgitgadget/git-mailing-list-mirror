From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] http: try standard proxy env vars when http.proxy
 config option is not set
Date: Sun, 11 Mar 2012 12:12:36 -0700
Message-ID: <7v4ntvx87v.fsf@alter.siamese.dyndns.org>
References: <4F4CCE8A.4010800@seap.minhap.es>
 <m3pqcjt6s2.fsf@carbon.jhcloos.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, peff@peff.net, sam.vilain@catalyst.net.nz,
	sam@vilain.net
To: James Cloos <cloos@jhcloos.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 20:12:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S6oCE-00065s-06
	for gcvg-git-2@plane.gmane.org; Sun, 11 Mar 2012 20:12:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313Ab2CKTMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Mar 2012 15:12:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57950 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116Ab2CKTMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2012 15:12:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E9926585;
	Sun, 11 Mar 2012 15:12:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+JTQ+VPJMpeVHb2m4wEBtR9JvXU=; b=aW9rJ9
	ARYefnz7LsOknDZfuHu7yT50hLmlMYLopmKL+mpFr0ESOIt2DluNdTOCej7v84If
	DXLjeNEg4nIicuig8KfW0R3hIZVhRMw1mR3cITsW7TOYc/hTKxyZUOzsNbz8z+RI
	M/DO9ck8pcEi28GLepJOQaRCt+h4dMMNN2/qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JShff6cfcVlW+JmjDBcrPTUT4jICBhhL
	DtUiUNHzhZKclxQZ5aN+8Xac1wlz8M9cta+6Saf/NL9NMnCYMI+j9mF0ibBtvE26
	E9SiLVZm2Wh00pW7m91KQo0Knh9O6InPOWF+PaGuCN/KU96S2idNQ3vPM64KYmln
	JMuzNeqTYa4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 639436584;
	Sun, 11 Mar 2012 15:12:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA02B6583; Sun, 11 Mar 2012
 15:12:37 -0400 (EDT)
In-Reply-To: <m3pqcjt6s2.fsf@carbon.jhcloos.org> (James Cloos's message of
 "Sun, 11 Mar 2012 12:56:53 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2A812046-6BAE-11E1-87DF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192822>

James Cloos <cloos@jhcloos.com> writes:

> Please include a way, eg via ~/.gitconfig, to ignore any http_proxy in
> the environment and connect directly.

Hrm.

I think without this patch series, the "NO_PROXY" environment
variable is honored by the curl library when it uses http_proxy
to make the decision. If this patch (or a future reroll of it) fails
to do the same, it would be a regression.

Nelson, do you agree?
