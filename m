From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: fix parsing of http.sslCertPasswordProtected variable
Date: Sun, 14 Jul 2013 21:13:09 -0700
Message-ID: <7vzjtoea0a.fsf@alter.siamese.dyndns.org>
References: <7v38rjlif4.fsf@alter.siamese.dyndns.org>
	<20130712190531.GD8482@google.com>
	<7vtxjzk13q.fsf@alter.siamese.dyndns.org>
	<CAHREChiOE8oMWQYFY_7yzf1tz-4E2_L5W9--k33vwATFSrR==A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git list <git@vger.kernel.org>,
	"Kyle J. McKay" <mackyle@gmail.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 15 06:13:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UyaA0-0002YX-Ge
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jul 2013 06:13:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960Ab3GOENM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jul 2013 00:13:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47243 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806Ab3GOENM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 00:13:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BC1B82A647;
	Mon, 15 Jul 2013 04:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/rO54SeqSdEZdyRHq+WWBTvNf0k=; b=CUseQ0
	QJ/ea/X2K0X8Z5pxwG2fXCQKUSlFBI4GL8w0UMEdD8PXTQZ5UDe5YXimiocvVg/5
	A6dKkMSObQLXt4RF4+YHFuLiYUFNZQF1zFGbhY7kXlQmWO/ZaLJ3z+/mc86tpJMn
	uJBJYjeryrofjmZ88K8IouCVb9u8fI4G/y5gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e2KCYxZomJgM2GHlk55OxqsnTzdqu7wA
	jrPeNehaAN4nvwy2a55YS5QTHikNuGBEzLiBhAvsF7ryM1PdV6oeHPauXAEG+QCi
	VevKQEpJME7VVwwyjc/C36QbshinLlcPuI7Ebcq5G3bgrnMg4lUmJ05P+i1pWH90
	7bsRN12SmJw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B33D82A645;
	Mon, 15 Jul 2013 04:13:11 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F36622A641;
	Mon, 15 Jul 2013 04:13:10 +0000 (UTC)
In-Reply-To: <CAHREChiOE8oMWQYFY_7yzf1tz-4E2_L5W9--k33vwATFSrR==A@mail.gmail.com>
	(Mark Lodato's message of "Sat, 13 Jul 2013 20:37:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DC88077C-ED04-11E2-8812-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230411>

Mark Lodato <lodatom@gmail.com> writes:

> On Fri, Jul 12, 2013 at 3:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>> > FWIW the GIT_SSL_CERT_PASSWORD_PROTECTED envvar has a similar "can
>> > only enable" behavior, but since it's documented, that's not as big
>> > of a problem.  Do you remember why it was written that way?
>>
>> Not me ;-).
>
> Because that's how GIT_NO_VERIFY, GIT_CURL_FTP_NO_EPSV, and

s/GIT_NO_VERIFY/GIT_SSL_NO_VERIFY/, I think.

> GIT_CURL_VERBOSE (and perhaps others) work.  That said, I agree that
> parsing the variable's value as a boolean would make much more sense.
> Perhaps this is how all of those variables should work?

I think you are probably right.
