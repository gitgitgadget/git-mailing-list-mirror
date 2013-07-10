From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Wed, 10 Jul 2013 11:18:26 +0200
Message-ID: <87mwpuepst.fsf@linux-k42r.v.cablecom.net>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
	<7vppurv8bl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 10 11:18:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwqXh-00014K-NZ
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jul 2013 11:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962Ab3GJJS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jul 2013 05:18:29 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26089 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381Ab3GJJS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jul 2013 05:18:29 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 10 Jul
 2013 11:18:22 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 10 Jul 2013 11:18:26 +0200
In-Reply-To: <7vppurv8bl.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 09 Jul 2013 12:31:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230032>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> If you define it that way, the output of
>>
>>   git blame -L 4,6; git blame -L /A/,+20
>>
>> is significantly different from
>>
>>   git blame -L 4,6 -L /A/,+20
>>
>> Not just in the presentation or any possible coalescing, but in the
>> meaning of the ranges.
>>
>> Do you really want to make it that way?
>
> Absolutely.  The primary reason I want to be able to specify two
> ranges at the same time is to follow two functions in a file that
> appear in separate places, and /A/ might not be unique.  When I want
> to say "I want to see from here to there, and then from here to
> there, and then from here to there", it would be very frustrating if
> "and then" resets what I mean by "here" every time and make these
> three evaluated independently.

Ok, fair enough.  That is at least an argument other than "trust me, I
care deeply" :-)

But still, log -L should then be changed to match this behavior (for all
args affecting a single file).  Currently it always does the scan for
the start of the range from line 1 of the file.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
