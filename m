From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] commit: add --ignore-submodules[=<when>] parameter
Date: Mon, 31 Mar 2014 10:14:40 -0700
Message-ID: <xmqqd2h28f3z.fsf@gitster.dls.corp.google.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>
	<5335A78C.60401@web.de>
	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>
	<53374E49.9000702@gmail.com> <533874F9.3090802@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronald Weiss <weiss.ronald@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 31 19:14:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUfnM-0004xx-Ss
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 19:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753253AbaCaROp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 13:14:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753052AbaCaROn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 13:14:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B57F781CF;
	Mon, 31 Mar 2014 13:14:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ksWX5IGPonA0AvH3QxkyhvywaU0=; b=SaPh8i
	pFpVVR6h1E+PY44LU0dOTuiU48G60z0SkNz01loxMHgvPbi/byp1b2v00dHnHujA
	U3V1JXDbY43gApvTFJTYHMFIAm2X6ZQXHEVTJ7SSGHt9QExv92u8WsaZDiM4yvhv
	C/o2TC70zg9ITj5IEWN7MxZuusfjs7UfDSLNo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hb1KHQEXjTLosfVYpvwEswpufMMFbQuZ
	i3zQvJLKTxJK+VhWOdp/inY+tQMQ3EGjpBqubvzRFjH1lXZ+5CUbStkIwNw3qW8/
	dK8/WHINoJbnFfLn1pypItSTLxgVHdlZ/4+LuoxlenIDP+RcdNJaCI6SBuSEG8hT
	25mOXaGYlys=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45ACE781CD;
	Mon, 31 Mar 2014 13:14:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8CF31781C7;
	Mon, 31 Mar 2014 13:14:42 -0400 (EDT)
In-Reply-To: <533874F9.3090802@web.de> (Jens Lehmann's message of "Sun, 30 Mar
	2014 21:48:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F3146D22-B8F7-11E3-86FB-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245495>

Jens Lehmann <Jens.Lehmann@web.de> writes:

>> Changes in add.c and cache.h (and related compilo fix in checkout.c) are
>> needed to make it work for "commit -a" too.
>
> Looking good so far, but we definitely need tests for this new option.
>
> But I wonder if it would make more sense to start by teaching the
> --ignore-submodules option to git add. Then this patch could reuse
> that for commit -a.

I am not sure about the code reuse, but from the usability and
consistency point of view, they must go hand in hand, I would
think.
