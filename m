From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] mergetool: add an option for writing to a temporary directory
Date: Wed, 15 Oct 2014 13:45:42 -0700
Message-ID: <xmqq1tq9vz7t.fsf@gitster.dls.corp.google.com>
References: <1413047085-12398-1-git-send-email-davvid@gmail.com>
	<xmqqk3433h8m.fsf@gitster.dls.corp.google.com>
	<20141015063848.GC14751@gmail.com>
	<293924028.621540.1413401411270.JavaMail.zimbra@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Charles Bailey <charles@hashpling.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 22:45:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeVS9-0005ha-JU
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 22:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751173AbaJOUpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Oct 2014 16:45:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57282 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750917AbaJOUpp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Oct 2014 16:45:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D90214765;
	Wed, 15 Oct 2014 16:45:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zzNivxUdb0wK
	1e2ZMxoF8xAwLN8=; b=vlHaV4mK4I9US7eHWfESerYkmbJ/SkeQsjDKm06bV72K
	8kScIiYvZFEvaq7JIzyyAQCmvopKb8KfgoVsP3u1NIiqyjUF8f1OmBrXwMqzKiYy
	FJ1T78obvzD2aaeJSO6oeFOn3Q7ICVSyEpjtOi0ukYGI75sJh3d5QS9LUagySIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SWcxqQ
	9wm2hRFuOCz9wAsifvSPRiayv46LhWgMOnS4VN57XsjcXTeqM19fxFbBap7AFOVE
	QfPLm3UVgnNERnxfmWoFAPmtNwHYV9/KA4hcYDl0hGj3woCilintJxC55LCII5Ha
	BJ17ht46EJTm54zn48VQBguENEVki8Q70K/5c=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 64EC414763;
	Wed, 15 Oct 2014 16:45:44 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D617414761;
	Wed, 15 Oct 2014 16:45:43 -0400 (EDT)
In-Reply-To: <293924028.621540.1413401411270.JavaMail.zimbra@dewire.com>
	(Robin Rosenberg's message of "Wed, 15 Oct 2014 21:30:11 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3B97C198-54AC-11E4-8724-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> ----- Ursprungligt meddelande -----
>> Fr=C3=A5n: "David Aguilar" <davvid@gmail.com>
>> Till: "Junio C Hamano" <gitster@pobox.com>
>> Kopia: "Robin Rosenberg" <robin.rosenberg@dewire.com>,
>> git@vger.kernel.org, "Charles Bailey" <charles@hashpling.org>
>> Skickat: onsdag, 15 okt 2014 8:38:49
>> =C3=84mne: Re: [PATCH] mergetool: add an option for writing to a tem=
porary directory
>>=20
>> On Mon, Oct 13, 2014 at 12:24:41PM -0700, Junio C Hamano wrote:
>> > David Aguilar <davvid@gmail.com> writes:
>> >=20
>> > > Teach mergetool to write files in a temporary directory when
>> > > 'mergetool.writeToTemp' is true.
>> > >
>> > > This is helpful for tools such as Eclipse which cannot cope with
>> > > multiple copies of the same file in the worktree.
>> >=20
>> > With this can we drop the "change the temporary file name" patch b=
y
>> > Robin Rosenberg?
>> >=20
>> > http://thread.gmane.org/gmane.comp.version-control.git/255457/focu=
s=3D255599
>> >=20
>> > Message-Id: <1408607240-11369-1-git-send-email-robin.rosenberg@dew=
ire.com>
>>=20
>> I would think so but I'm biased ;-)
>
> The new patch solves my problem.

Thanks.  Let's move David's series forward then.
