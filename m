From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] use '--bisect-refs' as bisect rev machinery
 option
Date: Wed, 04 Nov 2009 10:25:08 -0800
Message-ID: <7vljimgnaz.fsf@alter.siamese.dyndns.org>
References: <20091104034312.4545.2176.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Nov 04 19:25:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5kXw-0007Zb-Vy
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 19:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757670AbZKDSZP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 13:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757515AbZKDSZP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 13:25:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754762AbZKDSZO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 13:25:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2778A92CBE;
	Wed,  4 Nov 2009 13:25:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=G3mxeewnUhaPOdb3LkSMVv1tVwo=; b=tho4iv
	xOEW7FWm56bHhsRKLtImkEhd86QWbY3FZ2poSSkh75DdjTdPqVIgGK3RiQdoX3iR
	ouDnAXUxgEJZJiCdq5Y11wPEBpyEtLgfAJpritGjqVkXSijQaUk5e9d4VushYshx
	jF6EZWn1PG/9W875ZBLQ69MAnXoxADCCOd5kQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wYhx34qmmEGQ95AmvxUf6DWAL6c+y/OI
	rsivE9NuunC3wuNaN4DhPpqmUtuWERyKpKsmFO1Yndn7F7DvAr9dwE9rA8MVKNLY
	o/3zFkxdGSZgKSFmyLHPmObeqiNIMX1c+fAnKQm7286RUJRIR+HE//xkuyd4Ucyc
	AUfHB3VWqPc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F05EF92CBC;
	Wed,  4 Nov 2009 13:25:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7C19092CBB; Wed,  4 Nov 2009
 13:25:10 -0500 (EST)
In-Reply-To: <20091104034312.4545.2176.chriscool@tuxfamily.org> (Christian
 Couder's message of "Wed\, 04 Nov 2009 05\:00\:00 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 661CD408-C96F-11DE-BDEB-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132111>

Christian Couder <chriscool@tuxfamily.org> writes:

> So I suggest to use '--bisect-refs' instead of '--bisect' as the new
> bisect revision machinery option, because otherwise I think we get a
> regression when we call "git rev-list --bisect BAD --not GOOD" and we
> are already bisecting with bisect refs different than BAD and GOOD.
> This also simplifies the code a little bit.

Just to make sure that I read you correctly, do you mean that Linus now
would say:

    $ git bisect ...
    ... inside bisect session
    $ gitk --bisect-refs arch/x86
