From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/10] Fix icase grep on non-ascii
Date: Thu, 28 Jan 2016 15:54:49 -0800
Message-ID: <xmqq60ydl0om.fsf@gitster.mtv.corp.google.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:54:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOwOt-0004yD-LG
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 00:54:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbcA1Xyx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Jan 2016 18:54:53 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:61567 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751040AbcA1Xyv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jan 2016 18:54:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C34D13F397;
	Thu, 28 Jan 2016 18:54:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Yt5ySdvn5cgX
	8hy4C9fPYQ2ihIs=; b=q9f8sG891JNNStRMRUvGESYTLRouPsqu9K1Le4ib8SUx
	3YYcKCnUtKLzwQyK6PXA954EBYyPEhUisI4Ly/kAuioB/EkkXD20JaUW+5gpsxPj
	tqGsUbcr2SyY7KiE8VApVz//zGW0sDmH6mgLcyIyGKbPZ0G+1mc9WaY8ovcHMkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gTzjWF
	ywpWX968N9cf6Gbad43w7DKIo11ZDAeaIW+vH9NGzE/5QePwRCuGoVg83kbRoXfy
	uw61xmoccc4yBhmWky9D75EG2a7A10cVwcpw0DryeFXnCbS7VAg6tZt73hSTecvc
	7jtoM2F8Gb6caE5MeSuU7cPbKw/Ar3U34NmKE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BB2E03F396;
	Thu, 28 Jan 2016 18:54:50 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3DF903F395;
	Thu, 28 Jan 2016 18:54:50 -0500 (EST)
In-Reply-To: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 28
 Jan 2016 18:56:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 84B707D6-C61A-11E5-AFF1-04C16BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285049>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> The series fixes grep choosing fast path that only works correctly fo=
r
> ascii. This is a resend of v4 [1] after rebase. I think v4 just went
> off radar for some reason, nothing was wrong with it (or nobody told
> me about it).

Or nobody found it interesting, perhaps, in which case we cannot say
"nothing was wrong" or "nothing was good" with it ;-)

Will find time to take a look if nothing more urgent and interesting
(read: regression fixes) comes up in the meantime.

Thanks.

>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/273381/foc=
us=3D276288
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (10):
>   grep: allow -F -i combination
>   grep: break down an "if" stmt in preparation for next changes
>   test-regex: expose full regcomp() to the command line
>   grep/icase: avoid kwsset on literal non-ascii strings
>   grep/icase: avoid kwsset when -F is specified
>   grep/pcre: prepare locale-dependent tables for icase matching
>   gettext: add is_utf8_locale()
>   grep/pcre: support utf-8
>   diffcore-pickaxe: "share" regex error handling code
>   diffcore-pickaxe: support case insensitive match on non-ascii
>
>  builtin/grep.c                           |  2 +-
>  diffcore-pickaxe.c                       | 27 ++++++++----
>  gettext.c                                | 24 ++++++++++-
>  gettext.h                                |  1 +
>  grep.c                                   | 44 ++++++++++++++++++--
>  grep.h                                   |  1 +
>  quote.c                                  | 37 +++++++++++++++++
>  quote.h                                  |  1 +
>  t/t7812-grep-icase-non-ascii.sh (new +x) | 71 ++++++++++++++++++++++=
++++++++++
>  t/t7813-grep-icase-iso.sh (new +x)       | 19 +++++++++
>  test-regex.c                             | 56 ++++++++++++++++++++++=
---
>  11 files changed, 262 insertions(+), 21 deletions(-)
>  create mode 100755 t/t7812-grep-icase-non-ascii.sh
>  create mode 100755 t/t7813-grep-icase-iso.sh
