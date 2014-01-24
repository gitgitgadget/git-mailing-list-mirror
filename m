From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Globbing for ignored branches?
Date: Fri, 24 Jan 2014 12:44:58 -0800
Message-ID: <xmqqmwilqfcl.fsf@gitster.dls.corp.google.com>
References: <20140124090104.GA396@x4>
	<0C723FEB5B4E5642B25B451BA57E273075148284@S1P5DAG3C.EXCHPROD.USA.NET>
	<20140124170739.GC396@x4> <20140124170909.GD396@x4>
	<20140124182341.GB8202@sigill.intra.peff.net>
	<20140124183222.GE396@x4>
	<20140124185538.GA9836@sigill.intra.peff.net>
	<xmqq4n4trvzj.fsf@gitster.dls.corp.google.com>
	<20140124203312.GF396@x4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jim Garrison <jim.garrison@nwea.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Markus Trippelsdorf <markus@trippelsdorf.de>
X-From: git-owner@vger.kernel.org Fri Jan 24 21:45:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6ncj-0005p8-PM
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 21:45:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbaAXUpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jan 2014 15:45:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39164 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbaAXUpD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jan 2014 15:45:03 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EF8D65DA1;
	Fri, 24 Jan 2014 15:45:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FsXI92Y2Vksg5i/cDGTrUssh7jY=; b=f9qs+c
	iIaWIX2EdQoG5zfFMYcZxpf67O6g0GgNMVIf2hMeACbIEYJLImDIbhePir/qMY/M
	6yqr9Un/orHtnxUrrkscjmP6iiv5em7/ZA9tAq8dDxSJ4CsWjk8aE+oATYQxi962
	I7sejSvCYGbneWczE9P0dcVqt3/8mCfXbZv+Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5uoAySQJsDZ3J0zuK4rsuXqjR79VZme
	NMsXLTLO+IlAeGA+D+fo05ZhEef8XApebNMQ8RYB3Ull514SM1Tr1d2IX3EXaWYw
	q6+LVOSbqF1UxoLoMhYXtA6BLU+NI1i2rqjDagLi8LDBrKMcnGy1bk7uoryu4RZx
	dgDiB7x1oHA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 188F065D9F;
	Fri, 24 Jan 2014 15:45:03 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2193D65D9A;
	Fri, 24 Jan 2014 15:45:01 -0500 (EST)
In-Reply-To: <20140124203312.GF396@x4> (Markus Trippelsdorf's message of "Fri,
	24 Jan 2014 21:33:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 65A8F4AA-8538-11E3-9694-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241036>

Markus Trippelsdorf <markus@trippelsdorf.de> writes:

> On 2014.01.24 at 12:00 -0800, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Fri, Jan 24, 2014 at 07:32:22PM +0100, Markus Trippelsdorf wrote:
>> >
>> >> > However, you do have to specify each branch individually. You probably
>> >> > want to say "all branches except X", and you cannot currently specify
>> >> > a negative refspec like that.
>> >> 
>> >> Yes, that was the question I wanted to ask (, sorry for not formulating
>> >> it more clearly). 
>> >> Is this "negative refspec for branches" a feature that is planned for
>> >> the future?
>> >
>> > It is something that has been talked about before, but I do not think
>> > anybody is actively working on. It would probably not be too hard a
>> > feature if you are interested in getting your feet wet in git
>> > development. :)
>> 
>> The end result might be not so hard in the mechanical sense, but
>> designing the interface would be hard.  I do not offhand think of a
>> good way to do this.
>
> I don't know if the in-tree regex engine supports negative lookaheads.
> If it does, then something like the following should work (to use my
> "hjl" example):
>
> ^(.(?!hjl))*

refspec wildcards are *NOT* regular expressions.
