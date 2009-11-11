From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] filter-branch: stop special-casing $filter_subdir
 argument
Date: Wed, 11 Nov 2009 10:00:47 -0800
Message-ID: <7v3a4lq6uo.fsf@alter.siamese.dyndns.org>
References: <4AE945D0.5030403@viscovery.net>
 <0280836a32983c848bbb0e3b441be256d3c8f4fa.1257885121.git.trast@student.ethz.ch> <4AFA7624.5040400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 11 19:01:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8HVB-0004EI-U1
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 19:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758117AbZKKSAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 13:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758018AbZKKSAz
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 13:00:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:39951 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757947AbZKKSAy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 13:00:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9301B9B550;
	Wed, 11 Nov 2009 13:00:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=X9quCqtT/ghL5mqt/VLeCNuF6Xs=; b=ZOIB0c
	0BaE/W2Hvm7zZfhFVDyb8ap5uk3OR05v9+Y2Agn2uScqkn8H8VzmcKCnfcu6AY20
	muizboV1VjW17M8jtunhUeGsn2oJgd3FIUcPyzyPWZ5tjVP2MKs93bEnL2bkvNbN
	0YC/izWaXeF5sx6OlrdwIn0BWiuqK3PmztqHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IFQt7i4XK7adkjqFm4jORcYEZnk516Xz
	UTzEq6l7Io4kv/e+Q+ejtwBbQI4JwHbpZme01jhP4eORkesc3hFcnTBsCQDymlc6
	Dia5VUu1MM3xutFqx0zz5LNHcpJsnEAcfW/xCV4J5TpeQPAlfnUaPiNF9wiw3gKO
	2F97IQfwZBU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 65FEA9B54F;
	Wed, 11 Nov 2009 13:00:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D12209B54E; Wed, 11 Nov 2009
 13:00:49 -0500 (EST)
In-Reply-To: <4AFA7624.5040400@viscovery.net> (Johannes Sixt's message of
 "Wed\, 11 Nov 2009 09\:30\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28706836-CEEC-11DE-8B12-B888BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132682>

Johannes Sixt <j.sixt@viscovery.net> writes:

> In the snippet above, dashdash will always be set to "--" because a mere
> '+' in the variable expansion only tests whether the variable ('nonrevs')
> is unset, but it is always set. Even ${nonrevs:+"--"} is wrong, and your
> earlier 'test -z' invocation was the correct way to set dashdash.

I do not mind "test -z", so this is just for information, but you could
use variable substitution with a colon, i.e. ${nonrevs:+"--"}.

IIRC, the colon-form ("do this if unset or empty") wasn't understood by
ancient BSDs but these days it is safe to use.
