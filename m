From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/2] cache.h: eliminate SHA-1 deprecation warnings on Mac OS X
Date: Fri, 17 May 2013 09:53:51 -0700
Message-ID: <7vbo891ra8.fsf@alter.siamese.dyndns.org>
References: <1368601868-42410-1-git-send-email-davvid@gmail.com>
	<5193CC6B.50909@web.de>
	<CAPig+cTHh7iEY0+rReQ2LC94CsX-_aKdMLiVnL0ZF-FtKL6DaQ@mail.gmail.com>
	<CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Torsten =?utf-8?Q?B=C3=B6ger?= =?utf-8?Q?shausen?= 
	<tboegi@web.de>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 17 18:54:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UdNup-0006Fw-S4
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 18:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828Ab3EQQxz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 May 2013 12:53:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755507Ab3EQQxy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 May 2013 12:53:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CB20A1DECC;
	Fri, 17 May 2013 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B66ot2Ip6a9S1RHCVPg/rSXRoRk=; b=hIJn6a
	ty6Fgc09xZuYpyXXUxNcYuY3G37oBj7Tgq+592hYKeqwulDEKp60WYLm8CogvcQp
	qsz9OZVA1U6gq34X7LiqUCLYrvImFLkO1Y3lSrcKTG59WAR0ETvtDTD4R4BW5oj4
	Ckiw5MSUMkCFALFrLFN4UDfrukZawQynm8bPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WsNMyX/ZCC5/9AvsTXY+sTtzsmoESp56
	Yu+TAwog04ho/zlKz2Sa1+sDBIg9par78cZ1JFg3XAURYw+EekKYdbk3S1RMg8Ik
	wAL9thSYXOvl3GV2FcpQJAveUyyaW+F0CMBP2trtjbK/n1myJAL6EXHsOGt8C4Rp
	QSMOhf9fjA4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BFAF91DECB;
	Fri, 17 May 2013 16:53:53 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B5481DEC7;
	Fri, 17 May 2013 16:53:53 +0000 (UTC)
In-Reply-To: <CAJDDKr726C5BZwufz5o7JWZiP3pKce4g=AZvEbj8qzk8dOqzQA@mail.gmail.com>
	(David Aguilar's message of "Fri, 17 May 2013 01:21:59 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B042B10-BF12-11E2-9B5B-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224702>

David Aguilar <davvid@gmail.com> writes:

> Do you have advice on how we should proceed?  :sigh: sorry for wasting
> so much maintainer time on this series already.  If you need any
> resends or anything please let me know.  This time I'll wait for a
> strong opinion before firing off patches.
>
> My opinion: yeah, v5's ([NO_]APPLE_COMMON_CRYPTO) was probably where
> we should have stopped painting.  Hindsight is 20/20.  Luckily it
> never left "pu".

I could do this easily:

    $ git checkout da/darwin ;# b72ac20a6f73b
    $ git format-patch --stdout -2 |
      sed -e 's|COMMON_DIGEST_FOR_OPENSSL|APPLE_COMMON_CRYPTO|g' >P.mbox
    $ git checkout HEAD^^ ;# 29de20504e
    $ git am P.mbox
    $ git diff da/darwin HEAD ;# sanity check
    $ git log da/darwin.. ;# sanity check
    $ git branch -f da/darwin

if you nicely ask ;-)
