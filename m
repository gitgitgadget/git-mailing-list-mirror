From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 09 Aug 2013 23:50:12 -0700
Message-ID: <7v38qi2g63.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	<CAMP44s13y39f-eCP1sBuMEedciU230C1O11+iMb1SHi45RnSNQ@mail.gmail.com>
	<7v7gfu4ikb.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Ky2AkEt-XS_nAo=_RrPXSVAL=8cGiMuJabw0=BRU0Dw@mail.gmail.com>
	<7vmwoq304o.fsf@alter.siamese.dyndns.org>
	<CAMP44s1Q2x9uz5Ajr=BgVjSjO88XD5UYzVSEqgMeK5_YAYSa5A@mail.gmail.com>
	<7vioze2kev.fsf@alter.siamese.dyndns.org>
	<CAMP44s3ULMBg6BJr6m4zkqHyD70rHSwLcuG5ph+ABr6KME8T=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 08:57:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V837T-0000hh-7u
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 08:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506Ab3HJG5l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 02:57:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48559 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031890Ab3HJGuP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 02:50:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 663F12FCDC;
	Sat, 10 Aug 2013 06:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zN0U762mNpGMw9kgyCVqlra4zpk=; b=gGwvML
	hdvntGMRaAEVj7JrdsL9XMa8wzj07fxiRycjMDTBroICsrEjni64ZMstDeP4HXL0
	Sa0uQHMXHzwgUbY/tMYCyDX8jJufacOB3Yh+gceCUFXoSWBM7YRlqXaAog3Al77a
	yGWdCYfLRSOJZl66emsVO27lj1vYfD1grRW38=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K0to1OMhmdKcBxjV14UCtweA6cdSjVmb
	7lgbW9tFitCrkc6U+AnBVBTXatD6DiMj3PGsn6Fng6G8FCbcXwiuBEVorpzOcINA
	nYrqA8D0Q44l1AWuUrCQf036FM3bUIVLnB2o0KrvHWwGy8AHX6lnskwRDIsL2rQo
	Q5WaPOpsN3I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57EE02FCDA;
	Sat, 10 Aug 2013 06:50:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B868C2FCD8;
	Sat, 10 Aug 2013 06:50:13 +0000 (UTC)
In-Reply-To: <CAMP44s3ULMBg6BJr6m4zkqHyD70rHSwLcuG5ph+ABr6KME8T=w@mail.gmail.com>
	(Felipe Contreras's message of "Sat, 10 Aug 2013 01:39:59 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1BABDE86-0189-11E3-A623-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232070>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> If I clone ~/git, and then change my username, and move my home
> directory, doing a 'git fetch' in ~/git wouldn't work anymore, because
> we have expanded the path and fixed it to my old home, if instead we
> simply return without fixing, it would still work just fine.

Antoine's patch runs expanduser() only to see if the given one gets
modified to absolute path, and makes fix_path() return without
calling the extra 'git config', so it is my understanding that the
above describes exactly what the patch does.  Am I reading the patch
incorrectly?

It outsources the determination of "is this a special notation to
name a home directory?" logic to .isabs(.expanduser()) instead of
doing a .beginswith('~') ourselves.
