From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: git-svn with non-standard repository layout
Date: Tue, 11 Dec 2012 16:46:43 +0100
Message-ID: <CAA01CsqJPw9gNfgg5m6YycAsUct1AR=0v=OBj0hAMqLf6ZaKOw@mail.gmail.com>
References: <CAA01CsoS6xA-tGPw81tYmi1ETU8sQ08+oyHGg5ou1VGYrwd_SQ@mail.gmail.com>
	<516524996.289805.1354751683987.JavaMail.root@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git Mailing List <git@vger.kernel.org>,
	Carsten Fuchs <carsten.fuchs@cafu.de>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 16:55:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiSAt-0003fS-8y
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 16:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab2LKPy4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 10:54:56 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:63063 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab2LKPy4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 10:54:56 -0500
Received: by mail-qa0-f53.google.com with SMTP id a19so3055539qad.19
        for <git@vger.kernel.org>; Tue, 11 Dec 2012 07:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UP81Gp83+SAdxLLmTPEfCQJsJLECCx3OywHV2v5pJtE=;
        b=KtVDMQVpc6/jNC6GI8IEhRdMa3rtLVWvT2bIgOgsnG1cySWKxAC14ufwlDLPIK0pOU
         JlKVKdYUSkV02Wa3zOwsXg4ytmn+x8ew2w54uGKE9dSGIXFJicpkbwTmrDYv/fzJE49K
         5Y5jefx61Y8Uo9DsmEsXJz6QXFv68VWO2/xPGFgxzb5Gyj1M9Xm79r7R8uQ/Gf6+rr65
         LnnoCGZiW5DyQVsRfVXDqheGaXs3slHqtn7nI5uPojOUG9QLgqCnQA0f1WFwoi9mxQnJ
         uFpptvgYoZHO07z/bp/fUNq5CD+IdpeCLdoFDlJv0IdDsfqI/JWddg/keXiarGB6dW+k
         EaUA==
Received: by 10.224.176.138 with SMTP id be10mr34479011qab.50.1355240803442;
 Tue, 11 Dec 2012 07:46:43 -0800 (PST)
Received: by 10.49.84.133 with HTTP; Tue, 11 Dec 2012 07:46:43 -0800 (PST)
In-Reply-To: <516524996.289805.1354751683987.JavaMail.root@genarts.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211290>

On Thu, Dec 6, 2012 at 12:54 AM, Stephen Bash <bash@genarts.com> wrote:
> ----- Original Message -----
>> From: "Piotr Krukowiecki" <piotr.krukowiecki@gmail.com>
>> Sent: Wednesday, December 5, 2012 5:19:44 PM
>> Subject: Re: git-svn with non-standard repository layout
>>
>> Do you mean something like
>>
>>    branches = branches/work/*/*:refs/remotes/work/*
>>    branches = branches/{branch1,branch2}:refs/remotes/branches/*
>>
>> instead of (currently used)
>>
>>    branches = branches/work/*/*:refs/remotes/work/*
>>    fetch = branches/branch1:refs/remotes/branches/branch1
>>    fetch = branches/branch2:refs/remotes/branches/branch2
>
> Essentially yes.  But I guess since you have branches at the same level as the work directory,
> you either have to add to the glob for each new branch or add another fetch line...  Doesn't seem
> like a big win to me.  Jumping on a tangent, I thought there could only be one wildcard on the
> left side of the ':' (and the '*' on the right).  If your work/*/* is actually working, that's quite interesting.

At first I though it was working, but it seems it does not. I have
several branches, including:
  remotes/trunk
  remotes/work/user/xxx (based on remotes/trunk)
  master (based on remotes/trunk)
  xxx (based on remotes/work/user/xxx)

If I do 'git svn rebase -l' on xxx, it rebases commits on xxx (i.e.
remotes/trunk..remotes/work/user/xxx)
on top of master, so now xxx is based on master  :(

I don't know if this is git-svn bug, or the problem with 'work/*/*'
pattern, or something else...
I will try explicit branches specification and will see what happens.


--
Piotr Krukowiecki
