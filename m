From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git log --first-parent" shows parents that are not first
Date: Sun, 11 May 2008 11:44:06 -0700
Message-ID: <7vd4ns3cll.fsf@gitster.siamese.dyndns.org>
References: <200805110706.m4B76eLE006432@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git@vger.kernel.org
To: =?iso-2022-jp?B?GyRCJDckaSQkJDckSiRKJDMbKEI=?= 
	<nanako3@bluebottle.com>
X-From: git-owner@vger.kernel.org Sun May 11 20:45:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGXh-0002y4-RQ
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:45:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754937AbYEKSoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754844AbYEKSoQ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:44:16 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754643AbYEKSoP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:44:15 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A37F36B0;
	Sun, 11 May 2008 14:44:14 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B343336AE; Sun, 11 May 2008 14:44:10 -0400 (EDT)
In-Reply-To: <200805110706.m4B76eLE006432@mi0.bluebottle.com>
 (nanako3@bluebottle.com's message of "Sun, 11 May 2008 16:03:20 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 40E29DF2-1F8A-11DD-9BE1-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81813>

しらいしななこ  <nanako3@bluebottle.com> writes:

>> The result given by "git log --first-parent" ('next' version) is
>> unexpected to me.
>>
>>   % git rev-parse origin/next
>>   4eddac518225621c3e4f7285beb879d2b4bad38a
>>   % git log --abbrev-commit --pretty=oneline --first-parent origin/next^..origin/next
>>   4eddac5... Merge branch 'master' into next
>>   1f8115b... Merge branch 'maint'
>> ...
>>   921177f... Documentation: improve "add", "pull" and "format-patch" examples
>>   c904bf3... Be more careful with objects directory permissions on clone
>>
>> I asked for the log between one commit before the tip of "origin/next"
>> and the tip of the branch, following only the first-parent links.
>> v1.5.5 is not broken and shows the expected result:
>>
>>   % ~/git-v1.5.5/bin/git log --abbrev-commit --pretty=oneline --first-parent origin/next^..origin/next
>>   4eddac5... Merge branch 'master' into next
>
> Could you please revert d9c292e8bbd51c84cb9ecd86cb89b8a1b35a2a82?  With
> that patch reverted from 'next', the problem disappears.

That's d9c292e (Simplify and fix --first-parent implementation,
2008-04-27) by Stephen.

I know that the alleged "fix" works around a corner-case, a fast-forward
situation that was artificually recorded as a merge, but if the "cure"
breaks a normal case like this, it is worse than the disease.

Stephen, do you have a fix?
