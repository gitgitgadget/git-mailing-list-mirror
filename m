From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame.c: Properly initialize strbuf after calling,
 textconv_object()
Date: Fri, 28 Oct 2011 10:20:11 -0700
Message-ID: <7vd3dht4ms.fsf@alter.siamese.dyndns.org>
References: <4EAACA1C.6020302@gmail.com>
 <7vlis5t8bf.fsf@alter.siamese.dyndns.org>
 <CAHGBnuPUGfOe1D_OZ0ga4s8EiS_=GZeBG7WLmyOHt7vNg+w3Fw@mail.gmail.com>
 <7vhb2tt6ag.fsf@alter.siamese.dyndns.org>
 <CAHGBnuNpwZCpQxZQNRZ-pYpLMHMi1O4d0hsR9MKM3=7Hw5A=zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 19:20:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJq6R-00081N-EI
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 19:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755Ab1J1RUQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 13:20:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53101 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704Ab1J1RUP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 13:20:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 897B85744;
	Fri, 28 Oct 2011 13:20:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cZxeakG1HmOcTFnR7OuKcQmtcco=; b=jw5pxT
	4KFTmJrXfwA7p3w0XxlJMwV3Ge7aGK6Lg4hQUJJunlgZjpeN2TPTW7onkcKTHiFK
	/Htf4j/Mf1u2r51Nzkqz4P8XaTkKRTBhGpFuc7jIt1B57y1ChCum194ScNhTmbcG
	I5iQA5wlBqdJnbcB+XVSAchphP9G0cJYHigZU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=khyvuNALF8eByyQ81MFhyW5YogoT908x
	DlfsL7uWTum4TuBxEJlnAjaxmB1qDpy7QiP8H/VYETkpzq8NTwnbRN3THE75cKDB
	ui7ofaG7JOyASew2V3/dFrIHq3p78exIKBmv92J/hL2RwSI56dr0krfFWM89NoWN
	zbUQT4181ss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F3965743;
	Fri, 28 Oct 2011 13:20:14 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E610F5742; Fri, 28 Oct 2011
 13:20:13 -0400 (EDT)
In-Reply-To: <CAHGBnuNpwZCpQxZQNRZ-pYpLMHMi1O4d0hsR9MKM3=7Hw5A=zw@mail.gmail.com>
 (Sebastian Schuberth's message of "Fri, 28 Oct 2011 19:17:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 19022124-0189-11E1-AFE3-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184419>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Fri, Oct 28, 2011 at 18:44, Junio C Hamano <gitster@pobox.com> wrote:
>
>>>> Thanks; do you have no addition to the test suite to demonstrate the
>>>> breakage?
>>>
>>> Not yet. I'll try to come up with something.
>>
>> Let's do this.
>
> Thanks, but that does not seem to work for me. The test breaks both
> without and with my patch. I'll look into it.

Thanks. I suspect the difference is because you are on a crlf-native
platform while I am not...
