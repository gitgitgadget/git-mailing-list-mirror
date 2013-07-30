From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Remove sq_quote_print() in favor of *_buf
Date: Tue, 30 Jul 2013 08:00:34 -0700
Message-ID: <7viozsxfcd.fsf@alter.siamese.dyndns.org>
References: <1375173087-2164-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmc=?= =?utf-8?B?4buNYw==?= Duy 
	<pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 17:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4BPq-0000KR-EM
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 17:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755726Ab3G3PAk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Jul 2013 11:00:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50837 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755688Ab3G3PAh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Jul 2013 11:00:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 236D434764;
	Tue, 30 Jul 2013 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CPKabc7A4uIm
	G7SVjqZEPdekaKw=; b=Tha74eHw+dgE2mvoEFYQAy/rur0jyFsPU+HLxhu8CxiT
	+tmH4GVEoisjoLtfOfCsi3dRTDup3yXcYfWS2kTQRXCqI8z5NaIt/ZevC3/Wm59h
	IIq6akh5FvDi/ym9NJNUsX5dnu6JasJ8kethIGD1Q8kQY5gn/SgNszlWL41m7as=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oT6oG8
	uKHDEYPTDylXy3MxFGyHlRctwNYNDI6m9zzZGvRTCTiCh4XFXEApu+IW5MhRd8ls
	bmruoSqSnWaIKd75Hbnr9+eoXwCY/0tIOjCVsiTx/yFOo2QCIkDs7HepoBEsD9hr
	5WYzKzfiMxMXFD6ryDTGSMYFvzk4pPPJAkxrk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19CF134763;
	Tue, 30 Jul 2013 15:00:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6044A3475F;
	Tue, 30 Jul 2013 15:00:36 +0000 (UTC)
In-Reply-To: <1375173087-2164-1-git-send-email-artagnon@gmail.com> (Ramkumar
	Ramachandra's message of "Tue, 30 Jul 2013 14:01:24 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CA62EDDE-F928-11E2-A0C9-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231364>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> While going through the for-each-ref-pretty series that Duy and I wer=
e
> developing, I noticed that this cleanup was independent and good
> as-it-is.
>
> So here it is.

You always can first allocate a piece of memory and write into it
instead of writing things out directly.  The patch shows it _can_ be
done, but that is not a news.

And such a change is hardly a "clean-up".  It just wastes more
memory you do not have to waste, in order to do what you are doing.

When there is a reason why you need an in-memory representation,
this change starts to become the first step refactoring for an
enhancement.

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (1):
>   for-each-ref, quote: convert *_quote_print -> *_quote_buf

The log message for this one explains it very well.  This change by
itself is not useful, but it will become necessary once you start
needing to access an in-memory result.
