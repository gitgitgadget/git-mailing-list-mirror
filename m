From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Bug?] log -p -W showing the whole file for a patch that adds to the end?
Date: Tue, 24 May 2016 11:16:36 -0700
Message-ID: <xmqq7fej5njv.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
	<xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
	<5740AC28.6010202@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Tue May 24 20:16:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Gso-0001Vq-RE
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 20:16:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbcEXSQl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2016 14:16:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751959AbcEXSQk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 14:16:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 301421E0C6;
	Tue, 24 May 2016 14:16:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=g/xp0io73bbK
	xTe8R3o75afIP9Q=; b=yBWe1KYyOvXF+GM/4Ok9BVEOOO/TV4x+FRCM5kbobgJH
	JK9euSa8vPxZ8SlTVAXR6dzzct3TQImZLxJb6ThI2Rel2TOwU/+DWe0Cy+b3U9Ik
	2O90G53WvlRuMS4SeG1aHoGf2pvGEUxJs/XqAPeSyjSClrgIqwpmLZBZqqzNgNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=DjDWH/
	mgNDgVs59WNy2GlRaWSVsIOXxjcrG3dchg+SIiIiVKJwZhgo3nHsNE2NJ2uV/zI4
	qeIjgphI3Si5SJ4rkEdYVxcZAOLqCLdJ5UYpNAwTs0Itc7gETHhPfIIrO095ybIp
	1ttFcfpz2g5RqUwY7yQR/aKID/eG/h7iF6aag=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 269C21E0C5;
	Tue, 24 May 2016 14:16:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A38BA1E0C4;
	Tue, 24 May 2016 14:16:38 -0400 (EDT)
In-Reply-To: <5740AC28.6010202@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 21
	May 2016 20:42:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A8518032-21DB-11E6-B8BD-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295511>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>   diff: factor out match_func_rec()
>   diff: handle appended chunks better with -W
>   diff: ignore empty lines before added functions with -W
>   diff: don't include common trailing empty lines with -W
>   grep: don't extend context to trailing empty lines with -W
>
>  grep.c        | 28 ++++++++++++++++++++++++--
>  xdiff/xemit.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++=
+++-------
>  2 files changed, 82 insertions(+), 9 deletions(-)

Thanks.  The flow of reasoning in this cover letter was written very
well and I think I can agree with all of them.

It is curious that this much behaviour change does not need any
changes in the test scripts.  We do not have sufficient coverage,
perhaps?
