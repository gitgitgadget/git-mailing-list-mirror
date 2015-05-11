From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] bisect: print abbrev sha1 for first bad commit
Date: Mon, 11 May 2015 09:54:15 -0700
Message-ID: <xmqqfv73f420.fsf@gitster.dls.corp.google.com>
References: <1431128763-28453-1-git-send-email-tbsaunde@tbsaunde.org>
	<CAGZ79kYjES6DXmvQdmXLAXrKMGrnvQ-vqJuHQU2QxVC4+6M0aA@mail.gmail.com>
	<20150509014152.GA31119@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150509040704.GA31428@peff.net>
	<20150510231110.GA25157@tsaunders-iceball.corp.tor1.mozilla.com>
	<20150511011009.GA21830@peff.net>
	<xmqqmw1bg2dd.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Trevor Saunders <tbsaunde@tbsaunde.org>,
	Stefan Beller <sbeller@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 11 18:54:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrqyF-00018k-QC
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 18:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751669AbbEKQyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 12:54:19 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751208AbbEKQyS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 12:54:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 771434E2F5;
	Mon, 11 May 2015 12:54:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B5VlgOadZlDFIbL8jDODrSaAaC8=; b=S6X+yr
	YyQExN4nhT9zhF3yZzx6YXRXfdk73o7QPJGJZsLINc60jDCL7kNJcoNVTEe2UiSC
	MIbcVreQ8g8YfERMBFcmom9QC8pfcioQT+pjH/8zN2BHKykgrZu07uMXC32OYU23
	iWVmXdLitpYXaEyKXTzxDiPkz5CcPX75Q6CZY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=i6dSI+p0zZ8MMzm/waTNN+pstceR+NZJ
	ZvdSpUaZaUls6/NGhVrdHe+1S5wjQ/84WgjB0LBiApcRqrhRAbGJ5dzRDdQNtdkm
	wvAMoxkdBZLtn2+arN8VRT5oVzoYovbgya9N9YzVuPzX1ccJrjWdHdImXudKd3n/
	C8iB6g/nW6I=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F0C14E2F3;
	Mon, 11 May 2015 12:54:17 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D55354E2F2;
	Mon, 11 May 2015 12:54:16 -0400 (EDT)
In-Reply-To: <CAP8UFD1Aq54dWvxo5JTP4Fqy5u-qhA0LAm3vRrw9=jYg3o_F+g@mail.gmail.com>
	(Christian Couder's message of "Mon, 11 May 2015 09:38:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C387082-F7FE-11E4-BE4F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268797>

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, May 11, 2015 at 6:33 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> I'd argue for simply never showing the diff (dropping the "opt.diff = 1"
>>> line from bisect.c:show_diff_tree), but that is mostly my personal
>>> opinion.
>>
>> Yeah, I think that is sensible. It may even be OK to just give a
>> "log --oneline".
>
> Or maybe we could let the user configure the diff options or even the
> command used when the first bad commit is found?

That is a separate discussion.  I do not mind but I doubt many
people would use it (I was tempted to say "doubt anybody would", but
then was reminded how many people use Git, and toned it down), as
long as we have a good default.  And I thought that this discussion
was about coming up with a good-enough default.

To be bluntly honest, I think the current one is sufficient as a
good-enough default.  The first thing I would do after seeing that
message is to either "git checkout <commit-object-name>" or "git
show <commit-object-name>", and the current full 40-hex output gives
me an easier mouse-double-click target than the proposed abbreviated
one, so in that sense the original proposal may even be a usability
regression.

It is tempting to say that the output can be eliminated by always
checking out the first-bad-commit (i.e. only when the last answer
that led to the first-bad decision was "good", do a "git checkout"
of that bad commit), but in a project where a branch switching is
not instantaneous, that might be problematic (unless the first step
the user would have done is to check it out anyway, of course).
