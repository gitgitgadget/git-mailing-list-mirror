From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add a remote helper to interact with mediawiki
 (fetch & push)
Date: Fri, 26 Aug 2011 10:53:12 -0700
Message-ID: <7v4o14dppz.fsf@alter.siamese.dyndns.org>
References: <1314378689-8997-1-git-send-email-Matthieu.Moy@imag.fr>
 <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Jeremie Nikaes <jeremie.nikaes@ensimag.imag.fr>,
	Arnaud Lacurie <arnaud.lacurie@ensimag.imag.fr>,
	Claire Fousse <claire.fousse@ensimag.imag.fr>,
	David Amouyal <david.amouyal@ensimag.imag.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Sylvain =?utf-8?Q?Boulm=C3=A9?= <sylvain.boulme@imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 26 19:53:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qx0an-0002YK-R7
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 19:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754864Ab1HZRxR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 13:53:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43761 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365Ab1HZRxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Aug 2011 13:53:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 71AF44715;
	Fri, 26 Aug 2011 13:53:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WsSLthuh0J1hdUvQH46bTGpRFRI=; b=uILBSe
	PQq6TonCyOTGHM5586GPqrv8y4p2Bog+06nSEIAGPZcTI2vKBa0LZix+44v6xm/P
	kEa3VMVp0MK8eItsjX7pHFVxdypeR/P4S/eP4FwHE8eElV+ytnY8IKSQWRaPyGQW
	o1qnzivUXBLvp0T649jvjhCBevUCnnAuYwD78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=A4w33H56D2VsyiCrOunspnYtAKiEVO/m
	hwrcxZc52u40+MVIgGKNkX/6kr6iUwmzvFbu03L3rEpGyHoBdUSIr4CC3QQvr9kv
	RKBdu8WXwhNkqJSQUunhB/aUjiQ5EKFzYCQJ2RUiquwiTWwdau0hQp9NyCLqYKNn
	ikkm4/Q0UUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 681A94714;
	Fri, 26 Aug 2011 13:53:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C24354713; Fri, 26 Aug 2011
 13:53:13 -0400 (EDT)
In-Reply-To: <1314378689-8997-2-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri, 26 Aug 2011 19:11:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 451605EA-D00C-11E0-BE22-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180185>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> In short, the changes since v3 are:
>
> * Adapt to newer Git, which seem to require a "done" command at the
>   end of the fast-import stream. I don't understand why this is
>   needed, since fast-import is called without the --done flag by
>   remote-helpers, but if I don't do this, "git fetch" doesn't
>   terminate and keeps waiting ...

Hmmmm, is this a regression in fast-import? Can this be bisected if so?
