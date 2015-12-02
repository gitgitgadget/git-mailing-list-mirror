From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make error message after failing commit_lock_file() less confusing
Date: Tue, 01 Dec 2015 18:19:29 -0800
Message-ID: <xmqqy4dd618u.fsf@gitster.mtv.corp.google.com>
References: <1448883653-9140-1-git-send-email-szeder@ira.uka.de>
	<20151201231701.GB13245@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:20:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3x15-00018I-6V
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 03:19:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757457AbbLBCTb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Dec 2015 21:19:31 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757399AbbLBCTb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Dec 2015 21:19:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C0BC930A67;
	Tue,  1 Dec 2015 21:19:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GSN/BZ2HJUT1
	bXfUX82Me9mgU1g=; b=tmSzYJ4zBvmxXPsyDch0Q9ZLW8tQDk7Lpo/5UlhscjMY
	68tp3wGZszcuJjOUIk5fhFdCx+BPzJ39iOif+aD5iNeXZidvT1+PGlAAqon5yruM
	GUp2X/Dj/9qkorMwp8tvNbqfQJfAmyQNAN+IBuQIvOzSd6FKY/xt1jCUqJOP408=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H0+eLF
	lMRCNikA7kylz4Npvh/ksv1MMSPr2JAxihMigXSWuEOy/q+cdzV918FTCHjueGzQ
	j16bALZrsNQjFa1Ntv42yAMZoIh2+fkvXW74TszaPDiVVv73bXwoemNpjQA0g0E1
	8MFcAb2bTE54zZOVkvCH33Op29IXZXf5dEfe0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8B2D30A66;
	Tue,  1 Dec 2015 21:19:30 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3C6D430A61;
	Tue,  1 Dec 2015 21:19:30 -0500 (EST)
In-Reply-To: <20151201231701.GB13245@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Dec 2015 18:17:01 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1E6F20FA-989B-11E5-AAC0-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281875>

Jeff King <peff@peff.net> writes:

> On Mon, Nov 30, 2015 at 12:40:53PM +0100, SZEDER G=C3=A1bor wrote:
>
>> The error message after a failing commit_lock_file() call sometimes
>> looks like this, causing confusion:
>>=20
>>   $ git remote add remote git@server.com/repo.git
>>   error: could not commit config file .git/config
>>   # Huh?!
>>   # I didn't want to commit anything, especially not my config file!
>
> I like the intent of this patch; I've had the same "huh" moment mysel=
f.
>
>> The error message is of course bikeshedable.
>
> You chose "write", which I think is OK. It's really a "rename", and
> maybe that matters for some values of errno. I'd guess in practice
> probably not (the likely reason is going to be something like EPERM).
> And I can't think of a concise way to express rename (just saying
> "rename" is confusing, too, without indicating that it's from the
> tempfile to the final resting place).
>
> So perhaps "write" is the best we can do.

Yeah, "finalize" came to me but "write" is far easier to understand
by laypeople.
