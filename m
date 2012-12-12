From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] completion: add option --recurse-submodules to "git push"
Date: Wed, 12 Dec 2012 16:30:40 -0600
Message-ID: <CAMP44s2GYoR1fM-jEj9inO58ATgix5FuZouqZg2+tU47BOaTew@mail.gmail.com>
References: <1354883304-6860-1-git-send-email-steffen.jaeckel@stzedn.de>
	<7vehj1ixr6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steffen Jaeckel <steffen.jaeckel@stzedn.de>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:31:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiupN-0003md-Nz
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:30:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755561Ab2LLWal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:30:41 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:38411 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755329Ab2LLWak (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:30:40 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1381206oag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 14:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DnX32Hr7E/9vjljI2wYe8yyJEwdBdAMeJ+yxuXnRkqA=;
        b=SyTteJnGrXp1R/fXVnkCDQInD73C5iMj/OVwWkOOYbrilWyIu5a4U7UOSv6QU2f+u5
         ABdKBjCNv0RAglIBR9Q3YpWr5FFwQnSm2plNuHwe7rG6Q29/IsF/o8zUNO0SuAe8Eodz
         fjhyaGViLSTc5cW+OwaW01cALOUj/TfZOZ2CIUTC0XFUI4Oabms5ST183oGKhDNOYgFV
         DREMi5zXfiFgxGQ7Iw0SnG79VJmddkEB7iMTbSmwccTgBUY+zZE2jTLniGvl8pOkzyto
         h4ZosMs2x9RR7NMsm2iQjKPPbdunD0Lweiw6pVOOzYDBL4HRlDuVdhnVnLIFvYs4aVND
         5cMw==
Received: by 10.182.111.104 with SMTP id ih8mr1384677obb.13.1355351440063;
 Wed, 12 Dec 2012 14:30:40 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 12 Dec 2012 14:30:40 -0800 (PST)
In-Reply-To: <7vehj1ixr6.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211401>

On Fri, Dec 7, 2012 at 11:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Steffen Jaeckel <steffen.jaeckel@stzedn.de> writes:
>
>> Signed-off-by: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
>> ---
>>  contrib/completion/git-completion.bash | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index 0b77eb1..5b4d2e1 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1434,6 +1434,10 @@ _git_pull ()
>>       __git_complete_remote_or_refspec
>>  }
>>
>> +__git_push_recurse_submodules_options="
>> +     check on-demand
>> +"
>
> Most of the existing completion functions do not seem to define
> separate variables like this; instead, they literally embed their
> choices at the point of use.
>
> Is it expected that the same set of choices will appear in the
> completion of many other subcommand options?  [jc: Cc'ed Heiko so
> that we can sanity check the answer to this question].  If so, the
> variable may be justified; otherwise, not.
>
>>  _git_push ()
>>  {
>>       case "$prev" in
>> @@ -1446,10 +1450,15 @@ _git_push ()
>>               __gitcomp_nl "$(__git_remotes)" "" "${cur##--repo=}"
>>               return
>>               ;;
>> +     --recurse-submodules=*)
>> +             __gitcomp "$__git_push_recurse_submodules_options" "" "${cur##--recurse-submodules=}"
>> +             return
>> +             ;;
>
> Owners of the completion script, does this look reasonable?
> [jc: Cc'ed Felipe for this]
>
> This is a tangent, but why is it a double-hash "##" not a
> single-hash "#", other than "because all others use ##"?

Seems OK by me, but I agree, the options should be inline.

-- 
Felipe Contreras
