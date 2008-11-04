From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] git send-email: ask less questions when --compose is
 used.
Date: Tue, 04 Nov 2008 15:54:39 -0800
Message-ID: <7vvdv3nj28.fsf@gitster.siamese.dyndns.org>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-1-git-send-email-madcoder@debian.org>
 <1225815858-30617-2-git-send-email-madcoder@debian.org>
 <1225815858-30617-3-git-send-email-madcoder@debian.org>
 <1225815858-30617-4-git-send-email-madcoder@debian.org>
 <1225815858-30617-5-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Nov 05 00:56:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxVlM-0006wl-B6
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 00:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759051AbYKDXy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Nov 2008 18:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760808AbYKDXyz
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Nov 2008 18:54:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55632 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758998AbYKDXyy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Nov 2008 18:54:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B6005793FB;
	Tue,  4 Nov 2008 18:54:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7D5A3793F8; Tue,
  4 Nov 2008 18:54:45 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F9D1A868-AACB-11DD-8C2C-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100125>

Pierre Habouzit <madcoder@debian.org> writes:

> +	print C <<EOT;
> +From $tpl_sender # This line is ignored.
> +GIT: Lines beginning in "GIT: " will be removed.
> +GIT: Consider including an overall diffstat or table of contents
> +GIT: for the patch you are writing.
> +GIT:
> +GIT: Clear the body content if you don't wish to send a summary.
> +From: $tpl_sender
> +Subject: $tpl_subject
> +In-Reply-To: $tpl_reply_to
> +

Somebody already suggested this but I really think GIT: lines should be at
the end and use '# ' prefix instead.

With the ability to give --cover-letter option to underlying format-patch
do you still need this?

> +	my $editor = $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") || $ENV{VISUAL} || $ENV{EDITOR} || "vi";
> +
> +	if ($annotate) {
> +		do_edit($compose_filename, @files);
> +	} else {
> +		do_edit($compose_filename);
> +	}

Don't we want to abort the whole process when the user kills the editor
instead of normal exit (iow, do_edit() which is system() reports that the
editor was killed)?
