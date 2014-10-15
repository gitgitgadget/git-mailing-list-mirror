From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: --dissociate option to mark that reference is only temporary
Date: Wed, 15 Oct 2014 14:50:45 -0700
Message-ID: <xmqqfvepuhmy.fsf@gitster.dls.corp.google.com>
References: <xmqqa94yzap8.fsf@gitster.dls.corp.google.com>
	<543E85FA.6050404@xiplink.com>
	<xmqqwq81w8az.fsf@gitster.dls.corp.google.com>
	<543EDE6A.7040500@xiplink.com>
	<xmqqsiipuifi.fsf@gitster.dls.corp.google.com>
	<543EEAC4.8070204@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 23:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeWT6-0004cs-2g
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 23:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbaJOVus (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2014 17:50:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55940 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750792AbaJOVus (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2014 17:50:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5DF2915D9B;
	Wed, 15 Oct 2014 17:50:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dcJ776lGW3ikKcGvJqs/IqWcqJI=; b=oySLaL
	jC+PwamOGK9lnpnh05eDR3jR5RehJqyY/tABro0qrY3fogJ21+hFuIAOBkQ1J1EF
	MfP6huRYKDbNyJ+gIp7jp5PzNanlOAkgIPbk/6xk4yqGIAy9tEkWrq1+a3BNU6Dn
	kI5qD66GYhf89ZIuhLdrOu0q4C/XdiVdRMUlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GGgAVeFyjVdph1/PXmP0CAsHeUQfYf6w
	GaR1aQc0+YTLmp4NEP883VTBIzGgE3qHkLUh2dSxNJ9KiohQygnwYf3JvbBJ8aEf
	MSTyuZb0s6D/iF9TTFEeefgOA00aapvlKQ+AQAmDLp55VSiOG+Va7V2F++BBX2Q9
	jP0e1tXJL3Q=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5424615D9A;
	Wed, 15 Oct 2014 17:50:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C3BD915D99;
	Wed, 15 Oct 2014 17:50:46 -0400 (EDT)
In-Reply-To: <543EEAC4.8070204@xiplink.com> (Marc Branchaud's message of "Wed,
	15 Oct 2014 17:44:36 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 51EAB7EE-54B5-11E4-BE37-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Marc Branchaud <marcnarc@xiplink.com> writes:

> Yes, but we're cloning gko, not the neighbour.  Doesn't that mean that the
> clone operation won't know about any of the neighbour's refs?

No.  --reference (and a natural implementation of --borrow, I would imagine)
peeks the refs of the repository we borrow from and that is how
clone can say "I already have objects reachable from these refs, so
please send me the remainder" to the repository it is cloning from.
