From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Random thoughts on "upstream"
Date: Thu, 16 May 2013 18:03:55 -0500
Message-ID: <CAMP44s2t3+yBQMj9uSd_=3w0CgeJsHeAQM051j7Xt+SqVthvzQ@mail.gmail.com>
References: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 17 01:04:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud7DM-00043s-Tm
	for gcvg-git-2@plane.gmane.org; Fri, 17 May 2013 01:04:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754691Ab3EPXD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 19:03:57 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:55736 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473Ab3EPXD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 19:03:56 -0400
Received: by mail-la0-f49.google.com with SMTP id fp13so2917383lab.8
        for <git@vger.kernel.org>; Thu, 16 May 2013 16:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=rPOsaMDlfEK7owbBCiN14iPATd5hYehmn1UNGASJjvA=;
        b=fblgEe08crfRV4TyF4Z6AFgwUhyWxkY1VQeNI3xCI8MS2trMnc7mT11k9fiO00fVxx
         1t16+60Q2ahx4dH4eQoacIW7L9G0zD2/nK+vhtzS/6hnDfKDDceh2svqC827qixjq8Jd
         ecHtYjH6me9qHyg51KndLdvAg3ZA+RZSLO47LDAF+g5LORUEwiEASiuqInOGVIZch/MX
         u0N6wSjR6sZObToYjEw05jGHmy8gTyu49S8tnmUu222MG9ANkI4AwipnfIhlCOOun66a
         jmqpK9zQ4mHrhphl4y2Jl8DO70mTGSgnWWGNg62Afs6FVSdHSLWG7KSCKIAKs3LSriT0
         XP6g==
X-Received: by 10.112.63.169 with SMTP id h9mr6229829lbs.135.1368745435099;
 Thu, 16 May 2013 16:03:55 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 16 May 2013 16:03:55 -0700 (PDT)
In-Reply-To: <7vobca6c7r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224626>

On Thu, May 16, 2013 at 12:55 PM, Junio C Hamano <gitster@pobox.com> wrote:

> The value "upstream" for push.default does not make sense in the
> context of a triangular workflow, as you may well base your work on
> 'master' from the upstream, which is a branch with a very generic
> purpose (e.g. "to advance the state of the overall project"), but
> your work may have a more specific purpose (e.g. "to improve frotz
> feature") that deserves to be on a branch named after that specific
> purpose in the repository you publish your work on.  That is, after
> working on your 'frotz' branch this way:
>
>     git checkout -t -b frotz origin/master
>     work work work, commit commit commit

If the user has branch.autosetupmerge=always, that's not correct; even doing:

% git checkout -b frotz origin/master

Would setup the upstream. And I believe for v2.0 we do want
branch.autosetupmerge=always, but we might not want to always override
the push location.

> Now I have a curious value "single" in the above configuration that
> is not understood by current Git.  It is to trigger a new rule to
> modify the way remote.publish.push refspec is used:
>
>     When on branch 'frotz', where pushremote_get() would return
>     'publish', find where refs/heads/frotz would be pushed with the
>     refspec for that remote (i.e. refs/heads/*:refs/heads/topics/*
>     maps refs/heads/frotz to refs/heads/topics/frotz) and push only
>     that, i.e. update refs/heads/topics/frotz over there with the
>     tip of 'frotz' we are pushing.
>
> That may be a solution for those who do not find 'current' good
> enough.

What happens if I want to push to 'refs/heads/topics/frotz-for-juno'?

-- 
Felipe Contreras
