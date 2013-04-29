From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Itches with the current rev spec
Date: Mon, 29 Apr 2013 16:00:50 +0200
Message-ID: <517E7D12.6020605@drmicha.warpmail.net>
References: <CALkWK0n97VLtiR96VEy86645NVoDL2rS-g7LBuLb=JpncdH6VA@mail.gmail.com> <vpqehdzkoix.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 29 16:00:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWodM-00010C-Tx
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 16:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485Ab3D2OAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 10:00:44 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37427 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757115Ab3D2OAn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Apr 2013 10:00:43 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B6D31205FA;
	Mon, 29 Apr 2013 10:00:42 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute4.internal (MEProxy); Mon, 29 Apr 2013 10:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=tqX2vbUOu79B0+PqAN/Ykb
	c8+Jk=; b=QFIZJ4BFkKij0mp83woPUckvtX5Fj1mRb3v+U1igDsd7tXcudkKHE8
	9ADTjsWFGJeaq8q1C+4dEDPlCriXy71VMwGpDtFtJgGKy6mP/BTrtaSPaw8r8C1m
	07LtvP91hP+pAP3hZ/l/0N4hfacURUDECteEfzLTuqwcBQLE4dd0g=
X-Sasl-enc: FiJGwjSO9jKwX9lhLIdWndaUG+yBrj1gtipJoPMAv9/M 1367244042
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id EF07BC8000A;
	Mon, 29 Apr 2013 10:00:41 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130402 Thunderbird/17.0.5
In-Reply-To: <vpqehdzkoix.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222795>

Matthieu Moy venit, vidit, dixit 25.04.2013 10:22:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> 
>> Hi,
>>
>> So, I have three serious itches that would be nice to address:
>>
>> 1. git reset --hard HEAD~1/ git show HEAD~1 is a very common idiom
>> that's unnecessarily cumbersome to type out.  We can make the <rev>
>> part of <rev>~<n> optional without being ambiguous: you might argue
>> that ~<n> normally refers to a /home/<n>, but who uses numbers in
>> place of usernames?  Even if they do, how can that path possibly be
>> inside our repository?
> 
> It's a bit more complex than that: the ~<username> is expanded by the
> shell, before Git has any opportunity to guess anything.
> 
> ~1 would be unusable for zsh users and tcsh users at least by default:
> 
> zsh% echo ~1
> zsh: not enough directory stack entries.
> 
> tcsh% echo ~1
> Unknown user: 1.
> 
> (An obvious workaround is to shell-quote it, but as the goal is to have
> something easy to type, \~1 or '~1' do not give so much benefit over
> HEAD~1)
> 
> That said, it seems to work fine for bash (even if the number is a PID,
> it's not expanded), so it may be a good idea to add it as a shortcut,
> with a warning in the doc about shell expansion.

I've been using a patch for that for ages without problems; it had been
rejected because of the reasons above, plus:

Note that even in bash ~1 has a different meaning when your directory
stack is non-empty. It's just that I don't use that feature, and bash
leaves '~1' as is when there is no stack (you haven't used pushd),
whereas zsh errors out.

So, I do understand that some consider this semi-broken, even though
it's not. But we avoid clashes with shell expansion in most cases for
most shells.

As for rebase, I still have to look up what "git rebase A B" means. This
would be much clearer with a range notation. I seem to recall I even
suggested it, but that might have been in a parallel universe.

Michael
