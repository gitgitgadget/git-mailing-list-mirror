From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 22:43:43 +0200
Message-ID: <81b0412b0910201343r4ff49f9fnbdd9260dcf682416@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
	 <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:43:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LYc-0004r3-OS
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:43:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990AbZJTUnk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 16:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752988AbZJTUnk
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:43:40 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33407 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbZJTUnj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 16:43:39 -0400
Received: by fxm18 with SMTP id 18so6901578fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZyY2NsHvyz2sy5EnoOpvuZUFpj9d5s3RiYgGYUOUvho=;
        b=j7bp1sYZJT4v/5bJEMKJJaL4DveOv0dZv9smtgrzqTTMpm8wF5NLvQzEmj+Uw9CpgE
         HaNo1yucrApOq4oi7gEsMxwHdD9b4TD753S1+HppsnkO+1aH20H9i+nLw1WjhE4vWFlB
         gRWUU18FOIoxS8icHZG4VUZVoui+smtPI4FHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rMgBEMnq6SpEQMW8Ii3adE1y2TPL9iM/Mc330o5Dcto7vB1mpQxP0z6roGhEdc4oqg
         tuWdDPPPLuy4005pOaEmQXSclKQ4+3HfPXeIBNMldtApBXUCsYho8R6wu67c9nvB4FV2
         KJzQVl+b/j0Bz2u6kIeSx/I5hMjAnN2SkAd50=
Received: by 10.204.34.201 with SMTP id m9mr7031018bkd.77.1256071423503; Tue, 
	20 Oct 2009 13:43:43 -0700 (PDT)
In-Reply-To: <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130845>

On Tue, Oct 20, 2009 at 22:30, Eugene Sajine <euguess@gmail.com> wrote:
> One of my friends said that git is not working for their development
> model... C++ development with static linking across the board, where
> they need to see exactly which version of the file has got to the
> executable. Roughly, they are using CVS' keywords and revision number=
s
> and a script wich matches them between two versions of the
> executables.

As soon as your friend understand, that a commit describes the complete
state of the repository on the moment of commit, he/she will notice tha=
t
the commit allows to find each what content each file in the product
had at the moment of compilation and linking (assuming they weren't
compiling uncommitted tree, which RCS/CVS/SVN/Perforce mindset
tends to encourage).

> I've got curious if Git can support it and how it can be done with
> minimal changes to workflow.

Depends on workflow, I afraid. And I personally wouldn't bother.

>>> # little script or regexp here (don=E2=80=99t have it)
>>>
>>> Does it make sense?
>>
>> Not much. You'll always get a long list of commits which didn't
>> change the damned blob. And you have absolutely no way
>> to find out exactly which of the commits have produced
>> the blob you're looking at (because you decided to do away
>> with the information).
>
> How is that? It seams to me that git log <path> will show only commit=
s
> where <path> was changed/committed? Considering the fact that I've go=
t
> the initial path from the blob, i should get the exact commit history
> (or last commit in my example) for the file(s) (Files if renaming
> occurred without content change).

The blob is present in each commit since it was introduced. Except
when your project contains only that one blob, isn't the state of
the other parts of an interest?
