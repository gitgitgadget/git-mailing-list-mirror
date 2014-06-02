From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/9] replace signal() with sigaction()
Date: Mon, 02 Jun 2014 12:05:29 -0700
Message-ID: <xmqqzjhv3zeu.fsf@gitster.dls.corp.google.com>
References: <cover.1401645403.git.jmmahler@gmail.com>
	<538C5FD9.1010706@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>,
	Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Jun 02 21:05:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrXYO-0000Om-LS
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 21:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbaFBTFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 15:05:39 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62950 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753212AbaFBTFg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 15:05:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 54BC41DADC;
	Mon,  2 Jun 2014 15:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VA2VxidyiWZB+hL7xfMHSWzRZQU=; b=rFsCCY
	FKRRQa00NLkAt0SdUxveL+BjM9iDl40ECZ3M3JDh+wT1Msi4wxSn8yy2x2nrtVDb
	hXNI7xAhbNxnebOsFbfnhcq3I/szwy6HyWvtm0bM77zCCdDHKaJnJJfpS3/dHy7A
	YGwV7iPhzjiDYQK4ld3t7T1ulqcaUGiRbV8aE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPeBseqdmFKYxjORbJPxFLSnXwRKKGvI
	FzhmGehANrRWHjeDOn/L/py8ZkPKvtRDEpVAjab6t9+S64DgPnrxNPKLE1wTPMQM
	dviIdh3Fjd4VPIg5nQ0B///IAMtu5AXMWv/GOPVn6p6FCnxWlm5TRDEQhrStrBRf
	fBbhb8tYGtg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 49DE41DAD9;
	Mon,  2 Jun 2014 15:05:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BBAF31DAD3;
	Mon,  2 Jun 2014 15:05:31 -0400 (EDT)
In-Reply-To: <538C5FD9.1010706@viscovery.net> (Johannes Sixt's message of
	"Mon, 02 Jun 2014 13:28:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DE550E60-EA88-11E3-B254-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250581>

Johannes Sixt <j.sixt@viscovery.net> writes:

>> Jeremiah Mahler (9):
>>   compat/mingw.c: expand MinGW support for sigaction
>>   connect.c: replace signal() with sigaction()
>>   progress.c: replace signal() with sigaction()
>>   write_or_die.c: replace signal() with sigaction()
>>   daemon.c: replace signal() with sigaction()
>>   builtin/log.c: replace signal() with sigaction()
>>   builtin/merge-index.c: replace signal() with sigaction()
>>   builtin/verify-tag.c: replace signal() with sigaction()
>>   sigchain.c: replace signal() with sigaction()
>
> The series without patch 9/9 works on Windows so far.
>
> Without patch patch 9/9 and a more complete implementation of sigaction in
> compat/mingw.c the series misses its goal. But even if you complete it, it
> is IMHO only code churn without practical merits.

Hmm, you sound a bit harsher than you usually do---although I
sort of share with you the doubt on the practical merits.
