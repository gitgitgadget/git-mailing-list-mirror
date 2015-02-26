From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PULL] git-svn updates for master
Date: Thu, 26 Feb 2015 14:06:13 -0800
Message-ID: <xmqq61aol44q.fsf@gitster.dls.corp.google.com>
References: <20150226213515.GB2930@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Mike <ipso@snappymail.ca>, Minty <mintywalker@gmail.com>,
	Nico =?utf-8?Q?Schl=C3=B6mer?= <nico.schloemer@gmail.com>,
	Valery Yundin <yuvalery@gmail.com>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Ryuichi Kokubo <ryu1kkb@gmail.com>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 23:06:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YR6Zc-0007N1-VT
	for gcvg-git-2@plane.gmane.org; Thu, 26 Feb 2015 23:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754001AbbBZWGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2015 17:06:19 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56757 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754502AbbBZWGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2015 17:06:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 77B693BA3A;
	Thu, 26 Feb 2015 17:06:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ezzKcYM/DWfnWdb6RM5UHiuufc0=; b=Ab55v1
	KJJCgsepbp+3VHQEPUeglsx8eJeKFWt5naYr2KOmYmpwSAGWSNaK3bOsMd3bPiZi
	OvHTqRGygRsVkLC5caa13wZdP5Pddy8cZ7TlFgtWYcdoSppQCd3oQOTibRvvTXrU
	cuE0ZjXnPcfiDrdpx32oI+KerpZ7CTyefia/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Oax3/hLishEiB2TEa5qCDVuKfmwz3rKT
	S7das14TNepTuaGroJhCrVvq+9ji8be4nQ6Xc2ATphrH897+rt7ipjsDoRGzqA+r
	kUW3uoo3WIdzNH7VpjrZTHnFPrSQDw6du1zXMN9+yh/gOLlUlYGPs4lK4XwCNoUv
	7kGSgWnpPd8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F00C3BA39;
	Thu, 26 Feb 2015 17:06:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C9B593BA38;
	Thu, 26 Feb 2015 17:06:14 -0500 (EST)
In-Reply-To: <20150226213515.GB2930@dcvr.yhbt.net> (Eric Wong's message of
	"Thu, 26 Feb 2015 21:35:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AE75BF92-BE03-11E4-8D7B-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264472>

Eric Wong <normalperson@yhbt.net> writes:

> Hi Junio, mainly bugfixes but a tiny amount of progress on lazy-loading.
> The bugfixes from Kyle and Ryuichi should also be applied to maint.

I think you mean "cherry-picked".  Let me try to rearrange them by
doing the following:

0. Grab your stuff.

    $ git fetch git://bogomips.org/git-svn.git master

1. Queue two fixes for maint-2.2

    $ git checkout -b svn-maint-fixes maint-2.2
    $ git cherry-pick -s -2 FETCH_HEAD

2. Queue the other one for master, together with the other two

    $ git co -b svn-fixes FETCH_HEAD~2
    $ git merge --no-edit svn-maint-fixes

3. Make sure I got that right by comparing with yours

    $ git diff FETCH_HEAD
    ... no output ...

Then I'll merge svn-fixes to my 'master' and hopefully we can later
merge svn-maint-fixes to 'maint' and 'maint-2.2'.

Thanks.    

> Thanks.
>
> The following changes since commit 7f4ba4b6e3ba7075ca6b379ba23fd3088cbe69a8:
>
>   Post 2.3 cyle (batch #5) (2015-02-25 15:44:04 -0800)
>
> are available in the git repository at:
>
>   git://bogomips.org/git-svn.git master
>
> for you to fetch changes up to e0b4cad4fd77e4cd787c3ed26e7650fc4de8bcd2:
>
>   Git::SVN::*: avoid premature FileHandle closure (2015-02-26 20:19:41 +0000)
>
> ----------------------------------------------------------------
> Eric Wong (1):
>       git-svn: lazy load some modules
>
> Kyle J. McKay (1):
>       Git::SVN::*: avoid premature FileHandle closure
>
> Ryuichi Kokubo (1):
>       git-svn: fix localtime=true on non-glibc environments
>
>  git-svn.perl            | 13 +++++++------
>  perl/Git/SVN.pm         | 25 +++++++++++++++----------
>  perl/Git/SVN/Editor.pm  |  3 +--
>  perl/Git/SVN/Fetcher.pm | 11 +++++++++--
>  perl/Git/SVN/Ra.pm      |  8 +++++++-
>  5 files changed, 39 insertions(+), 21 deletions(-)
