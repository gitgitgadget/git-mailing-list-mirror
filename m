From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ability to remember last known good build
Date: Fri, 11 Mar 2016 14:08:38 -0800
Message-ID: <xmqqio0sacrd.fsf@gitster.mtv.corp.google.com>
References: <CEDF59214E9E6A4CB418120F4FD7A0056E86A214@US-MBX2.ingrnet.com>
	<xmqq60wsc2gh.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZS7vnw5EskQHty9Cathv6FdE3L8wLstFwaWpMFHamSEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Pedroso\, Osiris" <osiris.pedroso@intergraph.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 11 23:08:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeVEl-0008Bi-6R
	for gcvg-git-2@plane.gmane.org; Fri, 11 Mar 2016 23:08:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932762AbcCKWIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2016 17:08:43 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932084AbcCKWIl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2016 17:08:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D48004C15A;
	Fri, 11 Mar 2016 17:08:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d3Vydkfl3WotSzTuWc0N621ALyk=; b=IEVJON
	tbSgjSQfpDpfou8nyes4ouObTs2YvUEsuxAINLvD3PWTdcmIvX1fRYgWAqrmx0JQ
	OVy425qfwxKmvW4nf5DT0Mf3Ca/olpM8nuddsfI6Fulj93hhp5265ZvLsvc5eAlr
	P2wfDts1RfBtn8VjF602I1qL4tdKmRHM51jsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JpVyxjKz+YbEDZIojAZ106oHU2c8taYY
	h8s2womwjTTKr83+wl6FdGawaRX7ua48kNZKJGDfOJtvrzuCHljLXQ+wJyQf1C0y
	zXQrRjbBDb3feTOIvqZi4mj8IRdsxBk7ntxH8iAggVRQ8gVLnRTfGhTmnaS/dbDX
	So+PjKIQg/Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB4D14C159;
	Fri, 11 Mar 2016 17:08:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4B15B4C158;
	Fri, 11 Mar 2016 17:08:40 -0500 (EST)
In-Reply-To: <CAGZ79kZS7vnw5EskQHty9Cathv6FdE3L8wLstFwaWpMFHamSEw@mail.gmail.com>
	(Stefan Beller's message of "Fri, 11 Mar 2016 10:17:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CFB0F7B0-E7D5-11E5-B59C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288706>

Stefan Beller <sbeller@google.com> writes:

>>> Any better way of accomplishing this?
>>
>> "test && git branch -f last-good"?
>
> Travis-CI enabled, tells me they're using Github and are distributed,
> so one contributor would want to know the last known good state of
> a remote, that others push to, without testing all commits locally.
>
> So maybe the question is better rephrased as: "How do we keep track of
> the last good state using the distributed nature of Git?"

I think Travis integration with GitHub lets the commits tested to be
annotated in the test status, so scanning the history from the tip
to find the latest one with the "good" test result would be how you
would find "the last passing one" if your workflow relies on the
Travis-GitHub combination.

I am not sure about "using the distributed nature" part.  That
depends on the way how the result of the Travis testing is reflected
on the GitHub side.  If it is done by adding a note or something
that can natively exported over "git fetch", that would be one way
to do so.
