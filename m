From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git svn: reset invalidates the memoized mergeinfo
 caches
Date: Fri, 10 Aug 2012 14:29:05 -0700
Message-ID: <7vmx22iggu.fsf@alter.siamese.dyndns.org>
References: <20120807200207.GA10899@m62s10.vlinux.de>
 <20120807204510.GA10453@dcvr.yhbt.net>
 <20120808054129.GB10899@m62s10.vlinux.de>
 <20120808225258.GA24956@dcvr.yhbt.net>
 <20120809064253.GC10899@m62s10.vlinux.de>
 <20120810202211.GA16606@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Andrew Myrick <amyrick@apple.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Steven Walter <stevenrwalter@gmail.com>,
	Peter Baumann <waste.manager@gmx.de>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:29:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szwld-00025d-UO
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715Ab2HJV3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:29:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40572 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758010Ab2HJV3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:29:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35F718C0C;
	Fri, 10 Aug 2012 17:29:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nj95iggFQVHN9BP6AWdLt9g596c=; b=iXtR47
	rgAW5wQweJ568eBqqj7U5IMQgg+rpG+BvXb3r/qBJc+/4NXklE7c6UdS4sxSU/5c
	b/xVtse4UJ7eyNbBfWydYf0V9opCwHiSXR0+T5SpEZ/lF4uMfPqaunZX/3BbYOGx
	0FG2ZftaJV6KNDmSEx9smomJSoNHSUtuu0Hm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oCOSrpmmk2EjcaKXTS9DduvkMHM1ppl/
	9ufIZsKyf15AkNkicnYN7cPlbekyboPDLlS/sedb5Chhs+tcl2QHpvuuLQjazKCs
	XwPzyAXWMrd7GUp3usqOkw09TZW4lw2Gpg+sPV7s/LDDnmtIw4j/EecXN+DPSNBr
	BqITTuVFsnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21ACC8C0B;
	Fri, 10 Aug 2012 17:29:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 984608C0A; Fri, 10 Aug 2012
 17:29:06 -0400 (EDT)
In-Reply-To: <20120810202211.GA16606@dcvr.yhbt.net> (Eric Wong's message of
 "Fri, 10 Aug 2012 20:22:11 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6A25AFAE-E332-11E1-9CE4-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203264>

Eric Wong <normalperson@yhbt.net> writes:

> Peter Baumann <waste.manager@gmx.de> wrote:
>> First, let me thank you for your review and your detailed explanation.
>> I really appreciate it.
>
> You're welcome, Peter.  Thanks again for the patch.  I've signed-off and
> pushed for Junio.
>
> The following changes since commit 034161a94e827ef05790b1c7ce5a6e3e740c864e:
>
>   Merge git://github.com/git-l10n/git-po (2012-08-09 10:51:46 -0700)
>
> are available in the git repository at:
>
>
>   git://bogomips.org/git-svn for-git-master
>
> for you to fetch changes up to 61b472ed8b090a3e9240590c85041120a54dd268:
>
>   git svn: reset invalidates the memoized mergeinfo caches (2012-08-10 19:53:18 +0000)
>
> ----------------------------------------------------------------
> Peter Baumann (1):
>       git svn: reset invalidates the memoized mergeinfo caches
>
> Robert Luberda (1):
>       git svn: handle errors and concurrent commits in dcommit

OK, so these two are fit for 1.7.12-rc3 and later?

Will pull.

Thanks.

>
>  git-svn.perl                           |  74 ++++++++---
>  perl/Git/SVN.pm                        |  27 ++++-
>  t/t9163-git-svn-reset-clears-caches.sh |  78 ++++++++++++
>  t/t9164-git-svn-dcommit-concrrent.sh   | 216 +++++++++++++++++++++++++++++++++
>  4 files changed, 374 insertions(+), 21 deletions(-)
>  create mode 100755 t/t9163-git-svn-reset-clears-caches.sh
>  create mode 100755 t/t9164-git-svn-dcommit-concrrent.sh
