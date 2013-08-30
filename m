From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix the author initials in blame for non-ASCII names
Date: Fri, 30 Aug 2013 11:13:19 -0700
Message-ID: <xmqqhae7yrls.fsf@gitster.dls.corp.google.com>
References: <20130829163935.GA9689@ruderich.org>
	<1377851821-5412-1-git-send-email-avarab@gmail.com>
	<xmqqppsvyrzj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Simon Ruderich <simon@ruderich.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 20:13:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFTCR-0007UX-4w
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 20:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278Ab3H3SNb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 30 Aug 2013 14:13:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab3H3SNa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Aug 2013 14:13:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6EA173CF85;
	Fri, 30 Aug 2013 18:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=cG6OIFZ8x/6D
	gYDKIDm/uqb8lIM=; b=eRfbrfL/I214QXwwaYI1tMxMpepgZJNF9P9NMdhWSRTp
	CljbM6IFtSjsUDU1EkGR5jHN59Otr35wiDeXk3FN/lf1XHMANbIu/BOinwlmgelT
	HE5vxY3KVo40B/w3sI0Ys5zZSKcBVM1AgujcpbBJIE88wTzliQhJtsmgCAXbV0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yakLiI
	PbuwUHCYKa5+WRyK2Aupuft9f3Aw104nrSphUSDHtw7fxGIlHY7Ve+pLIoidxHiH
	h7xCFBIlNK02xX3Jb4suigi23xdY9MhN3PgyU70gBfILC7C0DQpoCWmlQQVQTE0c
	2Uwu4p3+8hNxwx96NPOERawhT2A713CWbkWTo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 630AF3CF84;
	Fri, 30 Aug 2013 18:13:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C77CF3CF66;
	Fri, 30 Aug 2013 18:13:21 +0000 (UTC)
In-Reply-To: <xmqqppsvyrzj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 30 Aug 2013 11:05:04 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DAB91890-119F-11E3-A401-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233450>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Acked-by: Jakub Nar=C4=99bski <jnareb@gmail.com>
>> Tested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> Tested-by: Simon Ruderich <simon@ruderich.org>
>> ---
>> +++ b/gitweb/gitweb.perl
>> @@ -6631,6 +6631,7 @@ sub git_blame_common {
>> ...
>> +	binmode $fh, ':utf8';

>
> [Fri Aug 30 17:48:17 2013] gitweb.perl: Global symbol "$fh" requires
> explicit package name at /home/gitster/w/buildfarm/next/t/../gitweb/g=
itweb.perl line 6634.
> [Fri Aug 30 17:48:17 2013] gitweb.perl: Execution of /home/gitster/w/=
buildfarm/next/t/../gitweb/gitweb.perl aborted due to compilation error=
s.

I think in this function the filehandle is called $fd, not $fh.  Has
any of you really tested this???
