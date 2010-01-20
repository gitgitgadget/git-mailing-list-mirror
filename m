From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [question] retrieve some patches from another repository
Date: Tue, 19 Jan 2010 22:23:14 -0800
Message-ID: <7vljft5m7h.fsf@alter.siamese.dyndns.org>
References: <20100120054614.GA1965@crane-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Crane Cai <crane.cai@amd.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 07:29:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXU41-0004lF-Os
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 07:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab0ATGXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 01:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754890Ab0ATGXX
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 01:23:23 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754865Ab0ATGXW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 01:23:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3396491ED4;
	Wed, 20 Jan 2010 01:23:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HrayS1sFOmCC79U3ydV/SKeh0Ic=; b=I5RWU5
	21J8rR5/DFDyn7YqSUUHFaKsAoLEcitu4V6sKukYaoONMJQ4A9fndlD4dKc3N734
	gTGjtdb2zSGyxdFuMFOonlyma+0yMEKp9SGrvbDMD+ERSUszmvnGhbt4upCwdi+r
	NwsNXbgLanOTOjN2PNwjQRKlTraGoGTltQQTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=m0HZwIdmA+dtfCsCiwq2ijKQdHU6p4NQ
	6zxmgVo2KveXppq4KeUl6bpnArH56LTwOYzsWh2BjdfBigKZlnLDm2vXTfn2T+hA
	QT+NOjUYpr4Gd2ngHT0CS4/tCGlsyPYPi8Xb7I5fai0i2AEh9UkYxbcAlNOpnbMx
	Ra2AOckksJg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 088E591ED3;
	Wed, 20 Jan 2010 01:23:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 672D791ED2; Wed, 20 Jan
 2010 01:23:16 -0500 (EST)
In-Reply-To: <20100120054614.GA1965@crane-desktop> (Crane Cai's message of
 "Wed\, 20 Jan 2010 13\:46\:14 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4D031438-058C-11DF-9DC8-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137521>

Crane Cai <crane.cai@amd.com> writes:

> * merge point will cause duplicated patch generated, for example repo B has x,
>   y, z, then accepted by repo A in merge point, and then merge back to repo B
>   (they are different with commit id), they will generate 2 twice.

This is inevitable, if 'x' and (say) 'b' corresponds to each other but has
textual changes due to different context.

> * some commits do not only change the driver source code, and they change some
>   other files also. Unfortunately git format-patch cut them. It cause compile
>   error.

You are probably running "format-patch a.. -- path/to/file.c".  Try giving
it the --full-diff option as well.  We've recently discussed to make it
the default for format-patch but the discussion thread petered out and
didn't reach conclusion.
