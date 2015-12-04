From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] add test to demonstrate that shallow recursive clones fail
Date: Fri, 04 Dec 2015 07:32:57 -0800
Message-ID: <xmqqd1umteja.fsf@gitster.mtv.corp.google.com>
References: <1447321061-74381-1-git-send-email-larsxschneider@gmail.com>
	<20151113053547.GD29708@sigill.intra.peff.net>
	<CAGZ79kbWS=fc-18F=Omv7g4wqgrx4SB=iZHHUC=6ELUYDCWBMA@mail.gmail.com>
	<CAGZ79kYDKM2ffdiR-+wQ9=HTgCZMG3UstJiNVrSh7rB1p9xecA@mail.gmail.com>
	<xmqqio4j8iit.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYY5FbvMpa2vOun7-h4S2cJvZLn67uPGYVbje55R4dFSg@mail.gmail.com>
	<CACsJy8CFCu4casNn25b1YPkV==-8kDy3wzYd5uf794R41M0Y9w@mail.gmail.com>
	<xmqqegf57sfe.fsf@gitster.mtv.corp.google.com>
	<xmqq7fkx7qsa.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbtOEMk2woY5rovvC4xduiQRsKp+BXVt=5h9d76tpLWSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 04 16:33:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4sMJ-0002JP-BH
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 16:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbbLDPdJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2015 10:33:09 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:64135 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753783AbbLDPdF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2015 10:33:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 826F12F32F;
	Fri,  4 Dec 2015 10:32:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8bxbv3NRN+82bh+OdMB5SJ8P/LA=; b=AH1Qr4
	sALyzcDIe1CgzdSlc1jf5xkdbJo5AEwKlRm6jBLzZdAUGYMntDBCvXTc/Zfh6nrj
	ZjwmBplLogNue/HbtB6tJt42V4pzgTQ6p5aKiLQY9TxMKnk/iLvslsaSnW4xhW9N
	ANu+lUQtFdZA3reKiu3wD70pQFaYjLX9FAht0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gsNNy3RRWJfOYuF+E2ZVtAGfbAwp9xqO
	RS2Tkr9btmss6WZOSF29gzbDEniKoZBmHDEXC8TlErdKH3LA+hPEzUMby4KLL6dj
	2qYg+oQciWm1gWe8jrCJOZeUKKHxxyB5llJvtqZ2kv1rBZD+yjpr6jIwSyl4V2fR
	kOV+CWH/aZM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7B01B2F32E;
	Fri,  4 Dec 2015 10:32:59 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DAF532F32D;
	Fri,  4 Dec 2015 10:32:58 -0500 (EST)
In-Reply-To: <CAGZ79kbtOEMk2woY5rovvC4xduiQRsKp+BXVt=5h9d76tpLWSA@mail.gmail.com>
	(Stefan Beller's message of "Thu, 3 Dec 2015 12:03:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4C3A25C2-9A9C-11E5-83AF-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281984>

Stefan Beller <sbeller@google.com> writes:

>> A single dot "." would be a possibility
>> (i.e. a ref component cannot begin with a dot), but squating on it
>> and saying "anything that begins with . must be followed by 40-hex
>> (and in the future by an extended SHA-1)" would rob extensibility
>> from us, so perhaps ".@c78f7b5ed9dc1c6edc8db06ac65860151d54fd07" or
>> something?
>
> My gut reaction is to reject that notation, as it is very cryptic.
> Looking at the @ sign, it reminds me of the reflog notion such as HEAD@{-1}.
> So maybe it would be more appealing to specify
> HEAD@{c78f7b5ed9dc1c6edc8db06ac65860151d54fd07}
> to mean a specific commit. By saying HEAD we indicate it is not meant as
> a branch (both on the remote as well as locally).
> By having the @{ sequence this would also be dis-ambiguous from any
> branch.

I specifically rejected that when I wrote the message you are
responding to, because I think that would make it harder to later
enhance the mechanism to ask for HEAD@{...}, i.e. extended SHA-1
expression.

But bikeshedding can be left as an exercise to those who have too
much time on hand.

> Looking at the big picture here, this being a preparation for improving
> submodule cloning, we also want to allow tags here?

The reason why we need to restrict to raw 40-hex in the initial
iteration is because we do not want protocol update for an uncooked
idea.  Hence a tag object name in 40-hex is fine, but a tag refname
e.g. v1.0 is not.
