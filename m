From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 19/24] refs.c: allow listing and deleting badly named refs
Date: Fri, 03 Oct 2014 13:39:39 -0700
Message-ID: <xmqqa95clwfo.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com> <20141002014817.GS1175@google.com>
	<20141002022819.GL1175@google.com>
	<xmqqa95envxa.fsf@gitster.dls.corp.google.com>
	<CAL=YDW=N1+XS+U=Vs0Sba0UqdN7+HRg5CTdZB28h5Ts3_yusYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:39:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa9dm-0005y2-NU
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 22:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbaJCUjn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 16:39:43 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51142 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752686AbaJCUjl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 16:39:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3602B3FD3F;
	Fri,  3 Oct 2014 16:39:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dyaTXB0/g4Nw4jJIr0aBEgFrz34=; b=mhZ0Lk
	Z2/l7jJiAm680hcVpsYRqCYuutAL7lLA18nac7zZFmMvCq2a6BT4Of2Hd3eKBz42
	LIM9gFslnOivpfIxWIKEx76F0TL6YSnpVC0NkjnQ4B4dPAURB+JBwcUjToe1I/9S
	7fmtFqRu9ahD0lu/IB51zpPhYyOXvrNNzmWfw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZQsKuCj/osRY+G2R5sSqZWKe2c78qcC9
	Hp+kTvv/t3HOdK4jAotLFJGAfFXoJzACkXao+gKTTSioiJQM2CH0o/HEeZ0SUkDQ
	50lHsW4LfPl4bF4QJXQxhz/2MAxQSbXr9rRgyVrb5U0sTYKDoQBP9ZTKqB6KJXk5
	vjcZHeVxUaU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2BF753FD3E;
	Fri,  3 Oct 2014 16:39:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A7B9E3FD3B;
	Fri,  3 Oct 2014 16:39:40 -0400 (EDT)
In-Reply-To: <CAL=YDW=N1+XS+U=Vs0Sba0UqdN7+HRg5CTdZB28h5Ts3_yusYg@mail.gmail.com>
	(Ronnie Sahlberg's message of "Fri, 3 Oct 2014 13:25:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6628BDD6-4B3D-11E4-8F97-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257866>

Ronnie Sahlberg <sahlberg@google.com> writes:

> On Thu, Oct 2, 2014 at 11:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Thanks.  We originally threw all the different kind of breakages
>> into ISBROKEN, but a ref can have a malformed name or can contain a
>> bad/non value and allowing us to tell them apart is a good direction
>> to go.
>> ...
>
> I updated cache.h to try to clarify it better.
> The intention here is to expand the use of REF_ISBROKEN.
>
> For all cases  REF_ISBROKEN will be set. This includes both "the sha1
> value is bad" as well as "a name is bad".

OK.  As long as it is documented in a way to help other people who
touch the code later to tell what these REF_* mean, either way is
fine between "BADNAME is just one of the possible ways a ref is
ISBROKEN" and "BADNAME is a way and ISBROKEN is another way for a
ref to be bad", and I agree that the former (i.e. the way you
defined) is easier on the existing code.

Thanks.
