From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 10:01:20 +0100
Message-ID: <535E18E0.3010507@game-point.net>
References: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>	<535D6EB1.9080208@game-point.net>	<CALKQrgdFLc=k9i1+N2458amLMGQa99q55A=N785VfMRwfOH6Rg@mail.gmail.com> <20140428.084543.1615507400056684596.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:01:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WehRB-0002yG-1G
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754153AbaD1JBR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:01:17 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:54776 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753463AbaD1JBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:01:16 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id B53A818A09AC;
	Mon, 28 Apr 2014 04:09:04 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <20140428.084543.1615507400056684596.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247252>

On 28/04/2014 07:45, Christian Couder wrote:
> Yes, it's possible. Yesterday, I sent the following patch:
>
> [RFC/PATCH 2/2] trailer: add examples to the documentation
>
> and it shows a commit-msg hook to do something like that:
>
> $ cat>.git/hooks/commit-msg<<EOF
> #!/bin/sh
> git interpret-trailers --trim-empty --trailer "git-version: \$(git describe)" "\$1">  "\$1.new"
> mv "\$1.new" "\$1"
> EOF
> $ chmod +x .git/hooks/commit-msg
>
> I think you just need to use the following if you want the branch
> instead of the git version:
>
> git interpret-trailers --trim-empty --trailer "git-branch: \$(git name-rev --name-only HEAD)" "\$1">  "\$1.new"
>
> It could even be simpler if there was an option (which has already
> been discussed) that made it possible to modify the file in
> place. This way one would not need the 'mv "\$1.new" "\$1"' command.
>
> Best,
> Christian.

This is certainly going in the right direction, but it's still 
implemented as a hook on a per-repo basis.  Do you foresee a point in 
the future where these trailers could be added through simple one-liners 
in someone's global .gitconfig file?  That's where I'd really like to 
get to.

-- 
Best regards,
Jeremy Morton (Jez)
