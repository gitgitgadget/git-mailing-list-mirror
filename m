From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 15:31:18 -0800
Message-ID: <7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Feb 18 00:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIZ1X-0007H5-BQ
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 00:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992875AbXBQXbU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 18:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992876AbXBQXbU
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 18:31:20 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54994 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992875AbXBQXbT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 18:31:19 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217233119.DTZK21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 18:31:19 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QnXJ1W00C1kojtg0000000; Sat, 17 Feb 2007 18:31:18 -0500
In-Reply-To: <20070217232603.GB30839@coredump.intra.peff.net> (Jeff King's
	message of "Sat, 17 Feb 2007 18:26:03 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40025>

Jeff King <peff@peff.net> writes:

> On Sat, Feb 17, 2007 at 01:12:52PM -0800, Junio C Hamano wrote:
>
>> +	prefix = setup_git_directory_gently(&is_not_gitdir);
>> +	prefix_length = prefix ? strlen(prefix) : 0;
>> +	if (!is_not_gitdir) {
>> +		git_config(git_apply_config);
>> +		if (apply_default_whitespace)
>> +			parse_whitespace_option(apply_default_whitespace);
>> +	}
>> +
>
> If I read this correctly, running 'git apply' inside a git repository
> will parse $GIT_DIR/config and $HOME/.gitconfig. However, outside of a
> repository it will parse neither. It would make more sense to me to
> still parse $HOME/.gitconfig to pick up the user's global options.

I thought about that, but decided against it.  If you are truly
operating outside a git managed repository, it does not feel
right to apply configuration user has for git.
