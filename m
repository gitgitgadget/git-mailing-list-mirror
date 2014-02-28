From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/11] reflog-walk.c: use ALLOC_GROW() instead of inline code
Date: Fri, 28 Feb 2014 11:06:51 -0800
Message-ID: <xmqqbnxrukdw.fsf@gitster.dls.corp.google.com>
References: <530FA3E7.8020200@yandex.ru> <531056E7.3010305@yandex.ru>
	<53105AF2.3070301@yandex.ru>
	<CACsJy8DKXYJc2k6Zsqd0ruF_Jex=FH8rWzmhax2Co8z_oa+7zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Dmitry S. Dolzhenko" <dmitrys.dolzhenko@yandex.ru>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 20:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJSmE-0006bB-8M
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 20:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbaB1THL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 14:07:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50268 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbaB1THK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 14:07:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4BAF6FF7C;
	Fri, 28 Feb 2014 14:07:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aD7sSBrwn9u4zjakC0DepN5i31w=; b=XfLOkY
	dVUnnLWHh05DA84+4OLFxBnoQzHGItIwtoJ6b/RNrsSP1P6/B3WvDxUA8GNiRx+y
	3H3xy3ldpQSk43uO201Wa80xX/MXu/AyF7Y+dD0xO0+jv8yUMHbe6gkfloPRfR8U
	xryjcyOsKpHWvHqrfGKN5QsYty7hQG+YTvXOM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QByUvCOXqRtDquW9wUuw6jsxD7JcWuPi
	OY2BNo22ufwRt8FIlaCqv6F/tPauWUBOYK+UzZZDL+RytKg6mpPnVJd47P6AWaTE
	PKNIqbnSV5AzzVY2RqlXXicPPWiCeb/Svm/jX4o4UEqpeBO3NMs5SMhqj+R2tntA
	cc9UalLSCEA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 919706FF78;
	Fri, 28 Feb 2014 14:07:09 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5A4636FF73;
	Fri, 28 Feb 2014 14:07:08 -0500 (EST)
In-Reply-To: <CACsJy8DKXYJc2k6Zsqd0ruF_Jex=FH8rWzmhax2Co8z_oa+7zw@mail.gmail.com>
	(Duy Nguyen's message of "Fri, 28 Feb 2014 19:39:12 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 85143294-A0AB-11E3-A51B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243005>

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 28, 2014 at 4:46 PM, Dmitry S. Dolzhenko
> <dmitrys.dolzhenko@yandex.ru> wrote:
>> Affected functions: read_one_reflog(), add_commit_info()
>
> We can usually see this from @@ line so it's not really needed to
> describe. Same comment for a few other patches.

Not everybody always reads "git log" with "-p".  It is good to see
what are changed mentioned somewhere.

I prefer to see full sentences, though ;-)

	Subject: reflog-walk.c: use ALLOC_GROW()

	read_one_reflog() and add_commit_info() open-codes reallocation;
        use ALLOC_GROW() instead.

or something.  But that is minor.
