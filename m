From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rev-list with --name-status?
Date: Thu, 25 Dec 2008 10:59:33 -0800
Message-ID: <7vr63w84iy.fsf@gitster.siamese.dyndns.org>
References: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 25 20:01:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFvS8-0007hx-1S
	for gcvg-git-2@gmane.org; Thu, 25 Dec 2008 20:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751899AbYLYS7l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Dec 2008 13:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751971AbYLYS7k
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Dec 2008 13:59:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47239 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbYLYS7k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Dec 2008 13:59:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 879021B0C0;
	Thu, 25 Dec 2008 13:59:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id E83C51B0B0; Thu,
 25 Dec 2008 13:59:35 -0500 (EST)
In-Reply-To: <2729632a0812241453x4ae50362g4bcd3317e5be0429@mail.gmail.com>
 (skillzero@gmail.com's message of "Wed, 24 Dec 2008 14:53:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2E67F91C-D2B6-11DD-80D3-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103909>

skillzero@gmail.com writes:

> Is there a way to print the equivalent of --name-status with git
> rev-list? The post-receive script that comes with git for sending
> comment emails does this to generate the commit log:
>
> git rev-parse --not --branches | grep -v $(git rev-parse $refname) |
> 	git rev-list --pretty --stdin $oldrev..$newrev

I should have noticed this earlier.

You seem to be referring to contrib/hooks/post-receive-email as "The
script that comes with git".  It does have customization possibility
already implemented and documented:

    hooks.showrev
       The shell command used to format each revision in the email, with
       "%s" replaced with the commit id.  Defaults to "git rev-list -1
       --pretty %s", displaying the commit id, author, date and log
       message.  To list full patches separated by a blank line, you
       could set this to "git show -C %s; echo".

One of my day-job repositories has:

    [hooks]
            mailinglist = some-secret-project@day-job-domain.com
            emailprefix = "[SOME-SECRET-PROJECT GIT] "
            showrev = "git show --stat %s; echo"

I think you can use "git show --name-status %s; echo" instead, if you like
the --name-status output.
