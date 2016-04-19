From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] git-p4: add P4 jobs to git commit message
Date: Tue, 19 Apr 2016 10:47:58 -0700
Message-ID: <xmqq7fft32y9.fsf@gitster.mtv.corp.google.com>
References: <0102015420a6c30a-f2da55c9-1fc4-4df6-860e-228c5305f617-000000@eu-west-1.amazonses.com>
	<xmqqshyi2yb7.fsf@gitster.mtv.corp.google.com>
	<CAE5ih7-2mefGwfXRhvQZJFPD4QYAzZ1jYG82s6cnDzWVCiDS8w@mail.gmail.com>
	<xmqqfuuh35v5.fsf@gitster.mtv.corp.google.com>
	<CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Jan Durovec <jan.durovec@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 19:48:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZku-0002a2-5v
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 19:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754557AbcDSRsD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 13:48:03 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754096AbcDSRsC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 13:48:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D44B133F0;
	Tue, 19 Apr 2016 13:48:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o1dQrXU77ETmawPZ3VI2oXri7N0=; b=rOr5hw
	knRJMG8XbBig3lyZ3YSQm2U0JybXM5dpmCzrUmIEy0kM0OgTW98N828/lkz817z1
	16R7zMfLzAH5sIJf5Znw8SgB5622zshzgU+9LS9DLGLskdfhq2cGRKktzd0ikZs0
	3IImMxqSZhk7vUljxMKB5Cdd1aLWZS2Yq9nr0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I3wqlTGjxxhB8zqGnvdQ2E71lSIL5z2b
	hXt4NCZdnPHceLEFIZzoCgH0DwEkioBHMKimVCUP62TfSx+Dy0wKgftJ0aSEcLTO
	f9sKjuVXMNCNzOI1M3xzvkNnkIjbMsgKtia/hE5unSd+udI39le3vbi19LRrPIf5
	RKKIoVvRqnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 73274133EF;
	Tue, 19 Apr 2016 13:48:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C624D133EE;
	Tue, 19 Apr 2016 13:47:59 -0400 (EDT)
In-Reply-To: <CABEqOBxZkYTm7_m-Eeq-acN=Nse1vLGk8Gm44BihVGi27KaGiw@mail.gmail.com>
	(Jan Durovec's message of "Tue, 19 Apr 2016 18:56:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DB56C53C-0656-11E6-845E-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291891>

Jan Durovec <jan.durovec@gmail.com> writes:

> given the fact that the rest of the code just follows existing
> source code style, i.e.
>
> * using %s not %d to add number to string (see git-p4.py:2301)

This one I do not care too deeply about, as formatting anything that
can be formatted via '%s' could just be more Pythonic style, in
which case "%s" is perfectly fine.  It just didn't look kosher to my
C trained eyes, that's all.

> * no space between function name and parentheses (see all functions
>   in t/lib-git-p4.sh)

I thought I said "Not a new issue, but..." to this one, and it
appears that leaving <<- here-doc unindented, which is stupid as
that shows the person who is writing the here-doc does not know what
the dash s/he is writing means at all, is also not a new issue.

> * no tab when specifying in-line expected output (see t/t9826...)

> ...is there anything left to fix in this patch or is it good as is?
>
> I.e. would you prefer me to change the code mentioned above at the cost
> of code style consistency?

Not really.

If you really want to know the preference, we prefer a preliminary
clean-up patch to correct existing style issues, followed by a new
feature patch that builds on the cleaned up codebase.
