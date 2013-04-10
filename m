From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [ITCH] Specify refspec without remote
Date: Thu, 11 Apr 2013 01:01:33 +0530
Message-ID: <CALkWK0nKvTiGsjO4zF81nsSuUM=MmmbpdzHWB=4hFR2PiB+LWg@mail.gmail.com>
References: <CALkWK0=siuUW1ex0muy+efwQOAwHf3uorFHWPo5sjMss08ywiw@mail.gmail.com>
 <7vip3vsi19.fsf@alter.siamese.dyndns.org> <CALkWK0nqZ+GGvDhR=OPOz+NtYKXz7waQrxvCi-spAJ46pL=YKA@mail.gmail.com>
 <7vhajfqz8r.fsf@alter.siamese.dyndns.org> <20130409231332.GZ30308@google.com>
 <7vobdnnpx6.fsf@alter.siamese.dyndns.org> <20130410041343.GB795@sigill.intra.peff.net>
 <7v4nfenxzm.fsf@alter.siamese.dyndns.org> <20130410172748.GA16908@sigill.intra.peff.net>
 <7vhajemd1x.fsf@alter.siamese.dyndns.org> <20130410185958.GA22394@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?UTF-8?B?RHV5IE5ndXnhu4Vu?= <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 21:32:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ0kl-0007bR-Fk
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 21:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761894Ab3DJTcP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 15:32:15 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:62145 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182Ab3DJTcO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 15:32:14 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so1063709ieb.34
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 12:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=O1DfvWoeUADtMRYlWOKpwj9xl+jibBHw0tJ5a9/djuc=;
        b=RfMa9+naZN2hNcMTZwX4cSWIK6xBuNx+KuXBGlsy/7HC8Cv048W0qMiNvIiWOaCGs1
         xBKn9kPtrJ7tR4F1SUF0vwr1pyEZQ9Y9eXFNewGVsDV8LoGyeJCK6QyliDx9qvkfpwj+
         Q0CowqX3T5znDuGMEViXHf7pgDE+5QrR9w7JVOVQpa80g4z+ZIjZdlTpZEYXEXJ/ya4g
         2wOE6ZZdf1bLYDRrzR/sTwV5RO9hPbQyEQA09Cil8q96KuajdAo8b87n6+aSDsEuJR0Z
         eyslf2/KGhNH6FitlaRIBB+YF3IByC+NzGm90oRnMKBbfo90TsHm+XcLEXio3dxi85YY
         nUjg==
X-Received: by 10.50.17.166 with SMTP id p6mr14147526igd.12.1365622333783;
 Wed, 10 Apr 2013 12:32:13 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Wed, 10 Apr 2013 12:31:33 -0700 (PDT)
In-Reply-To: <20130410185958.GA22394@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220733>

Jeff King wrote:
> On Wed, Apr 10, 2013 at 11:54:34AM -0700, Junio C Hamano wrote:
>> > If branch.$name.remote is "when I am on this branch, I want to talk to
>> > this remote", that rule is not be impacted by the presence of refspecs
>> > at all.
>>
>> So running the above while on 'maint' will send master and next to
>> the remote your "git push" would send to when run without any
>> refspecs?
>
> Exactly. The remote selection is orthogonal to the refspecs provided,
> and only cares about which branch you are on.
>
> Which is still kind of weird, because why should the branch you are on
> affect the default push location? But that is how default "matching" has
> always behaved, and we would remain consistent with that.

git push -- master next; pushes to my current branch's
branch.<name>.pushremote?  Isn't that a disaster?

>> That is internally consistent and understandable, and I have no
>> objection to it.  Certainly much better than basing the decision on
>> branch.{master,next}.remote as I thought you were suggesting to do.
>
> No, I am not suggesting that. I can see how such a command might be
> useful (i.e. "push master to where it goes, next to where it goes",
> where "goes" is defined by the upstream config). But that is not
> remotely close to how "git push" works now, and would be inconsistent
> with the other modes (e.g., matching, explicit refspecs, pushing
> non-branches, etc).

Otherwise, I think we're consistent.  git push master; pushes the
refspec master (with no explicit :<dst> counterpart) to the "default
place to push to" (either depending on which branch I am, or global).
I think Junio was mixing up refspecs with refs (branches, and hence
branch configuration) earlier.  git push origin; pushes to "default
refspecs" on the remote origin.  By extension, git push; should push
"default respecs" to the "default place to push to".  The "default
refspecs" in this context is determined by push.default, which is the
problem.
