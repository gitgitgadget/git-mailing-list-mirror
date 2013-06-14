From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/5] Write a good 'git stash store' for autostash
Date: Fri, 14 Jun 2013 07:26:47 -0700
Message-ID: <7va9mssr88.fsf@alter.siamese.dyndns.org>
References: <1371205924-8982-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 16:26:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUxr-0000MV-Pm
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 16:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752779Ab3FNO0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 10:26:51 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63577 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751884Ab3FNO0u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 10:26:50 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FFF22749A;
	Fri, 14 Jun 2013 14:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iGdUzl3984l7JDYDpODdPRD2TbY=; b=tE28JE
	ThTjBO55XQ+BpvEAtk2VkG9DlmJeJtE+bc3KpTWA7QlfZgi4HzIYkgOudSa8aK07
	HO2Y2Vct56vYFJ6Y2hQGyAm5HQvnaT0rhX9vLblEcVngueuZr52WFg3g5FKsV6n7
	Yj0ctHPt5toeAltJcLh+RmlSPg+VHQ0gCffH0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xuDcphFxVYb6vrzNfpgq9UehY0FVhIB2
	RIWamWK1ij6mMy4yppeQa+Q5Q3G12Gi1Jhfcc5qkvfXeDZcnNzQ1Iu/EPIIYNwlC
	QFGc6k3+v1Anwepgjtc1+3W9tCpkSQEUNju7fQo/ZPY8eLPmzFpITEl9GiRlG5n+
	Xm0dwGx5kW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74F9C27499;
	Fri, 14 Jun 2013 14:26:49 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EEC0527498;
	Fri, 14 Jun 2013 14:26:48 +0000 (UTC)
In-Reply-To: <1371205924-8982-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Fri, 14 Jun 2013 16:01:59 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 72F33408-D4FE-11E2-866C-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227874>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> So, I've taken Junio's suggestion and designed a proper command-line
> interface for 'git stash store' in this iteration:
>
>   git stash store [-m <message>] [-e <error>] <commit>

I am perplexed; that would not something I _would_ design or
suggest.  The "-e <error>" looks especially odd, in that "-e"
usually refers to something the command evaluates (e.g. sed, perl),
but more importantly if the caller wants a custom error message,
normal programmers would do

	command || die "my custom error message"

and if "command" wants to show its own error by default, perhaps do

	command --quiet || die "my custom error message"
