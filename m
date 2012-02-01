From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Rebase regression in v1.7.9?
Date: Wed, 1 Feb 2012 21:30:41 +0200
Message-ID: <CAMP44s12Q3BdXzgr_m2Z0EpApiexngYoWgLi6NRONfCtr1zHKQ@mail.gmail.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
	<4F29761E.1030605@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 20:30:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsftI-0007V9-EE
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 20:30:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755678Ab2BATan (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 14:30:43 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:45773 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755551Ab2BATan (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 14:30:43 -0500
Received: by lagu2 with SMTP id u2so853543lag.19
        for <git@vger.kernel.org>; Wed, 01 Feb 2012 11:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D5qah3iI+IkNPhELaeVfrKL9m3qqZAI0fpV/pft4X8k=;
        b=tKdasrGSrNi2OX9aeVwdfEjTggjANGAkEc4g42qCny2T1vEzUOfUc9ff4JQT42trAl
         EpBI3lZfpTrKumv4kGh/f3JBzn1OJD1DTIj+a8+Yy12+ITtVVjLHwIqK5C8UHZZ2hPUU
         SzLJujseDca2AtA40yjez1xcuW9oI8ajvh2/4=
Received: by 10.112.25.106 with SMTP id b10mr2162391lbg.102.1328124641687;
 Wed, 01 Feb 2012 11:30:41 -0800 (PST)
Received: by 10.112.40.202 with HTTP; Wed, 1 Feb 2012 11:30:41 -0800 (PST)
In-Reply-To: <4F29761E.1030605@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189531>

On Wed, Feb 1, 2012 at 7:27 PM, Andrew Wong <andrew.w@sohovfx.com> wrote:
> On 01/31/2012 05:56 PM, Felipe Contreras wrote:
>> The rebase will finish, but there will be a .git/CHERRY_PICK_HEAD file.
>>
> Ah, good catch. I can reproduce the issue. This is only happening in
> "rebase -i" because interactive rebase relies on cherry-pick, but not
> regular rebase. And now cherry-pick creates a state when there's a
> conflict (since 1.7.5?), which "rebase -i" didn't expect before. We
> probably just need to do a manual clean up before "rebase -i" continues.
>
> I'll try to come up with a patch for this. In the mean time, doing a
> "git reset" will remove that dangling file. Of course, you could always
> manually remove it. Does the dangling file cause a subsequent git
> command to fail?

No, it's just annoying with the __git_ps1 prompt stuff. Yeah, 'git
reset' solves the problem, but it's much better to type 'git skip'
instead... for now.

-- 
Felipe Contreras
