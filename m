From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: Pull is Evil
Date: Wed, 30 Apr 2014 15:45:23 -0400
Message-ID: <536152D3.5050107@xiplink.com>
References: <4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com>	<xmqqoazlqot4.fsf@gitster.dls.corp.google.com>	<536106EA.5090204@xiplink.com> <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marat Radchenko <marat@slonopotamus.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 21:51:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfaXh-0006uo-0o
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 21:51:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946005AbaD3Tvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 15:51:40 -0400
Received: from smtp154.ord.emailsrvr.com ([173.203.6.154]:59510 "EHLO
	smtp154.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186AbaD3Tvk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 15:51:40 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Apr 2014 15:51:40 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp16.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id 6E50D3D0107;
	Wed, 30 Apr 2014 15:44:59 -0400 (EDT)
X-Virus-Scanned: OK
Received: by smtp16.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 85B463D050F;
	Wed, 30 Apr 2014 15:44:57 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqppjyhnom.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247765>

On 14-04-30 10:55 AM, Junio C Hamano wrote:
> Marc Branchaud <marcnarc@xiplink.com> writes:
> 
>> But I'm definitely biased because I think pull is pretty much broken:
>>
>> * New users are encouraged to use pull, but all too often the default
>> fetch-then-merge behaviour doesn't match their expectations and they end up
>> starting threads like this one on the mailing list.
>>
>> * If we change pull's default behaviour, we'll just be shifting the
>> mismatched expectations onto the other half of the new users who would be
>> happy with fetch-then-merge.
>>
>> * I'm not sure why new users are taught to use pull.  I suspect it's because
>> it tries to hide the idea of local-vs-remote branches, and people writing git
>> tutorials don't want to overwhelm new users with what seems to be an internal
>> detail.  But these notions are really fundamental to using git effectively,
>> and I think pull does everyone a disservice by trying to gloss them over.
>>
>> Anyway, rather than ranting on I'll just suggest that there's not enough
>> commonality between the ways people use git to make it worthwhile trying to
>> teach pull how to deal with a significant number of them.  I think the pull
>> command should be deprecated and quietly retired as a failed experiment.
> 
> I almost agree with the first sentence in the last paragraph, and
> your bulletted list above supports it.
> 
> I am not sure how the second sentence can follow as its consequence.
> 
> If the conclusion were "maybe adding a 'git update' to match the
> expectation of those who build on top of the work of others (aka
> CVS/SVN style) more  closely and teaching new users to use that
> instead of 'git pull' may be a good way forward", I can sort of
> understand (if I may not be able to immediately agree with, until I
> can regurgitate the ramifications of such a change) it.

(Yum!  You know, regurgitated ramifications aren't just for breakfast
anymore... :) )

I think we would run into much the same problem with "git update" as we do
with "git pull".  To wit, any "git pull" (or "git update") implementation
needs to make certain workflow assumptions.  I think that no matter which
assumptions are made, there will always be a significant proportion of new
users[1] for whom the assumptions are wrong.

This is why the command is broken.  It's also why the "let's change git pull"
discussions never seem to get anywhere:  Attempting to make the command work
in new user X's environment will make it not work in new user Y's.  Whatever
change is made to "git pull", after a few months new user Y comes along and
says it's wrong.

And now we're seeing third-party tools, like TortoiseGit, using "git pull"
(or the default "git pull" workflow model) and exposing yet more new users to
workflow dissonance.

I don't think we'll ever be able to create a One "Git Pull" To Rule Them All.
 At best we'll end up with something with enough knobs that it could be
configured to work in most workflows (I think we're actually pretty close to
that).  But for new users that defeats the purpose.  It means that "git pull"
is really an advanced command, and beginners should avoid it until they
understand enough of git to configure it properly.

So rather than perpetuate the myth that one command can always (or even just
usually) do the right thing, let's just retire the command.

All that said, I don't object to any attempts at improving the command
either.  But I also don't see any kind of improvement that would lead me to
start using "git pull" let alone recommending it to new users.

		M.

[1] By "significant" I mean "enough to perpetually create new mailing list
threads about changing 'git pull'".
