From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Clone Parameter
Date: Fri, 19 Jul 2013 08:05:06 -0700
Message-ID: <7vvc46y4il.fsf@alter.siamese.dyndns.org>
References: <FB572366-0B1D-4053-9255-979CB213B160@gmail.com>
	<CALkWK0=q62SmQwDPKjRv+Z8D59Uy=Kpanth8QFYFJ=xOA5JCtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Allan Acheampong <allanadjei@gmail.com>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 17:05:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0CFE-0007kE-OK
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 17:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518Ab3GSPFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 11:05:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33678 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752468Ab3GSPFN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 11:05:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F0FD43021E;
	Fri, 19 Jul 2013 15:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bNKEXYKHV1ncNyXdrNZiPJOOMCM=; b=TZN+wb
	Ui/NJngzc5dEU3sTgh52DGKC8fI+L/iqEavf8TWWBiVFYZyUeNCnJwfHGalh440s
	ALYogZKI4aSoI/kFHPAExhq5wYniEnGkX22x7MvoeVx+fgAKslVvxginAP3xB4JY
	wQDI1qZXoJ9vgVl0bWwpAkiRxHHGu5rtqxmm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IOjZak1Hs5D34o+6+wlut6JQe22E6txo
	WlVIy0ixh7HeJ1P7URsVx5lGkYhN/NyFRoVynP8srBoq+DSXOVmPPeRetDZJ5xAZ
	xJ5awdWAtC7y7/HZIgAKNM3/vtn+0hkdh++PKBhoFvN5EjZx0RpF6DKyehtdIDih
	ddibduLcJW4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E865E3021B;
	Fri, 19 Jul 2013 15:05:12 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BDC330218;
	Fri, 19 Jul 2013 15:05:12 +0000 (UTC)
In-Reply-To: <CALkWK0=q62SmQwDPKjRv+Z8D59Uy=Kpanth8QFYFJ=xOA5JCtw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Jul 2013 15:31:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C573014-F084-11E2-B5C1-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230814>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Allan Acheampong wrote:
>> I could write a script with for each in but thats way too much hassle
>
>   $ git for-each-ref --format="%(refname)" refs/remotes/origin/ | sed
> 's/refs\/remotes\/origin\///;/HEAD\|master/d' | xargs git checkout -b
>
> (completely untested ofcourse)

You would at least need "xargs -n 1" for the produced command line
to make any sense, and it is wasteful to actually check out each
and every branch to the working tree only to create it.
