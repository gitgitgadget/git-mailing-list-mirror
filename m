From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Init on push
Date: Sat, 08 Nov 2008 12:12:34 -0800
Message-ID: <7v8wruc6z1.fsf@gitster.siamese.dyndns.org>
References: <200811081708.45672.robin.rosenberg.lists@dewire.com>
 <7viqqyc93w.fsf@gitster.siamese.dyndns.org>
 <bb6f213e0811081201w22a36800j1713b91d0cf66fb2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Alexander Gavrilov" <angavrilov@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 08 21:14:07 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KyuC6-0002nV-52
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 21:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466AbYKHUMw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 15:12:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752449AbYKHUMw
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 15:12:52 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36438 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751239AbYKHUMv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Nov 2008 15:12:51 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9AB397AB67;
	Sat,  8 Nov 2008 15:12:49 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EDBBC7AB66; Sat,
  8 Nov 2008 15:12:41 -0500 (EST)
In-Reply-To: <bb6f213e0811081201w22a36800j1713b91d0cf66fb2@mail.gmail.com>
 (Alexander Gavrilov's message of "Sat, 8 Nov 2008 23:01:02 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 9DAE7FDA-ADD1-11DD-B138-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100421>

"Alexander Gavrilov" <angavrilov@gmail.com> writes:

> Gitosis works by replacing the shell with a program called
> gitosis-serve, which parses and validates the incoming commands
> against the user access configuration. If it sees an unknown command,
> it will simply refuse to execute it.

If you implement a new feature by enhancing receive-pack (or anything
else), you obviously cannot use the new feature against an installation
with an older implementation, so what you said is a known.  My point was
how to enhance the receiving end and what constraints we would have in
enhancing it.

> On the other hand it will automatically perform initialization before
> calling receive-pack if the user is authorized to write to a certain
> path, but the repository does not exist yet.

That's good to know.  I also realize that gitosis does not need any hook
for "git init -D $there" to decide whether a new repository can be created
at requested location, as it reads the command line and makes decision
before driving the underlying command in response to the request.

On the other hand, people who enable 'push' access to their git-daemon
would need it, as the daemon would not even know who is asking for --init.
