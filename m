From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-bundle question.
Date: Sun, 11 May 2008 17:28:04 -0700
Message-ID: <7v3aoo2wob.fsf@gitster.siamese.dyndns.org>
References: <5d46db230805111511g5bbb0b9amf65fb95266a80504@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Govind Salinas" <govind@sophiasuchtig.com>
X-From: git-owner@vger.kernel.org Mon May 12 02:29:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvLuj-0000TU-SU
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 02:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbYELA2Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 20:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbYELA2Y
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 20:28:24 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38187 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbYELA2X (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 20:28:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 60E573F8B;
	Sun, 11 May 2008 20:28:22 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B50D13F89; Sun, 11 May 2008 20:28:18 -0400 (EDT)
In-Reply-To: <5d46db230805111511g5bbb0b9amf65fb95266a80504@mail.gmail.com>
 (Govind Salinas's message of "Sun, 11 May 2008 17:11:46 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 53F3DB38-1FBA-11DD-AE62-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81825>

"Govind Salinas" <govind@sophiasuchtig.com> writes:

> I am writing my wrapper over git bundle and I noticed that the
> "SPECIFYING REFERENCES" section says that the it will only
> bundle things that end in something git-show-ref can find.
>
> I can probably work around this by silently creating a tag
> doing the bundle and deleting the tag, but I want to know why
> this restriction is in there in the first place?  If there is a good
> reason for it then I will probably just add this info to the
> documentation.

Because bundle is not just a random collection of objects, a tarball of
your .git/objects/.  Instead, it is a (partial) history that leads to a
particular (set of) versions.

Think of it as what "git fetch $somewhere $that_branch" could give you.
It is not giving you just a collection of random objects, but you are
choosing from the endpoint the particular repository ($somewhere) is
offering you.

When you publish your history to be fetched over the network (or locally
for that matter), you do not just put bunch of objects there.  You give
branches to mark where the histories end.  It's the same deal with
bundles, and the only difference is the transfer may go over sneakernet.
