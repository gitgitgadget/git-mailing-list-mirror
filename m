From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How make "git checkout <commit> <file>" *not* alter index?
Date: Mon, 05 Jan 2009 22:26:05 -0800
Message-ID: <7vk599ne6a.fsf@gitster.siamese.dyndns.org>
References: <20090106051852.GA3278@seberino.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: chris@seberino.org
X-From: git-owner@vger.kernel.org Tue Jan 06 07:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LK5Pc-0002xP-57
	for gcvg-git-2@gmane.org; Tue, 06 Jan 2009 07:27:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbZAFG0N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2009 01:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbZAFG0N
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Jan 2009 01:26:13 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36657 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZAFG0M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2009 01:26:12 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 473271BE63;
	Tue,  6 Jan 2009 01:26:11 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id D96AF1BE7F; Tue, 
 6 Jan 2009 01:26:07 -0500 (EST)
In-Reply-To: <20090106051852.GA3278@seberino.org> (chris@seberino.org's
 message of "Mon, 5 Jan 2009 21:18:52 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E92370E4-DBBA-11DD-9E6C-EB51113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104638>

chris@seberino.org writes:

> I want to pull an old version of a file into my local directory and make it
> appear like work I haven't added to index yet...

The command to reset the index can be used any time you have unwanted
changes to it and pretend you started from the latest commit (aka HEAD).

Typically, you use it to recover from a "git add" you did by mistake,
e.g.

    $ edit frotz.c nitfol.c
    $ git add frotz.c nitfol.c
    ... oops, I do not want the changed frotz.c in the next commit.
    $ git reset frotz.c
    $ git commit -m 'update nitfol.c for such and such reasons'

This procedure can be used after you have smudged the index in an unwated
way, and is not limited to "git add" (or "git add -p").  In this case, you
can do:

    $ git checkout HEAD~43 Makefile
    $ git reset Makefile
