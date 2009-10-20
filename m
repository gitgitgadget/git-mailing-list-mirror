From: Eugene Sajine <euguess@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 16:30:27 -0400
Message-ID: <76c5b8580910201330r45cf625k3a41b5b9e24b3e01@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
	 <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 22:30:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0LLk-0006Qy-Sl
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 22:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752777AbZJTUaX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752755AbZJTUaX
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 16:30:23 -0400
Received: from mail-yx0-f187.google.com ([209.85.210.187]:54923 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbZJTUaW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 16:30:22 -0400
Received: by yxe17 with SMTP id 17so5361684yxe.33
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 13:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=64lcfjQ6/vYVJpkXfVyqSTAHugj9B3Jt7QlrqjFKiS0=;
        b=tMZtwoCl3dsQewN7Qj6hqLg37a75LTOagiq7SfEaGK9ly3n9noFwqxfQFLX7dpB4Z0
         VfDmAmGGLOIXOkhXnfNSbUMAs5QxQmDd2cPZMc+jslzO5Rh3B+6Gd/kxUh9Gxzni/q1j
         ci8+BizLcg7bK1rMWuNS5iRek4QS98pnAGCak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nb3VQIzRlBrz1OK1VuNy+A+8wrrw7wFuWoKyFRZ/UGCzY3UxWKHeO1gPudZ2LiaUEb
         ivjNR6Tzg+qW8KxM6bjjK0/aCjQEOuFmGmz9Lkgg9utM5m4Wneu4VQ79qnH33s4oiIzE
         nTjRMTVBbVcxI/ia4ozO/SmDpB9r3mP26N2AU=
Received: by 10.90.246.1 with SMTP id t1mr7337401agh.96.1256070627238; Tue, 20 
	Oct 2009 13:30:27 -0700 (PDT)
In-Reply-To: <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130837>

=46irst, thank you for your answers!

>
> Very likely it isn't, but it's your choice.

;)

>
>> Because after having this hash one can build up all necessary info f=
rom it:
>
> Depending on your definition of "necessary".

I'm trying to find a way to get to state where i can do

$ git log <path>

Or any other variants of it without introducing any non-default
scripts/features/keywords and limiting keywords to one to avoid any
related problem...

One of my friends said that git is not working for their development
model... C++ development with static linking across the board, where
they need to see exactly which version of the file has got to the
executable. Roughly, they are using CVS' keywords and revision numbers
and a script wich matches them between two versions of the
executables.

I've got curious if Git can support it and how it can be done with
minimal changes to workflow.

>
>> #finding blobs with SHA indicated in $Id$ keword
>> $ git log --no-abbrev --raw --all | grep SHA-1
>
> yeah. These are all starting from commit which introduced
> the hash under a specific path, ending at the commit where
> the path contains another SHA-1.

Actually, grep "SHA-1 A" will show added path(s) only, so this is resol=
ved

>
>> # little script or regexp here (don=E2=80=99t have it)
>> $ pull out path from result
>>
>> # last commit for the path with all corresponding info
>> $ git log -1 HEAD path
>>
>> So, this seems to cover most of the needs of people who would like t=
o
>> use keywords expansion, if they are not ready to forget about them=E2=
=80=A6
>>
>> Does it make sense?
>
> Not much. You'll always get a long list of commits which didn't
> change the damned blob. And you have absolutely no way
> to find out exactly which of the commits have produced
> the blob you're looking at (because you decided to do away
> with the information).

How is that? It seams to me that git log <path> will show only commits
where <path> was changed/committed? Considering the fact that I've got
the initial path from the blob, i should get the exact commit history
(or last commit in my example) for the file(s) (Files if renaming
occurred without content change).

Thanks,
Eugene
