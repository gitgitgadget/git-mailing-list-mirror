From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git commit <path> scanning entire working tree?
Date: Mon, 16 Feb 2009 16:28:10 -0800
Message-ID: <7vwsbpewkl.fsf@gitster.siamese.dyndns.org>
References: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Feb 17 01:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZDqK-0001dR-Ew
	for gcvg-git-2@gmane.org; Tue, 17 Feb 2009 01:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbZBQA2R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 19:28:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbZBQA2Q
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 19:28:16 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbZBQA2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 19:28:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1FC7B2B47D;
	Mon, 16 Feb 2009 19:28:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 685192B473; Mon,
 16 Feb 2009 19:28:12 -0500 (EST)
In-Reply-To: <2729632a0902161458m732af362od59e5f35af5643c3@mail.gmail.com>
 (skillzero@gmail.com's message of "Mon, 16 Feb 2009 14:58:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DDB2294A-FC89-11DD-A81A-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110269>

skillzero@gmail.com writes:

> When I do a 'git commit <path to a single file>', git seems to scan
> the entire working tree. Since my tree is relatively large (and when
> on Windows, stat'ing is even slower), it takes quite a while (5 or so
> seconds) before I can even edit the commit message.

Do you mean you edit the commit message, starting from the message
template "git commit" gives you?

The template lists "Changes to be committed" (which obviously would list
only the path that matches the single pathspec you give to the command,
and there is no need to scan the whole tree -- it only needs to check the
file or a directory hierarchy if the pathspec matches a directory), but
also "Changed but not updated" and "Untracked files".  You cannot generate
the latter two lists without checking with your work tree.
