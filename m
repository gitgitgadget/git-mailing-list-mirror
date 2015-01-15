From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cosmetic bug: "git show --pretty:format" produces different output than "git show --format"
Date: Thu, 15 Jan 2015 09:39:17 -0800
Message-ID: <xmqq8uh47xkq.fsf@gitster.dls.corp.google.com>
References: <CAEKevnWfFq9gyN8Ga8zXUDwk_+Mk6RK0HVT-+sbejjVPw0U0=w@mail.gmail.com>
	<54B7E98B.6020907@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Francesc Zacarias <francesc@spotify.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:39:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoOD-0002hN-5q
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 18:39:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752702AbbAORjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 12:39:20 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59203 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752254AbbAORjU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 12:39:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 041622E714;
	Thu, 15 Jan 2015 12:39:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C0jvwQyXs+F79pZHAzn7r24yiww=; b=kO3LD0
	JYVg9L9p95Jqx1+/W4xQnL2MjATfMdGXhaKo8/SFgiq+1OUw2ECI6Gq2Sp6G9MbS
	pJ4bxN/AlGJ6OMnbci6HJ1lrdN2mIdt8O9V7DX24004/6P8kudlhl2kzjAPzSeNJ
	h+CWcDl/Ecj9PSpEtKWYiFGCgs/L/GfMkRwzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jtz4jh2EpyCvmbc3DHMysWDdgYckgS1t
	RNQFW/x9JfQ8X7RE4hn71GxVPqg4TmIsTJKUh+tNtQd/LEDnVL9ejCw8s6olrwIv
	L1uJ4IXS5OPn2OKYf2Woc640BEEoQY4xmXGh21RgR/QbvOuJqUDBrvskiUZIKX6/
	vBH68pZuosY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ED1132E713;
	Thu, 15 Jan 2015 12:39:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6456D2E711;
	Thu, 15 Jan 2015 12:39:18 -0500 (EST)
In-Reply-To: <54B7E98B.6020907@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Thu, 15 Jan 2015 17:23:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6E8CFB62-9CDD-11E4-96E5-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262489>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Unfortunately, "--format" seems to be parsed as ("--pretty" and
> therefore?) "--pretty=tformat:" which I consider a bug.

"tformat:" was introduced to fix "format:, because many people found
the latter hard to use, probably because most of the time they
wanted to use the feature to show one-line-per-commit and a LF after
each record ("terminator semantics" where 't' in "tformat:" comes
from) made more sense in that context, compared to a LF between each
record ("delimiter semantics").

Of course, "format:" that uses the delimiter semantics has its uses;
after all, the delimiter semantics is what is used for canned
formats, other than --oneline.

It was a deliberate design decision to make "--format=<string>" as a
short-hand for "--pretty=tformat:<string>", favouring "tformat:"
over "format:", AFAIK.  To use the facility to show a break between
each (likely multi-line) record, use "--pretty=format:<string>", not
"--pretty=tformat:<string>" aka "--format=<string>".
