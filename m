From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
 not change
Date: Tue, 22 Jul 2008 16:55:20 -0700
Message-ID: <7viquxjwyf.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
 <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRiW-00018R-Id
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754129AbYGVXz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbYGVXz2
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:55:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbYGVXz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:55:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C820C3A4C7;
	Tue, 22 Jul 2008 19:55:26 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 163A33A4C6; Tue, 22 Jul 2008 19:55:21 -0400 (EDT)
In-Reply-To: <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
 (Avery Pennarun's message of "Tue, 22 Jul 2008 18:22:34 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A8289A0A-5849-11DD-8A38-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89570>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> On 7/22/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>>  If the user called "rebase -i", marked a commit as "edit", "rebase
>>  --continue" would automatically amend the commit when there were
>>  staged changes.
>>
>>  However, this is actively wrong when the current commit is not the
>>  one marked with "edit".  So guard against this.
>
> This patch is perhaps a symptom of something I've been meaning to ask
> about for a while.
>
> Why doesn't "edit" just stage the commit and not auto-commit it at
> all?  That way an amend would *never* be necessary, and rebase
> --continue would always do a commit -a (if there was anything left to
> commit).  The special case fixed by this patch would thus not be
> needed.

That would actually be in-line with the way how "rebase --skip" does the
resetting without asking the user to do so, wouldn't it?
