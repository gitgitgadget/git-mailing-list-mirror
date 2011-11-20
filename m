From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug report - local (and git ignored) file silently removed after
 checkout
Date: Sun, 20 Nov 2011 13:16:27 -0800
Message-ID: <7vehx2ijf8.fsf@alter.siamese.dyndns.org>
References: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bertrand BENOIT <projettwk@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sun Nov 20 22:16:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RSEkc-0002Qc-TB
	for gcvg-git-2@lo.gmane.org; Sun, 20 Nov 2011 22:16:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933Ab1KTVQa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Nov 2011 16:16:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753824Ab1KTVQ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Nov 2011 16:16:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57E426963;
	Sun, 20 Nov 2011 16:16:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1AInrj9H2fpXwRTN09OdLwlqOBU=; b=UW0C2I
	XJdH3QOEIIRmZ6Pwa2i+wqBx1oKOqaSzi75NePE3FIJ+4ibLT8p3UMezWDr9jaYo
	7WaA7oSMxv6pOoE6ymsTfHvroVujU9Ty7w6yKrfhC2vXzhDg7nQ6qeamaf8aWPC6
	DUGPx/ocWzaxBZTvfEitGRFQzohPU42ofo6oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VDBB51F1TdOP9ZfJP7aB6tRnorbhVVCP
	uWqK0Jopy1vLXJ8LV/DSSQcBs9RquvsJFxxDK+ZNA59QDIYUAyZsh1egS7Qmtlqc
	8U7JJpU6d+R6521j4V2zN4jFf+lHDUmwHktQaN3GO+2V8ABJdCXujG9Gw3Nu8v2x
	AYS36ZdWqEE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 502D86962;
	Sun, 20 Nov 2011 16:16:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DA6836961; Sun, 20 Nov 2011
 16:16:28 -0500 (EST)
In-Reply-To: <CAPRVejcpAZrLWCeHTZJr9Uk6_z6hTPQLLd6pCOKteYnRGMQ5ig@mail.gmail.com>
 (Bertrand BENOIT's message of "Sun, 20 Nov 2011 14:42:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E97030D6-13BC-11E1-AA7F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185726>

Bertrand BENOIT <projettwk@users.sourceforge.net> writes:

> Context:
>   - in previous version of my project, the TODO file was versioned
>   - in current development version, this file is NO more versioned AND
> it is ignored by a gitignore rule,...

What you observed is expected with all the versions of Git since the
gitignore mechanism was introduced. The ignored files are "not tracked,
are cruft that can be removed to make room if it is necessary for checking
out a tracked version, and would not want to track (e.g. build artifacts
like '*.o')" (I am not saying that it is the most sane semantics, I am
just stating the fact).

We do not have "not tracked, but precious (e.g. your TODO)" category; from
time to time we have discussed possibilities of adding such to enrich the
categorization, but nobody stepped up to actually do the work of designing
let alone coding such a beast.
