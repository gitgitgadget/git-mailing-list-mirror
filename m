From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] clone.c: move more code into the "if (refs)"
 conditional
Date: Sun, 12 Feb 2012 19:35:53 -0800
Message-ID: <7vmx8nids3.fsf@alter.siamese.dyndns.org>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
 <1328941261-29746-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Feb 13 05:00:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwn5E-0007zV-6L
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 05:00:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754797Ab2BMEAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 23:00:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49827 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097Ab2BMD77 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 22:59:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AA376E33;
	Sun, 12 Feb 2012 22:59:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=vrRUKnfWWB5u9WP9KXoM9shLvpY=; b=roKf92mcjkS1K8pWi+F0
	odirB6qiGPzBW4SDYt9MQY5DKtfc1fcdb2oZuwJTfEU6TZ4qSW8fYCGT/NEFhcfi
	gj/773JBm6Q9V/LwsaFElUwDuSmYY4wJTYly9GhxAFS15K5Illy+yjC8p4gA1tGW
	Zzo3W2/T6eIQBNfmKWLzmxU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=laZz/cYf5WdBF3IIjcKWM6Tio0CZ3zKxBjU0C8fA6zcgrr
	gDM9mb8MIQh74vGSKkvAVHm2x1hdVA6CwTcpzRuEGc2G7S73xJ/SG4sDOxfu8Npr
	YsbANZP7xaxA6XwmwdQOXsPtHLKLUJnvVfxFcE5YymM3f37dArKCUCu8erddE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FC8A6E32;
	Sun, 12 Feb 2012 22:59:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AE926E31; Sun, 12 Feb 2012
 22:59:58 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31F90C8E-55F7-11E1-84BD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190602>

mhagger@alum.mit.edu writes:

> From: Michael Haggerty <mhagger@alum.mit.edu>
>
> The bahavior of a bunch of code before the "if (refs)" statement also
> depends on whether refs is set, so make the logic clearer by shifting
> this code into the if statement.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/clone.c |   39 ++++++++++++++++++++-------------------
>  1 files changed, 20 insertions(+), 19 deletions(-)

Nice; the result is much easier to follow.
