From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (May 2016, #02; Fri, 6)
Date: Tue, 10 May 2016 00:20:31 -0700
Message-ID: <xmqqy47iqszk.fsf@gitster.mtv.corp.google.com>
References: <xmqqeg9e24ay.fsf@gitster.mtv.corp.google.com>
	<alpine.DEB.2.20.1605100757410.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 10 09:20:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b01yA-0008GL-Ss
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 09:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbcEJHUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 03:20:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbcEJHUe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 03:20:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6BC5714CE7;
	Tue, 10 May 2016 03:20:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5t+AkEj8hZ2kFaTpwXjLDcY9k8M=; b=IL4ixa
	sD/LkjnndpJNvxUvRnrh2+YFUfvIOtHv3/cZYyuxOT3g/e7YGTxXJqs56frbbuW+
	VEphcj6qO2vh6t0J9NjUlYdGLxAukNSdkpeQRIXThbDI4BfNMRnvkJmOX0PPdtSr
	DJ6ZgVy6yv7rpR+2p3NRJ2hWNPKb203M4lfqU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rS/7xKJUtbpgOIFymK+nNeNLoVt5Bz7Y
	9yNPfJ2L2/ssu+kOqCi888Xi4edaYsLe69xtIwR6QP44/J2uzUHxH7jCX268DFl+
	HnyOCw89lY7KWvhA0JPu5ShsdHl33ak27+7mcEAapQQvBc1r1YXl8R2/uzZu5RuR
	K0Ha5WbRSBs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 62C1C14CE6;
	Tue, 10 May 2016 03:20:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D2A8414CE4;
	Tue, 10 May 2016 03:20:32 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.20.1605100757410.4092@virtualbox> (Johannes
	Schindelin's message of "Tue, 10 May 2016 07:59:35 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AEAF501A-167F-11E6-AD23-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294112>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Fri, 6 May 2016, Junio C Hamano wrote:
>
>> * jc/fsck-nul-in-commit (2016-04-14) 2 commits
>>  - fsck: detect and warn a commit with embedded NUL
>>  - fsck_commit_buffer(): do not special case the last validation
>> 
>>  "git fsck" learned to catch NUL byte in a commit object as
>>  potential error and warn.
>> 
>>  What was the status of this one?  Ready to proceed?
>
> I think this code looks fine. Maybe two comments on the test:
>
>>               test_must_fail git -c fsck.nulInCommit=error fsck 2>warn.1 &&
>>               git fsck 2>warn.2 &&
>>               grep nulInCommit warn.2
>
> 1) warn.1 is not used. Maybe skip that redirection?

Or check it for expected result.  I don't know offhand which is better.

> 2) I was under the impression that we preferred test_i18ngrep over grep...

Only when the strings we are expecting are subject to i18n.  I
somehow did not think your report() codepath has any i18n/l10n?
