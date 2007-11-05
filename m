From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add more tests for git-clean
Date: Sun, 04 Nov 2007 16:17:47 -0800
Message-ID: <7vr6j5r1ec.fsf@gitster.siamese.dyndns.org>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
	<11942029442710-git-send-email-shawn.bohrer@gmail.com>
	<7vve8hr3ch.fsf@gitster.siamese.dyndns.org>
	<20071104234617.GG4207@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Nov 05 01:18:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IopfP-0004t1-LD
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 01:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbXKEAR5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 19:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752807AbXKEAR5
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 19:17:57 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:49662 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbXKEAR4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 19:17:56 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 17FD12EF;
	Sun,  4 Nov 2007 19:18:15 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 939CC921DF;
	Sun,  4 Nov 2007 19:18:11 -0500 (EST)
In-Reply-To: <20071104234617.GG4207@artemis.corp> (Pierre Habouzit's message
	of "Mon, 05 Nov 2007 00:46:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63462>

Pierre Habouzit <madcoder@debian.org> writes:

> On Sun, Nov 04, 2007 at 11:35:42PM +0000, Junio C Hamano wrote:
>> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
>> 
>> > +test_expect_success 'git-clean with prefix' '
>> > +
>> > +	mkdir -p build docs &&
>> > +	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
>> > +	cd src/ &&
>> > +	git-clean &&
>> > +	cd - &&
>> 
>> This is wrong for two reasons.
>> 
>>  - Is "cd -" portable?
>
>   this is POSIX:

That actually doesn't matter.  What the real world shells do
matters more.

In addition, "cd -" is a nice shorthand for interactive use but
it is a bad discipline to use it in a script anyway.

	...
	( cd src && git-clean ) &&
	...

would be the best way to write this.
