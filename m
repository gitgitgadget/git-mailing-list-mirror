From: Junio C Hamano <gitster@pobox.com>
Subject: Re: blame -C: adding a line in moved content sometimes affect blame
 result
Date: Wed, 08 Jun 2011 20:25:25 -0700
Message-ID: <7v4o3zznx6.fsf@alter.siamese.dyndns.org>
References: <4DEF041A.9070003@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 09 05:25:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUVsH-0005sA-Tw
	for gcvg-git-2@lo.gmane.org; Thu, 09 Jun 2011 05:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755531Ab1FIDZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 23:25:33 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43953 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755140Ab1FIDZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 23:25:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AE10166C9;
	Wed,  8 Jun 2011 23:27:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LLUoozEa+tXnLdesu5RWLj6oEfc=; b=LJ5zjl
	gAT0Wl9d12sDMivSbr2C058U8RttuyF4vg1OhvmmBuYvAHjhXmRQBfzvzRSmmVeZ
	qJLk2NRwU4G7iv4QIQeN3jFgDvbGwE1BOnHFy35KskhiIPuQjdf76JBBigrcvJos
	Dh0Slb4ABGSp0A0dvWIWxRmSYCGJGHVxM4+qM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mDngFTL3QsKOJVrV+nsQJJ/JCTNx/s8t
	NBWqTwwvzL3FJYoi4gEmsL0hABPl9Jq9YlEUeIN2yX4XjDSONFjXn88qsn/tHfWQ
	OuhYgPDG4IJPEHk/X2ogVNB6QQTOgIb0jR1Iv++pcKs18osOUGLG2NuSMgoNm/rJ
	iB2ctl9eiCc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D8DB66C7;
	Wed,  8 Jun 2011 23:27:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id AA41D66B9; Wed,  8 Jun 2011
 23:27:37 -0400 (EDT)
In-Reply-To: <4DEF041A.9070003@gmail.com> (Andrew Wong's message of "Wed, 08
 Jun 2011 01:09:46 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6E29D076-9248-11E0-9688-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175486>

Andrew Wong <andrew.kw.w@gmail.com> writes:
>
> After moving content from file1 to file2, "git blame -C file2"
> correctly shows that the content came from file1. However, if I add a
> line in near the top or bottom of the moved content in file2, "git
> blame -C file2" fails to detect that the top or bottom of the moved
> contents came from file1.

Probably your first few remaining lines of file2 are considered
insignificant copy by the logic in step 4 described in:

    http://thread.gmane.org/gmane.comp.version-control.git/28826

I didn't actually tried to follow what the code does to your exact input,
though.
