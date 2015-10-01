From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Convenient shortcut to push delete current branch?
Date: Thu, 1 Oct 2015 13:37:13 -0500
Message-ID: <CAHd499C7r+Xd1+4Sn5WdXrEHv5yp0=jbnMUvLBHHJ-1s1sJ4gQ@mail.gmail.com>
References: <CAHd499C3n8DGuhxwajQbFrH+Fr8zHRA7sVjhG3yfSD5kKPSZsA@mail.gmail.com>
	<CA+P7+xpWXoNiK67xCepoChr8rqX-Z5EcNb-Bs3xhC+Uot2ruYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 01 20:37:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhijK-0002y7-Sz
	for gcvg-git-2@plane.gmane.org; Thu, 01 Oct 2015 20:37:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015AbbJAShP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 14:37:15 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:37606 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750923AbbJAShO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 14:37:14 -0400
Received: by igbni9 with SMTP id ni9so1164383igb.0
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lrJ8mAXe2UhZb8HmyIKV0Y2+vSLMfy5TcyDwomYFEA8=;
        b=QiMowaCQR4lveRAShXblhdSGmzO6a8YB18D0MiKpKC+4abCKcb/gfPOiW4ieolIMrv
         tZzlsbyFFCzQEwJzTmiyt61fSpi2EyiIMaUsFI+xUJ9h99EGusvHlqhcnB3tNOq8qBTw
         Ira3OxZHDlkhLpd26K4A61My1aUneWB57+PVx0bZq9ZF0ik2vI7V+Ixk7ZOJyXo3UdxX
         ZGjiuTSBFo0Vk3piWruAOJ7NdgjgWRXXELAG/++n0LdftRkwHfLaFseljnxRYwSamSxC
         A2VliFCVigxDsS5d+WvU+99ftFDn+T/0e8MEVHDx3L4QURCtuypBALLca//+4BxnH6Zp
         brMg==
X-Received: by 10.50.136.129 with SMTP id qa1mr326446igb.91.1443724633904;
 Thu, 01 Oct 2015 11:37:13 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.83.147 with HTTP; Thu, 1 Oct 2015 11:37:13 -0700 (PDT)
In-Reply-To: <CA+P7+xpWXoNiK67xCepoChr8rqX-Z5EcNb-Bs3xhC+Uot2ruYg@mail.gmail.com>
X-Google-Sender-Auth: fRDy6wKZ2MJRTV-Epj_6EGaTlbo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278899>

On Thu, Oct 1, 2015 at 1:22 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Oct 1, 2015 at 9:43 AM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>> For convenient pushing of current branch, git supports this syntax:
>>
>> $ git push origin HEAD
>>
>> This will push your current branch up. However, is there such a
>> shortcut for *deleting* the branch? The only goal here is to avoid
>> having to type the branch name in the push command. Normally I rely on
>> tab completion but we have tons of branches, all which start with some
>> prefix mixed with numbers, so it becomes cumbersome to rely on tab
>> completion. Ideally I'd like to be able to do:
>>
>> $ git push --delete origin HEAD
>> $ git push origin :HEAD
>>
>> Is there a syntax like this available?
>
> You can do
>
> git push origin:<branchname>
>
> but I don't believe HEAD is supported. It might be valuable to extend
> push to have a --delete option which would maybe be useful for those
> who didn't learn the full refspec syntax.

Push already has a --delete option.

> I don't think git push origin :HEAD makes too much sense, since that's
> on the remote side of a refspec, and you want it interpreted
> locally... I suppose it makes sense somewhat, but other refspecs with
> HEAD on the remote side of the refspec don't really make sense, where
> as HEAD always makes sense on the local side of the refspec.

HEAD makes sense on the remote side if you think of it like an alias:

HEAD -> branch-name -> SHA1

HEAD simply points to branch-name. It makes sense for git to assume
that we should never do anything with real HEAD ref on the remote
side, and instead treat it as a substitution for the remote name. My
assumption may not be correct, but at the very least it should be a
niche case.
