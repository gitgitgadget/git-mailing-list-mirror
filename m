From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Bug with rev-list --reverse?
Date: Thu, 18 Apr 2013 06:15:36 -0500
Message-ID: <CAMP44s1np9vxZS6N2+w-K=zzRhq4x2+eFBzu-HJMeoNjk7ze-Q@mail.gmail.com>
References: <CAMP44s25mUA1M+K+YKaC=bz3Dr7kSDyXK5g2ot8i+1EPy8zRhA@mail.gmail.com>
	<20130418102644.GY2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Apr 18 13:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USmof-0002p0-Kf
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 13:15:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966815Ab3DRLPj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 07:15:39 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:33243 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965997Ab3DRLPh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 07:15:37 -0400
Received: by mail-la0-f53.google.com with SMTP id fp13so2379798lab.26
        for <git@vger.kernel.org>; Thu, 18 Apr 2013 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=uYx803ddUJnWoJFSif+rRPDFZ3OUF8qIq/ezOgXb0zQ=;
        b=nFXtvvJOQqGseo4FzX+idUA3pQQ8ZjmcW5qKKPIaSmRvfUMpVo7sT1QjIKWub6ZTJJ
         tuZX9mS+rq+N1rCN5+zlZCmWnztOrI4V3LZBZFucNtbEQzuGhOzyA7s0un6BCz15BkBN
         ccnfMa4waqiF/CjNjKWNCqyZAaG0FIY9jHH/1AdGebbZdDhQlVLT2yxfA/Psi4k6Wg7E
         6qwfOUMV+UGe7CzRrC2rKGlgE804iDFwk+oaPjXRH6GJgMI3TZT6HUFJYcHajkfEIUMO
         2iwsk7rAUBXv271s6uwZ6dUZ1WqI6n83S0HxphWkreVGHRdR/ea+oJKkg5IMPghWj/mc
         +VUA==
X-Received: by 10.112.156.102 with SMTP id wd6mr5677680lbb.82.1366283736277;
 Thu, 18 Apr 2013 04:15:36 -0700 (PDT)
Received: by 10.114.59.210 with HTTP; Thu, 18 Apr 2013 04:15:36 -0700 (PDT)
In-Reply-To: <20130418102644.GY2278@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221649>

On Thu, Apr 18, 2013 at 5:26 AM, John Keeping <john@keeping.me.uk> wrote:
> On Thu, Apr 18, 2013 at 05:17:14AM -0500, Felipe Contreras wrote:
>> If I do these:
>>
>> % git log --oneline -1 v1.8.1.5^..v1.8.1.6
>> % git log --oneline --reverse -1 v1.8.1.5^..v1.8.1.6
>>
>> I expect to get a different output, and not both showing v1.8.1.6.
>> Wouldn't you agree?
>
> I expect to get the same output.  This is probably because I consider
> --reverse to be an output filter.  So I expect to show the commits
> "v1.8.1.5^..v1.8.1.6 -1" which selects a single commit and then show
> that in reverse order.

How about this:

% git log --oneline --reverse --max-count=1 v1.8.1.5^..v1.8.1.6

In this case --max-count is acting as "start from the first commit
before the tip", not as "output a maximum of one commit". Given that
the name is max-count, I expect it to be the later.

And if max-count doesn't select a maximum of n commits, then what does?

-- 
Felipe Contreras
