From: Steven Michalske <smichalske@gmail.com>
Subject: Re: [RFD] Rewriting safety - warn before/when rewriting published history
Date: Sat, 7 Apr 2012 23:01:31 +0800
Message-ID: <6C977F5E-0C26-4165-AF2E-C032FA64F78B@gmail.com>
References: <201202042045.54114.jnareb@gmail.com> <201202071531.08385.jnareb@gmail.com> <CALKQrge821x7OoSekkWw7vUjP642jhbE0D9oWPcCxuuTXOqQHA@mail.gmail.com> <201202102038.55710.jnareb@gmail.com> <CALKQrgdWOgG3y2HzM694zDykGJWa4QDetsEVXf0AGpf=FNFaVg@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jakub Narebski <jnareb@gmail.com>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 17:01:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGX98-0002WO-Gn
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 17:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab2DGPBl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 11:01:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:65177 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753096Ab2DGPBk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Apr 2012 11:01:40 -0400
Received: by obbtb18 with SMTP id tb18so4185588obb.19
        for <git@vger.kernel.org>; Sat, 07 Apr 2012 08:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=jFIZkEehgOmbwUwj26y+W0QV9immbo1sGdwL967vxwU=;
        b=HIxkhrK+dHFLw0s0ZA+UcfPtkaZoFNprHsk2xhz90Qu9c2mx+ssuedaoJ1qOAzhb4c
         SgbECVErM5UsUqbk8I1P/XpvYVvIPxIScPG8irSNN1AvmC1TUS/7MJnl3XK/BGzU7mT+
         itXIqLUOSQAI72hfFbUBhYjHBFbqG7AGiQ5oUyL+mlkB4kGfz3rjrSrDCdxYzyibq06K
         izTn+9Vr52zsS0x9yDFSQ/HyzEm3ac5OWF6c3qTRAeuQiUWfQHDHTXazPjanQH0YvGn7
         RD515tDRj0GbZ7/gpcozG3CF4let34x+N+BhTpPmZVUrJEcKGGGyVee8b0LqduqfwZON
         9p7Q==
Received: by 10.182.8.37 with SMTP id o5mr2244787oba.28.1333810899991;
        Sat, 07 Apr 2012 08:01:39 -0700 (PDT)
Received: from [10.0.1.2] ([222.66.106.162])
        by mx.google.com with ESMTPS id hh2sm2931310obb.1.2012.04.07.08.01.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 Apr 2012 08:01:39 -0700 (PDT)
In-Reply-To: <CALKQrgdWOgG3y2HzM694zDykGJWa4QDetsEVXf0AGpf=FNFaVg@mail.gmail.com>
X-Mailer: Apple Mail (2.1251.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194954>


On Feb 11, 2012, at 9:10 PM, Johan Herland wrote:

> On Fri, Feb 10, 2012 at 20:38, Jakub Narebski <jnareb@gmail.com> wrote:
>> On Tue, 7 Feb 2012, Johan Herland wrote:
>>> On Tue, Feb 7, 2012 at 15:31, Jakub Narebski <jnareb@gmail.com> wrote:
>>> I am unsure whether the 'secret'-ness of a commit should follow across
>>> the push, but if you do (assuming we store the 'secret' flag using
>>> git-notes) this is simply a matter of synchronizing the
>>> refs/notes/secret to the same remote.
>> 
>> I think it should, so that 'secret' commit would not escape by accident
>> via a group secret repository.
>> 
>> What makes it hard (I think) is that we would prefer to transfer
>> 'secret'-ness only for pushed commits.  That might be problem for notes
>> based implementation of 'secret' annotation and 'secret'-ness transfer...
>> though I guess knowing that there exist 'secret' commit with given SHA1
>> which we do not have and should not have is not much breach of
>> confidentiality.  Still...
> 
> If you don't want to transfer all of refs/notes/secret, you would
> probably have to extend the git protocol with a per-commit 'secret'
> flag (which would then be applied to the receiving repo's
> refs/notes/secret).

Implementing these as bi-directional transfer of flag attributes might be a good working concept.
This way we could implement the public flag and later add the secret flag, and later add the foo flag.

I say bidirectional because if Tom and mary are working on a group project.  Mary publishes a commit to the public repo.
When Tom pulls from Mary he should get the update for the flags that Mary published.  If Mary pushes to Tom's repo it should update Tom's flags as well.

> 
> Still, this is all specific to the 'secret' feature, which IMHO is
> much less important then the 'public' feature. Implementing the
> barebones 'public' feature (i.e. refuse rewrite of commits reachable
> from upstream) is much less work, and would be enough for 90% of git
> users, I believe.
> 
> 

There are two kinds of pushes.  Those to public facing repositories and those to a private working repository.  Like a build bot repo.  Pushes to that repo might not want to mark a commit as public.

Steve





> ...Johan
> 
> -- 
> Johan Herland, <johan@herland.net>
> www.herland.net
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
