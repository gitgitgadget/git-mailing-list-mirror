From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] GIT_SSH does not override ssh in git-svn
Date: Mon, 17 Aug 2009 14:40:13 -0700
Message-ID: <7vhbw6qfuq.fsf@alter.siamese.dyndns.org>
References: <4A89C6F8.3010100@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Karthik R <karthikr@fastmail.fm>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:40:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9wI-0001Lc-Ul
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:40:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758190AbZHQVkV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758187AbZHQVkV
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:40:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758186AbZHQVkT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:40:19 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3CC9E99A;
	Mon, 17 Aug 2009 17:40:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1C54DE999; Mon, 17 Aug
 2009 17:40:14 -0400 (EDT)
In-Reply-To: <4A89C6F8.3010100@fastmail.fm> (Karthik R.'s message of "Mon\,
 17 Aug 2009 16\:09\:12 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 900871D2-8B76-11DE-AC3A-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126294>

Karthik R <karthikr@fastmail.fm> writes:

> +my $git_ssh_user_set = 1 if defined $ENV{GIT_SSH};
> +if ($git_ssh_user_set) {
> +       # If GIT_SSH is set, also set SVN_SSH...
> +       $ENV{SVN_SSH} = $ENV{GIT_SSH};
> +       # ... and escape \s in shell-variable on Windows
> +       if ($^O eq 'MSWin32' || $^O eq 'msys') {
> +               $ENV{SVN_SSH} =~ s/\\/\\\\/g;
> +       }
> +}
> +

Why not just

	if (defined $ENV{GIT_SSH}) {
        	...

???

> $Git::SVN::Log::TZ = $ENV{TZ};
> $ENV{TZ} = 'UTC';
> $| = 1; # unbuffer STDOUT
> -- 
> 1.5.4.3
