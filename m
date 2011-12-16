From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Any tips for improving the performance of cloning large
 repositories?
Date: Fri, 16 Dec 2011 09:08:06 -0800
Message-ID: <7vzkesigw9.fsf@alter.siamese.dyndns.org>
References: <CAJ-05NPP7aCcr_SYxLYk8U1entDMv0aF2Me3cTGmOLjYqFKUOA@mail.gmail.com>
 <hbf.20111216yufz@bombur.uio.no> <hbf.20111216zcin@bombur.uio.no>
 <201112161414.pBGEExLJ006769@no.baka.org>
 <CAJ-05NPbRmyx=a+U7BK4rNShBgaXj+g-Bwc1aBDDb3N0VPBW=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Seth Robertson <in-gitvger@baka.org>,
	Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Alex Bennee <kernel-hacker@bennee.com>
X-From: git-owner@vger.kernel.org Fri Dec 16 18:08:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbbGZ-0000Vm-2C
	for gcvg-git-2@lo.gmane.org; Fri, 16 Dec 2011 18:08:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760110Ab1LPRIL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 12:08:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51684 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752189Ab1LPRIJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 12:08:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C1C57747;
	Fri, 16 Dec 2011 12:08:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MZxmXNfpm7bj2V+a3GGeNMGNbKU=; b=G4RTKu
	S2IfSnjM05/1zgQj5lOIyJf/u4s6ajk6MkPFj8VN5P8K/5gaBzZljn6GNyhGJX90
	4+SVW5p1YxATVtToCzi1ON2DVeDpxi/dlIOtuCnPWeDzf4lQLF3vdZ4D/8qRWOVq
	pFqFDpLYUIARNRXF6HO+eg4T1vWjYajNuTDJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ukZMH1olOfQnua0jZunFgWjNmhrd/a5m
	IjSFcGdr2Rx4zh1L57zYffqHISEJfslGOm7QDLVo8VUtf3qudHYWXeQ3kpgwyO86
	5vqjE1Yebm2XOHQzdLn2EhGZXimqPmifWLVmwP+JPrMMIiKgIKBF97rwn2zLG+0n
	bayXDlzqkx0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 929B77746;
	Fri, 16 Dec 2011 12:08:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 124BC7745; Fri, 16 Dec 2011
 12:08:07 -0500 (EST)
In-Reply-To: <CAJ-05NPbRmyx=a+U7BK4rNShBgaXj+g-Bwc1aBDDb3N0VPBW=A@mail.gmail.com> (Alex
 Bennee's message of "Fri, 16 Dec 2011 15:28:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 86992C14-2808-11E1-AFD6-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187288>

Alex Bennee <kernel-hacker@bennee.com> writes:

> Well that's counter intuitive....
>
>  - reverting the original repo to one big pack speeds up the clone
>  - adding a --local --reference mirror slows it down

Neither is. Read what "--local" says in the help text of clone. It
disables the git aware clever optimization.
