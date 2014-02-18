From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] Good bye fnmatch
Date: Tue, 18 Feb 2014 11:28:06 -0800
Message-ID: <xmqq38jgfcft.fsf@gitster.dls.corp.google.com>
References: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:28:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqLD-0003cz-FM
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:28:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbaBRT2U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 14:28:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57520 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751918AbaBRT2T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Feb 2014 14:28:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E44126BB81;
	Tue, 18 Feb 2014 14:28:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=36JuQZUkHUXq
	cKUtYHYGXAykzd0=; b=O6kNH4FkO+C4o+eIO02Yv5L9S9c301M44RArGxte9pGN
	7vcp5YMlEMGbzqb6LHXOnrvezlnHpQxfyTru68fa2/KbGNlA48TjmrelXfvX/Mx6
	XWJLXeh5s/lBa7rsobihkXDF9CPz3kYwx+yx9b3BZx37/B6WLHIpTRdgBk6t18Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=hgwQlR
	ZMB0FiGSHvs6Ht9pvg/9Xeu2rbN/s0y82wlsQHVz3hemh9iNLc2cRY0Iz17zxA+x
	G+gJAENUvtDrWzKx3KmGaPCDykRm82J9/J/ma9CL6CAEPHnv0gCfaHVHsH3T5UHl
	kz25NlVGEJp+e9oR9MqcgT6mp/FmQFh+jHcMk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62D7B6BB80;
	Tue, 18 Feb 2014 14:28:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64D156BB7D;
	Tue, 18 Feb 2014 14:28:10 -0500 (EST)
In-Reply-To: <1392429709-9237-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 15
 Feb 2014 09:01:45 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CD2F1188-98D2-11E3-B82D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242341>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Long story short, we wanted globbing wildcard "**" so I ripped
> wildmatch library from rsync to do it. And it opened a possibility
> to replace fnmatch completely, which would provide consistent behavio=
r
> across platforms (native fnmatch behaves differently on many corner
> cases), and some performance gains. I started fnmatch replacement wit=
h
> 4917e1e (Makefile: promote wildmatch to be the default fnmatch
> implementation - 2013-05-30). This is the final step.

Nice.

>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (4):
>   Use wildmatch() directly without fnmatch() wrapper
>   Revert "test-wildmatch: add "perf" command to compare wildmatch and=
 fnmatch"
>   Stop using fnmatch (either native or compat)
>   Actually remove compat fnmatch source code
>
>  Makefile                        |  22 --
>  builtin/apply.c                 |   2 +-
>  builtin/branch.c                |   2 +-
>  builtin/describe.c              |   2 +-
>  builtin/for-each-ref.c          |   2 +-
>  builtin/ls-remote.c             |   2 +-
>  builtin/name-rev.c              |   2 +-
>  builtin/reflog.c                |   2 +-
>  builtin/replace.c               |   2 +-
>  builtin/show-branch.c           |   2 +-
>  builtin/tag.c                   |   2 +-
>  compat/fnmatch/fnmatch.c (gone) | 494 ------------------------------=
----------
>  compat/fnmatch/fnmatch.h (gone) |  84 -------
>  config.mak.uname                |  10 -
>  configure.ac                    |  28 ---
>  diffcore-order.c                |   2 +-
>  dir.c                           |  11 +-
>  git-compat-util.h               |  12 -
>  refs.c                          |   2 +-
>  revision.c                      |   2 +-
>  t/t3070-wildmatch.sh            |  13 --
>  test-wildmatch.c                |  79 -------
>  22 files changed, 20 insertions(+), 759 deletions(-)
