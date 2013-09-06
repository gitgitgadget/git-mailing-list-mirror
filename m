From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Fri, 06 Sep 2013 15:14:25 -0700
Message-ID: <xmqq1u51wqbi.fsf@gitster.dls.corp.google.com>
References: <xmqqd2opu8hr.fsf@gitster.dls.corp.google.com>
	<CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com>
	<xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com>
	<20130904081047.GB2582@serenity.lan>
	<xmqqa9jso69u.fsf@gitster.dls.corp.google.com>
	<7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley>
	<xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
	<20130905080606.GE2582@serenity.lan>
	<xmqqd2onhyay.fsf@gitster.dls.corp.google.com>
	<20130905192646.GG2582@serenity.lan>
	<20130906214138.GA7470@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Philip Oakley <philipoakley@iee.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org, Andreas Krey <a.krey@gmx.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 07 00:14:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VI4IY-0004Ck-8P
	for gcvg-git-2@plane.gmane.org; Sat, 07 Sep 2013 00:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095Ab3IFWOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 18:14:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40106 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752832Ab3IFWOc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 18:14:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 464793D78C;
	Fri,  6 Sep 2013 22:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PAvi1KQdg7RLOckQHi23jCqxMVc=; b=XyS++9
	rNvQ16himJ2sr1knTp6u97ym1u9Hdtpz6NntiRxsCdNdTK2z/aivLmySJS1jNhEr
	/mTYsFgbTuKt3c3DkHbIwWrhRv1EvrUdiR+iTRpg6PlwsVepWfYQJTK8I2Ls1MUJ
	R36rgTB8yiiAOV2xUxHO7Txg63RZdZnKFlEX0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J3camKG/CW9IUawhX29lWXhhD5UheVLm
	6r6a8TK0xo3QjrRkLTmJIZ3lCTF4Aww4dbF1i6CpS0p1WQurWFS0gVer4dJTB7Xz
	YuwNbxjF0roxlvJJLs68ca3S0fpbP6JxRR18IwuJD1ILokm2dFyzN6LK1PNceP8Z
	BxN1iD/8Z8s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC3D93D78B;
	Fri,  6 Sep 2013 22:14:30 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 49AF03D781;
	Fri,  6 Sep 2013 22:14:29 +0000 (UTC)
In-Reply-To: <20130906214138.GA7470@google.com> (Jonathan Nieder's message of
	"Fri, 6 Sep 2013 14:41:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B2E86F3A-1741-11E3-B762-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234107>

Jonathan Nieder <jrnieder@gmail.com> writes:

> John Keeping wrote:
>> On Thu, Sep 05, 2013 at 12:18:45PM -0700, Junio C Hamano wrote:
>
>>> I somehow thought that rebase by default looked in the reflog to do
>>> exactly that. Perhaps I am not remembering correctly.
>>
>> It just does @{upstream} by default, which tends to get messy if the
>> upstream has been rewritten.
>
> Maybe Junio is thinking of 'git pull --rebase', which walks the reflog
> until it finds an ancestor of the current branch and uses that as the
> <upstream> parameter to rebase.

You're right.

It makes me wonder why we did that one inside pull and not in
rebase, though.
