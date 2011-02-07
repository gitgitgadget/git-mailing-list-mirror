From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git add -u" broken in git 1.7.4?
Date: Mon, 07 Feb 2011 11:31:23 -0800
Message-ID: <7vaai7vdys.fsf@alter.siamese.dyndns.org>
References: <4D4DEDC4.4080708@hartwork.org>
 <20110206051333.GA3458@sigill.intra.peff.net> <4D4EF7E4.7050303@hartwork.org>
 <vpq1v3kopn3.fsf@bauges.imag.fr> <7vwrlcv1ea.fsf@alter.siamese.dyndns.org>
 <20110207055314.GA5511@sigill.intra.peff.net>
 <7vhbcguytf.fsf@alter.siamese.dyndns.org> <20110207183412.GB1900@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Sebastian Pipping <webmaster@hartwork.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git ML <git@vger.kernel.org>
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Feb 07 20:32:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmWoa-0000cs-DD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 20:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757Ab1BGTbs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 14:31:48 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51921 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab1BGTbr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 14:31:47 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0326B3630;
	Mon,  7 Feb 2011 14:32:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iebdhXNa4KWM
	V+iSk9GcBjguPvk=; b=WCLQPQ7mKFiRg7sjhPl4eH1NdtQCvUQcipd9xQwk6fMm
	7hvSc+CWP7qGLdZtRbf0umhV8qblvDXHyMD6uCSOf8lYSX3A+dEPdnEHydmbHBZ0
	dLkGLtTbJXurkNsxAZyQI1zNl/gF+QjSuHmOcxk8B5rbK9nCOG5lYkDHiqbu7C4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=fWh1LG
	ZppGf8wmOhIJ1wspMS/uL8YFz03FYsBr/vEsmPa++Cr+5WLp4JydTA3Nd7BSbztQ
	VEqH5TgMAOMzxSX39EKmnOSXm3kObn57T7rMYs7Td1FZG9uDnq6dmzUulWUISlrb
	JjFiB9zH4QJ4t245an/AocgknsdtUDkBn3n2g=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 85EB0362C;
	Mon,  7 Feb 2011 14:32:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CF3BC3624; Mon,  7 Feb 2011
 14:32:22 -0500 (EST)
In-Reply-To: <20110207183412.GB1900@neumann> ("SZEDER =?utf-8?Q?G=C3=A1bor?=
 =?utf-8?Q?=22's?= message of "Mon\, 7 Feb 2011 19\:34\:12 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 02B4AED0-32F1-11E0-BD9E-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166275>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> _Everything_ relative to the current working directory?  I can't
> imagine how would that work in practice.  Could you explain what woul=
d
> the following commands do, for example, when they are relative to the
> current working directory?
>
>   $ cd t
>   $ git checkout next
>   $ git merge somebranch
>   $ git reset HEAD^

Perhaps I stated things badly.  I was only talking about commands that
take pathspecs, and none of the above are relevant to this thread.  You
don't check out a branch with pathspec, nor merge another branch, nor
reset the index and the HEAD pointer.

I wouldn't point out that "git checkout next -- this-file" is to check =
out
a file out of a commit, not to check out a branch, as I think you alrea=
dy
know that.
