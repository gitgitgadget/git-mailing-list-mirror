From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 10:17:20 -0800
Message-ID: <xmqqoaqu2pu7.fsf@gitster.dls.corp.google.com>
References: <20141223084536.GA25190@peff.net> <54998949.9090908@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 19:17:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3U1Q-0005xb-5O
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 19:17:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512AbaLWSRY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Dec 2014 13:17:24 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63859 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751216AbaLWSRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Dec 2014 13:17:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AD57287B2;
	Tue, 23 Dec 2014 13:17:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=0y4AN+i6s6PX
	/rCw/yHBBvhZvWU=; b=FBhL6RxZ6bPNEqVAzukpLzGKpQFSPYJvBNtW7YqK70Nz
	q0j4bXZ0rjanxSXxkblYbp1mLo8xjhrjVJI6zYM+ygz3HQ/rZ7V2zEd1kpCVLUGe
	zI7bFE7evbfvI62bS5pYSbUUi1w+Be1e50ptGgMPlSu/TOmBM+Wc3lFIoK8im6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fDkeTh
	vxUtu63W6cCIGEfjgA9Awm+oLAjhHyIwsUl/tlf4op8tITvOECgJREVrhg82Uf5t
	b9zY42Nhece8du+9m2tY7niEiVTkX8Ot5HdOYnLSydw4fauh3/8sRnNdVl8hwtwr
	7XgNl4mB5LQLdJrkuM9irH+FNeQGX7CN4z+Dg=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71CCE287B1;
	Tue, 23 Dec 2014 13:17:22 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D5782287B0;
	Tue, 23 Dec 2014 13:17:21 -0500 (EST)
In-Reply-To: <54998949.9090908@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Tue, 23 Dec 2014 16:24:57 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F016D11E-8ACF-11E4-827A-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261756>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Don't we have the same possible problem under NTFS?
> Under Linux + VFAT ?
> Under all OS + VFAT ?

I do not think so, as NTFS codepath does not use the (previouly too
wide but now fixed) is_hfs_dotgit() in the first place, and
is_ntfs_dotgit() does not read one unicode codepoint at a time if I
remember correctly.

> And what happens if I export NTFS to Mac OS X?
> (Other combinations possible)
> Shouldn't fsck under all OS warn for NTFS and hfs possible attacks ?

Doesn't it?  Have you read the whole series you are commenting on?
