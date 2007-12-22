From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] Don't dereference NULL upon lookup_tree failure.
Date: Sat, 22 Dec 2007 01:15:15 +0100
Message-ID: <8763yrvb3g.fsf@rho.meyering.net>
References: <873atvwueq.fsf@rho.meyering.net>
	<7v4peb4qbj.fsf@gitster.siamese.dyndns.org>
	<87hcibveut.fsf@rho.meyering.net>
	<7vzlw33a1o.fsf@gitster.siamese.dyndns.org>
	<87bq8jvd1g.fsf@rho.meyering.net>
	<7vve6r39bp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>,
	Matthew Farrellee <mfarrellee@redhat.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 01:15:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5s1n-0001sx-Td
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 01:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757491AbXLVAPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2007 19:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757370AbXLVAPR
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Dec 2007 19:15:17 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:52942 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754174AbXLVAPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2007 19:15:16 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 70C3317B53D
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 01:15:15 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 5B9A117B531
	for <git@vger.kernel.org>; Sat, 22 Dec 2007 01:15:15 +0100 (CET)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 2FE8738096; Sat, 22 Dec 2007 01:15:15 +0100 (CET)
In-Reply-To: <7vve6r39bp.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Dec 2007 15:40:58 -0800")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69111>

Junio C Hamano <gitster@pobox.com> wrote:

> Jim Meyering <jim@meyering.net> writes:
>
>> Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>>> Sorry, I asked for a wrong thing.  parse_object() reads and
>>> finds out the type, so type there is presumably the right type
>>> of the object (which is OBJ_TREE).  Then parse_object_buffer()
>>> checks if it has already seen the object of the same SHA-1 and
>>> finds that somebody had earlier told that SHA-1 name is of a
>>> commit object.  Either you found a SHA-1 collision (highly
>>> unlikely) or the earlier caller had lied.  And I think what
>>> really needs to be fixed is that lying caller.  That is not in
>>> the above call chain.
>>
>> I presume that parsecvs is the culprit, in constructing
>> an invalid repository...
>
> Independent of who creates a "invalid repository", our tools
> should be prepared to be fed bad data and not get upset.
> Somebody in our code read a non-commit (or it did not read
> anything) and told the object layer it is a commit.  That
> codepath needs to be tightened up, no?

Yes, of course.
Unfortunately, I won't have time to investigate for a while.
