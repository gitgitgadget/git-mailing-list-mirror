From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Another approach to large transactions
Date: Fri, 17 Apr 2015 15:12:46 -0700
Message-ID: <xmqqsibyo141.fsf@gitster.dls.corp.google.com>
References: <1429226259-21622-1-git-send-email-sbeller@google.com>
	<xmqq8udqheb5.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: mhagger@alum.mit.edu, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 18 00:12:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YjEVK-0002AQ-Lf
	for gcvg-git-2@plane.gmane.org; Sat, 18 Apr 2015 00:12:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752188AbbDQWMu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 18:12:50 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751394AbbDQWMt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 18:12:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9A1CD48C10;
	Fri, 17 Apr 2015 18:12:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3DN1rGPkBWQFPzDnveqntI3CgGU=; b=u7/ebL
	PYNclIBomEb55S1pUDDLXnY+zoFcxR1nCM2wtT/eA2FxDYppTt/pf+TY9NQE9Dou
	vx/ctju5UPRMod+e4/fs+5+OP3Jvuz7lK5s6BlSXNu+qX1gyU85PWnpUpYMqIpx7
	J5uOmusseWet9ek+lNB4yVZ+OCaOCz6s/YPsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BBCdxQxs/WVn6vrU/7kfGwFRnlhgc3VB
	X4XW16egPIWJqo5InhV2y0Q+N5WinzoQB2WlLY/Jezcft81aHvOsfOo3mjOpz+3b
	NWEjuYCMfr7gijQPI89bhG5sI820FaToV9wHw1IglcZXeLfYRhQvQ/bY+gik1yhA
	Aifvx8y72U8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 91CA448C0F;
	Fri, 17 Apr 2015 18:12:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1AB9848C0E;
	Fri, 17 Apr 2015 18:12:48 -0400 (EDT)
In-Reply-To: <xmqq8udqheb5.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 17 Apr 2015 10:09:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E17D5AC2-E54E-11E4-A9F8-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267396>

Junio C Hamano <gitster@pobox.com> writes:

> Stefan Beller <sbeller@google.com> writes:
>
>> * We keep the speed on small transactions 
>>   (no close and reopen of fds in small transactions)
>>
>> * No refactoring for refs included, only minimally invasive to the refs.c code
>>
>> * applies on top of origin/sb/remove-fd-from-ref-lock replacing the last
>>   commit there (I reworded the commit message of the last patch of that tip,
>>   being the first patch in this series)
>>   
>> * another approach would be to move the fd counting into the lock file api,
>>   I think that's not worth it for now.
>
> I agree that it is a good direction to go to limit the number of
> open file descriptors.  Overall it looked good to me.

This is now pushed out and sitting at the tip of 'pu'.  It seems to
break one of the tests in 1400 when merged to 'next', but I didn't
look it closely.

Thanks.
