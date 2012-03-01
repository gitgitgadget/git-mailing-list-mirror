From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 4/4] bundle: keep around names passed to add_pending_object()
Date: Thu, 1 Mar 2012 23:22:21 +0100
Message-ID: <87obsggdwh.fsf@thomas.inf.ethz.ch>
References: <cover.1330637923.git.trast@student.ethz.ch>
	<6fba13f255f76481dc9098b5e8fbb33bd10735cb.1330637923.git.trast@student.ethz.ch>
	<7vehtckmee.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Thomas Rast <trast@student.ethz.ch>, <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3EOO-0008PL-GS
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 23:22:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758031Ab2CAWW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 17:22:27 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:26142 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754371Ab2CAWWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 17:22:25 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 23:22:21 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.210.31) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 1 Mar
 2012 23:22:22 +0100
In-Reply-To: <7vehtckmee.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 01 Mar 2012 14:05:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.210.31]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191983>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@student.ethz.ch> writes:
>
>> The 'name' field passed to add_pending_object() is used to later
>> deduplicate in object_array_remove_duplicates().
>>
>> git-bundle had a bug in this area since 18449ab (git-bundle: avoid
>> packing objects which are in the prerequisites, 2007-03-08): it passed
>> the name of each boundary object in a static buffer.  In other words,
>> all that object_array_remove_duplicates() saw was the name of the
>> *last* added boundary object.
>
> Ouch.

Actually, I just noticed that object_array_remove_duplicates() is much
newer than 18449ab, from b2a6d1c (bundle: allow the same ref to be given
more than once, 2009-01-17).  However it did pass in the same buffer all
the time starting from 18449ab, which is a bug waiting to happen (and
perhaps NULL would have been more appropriate).

Archaeology sure is fun.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
