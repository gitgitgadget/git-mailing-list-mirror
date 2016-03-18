From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/2] rebase: decouple --exec from --interactive
Date: Fri, 18 Mar 2016 14:44:10 -0700
Message-ID: <xmqqd1qrpil1.fsf@gitster.mtv.corp.google.com>
References: <xmqqd1qszs03.fsf@gitster.mtv.corp.google.com>
	<1458336377-28296-1-git-send-email-sbeller@google.com>
	<xmqqh9g3pj3e.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes.Schindelin@gmx.de, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 22:44:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah2Bu-0005wh-NG
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 22:44:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531AbcCRVoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 17:44:15 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754940AbcCRVoN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 17:44:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEBCA4EBDA;
	Fri, 18 Mar 2016 17:44:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SEaBhJzRGW+pAUopDoN0z8jfpHA=; b=XgDOa/
	X492r/ef8DJyhQwOPE54A3M47fI0iR4bRDokqlxIURAqC1d0M6ryAXPKW8omH00h
	VwXSm+S36Hq0xsvhbCNDxxY5eyGf0EUxq2hHkHdAqySQFQlcXdw4IdXLnSB4pq/s
	/MdZL15sLAqVf+WuplNV7i2faIE3x8iYSEgmI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U5+FIm+zKr8X+kJ+Rum2TX7wUEZqLpdd
	QZKxT23j8MCQwIbj6D8stP7bJpgVcs9Ez7rX95JHUG9dO6d5odNXzM4WO1zIW6Aw
	Kx7t0Zyy6NIt2vltbmi+qulOZDbnQS2ctegwVqsP42YLiScGzxaaEObpCPQyDBhi
	t7PJdK1WcD4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A586F4EBD9;
	Fri, 18 Mar 2016 17:44:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1C9BE4EBD8;
	Fri, 18 Mar 2016 17:44:12 -0400 (EDT)
In-Reply-To: <xmqqh9g3pj3e.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Fri, 18 Mar 2016 14:33:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8D796990-ED52-11E5-A3E9-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289256>

Junio C Hamano <gitster@pobox.com> writes:

>>         +	EDITOR="echo >invoked_editor" git rebase --exec "echo a line >>exec_output"  HEAD~2 2>actual &&
>
> Hmph.  If you add "-i" to the command line, do you see the
> 'invoked_editor' file created?
>
> I ask this because I thought we override GIT_EDITOR, which has
> higher precedence than EDITOR, in the test-lib framework.

False alarm.  We do use EDITOR=: and arrange GIT_EDITOR from the
outside world to be ignored by unsetting in test-lib.sh, so
exporting EDITOR here should be safe and OK.

Will queue once I manage to locate 2/2 ;-).
