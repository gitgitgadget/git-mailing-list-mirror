From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Wed, 16 Mar 2016 09:30:45 -0700
Message-ID: <xmqqmvpy5qru.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<56E6D8C4.2010205@drmicha.warpmail.net>
	<xmqqoaahaw99.fsf@gitster.mtv.corp.google.com>
	<xmqqziu19cjz.fsf@gitster.mtv.corp.google.com>
	<56E96096.4020108@drmicha.warpmail.net>
	<CACsJy8CyLGtYpPnwdhS-AD4d2pcU7RVv=OxPEePcHYhFpDh4pg@mail.gmail.com>
	<56E97CA8.8070400@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 17:31:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agEM7-0000o9-PO
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 17:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755501AbcCPQav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 12:30:51 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:59394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755185AbcCPQat (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 12:30:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 233A34C0FC;
	Wed, 16 Mar 2016 12:30:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=en/YsGhax9HkazjmmWRWiUkrpDg=; b=pR33MV
	NQx/67y/wfNm6PIx4qTFgVfFIxYC//BUQxmdXgwBMPtF/xdW2fbmGsG0ETbHXqpv
	3M5+d1exOkT/TWaauQJp6d5sM0JmpN0oDvrW0PSYlhqw+Q4BHp5KJgE4FGl9V0cl
	mq/lyJxx9VQ7NAkdSReMJt2E/lwypgTlha21k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eJKsPPqSD4nJEDPeDge84z6dm3T7+Xdu
	POSKd+ln4ePEHlTR/wPduNDuGM/k8i6hJKyrqdIXKZnG78L+te7ogqwPsbCSc86f
	mkL5A0Zn9+Jro0mldZyWm3C7pauIg4wKYSfyTzoUX56M6+u209YCBnzCtafPwDXz
	aO9QaEqerU4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 19FE84C0FB;
	Wed, 16 Mar 2016 12:30:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 945344C0FA;
	Wed, 16 Mar 2016 12:30:46 -0400 (EDT)
In-Reply-To: <56E97CA8.8070400@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 16 Mar 2016 16:32:56 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 70494D00-EB94-11E5-8076-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288988>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> echo '*.po diff=po' >>.gitattributes
> echo '*.pot diff=po' >>.gitattributes
> git config diff.po.textconv "msgcat --indent --no-location"
>
> With or without the indent, that gives a pretty clean diff. [It's
> unfortunate that one half of that config is in-tree, one-half is not.]

That's a good tip. [By the way, it is not unfortunate that these are
separated to two places, but quite the opposite.  Attributes define
"what kind of things" they are, and configuration defines "how" each
kind of things are handled.  "msgcat" may have to be invoked
differently from yours on other people's systems, and one level of
indirection is a reasonable way to allow customizing "how" part
without forcing people to rewrite all of THIS in "for *.po do THIS,
for *.pot do THIS too".  You should be thankful for this separation.]

> So, really, the "actual coders" know best whether their changes should
> affect l10n or not, so they should be made more aware of it. Forcing
> "make pot" (and maybe more) on everyone sounds a bit harsh, but what
> else can we do?

I am not sure what problem you are trying to solve.  Do you want to
make sure mismarking such as N_(("foo")) is caught by the person who
changes "foo" into N_(("foo"))?

"make pot" alone would obviously not help, and you would definitely
need "maybe more" but I'd imagine that would involve checking the
diff in the code part i.e. "we have a new N_(...)" against the
differences in git.pot files you would obtain by running "make pot"
before the code change and after the code change, i.e. "there is no
new mention of "foo"".

I do not think you are suggesting to commit the result of "make pot"
along with code changes, but if you are, please don't ;-)
