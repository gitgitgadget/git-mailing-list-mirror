From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] git p4: fix branch detection with --use-client-spec
Date: Sat, 11 Aug 2012 21:41:51 -0700
Message-ID: <7v4no8hgc0.fsf@alter.siamese.dyndns.org>
References: <CANWnr5aqswATTM9_Zyw=w_x01=e8CqoCsn0Ybee0XvGSJ3F_yw@mail.gmail.com>
 <20120811165143.GA2004@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthew Korich <matthew@korich.net>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 06:42:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Q0b-0002qQ-VA
	for gcvg-git-2@plane.gmane.org; Sun, 12 Aug 2012 06:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803Ab2HLElz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Aug 2012 00:41:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750711Ab2HLEly (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2012 00:41:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F17B911C;
	Sun, 12 Aug 2012 00:41:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=63b8gHoofbShfFvDaHahvhF4mwU=; b=yBrz/M
	R+mvhxIBTtY91Yd60DQiHCI0mU/ez4AfDNwhoGctLhs3KBmTefOdi8B5UbDWB0nm
	lk0wI9tYxZQzxrYyFi821F/ZYeUHWHo1S+OdNGI6mfzu+xagBRRuf+gzno0x4FWa
	9xwMX5QtJxUKxR9lb1UcTKxvwQKhQRle9AvXU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FuUTIY1rU9BsOGLwzaR0nAAXvwgYBqxt
	ApgbFvegMc2Iabsb21BdL+qaPEGro566rlTju3FaijydDLiIGIoiwKZe60zntqYN
	mdVc/iJaDoJ+e2OZp///59Q6ndp6bwD54e31UJ8mUzJ+22ovEjr6WaHJoqdoQD4i
	e+7fxZCFGDk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D24C911B;
	Sun, 12 Aug 2012 00:41:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5722D9118; Sun, 12 Aug 2012
 00:41:53 -0400 (EDT)
In-Reply-To: <20120811165143.GA2004@padd.com> (Pete Wyckoff's message of
 "Sat, 11 Aug 2012 12:51:43 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 09ECDFB6-E438-11E1-B031-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203304>

Pete Wyckoff <pw@padd.com> writes:

> matthew@korich.net wrote on Fri, 10 Aug 2012 12:14 -0700:
>> Using git p4 on git version 1.7.12.rc2 has path issues. Standard
>> clone/sync ops apparently place detected master and branches on
>> independent and parallel directory structures instead of git branches.
>> See http://stackoverflow.com/q/11893688/1588831 for a full demo of the problem.
>
> Thank you for the detailed report.  It is a bug in 1.7.12-rc2.

Do you mean "a feature that was present in 1.7.11 without this bug
was broken when used with 1.7.12-rc2"?  Or do you mean "this bug
exists in 1.7.12-rc2 (older versions may or may not have it, but I
am stressing that it is not fixed)"?

The description for [PATCH 5/5] blames v1.7.9-rc0~4^2~1, which tells
me it is the latter.  And if that were the case, and if this were in
the area of the system I oversee, I wouldn't push it to the upcoming
release at this late in the cycle, when I do not know what other
things it might break while fixing this bug (in other words, a fix
to an old bug is not an execuse to introduce a regression).

But git-p4 is not in my area, so if you meant this should go in the
upcoming 1.7.12 release, I'll queue them directly on 'master'.

Please tell me what your preference is.

Thanks.

> This series fixes it, on top of origin/master.
>
> The crux of the matter is that files are mapped into the wrong
> locations in git when both --use-client-spec and --branch-detection
> are enabled.
>
> Pete Wyckoff (5):
>   git p4 test: move client_view() function to library
>   git p4 test: add broken --use-client-spec --detect-branches tests
>   git p4: set self.branchPrefixes in initialization
>   git p4: do wildcard decoding in stripRepoPath
>   git p4: make branch detection work with --use-client-spec
>
>  git-p4.py                     | 75 +++++++++++++++++++++++++++--------------
>  t/lib-git-p4.sh               | 18 ++++++++++
>  t/t9801-git-p4-branch.sh      | 77 +++++++++++++++++++++++++++++++++++++++++++
>  t/t9809-git-p4-client-view.sh | 17 ----------
>  4 files changed, 146 insertions(+), 41 deletions(-)
