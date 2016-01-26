From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] tag-ref and tag object binding
Date: Tue, 26 Jan 2016 13:13:16 -0800
Message-ID: <xmqqwpqwavtf.fsf@gitster.mtv.corp.google.com>
References: <20160125212208.GB26169@LykOS>
	<56A73DE6.5050201@drmicha.warpmail.net> <20160126152941.GA31951@LykOS>
	<20160126202651.GA1090@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Santiago Torres <santiago@nyu.edu>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 26 22:13:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOAvX-0003Ia-1g
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 22:13:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbcAZVNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 16:13:23 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:52637 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751313AbcAZVNT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 16:13:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AC0154084D;
	Tue, 26 Jan 2016 16:13:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pM6T6SC4o7GHC7jdtb23IKH19Wo=; b=CzCWUL
	/s7p9pkKwNc2oYOKWKb5eoF0m8VTG3+/N8JDGp5E5Q7u9zmSITiXb1JQFugFRnnz
	K7XN0hbQTT4GXKQIxN0BBibnKj32JJOsFt9Ptm8fpyZksh1NUV/ragXn/s/kXQlM
	EMMPEupiLqfXzYDz4nSEoYwpBv7BSbPNBA68A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=F/IX7T7KP1CljsPsEzLiQJpTwAlVcgCv
	pSPXn4x7nNdlID8gLyDHcnj1gVjKUdF7+J0x1mdFPbM6pBGtEyTZsXIJbdr5tmvx
	1CH2dt15bRyKG0jhIzNJpl8A6Ub8HLzE9EsKMx1st7lC7yAb66BWMktmHwZ/yh+y
	xsFT9AAQS/E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A32F94084C;
	Tue, 26 Jan 2016 16:13:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2353F4084B;
	Tue, 26 Jan 2016 16:13:18 -0500 (EST)
In-Reply-To: <20160126202651.GA1090@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 26 Jan 2016 15:26:51 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9EF0C4AC-C471-11E5-85C8-80A36AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284855>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 26, 2016 at 10:29:42AM -0500, Santiago Torres wrote:
>
>> > If you cannot trust those with write access to a repo that you are
>> > pulling and installing from you might want to re-check where you are
>> > pulling or installing from ;)
>> 
>> Yeah, I see your point, but mechanisms to ensure the server's origin can
>> be bypassed (e.g., a MITM). I don't think it would hurt to ensure the
>> source pointed to is the source itself. The tag signature can help us do
>> this.
>
> Right. I think the more interesting use case here is "I trust the
> upstream repository owner, but I do not trust their hosting site of
> choice."

Yup, and push-certificate is there to help with that issue.
