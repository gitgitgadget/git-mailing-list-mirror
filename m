From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3] push: Enhance unspecified push default warning
Date: Wed, 6 Nov 2013 15:45:44 -0800
Message-ID: <20131106234544.GF10302@google.com>
References: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
 <CAKYC+eLvx1vB1ZDqYK=7Dg68QuCojBdSAVQZMF6HBtfxu_b_aw@mail.gmail.com>
 <xmqqvc08yq4v.fsf@gitster.dls.corp.google.com>
 <1839883487.4893076.1383646619137.JavaMail.root@imag.fr>
 <xmqqk3gl8id0.fsf@gitster.dls.corp.google.com>
 <vpq1u2tb3px.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Greg Jacobson <coder5000@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 07 00:46:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeCnJ-0003qk-UY
	for gcvg-git-2@plane.gmane.org; Thu, 07 Nov 2013 00:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751740Ab3KFXpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 18:45:50 -0500
Received: from mail-pb0-f50.google.com ([209.85.160.50]:45283 "EHLO
	mail-pb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120Ab3KFXpt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 18:45:49 -0500
Received: by mail-pb0-f50.google.com with SMTP id uo15so221829pbc.37
        for <git@vger.kernel.org>; Wed, 06 Nov 2013 15:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H9nGyigGn/oRcgfhPnrtWX7x+Uogg0oRGBCgsRHpvKA=;
        b=aS4L3W4Y2PcQaBN8c2DhFm752uYHIb8+LnnYxYXTXyfyWEgOJ2JCcJFPvYkmQpPN2x
         BqNXINlGGwv0GL7tim34coibN44XpwKFSkGt+eTXaRI4tLW04cNfOCG8Qv0n7HnttMpe
         /lY+z4NGrxN4HLzdd2JZvxuKIIdzrkJ+QEPks00gaIliiylkndOMgW7CsxlWnIliBLNl
         dvJ/mbP9FWJpe8vmeD0ZLe8A4JHKVbJDw49qW1Jvbm9I/MSZpLWaJLeof8HAcl5npm3t
         tVbPzkCKEy7RZZLlMNzhlCbs1zE58CzZfDxbVNZvuQ2l5F3cVOhKciWlzYnEYdqUYWjX
         P5Mg==
X-Received: by 10.66.178.143 with SMTP id cy15mr6528839pac.105.1383781547642;
        Wed, 06 Nov 2013 15:45:47 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id qw8sm606231pbb.27.2013.11.06.15.45.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Nov 2013 15:45:47 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <vpq1u2tb3px.fsf@anie.imag.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237384>

Matthieu Moy wrote:
> Junio C Hamano <gitster@pobox.com> writes:

>> Specifically:
>>
>>>> +   "When push.default is set to 'matching', git will push all local branches\n"
>>>> +   "to the remote branches with the same (matching) name.
>>
>> invites those who do not read documentation to mistake it with using
>> an explicit "refs/heads/*:refs/heads/*" refspec.
>
> Yes, but those who want to know the exact behavior should read the doc.
> That's life.

Surely we can do better?

For example:

	When push.default is set to 'matching', git will push local branches
	to remote branches that already exist with the same (matching) name.

>>>> +   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
>>>> +   "branch to the same remote branch used by git pull.   A push will\n"
>>>> +   "only succeed if the remote and local branches have the same name.\n"
>>
>> while you can see that it is not telling a lie if you read it twice,
>> "will only succeed if" feels somewhat roundabout.
>>
>> 	... push only the current branch back to the branch of the
>> 	same name, but only if 'git pull' is set to pull from that
>> 	branch. Otherwise the push will fail.
>>
>> might be an improvement, but I dunno.
>
> I do not see much difference actually. I tend to prefer the original
> version: to me the expected behavior is to make push and pull
> essentially symetrical, and the fact that it fails if the branch is
> named differently is a safety feature comming on top of that.

Perhaps:

	In Git 2.0 (or now, if push.default is set to 'simple'), git will behave
	more conservatively by pushing only the current branch to the corresponding
	remote branch used by "git pull", and only if the remote and local branches
	have the same name.

Except that forgets the exception having to do with triangular
workflows.  So maybe:

	In Git 2.0, git will default to a more conservative 'simple' behavior
	that only pushes the current branch.

Hope that helps,
Jonathan
