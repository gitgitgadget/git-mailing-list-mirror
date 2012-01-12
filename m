From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 2/3] am: learn passing -b to mailinfo
Date: Thu, 12 Jan 2012 09:52:59 +0100
Message-ID: <8762ghxpxw.fsf@thomas.inf.ethz.ch>
References: <e915a551c9bbf12f4d8fd929e9ed24f3223790ee.1326312730.git.trast@student.ethz.ch>
	<19539098c07a207f3bd24f5a145ba3b6c5e46766.1326312730.git.trast@student.ethz.ch>
	<7vzkdt4s9l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 09:53:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlGPF-0002aD-Cq
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 09:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896Ab2ALIxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jan 2012 03:53:05 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:9677 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751794Ab2ALIxD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jan 2012 03:53:03 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 09:53:00 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 12 Jan
 2012 09:53:00 +0100
In-Reply-To: <7vzkdt4s9l.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 11 Jan 2012 17:35:34 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188434>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> @@ -571,8 +574,8 @@ then
>>  else
>>  	utf8=-n
>>  fi
>> -if test "$(cat "$dotest/keep")" = t
>> -then
>> +keep=$(cat "$dotest/keep")
>> +if test "$keep" = t
>>  	keep=-k
>>  fi
>
> Curious.
>
> Who writes 't' to $dotest/keep after this patch is applied?

Nobody; like the commit message says, I was just trying to help users
upgrading from one version to the next in the middle of an 'am', which
almost worked except for

> I suspect that this patch was not tested in a way to exercise this
> codepath; shell would have barfed when seeing the lack of "then" here, no?

(ouch)

> I also do not want to worry about "echo" portability issues that may come
> from an existing
>
> 	echo "$keep" >"$dotest/keep"
>
> that this patch does not touch.

Good point, thanks.  I'll reroll with printf.  Should I keep the
upgrade path compatibility?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
