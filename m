From: Jeremy Morton <admin@game-point.net>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 10:16:42 +0100
Message-ID: <535E1C7A.3040504@game-point.net>
References: <CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>	<535D6EB1.9080208@game-point.net>	<CALKQrgdFLc=k9i1+N2458amLMGQa99q55A=N785VfMRwfOH6Rg@mail.gmail.com>	<20140428.084543.1615507400056684596.chriscool@tuxfamily.org>	<535E18E0.3010507@game-point.net> <CALKQrgfN-bE7KpZFadtD806Xk29N_R2sYurPQSKHLSh0UwcZiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Git mailing list <git@vger.kernel.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Apr 28 11:16:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wehg7-0006uO-UC
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 11:16:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754737AbaD1JQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 05:16:40 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:55450 "EHLO
	mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754565AbaD1JQj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 05:16:39 -0400
Received: from [192.168.0.2] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
	by mail.gooeysoftware.com (Postfix) with ESMTPSA id C811A18A09AC;
	Mon, 28 Apr 2014 04:24:26 -0500 (CDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
In-Reply-To: <CALKQrgfN-bE7KpZFadtD806Xk29N_R2sYurPQSKHLSh0UwcZiw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247260>

On 28/04/2014 10:09, Johan Herland wrote:
> On Mon, Apr 28, 2014 at 11:01 AM, Jeremy Morton<admin@game-point.net>  wrote:
>> On 28/04/2014 07:45, Christian Couder wrote:
>>> Yes, it's possible. Yesterday, I sent the following patch:
>>>
>>> [RFC/PATCH 2/2] trailer: add examples to the documentation
>>>
>>> and it shows a commit-msg hook to do something like that:
>>>
>>> $ cat>.git/hooks/commit-msg<<EOF
>>> #!/bin/sh
>>> git interpret-trailers --trim-empty --trailer "git-version: \$(git
>>> describe)" "\$1">   "\$1.new"
>>> mv "\$1.new" "\$1"
>>> EOF
>>> $ chmod +x .git/hooks/commit-msg
>>>
>>> I think you just need to use the following if you want the branch
>>> instead of the git version:
>>>
>>> git interpret-trailers --trim-empty --trailer "git-branch: \$(git name-rev
>>> --name-only HEAD)" "\$1">   "\$1.new"
>>>
>>> It could even be simpler if there was an option (which has already
>>> been discussed) that made it possible to modify the file in
>>> place. This way one would not need the 'mv "\$1.new" "\$1"' command.
>>
>> This is certainly going in the right direction, but it's still implemented
>> as a hook on a per-repo basis.  Do you foresee a point in the future where
>> these trailers could be added through simple one-liners in someone's global
>> .gitconfig file?  That's where I'd really like to get to.
>
> It's a hack, but it works surprisingly well in practice (assuming that
> you and your co-workers all agree that this is an acceptable
> approach):
>
>   1. Write the hook script and add it to your project (in a git-hooks
> subdir or something)
>
>   2. Add a post-checkout hook to install the first hook and the
> post-checkout hook itself into the user's .git/hooks/ dir.
>
>   3. Tell your co-workers to run the post-checkout hook script manually
> the first time. After that, the script should take care of updating
> itself and any hooks that you add to the project.
>
>
> ...Johan

I don't understand why the co-workers need to run the post-checkout hook 
script manually the first time?

-- 
Best regards,
Jeremy Morton (Jez)
