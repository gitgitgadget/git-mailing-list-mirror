From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Fixing volatile HEAD in push.default = current
Date: Thu, 23 May 2013 07:45:34 -0700
Message-ID: <7vmwrlhi0h.fsf@alter.siamese.dyndns.org>
References: <1369160600-22337-1-git-send-email-artagnon@gmail.com>
	<7v38tgno2k.fsf@alter.siamese.dyndns.org>
	<CALkWK0m3QP_eE14y8UoJ+HeFzkKM=1nVKAnYJcTrwQMp+Atphg@mail.gmail.com>
	<7vppwkm682.fsf@alter.siamese.dyndns.org>
	<CALkWK0np7o0eH8ZsWQSwk1Cdwnnpj5B==gS8kAE+OkTskASOsQ@mail.gmail.com>
	<7v7girks4s.fsf@alter.siamese.dyndns.org>
	<CALkWK0kXonM+J92KHs+dW31A_kZ8h9jNqwYn8AqT_V+GJhe_vg@mail.gmail.com>
	<7vppwjj5ws.fsf@alter.siamese.dyndns.org>
	<CALkWK0mfGWA3aBntQQU5fkCJDPx+MUOScvMRJjS+JzjNucFzPw@mail.gmail.com>
	<20130523085359.GA23933@inner.h.apk.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 23 16:45:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfWm0-00055n-Kr
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 16:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759222Ab3EWOpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 May 2013 10:45:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758002Ab3EWOpg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 May 2013 10:45:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 846E220D5C;
	Thu, 23 May 2013 14:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bhSikOOLYCxzHyJu7mZmytUAk84=; b=p0fxf0
	7tZOBmES3Gwq8fDiEPwcgNf3vLPwkMottYInH4115FNpfYrU8JuOu3X54o7e7SHQ
	dO1psssyZqT2YHiQpdcSyHRq6jLwaB2aLpbKkMvX/e1vIML0S4bHDTBOIxUnRurj
	X/Vs+Yc+4sSIR7qEtANC9Mb1GxiuyaljQh/uU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C1gTxgygMV3xkMD1l+WRCdcBIvtPZR5U
	VDs4sLiRIthOS6KhBuVEXeS9H3mkNOYWNjo78qPF734QnWiaKzERHYor5I4T59YX
	4sw+x9QXHw66L00Eu+lOWTzJrKa6nUhQB55Bwlx1SgYbVtWBMqu1eXDTmXkwxR7U
	ZuPb4jFS3vE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76A8520D5B;
	Thu, 23 May 2013 14:45:36 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C878920D5A;
	Thu, 23 May 2013 14:45:35 +0000 (UTC)
In-Reply-To: <20130523085359.GA23933@inner.h.apk.li> (Andreas Krey's message
	of "Thu, 23 May 2013 10:53:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D83C54E-C3B7-11E2-8AF3-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225252>

Andreas Krey <a.krey@gmx.de> writes:

> On Thu, 23 May 2013 13:25:55 +0000, Ramkumar Ramachandra wrote:
>> Junio C Hamano wrote:
>> >     I have "largedir" I want to get rid of, but there is a directory
>> >     I want to save, "largedir/precious", in it, so I do
>> >
>> >         cp -R largedir/precious precious
>> >
>> >     and then run 'rm -rf largedir' in another terminal in parallel.
>
> 'mv largedir/precious precious; rm -rf largedir'? No race here.

Yeah, but 'cp -R largedir/precious precious; rm -fr largedir' is the
same thing.  Ram's original issue was "I do something else in
another terminal without waiting for the first command to finish".

Even with 'mv', between the time the main in mv starts and the
process finally issues rename(2) on the directory, you can start
running what competes and interferes with it in another terminal,
so it does not fundamentally change anything, I would have to say.
