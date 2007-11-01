From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 01 Nov 2007 14:20:15 -0700
Message-ID: <7vhck5acj4.fsf@gitster.siamese.dyndns.org>
References: <20071022063222.GS14735@spearce.org>
	<7vzly84qwf.fsf@gitster.siamese.dyndns.org>
	<7vmytycykt.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org>
	<916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com>
	<7v4pg5btis.fsf@gitster.siamese.dyndns.org>
	<20071101204755.GA15842@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 22:20:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InhT6-0006bP-IA
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 22:20:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754458AbXKAVUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 17:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754471AbXKAVUX
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 17:20:23 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:57132 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458AbXKAVUX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 17:20:23 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id C3F182F9;
	Thu,  1 Nov 2007 17:20:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 11BCB90CE1;
	Thu,  1 Nov 2007 17:20:38 -0400 (EDT)
In-Reply-To: <20071101204755.GA15842@glandium.org> (Mike Hommey's message of
	"Thu, 1 Nov 2007 21:47:55 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63005>

Mike Hommey <mh@glandium.org> writes:

> On Thu, Nov 01, 2007 at 01:27:55PM -0700, Junio C Hamano wrote:
> ...
>> I do not know where "git clean" came from.  I am suspecting that
>> it was to give counterparts to some other SCMs, but do not know
>> which ones.  Some people wanted to have it --- so you need to
>> convince them that it is a bad idea first.  Adding an equivalent
>> options to "git rm" alone does not solve that issue.
>
> Well, they could add an alias, then ;)

Why do people talk about forcing different behaviour on existing
users before proving that the new behaviour is good for
everybody, including existing ones?

I am personally very much in favor of removing "git clean", but
having many people on the list saying loudly that it is a bad
command is not good enough justification, as people who are
content with the status quo tend to be silent.

The steps I think is sensible to transition to that goal would
be:

 - Change clean.requireForce to default to 'true' in the next
   (or one after) version of git, to make 'clean' even safer.
   See if anybody complains (I do not expect any).

 - Implement the same functionarity as a new option to "git rm",
   which is already in C.

 - Do "git clean" in C, but sharing the code with "git rm"
   implementation above.

 - Discuss deprecation and removal of redundant commands.  Ship
   a version of git with deprecation and future removal notice.
   Outline how to achieve the same thing as the deprecated
   command used to do (or give convincing argument why what the
   deprecated command used to do was a bad thing and do not
   offer an alternative).

 - Wait for a while (6 months to 1 year) and then remove them.
