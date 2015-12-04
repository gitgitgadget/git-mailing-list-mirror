From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] setup.c: re-fix d95138e (setup: set env $GIT_WORK_TREE when ..
Date: Fri, 04 Dec 2015 12:35:15 -0800
Message-ID: <xmqqa8pqrlz0.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9k06all.fsf@gitster.mtv.corp.google.com>
	<1449166676-30845-1-git-send-email-pclouds@gmail.com>
	<1449166676-30845-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, sbeller@google.com, asottile@umich.edu
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 21:35:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4x4e-00032a-Oa
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 21:35:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445AbbLDUfT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2015 15:35:19 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753148AbbLDUfR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2015 15:35:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 461BD30B1F;
	Fri,  4 Dec 2015 15:35:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hQI993jLn3/8
	qf/PrzaJRVkKOOw=; b=Hoaik+b0IAm66hPHerv+M4xvhd/nfPAuaQnwACgtuzPF
	wNUC2iLACc5NI5dQ8yy254hxJt4K4v85BQt6s4ogcMdBd9WT/Ot79jsm1tPL/Z67
	M7a0Yyn9Dkf+EUgLlUl2FeKkLZix6VA3cAKr612tIfqWRMjCuziSaUOIF+yLPkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Rjgz/O
	mqjYXXQ8WSIWuikLi0A8YZGNOSse97YorK5Df6CiSBmfQxMKZg3RvqFWIMHqdGWB
	3xisL2J3qXWdPfJRout3oyZQWCTLcaoX9Y7LX/FnNYYEjTbiftm0psHcxnALeW3T
	A6jmuWFAaqFA6ggYXvdIszcMFz5y4VubQ5dh4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 31A5530B1D;
	Fri,  4 Dec 2015 15:35:17 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9CF7130B1C;
	Fri,  4 Dec 2015 15:35:16 -0500 (EST)
In-Reply-To: <1449166676-30845-2-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 3 Dec
 2015 19:17:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 872A847C-9AC6-11E5-B98A-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282000>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> ... Now I conclude
> that setup-messed-by-alias is always evil. So the env restoration is
> done for _all_ commands  whenever aliases are involved.

So a side effect of this is whenever an alias is involved, all
commands are re-spawned, not just the external ones but builtins as
well.

>  This may be a brilliant fix, or another invitation for regressions.

;-)
