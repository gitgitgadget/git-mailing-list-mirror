From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Tue, 10 Sep 2013 14:56:48 -0700
Message-ID: <xmqqfvtcwdb3.fsf@gitster.dls.corp.google.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<20130904092527.GB22348@sigill.intra.peff.net>
	<CAMP44s3Vaqe-POwQb30AGdarf=ObdPUay3QEMqxHV3NKiPAouA@mail.gmail.com>
	<20130908041805.GB14019@sigill.intra.peff.net>
	<CAMP44s01LL2JCKzqa0Qc5MfBz9zfMXR4H8jZdauLOi-D0JVHpw@mail.gmail.com>
	<20130908172605.GF5359@vauxhall.crustytoothpaste.net>
	<CAMP44s0SLoD7ptgiYOg_vq+Jpo5uhWvzFC8Bd76JHo5zbjf8fg@mail.gmail.com>
	<20130909000153.GG5359@vauxhall.crustytoothpaste.net>
	<CAMP44s2seqO_0o=G2PjoL77HNSNcjTe4s6ZYj90_wsUT30pW8A@mail.gmail.com>
	<vpqr4cy4g5q.fsf@anie.imag.fr>
	<xmqq1u4x4yst.fsf@gitster.dls.corp.google.com>
	<vpqbo41lo2v.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Sep 10 23:56:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJVvc-0001GF-4G
	for gcvg-git-2@plane.gmane.org; Tue, 10 Sep 2013 23:56:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383Ab3IJV4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Sep 2013 17:56:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35212 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101Ab3IJV4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Sep 2013 17:56:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A96B740D4B;
	Tue, 10 Sep 2013 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NZHB3X5vzsDZZpn7vsM577O0UJo=; b=pEYdoP
	fYY43wjrLITUudmiUcakVeq+/M6W+d2BcZwydXmN/gzRWkPkKg72kZFOnXl/8zdu
	VPr+MkP64FppDQPuKrWuTaLyBxbZ1VGaYTbU4+RUO7Oz1IAzn5hrnJ+EGhDAYulQ
	evclRcshKpQHanBAh3nwhhp4B2Hm69TV/brW8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=URB2A8sI/DWr9h4qE/BqHWwz/KcEvVfh
	18wJXpVjkeTRQhTjw398ESv9wmn2C3Lzd7YU+1+4zb479PtovYZMGVo5DeChxXed
	bz3WsaMa/vD30/MN9SMJh30L59nD4iMmxBh7o6E0QqlOEWrqiowNm+W6ZPvt63FK
	WyB/oC2+4Fw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AC9740D4A;
	Tue, 10 Sep 2013 21:56:50 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CE13240D49;
	Tue, 10 Sep 2013 21:56:49 +0000 (UTC)
In-Reply-To: <vpqbo41lo2v.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	09 Sep 2013 22:47:20 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E51E6DE0-1A63-11E3-B25C-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234488>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> You are in favor of an _option_ to allow people to forbid a pull in
>> a non-ff situation, and I think other people are also in
>> agreement.
>
> Yes. Having an option can't harm anybody, and there's a clear demand for
> that.
>
>> So perhaps:
>>
>>  - drop jc/pull-training-wheel and revert its merge from 'next';
>>
>>  - update Felipe's series with a bit of tweak to make it less
>>    impactful by demoting error into warning and advice.
>>
>> would be a good way forward?
>
> I didn't follow very closely the discussions and patch series, but that
> would sound right to me. The last version of Felipes' patch series
> already gives a warning only, but the wording and commit message implies
> that this will become an error in the future (this is the part with
> which I disagree).

OK, the first step to drop jc/pull-training-wheel from 'next' has
been done. I _think_ the one that starts at $gmane/234295 is the
newer incarnation of the patches in this thread, but that seems to
do a lot more than what the patches in this thread did, and it also
badly interacts with another topic in flight that updates git-pull,
so I have a topic branch for it but haven't merged to 'pu' yet.
