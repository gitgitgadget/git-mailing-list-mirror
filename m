From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Correct singular form in diff summary line for human
 interaction
Date: Tue, 31 Jan 2012 09:50:15 -0800
Message-ID: <7vvcnr92y0.fsf@alter.siamese.dyndns.org>
References: <1328019840-6168-1-git-send-email-pclouds@gmail.com>
 <20120131152028.GA10717@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Frederik Schwarzer <schwarzerf@gmail.com>,
	Brandon Casey <drafnel@gmail.com>, dickey@invisible-island.net
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 31 18:50:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsHql-0006vj-Si
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 18:50:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754058Ab2AaRuV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jan 2012 12:50:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34012 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753372Ab2AaRuT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2012 12:50:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C302D6069;
	Tue, 31 Jan 2012 12:50:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bGM5u5ABIxZx
	T3AVIY98Xku7wZs=; b=BRJrxUc28k9J1FrPnH+w0wTaGTEBN63GU437tAAGxQKA
	BHxa2kTP54tLQKr/6alzRJE9riFfWOA9zIYgNzY1i/1wewRdb552lBZzGKl2MDkd
	Ck+mShQtbcvzyrdyYk1X07UUPmvPkDE3JLhOFWgaGINZcAuLAB51t9QdAsrH5n0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ptBRme
	/u7WMwvmZb1I8Q2JSHG2GMmeVN6XzQaM/CM7x7V87COZMVZzLlf/wOHTmSc2KgsP
	lUhoYzGJLgVS7m9tDvCPD2Hrf9SPHgvQdeU0KFlFGrLlnP/FU0lqmbNRdgfkxQ81
	6MYUlixI+Ur9UdM57BGOQnPM0PDHmFMQb8D5Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9F9A6068;
	Tue, 31 Jan 2012 12:50:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF3D76067; Tue, 31 Jan 2012
 12:50:16 -0500 (EST)
In-Reply-To: <20120131152028.GA10717@burratino> (Jonathan Nieder's message of
 "Tue, 31 Jan 2012 09:20:28 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 08D42A4A-4C34-11E1-A962-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189461>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> Convenient function interactive_use() is added for this purpose. The
>> command thinks it's in human hands when:
>
> I admit I really dislike this, especially:
>
>>  - GIT_SCRIPTING environment variable is not set

I would have to agree that it is horrible.

> But maybe I'm not the right person to ask, since I'd be okay with
> removing the "s"es (with an appropriate incubation time to discover
> whether we are introducing a regression) unconditionally.
>
> If there is an environment variable to say "I don't want to see
> variations on strings intended for humans", can it be spelled as
> LC_ALL=3DC?

I have been wondering if we should even care, for two reasons.

 * We have had --numstat forever which is exactly what we added for scr=
ipts'
   use. "I've been parsing that output meant for humans" is not an excu=
se.

 * 'diffstat', at least the recent versions of it (it is hard to track
   down historical versions and I gave up [*1*]), gives output like the=
se:

        1 file changed, 1 insertion(+)
	2 files changed, 3 insertions(+), 1 deletion(-)
	0 files changed

   The first one does not have anything but a one-line addition to a fi=
le,
   and we do not even see "0 deletions(-)". The second one is a more
   typical example. The third one is "diffstat </dev/null" [*2*].

If we were to touch this, I would prefer to do so unconditionally witho=
ut
"hrm, can we reliably guess this is meant for humans?" and release it
unceremoniously, perhaps as part of the next release that will have a m=
uch
bigger user-visible UI correction to 'merge'.


[Footnote]

*1* I can guess from http://invisible-island.net/diffstat/CHANGES that =
the
source is probably kept in RCS, but I couldn't find development histori=
es
beyond what is in that file.

*2* We mistakenly applied a patch to make "git apply --stat </dev/null"=
 to
error out recently, which we might want to fix. But that is a separate
topic.
