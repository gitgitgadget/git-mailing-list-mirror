From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] svnimport/cvsimport: force creation of tags that already exist.
Date: Fri, 07 Sep 2007 13:54:01 -0700
Message-ID: <7vzlzy2o46.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709071125090.6203@juice.ott.cti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Smith <msmith@cbnco.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 22:54:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITkqE-0006Xx-G6
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 22:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932755AbXIGUyJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 16:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753664AbXIGUyJ
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 16:54:09 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:48763 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752346AbXIGUyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2007 16:54:08 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id BC64C130439;
	Fri,  7 Sep 2007 16:54:25 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709071125090.6203@juice.ott.cti.com> (Michael
	Smith's message of "Fri, 7 Sep 2007 11:42:22 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58073>

Michael Smith <msmith@cbnco.com> writes:

> I understand moving tags is frowned upon in Git. I don't know how common 
> the practise is in Subversion and CVS, or whether it makes sense to 
> make the import scripts force tag creation by default.

I think the patch itself makes sense.  If for some reason the
importer detects that the CVS or SVN history moved a tag, we
either:

    (1) have a way to keep track of the versions of the tag; or
    (2) allow it and make it "last one wins" semantics; or
    (3) ignore it and make it "first one wins" semantics.  

Erroring out complaining that the tag cannot be created, as the
current code does, does not make any sense.

The patch needs to be accompanied with a better commit log
description.  I am guessing that with your change the semantics
would become (2) above (assuming that cvsps or whoever reads the
history of the other side gives events in chronological order),
but you should not force readers of your commit log message to
guess.
