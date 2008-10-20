From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] -C/--chdir command line option
Date: Sun, 19 Oct 2008 22:41:04 -0700
Message-ID: <7vhc774ydr.fsf@gitster.siamese.dyndns.org>
References: <20081019000227.GA9423@charybdis.dreamhost.com>
 <20081019131745.GA8643@coredump.intra.peff.net>
 <86685067-021C-4DC5-A462-AA6834208BDE@pasternacki.net>
 <20081019141634.GA8997@coredump.intra.peff.net>
 <7vr66b50gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maciej Pasternacki <maciej@pasternacki.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 20 14:51:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrnXC-0003kk-Hm
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 07:42:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbYJTFlS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 01:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbYJTFlS
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 01:41:18 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59667 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbYJTFlR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 01:41:17 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D272716CA;
	Mon, 20 Oct 2008 01:41:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 02386716C9; Mon, 20 Oct 2008 01:41:11 -0400 (EDT)
In-Reply-To: <7vr66b50gy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 19 Oct 2008 21:55:57 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B6B42F92-9E69-11DD-829D-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98663>

Junio C Hamano <gitster@pobox.com> writes:

> The only excuse I remember seeing in the thread was that "make has '-C'
> option, so let's have it, because it is similar", which does not justfiy
> addition of that option to git at all to me.

Just after having said that "make has it, so let's have it ourselves, too"
is a non-excuse to any feature bloat, one thing I could accept a patch to
imitate what "make" does, especially if we are going to actually clean up
the startup sequence like we have discussed sometime ago to fix breakage
around --work-tree, is to have VAR=VAL (e.g. "make CFLAGS=-O2") on the
command line.  We could use that syntax to allow configuration variables
to be overridden, like so:

	$ git core.whitespace=cr-at-eol log -p master..next

I wouldn't however suggest allowing the syntax to set environment
variables, like:

	$ git GIT_AUTHOR_NAME="A U Thor" commit

as this is something your shell lets you do easily, i.e:

	$ GIT_AUTHOR_NAME="A U Thor" git commit

But overriding some configuration variables for a single command
invocation is not something you can do without actually editing the
configuration file for some variables, so the former would be justified.
