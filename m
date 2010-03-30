From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: Add sanity check for url
Date: Tue, 30 Mar 2010 16:45:36 -0700
Message-ID: <7voci5qspr.fsf@alter.siamese.dyndns.org>
References: <f3271551003301308y683173f6y6a4fadb01b791049@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 31 01:46:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nwl8P-0006te-MK
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 01:46:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757294Ab0C3XqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Mar 2010 19:46:01 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab0C3Xp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Mar 2010 19:45:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2504711F6;
	Tue, 30 Mar 2010 19:45:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YGIEDbv5ka2GCWOJLA80cyUq6gE=; b=VhMGTx
	pXUMg8SiJz32Qx9Hgx5+fH9DhdetLEbjQ64jhM0tOFRRnZNSnkfzLOcaVul8pHvi
	GninML2qjuENGwaDTdX3WFgdHKSwbr4/3t4Qjk9v4NP36A8jGe2IgzONnCD9ojPh
	VO1zJI/HNbzLohccakM6TYplCOqYx2HCxEDVg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LsPIY5BcHSxSvj3Ub8dSm4Dru7iw9Zig
	3IJInkvFi3nnqdYGwlmLjlWOLCB6EJShctimBM0AMP4rtV0aqup3GiwwJ1o8Ueyt
	sEUjbLz+RzA8vRMW6dL9gFhczoc5VaNLg6NmvmqDP3FieI1XQD1r6gKITYMNnPH2
	HpPSnVBQBQE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DB92A11EF;
	Tue, 30 Mar 2010 19:45:47 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 93AAD11E5; Tue, 30 Mar
 2010 19:45:38 -0400 (EDT)
In-Reply-To: <f3271551003301308y683173f6y6a4fadb01b791049@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed\, 31 Mar 2010 01\:38\:42 +0530")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5D7540F6-3C56-11DF-9916-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143624>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Previously, `git remote-http foo` and subsquent commands would try to
> work on a HTML page. This patch fixes the bug by making one assumption
> about the URL handled by libcurl: it must contain the string "://"

I may be being slow but I do not see the point of this patch.

I thought that remote-foo is never invoked directly from a command line
with random arguments, and fetch/push frontends make the decision based on
the shape of the "URL" (or whatever data used to reach the remote end)
which helper to run.

I do not think your patch would _break_ anything, but my question is more
about the reason why we would want a duplicated check here.
