From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug report on update-index --assume-unchanged
Date: Fri, 05 Dec 2014 10:30:24 -0800
Message-ID: <xmqq1toeq79b.fsf@gitster.dls.corp.google.com>
References: <1417732931.20814.16.camel@segulix>
	<1417759955.10992.2.camel@segulix> <548156E5.2080006@kdbg.org>
	<CACsJy8AVKaq4NJu=23W+wcRgVTQ7hVAOxsVwtZnZsNw6393cTA@mail.gmail.com>
	<1417798622.23238.6.camel@segulix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?Q?S=C3=A9rgio?= Basto <sergio@serjux.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 19:30:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwxeH-00029H-QJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 19:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbaLESae convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Dec 2014 13:30:34 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751140AbaLESad convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 13:30:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D02E2285F;
	Fri,  5 Dec 2014 13:30:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r66RQu7dXzwN
	4mFEXsTN4zl1yS0=; b=Y2wJgqEr0Yj84cFyAE4Lj8EPbPWaxRxSRk3+rrErzpt5
	FhMtju+ZCMWA00qUrsWQGGyCUZPcMYXlbZcmUREFjAeLo15ey0boxgVMM6pgPLFf
	ccrQccbNkLNaOb3ZqwVFgYgi8g2BEoJQCGqo7QKgmlMe2rkcY/7QojnKv85QjLs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QEN8YS
	ao8/9fwKREjSo4eLpLF3nssj+dqLDN3OgAnuMad6bJhMpJ0R5WklQiFGkV5QB+tY
	GCSmmc048R0BkDHG58XTR2m23WjyxeeH02f1PKcMLkab5hAyGropxfxwVASBgY/H
	CTpxyEmRkxe1dTqxYxOjRJkh+HSRYc0nw6Wt4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 331BC2285C;
	Fri,  5 Dec 2014 13:30:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8E1122855;
	Fri,  5 Dec 2014 13:30:25 -0500 (EST)
In-Reply-To: <1417798622.23238.6.camel@segulix> (=?utf-8?Q?=22S=C3=A9rgio?=
 Basto"'s message of
	"Fri, 05 Dec 2014 16:57:02 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C7EC7774-7CAC-11E4-893D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260880>

S=C3=A9rgio Basto <sergio@serjux.com> writes:


> On Sex, 2014-12-05 at 17:52 +0700, Duy Nguyen wrote:=20
>> On Fri, Dec 5, 2014 at 1:55 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > Actually, it's a user error. When you set --assume-unchanged, then=
 you give
>> > a promise to git that you do not change the files, and git does no=
t have to
>> > check itself whether there is a change.
>> >
>> > But since you did not keep your promise, you get what you deserve.=
 ;-)
>
>
> No, I marked with assume-unchanged *after* change the file , and not
> before. Else don't see what is the point of assume-unchanged if you
> really don't change the file.=20

That "unchanged" is relative to what is in the index.

Your promise is "these paths I will not modify" and in return you
gain performance in "git status" as the promise allows Git not to
check with lstat() if the files in the workng tree was modified and
instead assume that you didn't change them.  That is the point of
assume-unchanged bit.

If however you did something that made Git notice that you changed
these paths marked with assume-unchanged bit anyway, then Git will,
well, notice that they are not "unchanged" as you promised.
