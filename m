From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-curl: don't fall back to Basic auth if we haven't tried Negotiate
Date: Sat, 20 Feb 2016 13:38:09 -0800
Message-ID: <xmqqk2lz9i66.fsf@gitster.mtv.corp.google.com>
References: <1454404284-2197-1-git-send-email-dmitry.a.vilkov@gmail.com>
	<xmqqegcusvb4.fsf@gitster.mtv.corp.google.com>
	<20160202232952.GA6503@vauxhall.crustytoothpaste.net>
	<CAHdYDCqtNQMoU3Gu2AcSEWM5wA0SbaMrivu3WV_-N+B-F67v1Q@mail.gmail.com>
	<20160205204648.GA7403@vauxhall.crustytoothpaste.net>
	<xmqqa8nedg59.fsf@gitster.mtv.corp.google.com>
	<20160205210623.GC7403@vauxhall.crustytoothpaste.net>
	<xmqq60y2dduw.fsf@gitster.mtv.corp.google.com>
	<CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
	<CAHdYDCryaCbj-s6LG5fcDu115fi0k_uCawtus81PPbgyWpBTSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
To: Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 20 22:38:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXFEH-00005X-95
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 22:38:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759454AbcBTViN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 16:38:13 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50551 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752384AbcBTViM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 16:38:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E74F0432A1;
	Sat, 20 Feb 2016 16:38:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rUeETucFR9z7z+84PdBuxrNAkwA=; b=VRnKGX
	MiqQlqBZupWSfhDkeA+hQ0ptYbgSXgR0Uu9AelvhjMO5fMrOptQjylomhcCHuwGJ
	yQrMb79QafYwTZ9cymD9/4hxSzwkFO0as/gcReQOXe1YvONP/Mcfa3uAJ3xG25vl
	pK+ghaAyNyQ3j41yi9iWj9L4i0L5J+Ef7RxP8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aHs1j+Mdh/jR560z7JhekMR/8gOUE4B5
	jmOdzpUACh8Tymq5lwqckqJNuCJAvaEXfHoA8U9FLJceh55Isf2R5MQ7DIWArfDi
	/QYTwvLE38eEL8cEpNhhoHK1wlERvcMVMBHkTQt1PWOzuKh2aWLsSmzQ2I2UMe4j
	SsMteB5fpKA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF302432A0;
	Sat, 20 Feb 2016 16:38:11 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 279B94329E;
	Sat, 20 Feb 2016 16:38:11 -0500 (EST)
In-Reply-To: <CAHdYDCryaCbj-s6LG5fcDu115fi0k_uCawtus81PPbgyWpBTSA@mail.gmail.com>
	(Dmitry Vilkov's message of "Sat, 20 Feb 2016 17:35:19 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3D2CD15E-D81A-11E5-8D54-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286789>

Dmitry Vilkov <dmitry.a.vilkov@gmail.com> writes:

> Hi guys! Any luck with fixing this issue?

I think Brian suggested an alternative approach, to which you earler
responded

>> That would be great! Definitely it will be much better solution than
>> patch I've proposed.

The patch has been queued as 121061f6 (http: add option to try
authentication without username, 2016-02-15); perhaps you can help
by trying it out in your installation before it hits a released
version of Git?  That way, if the patch does not fix your problem,
or it introduces an unexpected side effect, we would notice before
we include it in a future release.

Thanks.
