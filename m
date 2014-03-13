From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: Write git subtree info to .git/config
Date: Thu, 13 Mar 2014 16:36:06 -0700
Message-ID: <xmqqmwgthdsp.fsf@gitster.dls.corp.google.com>
References: <CAJ2ZDL+HuBCv_xJCXEBb3Pex-qt86ocEX9yu=uV+CzdvqwECDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: John Butterfield <johnb003@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 00:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOFAh-0003jC-Jt
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 00:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbaCMXgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 19:36:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354AbaCMXgO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 19:36:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0FEA7558F;
	Thu, 13 Mar 2014 19:36:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lTTgiYZLMaGvX/WduJCBwQ+hXCg=; b=r/ZEzB
	CvFLe9dihqP4N2w/5LWQwMig8mGk6NqwZBHsycpnOroDwlU/VOo+VrJaPMZ9wQFR
	/btwjnyhp/JQrp8pEciOFkgS10kPDL7aNoHyYQJahMSTGV8AAdRV1JSqsUxWPvdg
	znBsc/pPaqyq6ufHsBZQrxq7cPuaV9pP4lN24=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ByrMNsjmIqRPU5+npbQwNC61mza2iWTG
	xfPYPQcFbSypTRYt01RiMXgz3R8xZBxeuIt/5/Lv3xPNMV0Zg9YCZ5BkVFOYBRl1
	BNK7umC83zaTB/tjGPLgFyt53g9UhQAI6rw5kMfIhothTjbIeYF8Xjxa4UfvlU4p
	PHMPXfR4fKI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ECF97558E;
	Thu, 13 Mar 2014 19:36:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BCAE57558A;
	Thu, 13 Mar 2014 19:36:12 -0400 (EDT)
In-Reply-To: <CAJ2ZDL+HuBCv_xJCXEBb3Pex-qt86ocEX9yu=uV+CzdvqwECDA@mail.gmail.com>
	(John Butterfield's message of "Thu, 13 Mar 2014 16:18:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4343372C-AB08-11E3-A97D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244062>

John Butterfield <johnb003@gmail.com> writes:

> Has there been any talk about adding a stub for git subtrees in .git/config?

I do not think so, and that is probably for a good reason.

A subtree biding can change over time, but .git/config is about
recording information that do not change depending on what tree you
are looking at, so there is an impedance mismatch---storing that
information in .git/config is probably a wrong way to go about it.

It might help to keep track of "In this tree, the tip of that other
history is bound as a subtree at this path", which means that
information more naturally belongs to each tree, I would think.
