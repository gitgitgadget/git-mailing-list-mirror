From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] Makefile: use `find` to determine static header dependencies
Date: Mon, 25 Aug 2014 15:08:50 -0700
Message-ID: <xmqq4mx0kyrx.fsf@gitster.dls.corp.google.com>
References: <20140822042716.GE27992@peff.net>
	<20140822043303.GB18192@peff.net> <20140825194641.GS20185@google.com>
	<20140825200042.GJ30953@peff.net> <20140825204516.GT20185@google.com>
	<xmqqppfol1sx.fsf@gitster.dls.corp.google.com>
	<20140825212705.GU20185@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Jiang Xin <worldhello.net@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 00:09:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XM2Rn-0000sJ-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 26 Aug 2014 00:09:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933512AbaHYWJB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 18:09:01 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51773 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755147AbaHYWJA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 18:09:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F2893359B4;
	Mon, 25 Aug 2014 18:08:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5eTScLXwB0XyB3TxoD8dKsuBURQ=; b=AO4y7m
	oxwXBPlhJcX2NrwiwhcEq4EfgaiDobgqAOs7MGYDH7Lzxq2yYdu+mQKanfeJiVw/
	2T6TTHbz4VSWiRYQigyrYjCZzR3IlFkBUSSTz4hvJEXEbfFUn2yrBFgKAann1vPb
	WhNSJujtP2eJ+L6f7VCo8LJcvMMnNkSFg5E94=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=o2HTT+IODavSWSgJ1hH3AXpm5mDsuMSR
	nABdmXEKy57wFDsm/gn3P3iBa1i0cGyAp/ogVZKH3W0VC2ctvkz8jIO0JYyzgo2Q
	P7eUKOTWfO3WocVPGlrAky2iXqxzZSE4hnK2SrEhjyzHngjd030trSIHVF85z0hf
	akx3gtx+O+o=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E815B359B3;
	Mon, 25 Aug 2014 18:08:59 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1F116359AB;
	Mon, 25 Aug 2014 18:08:52 -0400 (EDT)
In-Reply-To: <20140825212705.GU20185@google.com> (Jonathan Nieder's message of
	"Mon, 25 Aug 2014 14:27:06 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65C13376-2CA4-11E4-9466-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255873>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Wouldn't it be sufficient to start digging not from "*" but from
>> "??*"?
>
> Gah, the * was supposed to be . in my examples (though it doesn't
> hurt).
>
>> 	find ??* \( -name Documentation -o -name .\?\* \) -prune -o -name \*.h
>
> Heh.  Yeah, that would work. ;-)

Continuing useless discussion...

Actually as you are not excluding CVS, RCS, etc., and using ??* as
the starting point will exclude .git, .hg, etc. at the top, I think
we can shorten it even further and say

	find ??* -name Documentation -prune -o -name \*.h

or something.

...and time to go back to something more serious and practical.

Don't we want to exclude contrib/ by the way?
