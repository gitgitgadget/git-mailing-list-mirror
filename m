From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v22.5 09/24] refs.c: pass a list of names to skip to is_refname_available
Date: Tue, 07 Oct 2014 12:26:14 -0700
Message-ID: <xmqqr3yjel61.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com> <20141002014817.GS1175@google.com>
	<20141002020332.GB1175@google.com>
	<xmqq61g2nuud.fsf@gitster.dls.corp.google.com>
	<20141003185128.GS1175@google.com>
	<xmqqoattkm87.fsf@gitster.dls.corp.google.com>
	<20141003213900.GT1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 07 21:26:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbaOr-00066d-RB
	for gcvg-git-2@plane.gmane.org; Tue, 07 Oct 2014 21:26:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbaJGT0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2014 15:26:17 -0400
Received: from smtp.pobox.com ([208.72.237.35]:53600 "EHLO sasl.smtp.pobox.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932075AbaJGT0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2014 15:26:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 44E1B1367A;
	Tue,  7 Oct 2014 15:26:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Omb7v1XrrfYgOF5NMLdLMuLf92I=; b=H5SSY5
	rcVt36L4JC3ZiFei7Gygfom4TNCFQ2P7yZ0VxiClazFuiBslCgzp/4585HfzV9JL
	cHHiNLlkugHA+8SCYSMmYZoqPoWZjW7GCX3HRun/NlRHYJPN2tZ997KgwSo5lrV1
	N7Rnkfanw8iOn5pcVujK22LEXWJdYLc6Vr+bo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sr3dIVPOs2BvjuO5hT056QUnxMSYIQz9
	Yt7M+F0PLgvtba0OmcmFaCBaldERyg6WakZkHvOMQUFRbH8gvIlgU9gxlOz6d9Og
	4ZXLboII5dY639KTYdo3rUKuVgWRFqdDpDqRs7ArEkDG3Gt9XGC9zgdb58HD+Jtd
	Og96SDjXbBU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BC7613679;
	Tue,  7 Oct 2014 15:26:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B96A013678;
	Tue,  7 Oct 2014 15:26:15 -0400 (EDT)
In-Reply-To: <20141003213900.GT1175@google.com> (Jonathan Nieder's message of
	"Fri, 3 Oct 2014 14:39:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CE45B122-4E57-11E4-BAEA-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257948>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Will take a look over there (I really hate having to context switch
>> only to review this series, though).
>
> Here's a copy to save a trip.

The patch itself looks fine, but Gerrit really needs a way to convey
"these changes make a single topic and here is the tip" somehow.  It
could be that there is and it is not well advertised, but the end
result is I visit the URL,

  https://code-review.googlesource.com/#/q/project:git+topic:ref-transaction

pick and view a few patches at random to view the changes in pretty
side-by-side diff output (which by itself is fine), check "Download"
to see the fetch URL, when it is followed it often gives me only an
early half of the topic, get confused and scratch my head, give up
and abandon and the whole time doing so ends up being wasted.
