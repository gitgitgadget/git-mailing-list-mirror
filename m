From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] name-rev: include taggerdate in considering the best name
Date: Fri, 22 Apr 2016 13:50:48 -0700
Message-ID: <xmqq60v9pduf.fsf@gitster.mtv.corp.google.com>
References: <d58135a6720d6fda4c7bc609e77e2709d161fe25.1461332260.git.johannes.schindelin@gmx.de>
	<20160422181103.GA5920@sigill.intra.peff.net>
	<CA+55aFxLoi8RAYOZS8ziaGXkbTOdQ=YFbMA0EO0eFpNVgnugKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:50:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ati2R-00064W-Tj
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 22:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904AbcDVUuw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 16:50:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59210 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751172AbcDVUuv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 16:50:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 203B015CA6;
	Fri, 22 Apr 2016 16:50:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZMIZurNro8cfmaTarS/C0rYGdfc=; b=hob9pr
	bZCmWJhDpyLUz4Jgx4kSozqrEpS3M3traZ//Doy6hNnjD9UfESKoCqVJXOXEx+Pb
	SCvQEQWaFeNtju06ELTT6ljhGOAF5ZU14MFwyyvZicmUTHENOugzTKSW0gzFV0FI
	iNNiZggvflsWe6Qcafx55sw3Z6g2PfxgRQ9yE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tsekue2/ONrVu5dFYJVWz41gxdRg4TG5
	N1WbOtZFXGvfpQ8HfQ8DVk8oo1ppXqpdLQKMOE1+992CbsXW6Z8dS0s8zI/P+j2a
	T0Es0jltb5znpe/KX9uxlWwYC/xV1a8g5WqWx1koBRXirbXl391Ca3lLua5voJ59
	adleZ87WwSc=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17D2615CA5;
	Fri, 22 Apr 2016 16:50:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6C40115CA4;
	Fri, 22 Apr 2016 16:50:49 -0400 (EDT)
In-Reply-To: <CA+55aFxLoi8RAYOZS8ziaGXkbTOdQ=YFbMA0EO0eFpNVgnugKA@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 22 Apr 2016 11:45:27 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E50748A0-08CB-11E6-8125-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292265>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... I think this is still the simplest model we can use
> without trying to really do a topo-sort. And in many ways it's the
> simplest one to explain to people too: "we try to use the oldest
> reference we can find as a base for the resulting name" is not a
> complex or hard concept to explain.

Yes, the more I look at Dscho's patch, the more like it exactly for
that reason.  Its behaviour is very simple from the end-user's point
of view, unlike the historical one.
