From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] credential-cache: fix expiration calculation corner
 cases
Date: Sun, 18 Sep 2011 14:51:22 -0700
Message-ID: <7vzki1bjtx.fsf@alter.siamese.dyndns.org>
References: <20110914191704.GA23201@sigill.intra.peff.net>
 <20110914191757.GB28267@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:51:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5PGr-0005Vf-KO
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666Ab1IRVvZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:51:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50807 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932255Ab1IRVvZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:51:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEA5442D4;
	Sun, 18 Sep 2011 17:51:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=zipPWNdMMMvvQtLbW9lUMAo+src=; b=GLFKGrLQ3xxmzsEckKRD
	c9ktKDLYVPwoRozxnkx2vdwdlwrzO+BZ5BruV9pJbBa0sXidTmYscY2IORJnGjii
	I65U31pG7h2JT1EqgPHPTQ90U2UAYIYuo5yaghnG46ylUagxQpql9ykonk2gBNc7
	5+0xzOroByvmWCD1Iya3epU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WKK3jMpWxpyVeEKgfKOQJgT/dhRqzakVvBSCQdpEPbf9QR
	QL/nLr1XClCQtUZzF/h/TMam+ZnxfPpT2Vw/RlCPbGYw/wa00DJvuecJ2lnptf7Q
	D6GB4vXYvhaqNXZNr179Q1PMbgzfjASHQbj405bowmPNUxIe3REAgYTfEEzSA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A63D242D3;
	Sun, 18 Sep 2011 17:51:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EBD642D2; Sun, 18 Sep 2011
 17:51:24 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A590C86-E240-11E0-848F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181650>

Jeff King <peff@peff.net> writes:

> The main credential-cache daemon loop calls poll to wait for
> a client or to trigger the expiration of credentials. When
> the last credential we hold expires, we exit.
> ...

Thanks.
