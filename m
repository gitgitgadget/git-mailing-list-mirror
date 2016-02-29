From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] sumodule--helper: fix submodule--helper clone usage and check argc count
Date: Mon, 29 Feb 2016 11:44:17 -0800
Message-ID: <xmqqegbv9u9a.fsf@gitster.mtv.corp.google.com>
References: <1456532000-22971-1-git-send-email-jacob.e.keller@intel.com>
	<1456532000-22971-2-git-send-email-jacob.e.keller@intel.com>
	<xmqqr3fvcsoy.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xryNo=n0fFn9HNrj78z4XtWwoF=j67+Qy8TbO7reBTO-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 29 20:44:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaTk1-0005XN-Rd
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 20:44:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbcB2ToV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 14:44:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:53075 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752328AbcB2ToV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 14:44:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A31B848759;
	Mon, 29 Feb 2016 14:44:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kUhJ4xqt7rwro+dcZQy5SSHRc2U=; b=yOvWRd
	PPqZfrgySCdOB8ACESRlNpqgNFFXK+jMSzu5JuXxXE9nmxZzzzejZWRI3w6o94BQ
	bjjoxCjfzckdG6sTBVcBWWhl6GzLjdysalaseRcQtvVNpmPiS7BytZpvAvMA8FHp
	+dFbUi6CH+Ctz9LwAFVl3neffiwT1oB78DuMs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ODwrrocJxdV6DTQMp1/ELxTGxDjw6e+H
	JdD24d2y6iKBcpT4nK5w5GTcMz0nJA8DWwV5e135ClOizA5nA6zkTlzrnrSreSx/
	zt2F4yrN5UrMrVMB3slCbuQgkR/t1ICBfU+gelVPoMNvx4+2BLhwhdeKpVtxaOTP
	BJqeSPBYqnc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A05148758;
	Mon, 29 Feb 2016 14:44:19 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 0C59E48757;
	Mon, 29 Feb 2016 14:44:19 -0500 (EST)
In-Reply-To: <CA+P7+xryNo=n0fFn9HNrj78z4XtWwoF=j67+Qy8TbO7reBTO-Q@mail.gmail.com>
	(Jacob Keller's message of "Mon, 29 Feb 2016 11:34:32 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D2AD4CB4-DF1C-11E5-955C-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287892>

Jacob Keller <jacob.keller@gmail.com> writes:

>> This does make sense but it is an unrelated fix.  Perhaps split this
>> patch into two?
>
> That actually is required because otherwise adding a check for argc
> would break the things. I could split them and do this first and then
> check for argc if you really prefer?

It is not "check for argc breaks", it is already broken and by
checking for argc you are exposing the breakage, no?

So I'd say fix that first and then fix the clone subcommand?


>
>>> +     if (argc)
>>> +             usage(*git_submodule_helper_usage);
>>> +
>>
>> That asterisk looks very unusual and wanting to be future-proofed
>> (i.e. who says that only the first entry matters?).  Should't this
>> be calling usage_with_options()?
>>
>
> I... didn't know usage_with_options was a thing! Hah. I can fix these up.
>
> Thanks,
> Jake\
