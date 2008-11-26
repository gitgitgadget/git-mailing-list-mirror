From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git cat-file blob does not convert crlf
Date: Wed, 26 Nov 2008 11:42:17 -0800
Message-ID: <7v3ahegtpi.fsf@gitster.siamese.dyndns.org>
References: <20081127013456.6117@qkholland.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Quim K. Holland" <qkholland@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 20:44:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5QJ1-0003h6-Dt
	for gcvg-git-2@gmane.org; Wed, 26 Nov 2008 20:44:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752643AbYKZTmt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2008 14:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYKZTmt
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Nov 2008 14:42:49 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49765 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752643AbYKZTms (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2008 14:42:48 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 27FE9178B3;
	Wed, 26 Nov 2008 14:42:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 07B9E178AC; Wed,
 26 Nov 2008 14:42:19 -0500 (EST)
In-Reply-To: <20081127013456.6117@qkholland.gmail.com> (Quim K. Holland's
 message of "Thu, 27 Nov 2008 01:34:56 +0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 66C2DDB6-BBF2-11DD-8E7B-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101760>

"Quim K. Holland" <qkholland@gmail.com> writes:

> I think git is buggy.

Thanks for pointing it out X-<.

> I wanted to discard the changes I made to my file by checking out a copy from the last commit, so I said
> % git cat-file blob HEAD:my-file >my-file
> But this does not respect core.autocrlf and the file becomes one long line.

That is pretty much intentional.  cat-file is a low-level command that is
meant to inspect the raw object contents.  The output from the command has
to be reproducible regardless of what customization you have in your
particular repository and omission of attributes support (including the
crlf conversion) is quite deliberate.

You said that you wanted to discard the changes by checking out a copy out
of the HEAD commit.  This can literally be done by:

	$ git checkout HEAD my-file

If you want to check out a copy out of the index (i.e, "the last staged
version"), you can say:

	$ git checkout my-file

In other words, if you want to checkout, you can say checkout ;-)
