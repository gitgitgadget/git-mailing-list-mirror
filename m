From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] cvsimport: start adding cvsps 3.x support
Date: Mon, 14 Jan 2013 22:44:09 -0800
Message-ID: <7vehhn54jq.fsf@alter.siamese.dyndns.org>
References: <7v8v7wiv3a.fsf@alter.siamese.dyndns.org>
 <1358127629-7500-1-git-send-email-gitster@pobox.com>
 <1358127629-7500-4-git-send-email-gitster@pobox.com>
 <CAEUsAPZV6rdFz5R6NN55qYr5se4bFJftE0xGSPAtXLp8jcO0vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, mhagger@alum.mit.edu,
	esr@thyrsus.com
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 07:44:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv0GN-0002Rg-6X
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 07:44:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962Ab3AOGoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 01:44:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43639 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab3AOGoL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 01:44:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 250E563AE;
	Tue, 15 Jan 2013 01:44:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FAfDvTz816pXjRJUwOzt11xneUI=; b=ZPjVfm
	hXzMDt2M5wSJVFAfZ2huRoJ0GlELTvlq6zUxLh7OyrfoIKCE4rLsEn+PLkSPKIt8
	CPVH1Ch/a785795B18gUBntZdApVFdl9n8AWo0sBObRrXP0C0YT5w3x52SrwzJyd
	ZbqY7mZwsQcuYNdB2J/6r6ciLqPyO9I160qJA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SzEdFfvpOXMuhUt5qbyFvTumksKNhQj6
	t2Rajmroo6+d6ufMUlJCSLj1I/dhc+JscffswqntI86yBaWsdBu6HJcnbzNRnCVw
	1CIuVF5yNeCcGLht6TgLVcqOEswm+YMtyyORBC0djqdosTHjfcb350xv6JIsXfYX
	Gsp3pKgZGnE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1725A63AD;
	Tue, 15 Jan 2013 01:44:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DD9763AC; Tue, 15 Jan 2013
 01:44:10 -0500 (EST)
In-Reply-To: <CAEUsAPZV6rdFz5R6NN55qYr5se4bFJftE0xGSPAtXLp8jcO0vw@mail.gmail.com> (Chris
 Rorvick's message of "Tue, 15 Jan 2013 00:19:43 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F7A79F04-5EDE-11E2-AAA7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213600>

Chris Rorvick <chris@rorvick.com> writes:

[jc: please elide parts you are not responding to, leaving enough
lines to understand the context]

>> +    def command(self):
>> +        "Emit the command implied by all previous options."
>> +        return self.cvsps + "--fast-export " + self.opts
>
> "--fast-export" string is missing a leading space.  With this fix and
> the latest cvsps build I'm seeing 6 of 15 failures for t9650 which is
> what I was getting out of the patched t9600.

Thanks; I'll amend it and push the result out, but I think we will
need to rip this part out and form the command string in a saner way
(e.g. if the path needs to have SP in it, e.g. "/Program Files/cvsps3",
the above would not work correctly anyway).
