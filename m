From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH 1/4] Prepare checkout_entry() for recursive checkout
 of submodules
Date: Sat, 10 Apr 2010 11:44:28 -0700
Message-ID: <7vwrwfw3jn.fsf@alter.siamese.dyndns.org>
References: <4BBF9D6F.2000006@web.de> <4BBF9DC9.8030905@web.de>
 <7vd3y81e3s.fsf@alter.siamese.dyndns.org> <4BBFB40C.1060905@web.de>
 <4BC0AED8.1080006@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sat Apr 10 20:44:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ffi-00066M-I7
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 20:44:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140Ab0DJSoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 14:44:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35770 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab0DJSoi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 14:44:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 54439A9917;
	Sat, 10 Apr 2010 14:44:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=shiSALaqDE3FQ6BWOZaQfemwUME=; b=LEkO6+
	s7J5qcCvObsinwJZoqCBZNbImeH/yhIz7hpjbX4RSUN9kgevkbPpl2kNJ5APiC0T
	hsakFwWxAlA6x1Z4N85RtGWSXjstC59H0t69ootkuNZuIPqqFiNW3DizxFkU4+aV
	cqmGevgocwjGKsBKUhq/Os05dPjkcZRRvjwlg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IAo/9fBOHcje5KVIXuqx9kHgIYOKA3Ns
	E9yNw/QiXlfLDss0sR5tzlGW8MQeayJ0CRzkKzLlnQVLMHdnrWzqrkXGWJOFlvfR
	TvlLdRzaLaXwIBUq7xTvK5J1YP9yu4LrdWrupC63m2vEDtLxcN66nAEdpoKRTL3a
	lNyUHQcdx/A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F7EDA9915;
	Sat, 10 Apr 2010 14:44:33 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DFA0A9910; Sat, 10 Apr
 2010 14:44:30 -0400 (EDT)
In-Reply-To: <4BC0AED8.1080006@web.de> (Jens Lehmann's message of "Sat\, 10
 Apr 2010 19\:01\:12 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1AA5AE04-44D1-11DF-856F-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144575>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>>> This would give you an incorrect result if .git is a file that records
>>> "gitdir: overthere" (see read_gitfile_gently() in setup.c); I would expect
>>> it would become a fairly important ingredient if we ever enhance the
>>> submodule support to add submodule that disappears/reappears in the
>>> history.
>> 
>> Right. This assumption is also present in add_submodule_odb() (used by
>> show_submodule_summary()) and is_submodule_modified(), so i just reused
>> it. This should be addressed in another patch.
>
> What about this one:

Looks sensible to me.  Thanks, and sorry for not catching this earlier.
