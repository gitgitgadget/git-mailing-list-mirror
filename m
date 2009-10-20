From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: ident hash usage question
Date: Tue, 20 Oct 2009 21:19:47 +0200
Message-ID: <81b0412b0910201219q4d16c472n43cab4b5d17cf63c@mail.gmail.com>
References: <76c5b8580910201024x58ffdd3bs6f4cc6932ac31868@mail.gmail.com>
	 <81b0412b0910201116s694d7877rda872b368f1ae09a@mail.gmail.com>
	 <81b0412b0910201119w7583487ag276cf964d0a85e@mail.gmail.com>
	 <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 20 21:19:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0KFO-00033Y-Ch
	for gcvg-git-2@lo.gmane.org; Tue, 20 Oct 2009 21:19:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751992AbZJTTTo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Oct 2009 15:19:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751964AbZJTTTo
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 15:19:44 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:45829 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751733AbZJTTTn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Oct 2009 15:19:43 -0400
Received: by fxm18 with SMTP id 18so6810061fxm.37
        for <git@vger.kernel.org>; Tue, 20 Oct 2009 12:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BnSNPFhDnT+4u6f7Box7quf9LggHklkU51x44hyovL4=;
        b=oGVY2zjdVetRAcAs0UGiwhKhnvrauqDuaeamfmEUe24mHh/CQ18K6FlGojEvFpRzrd
         sObUumxi/kMPK/gZb3fgHRNme+SRSFAwYNvZLJiRUQNQxEXuQykW4ieoJF7ORSWalmkF
         3/tZDkx9mg3cphdbdBHP/T4jc4QZbBByF+qyc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Avlh7uOxrHYcFWBoKevIHQI0e06UBkz7NiTtHBJU2lYiJcmZdx7OatNI3bmGvJVWIa
         hx6A5xzz4UaqLfX1bQ23ETgUrW2WBdKskvUEXkclRDeCxthBfXMIMgMIAOt0uncb6+vs
         TzrSQRLN6uE2SdluKH5Pbb/RGxdZvWdd3XhSc=
Received: by 10.204.25.72 with SMTP id y8mr3141676bkb.129.1256066387188; Tue, 
	20 Oct 2009 12:19:47 -0700 (PDT)
In-Reply-To: <76c5b8580910201159i75a90f28pb882e83f0c7c40ae@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130828>

On Tue, Oct 20, 2009 at 20:59, Eugene Sajine <euguess@gmail.com> wrote:
>>
>> Well, not exactly impossible, but you can end up with multiple paths=
,
>> some of which may not have anything to do the original path.
>>
>> Just run git log --no-abbrev --raw --all and grep for the SHA-1
>
> This is exactly what I was looking for! Thank you!
>

Very likely it isn't, but it's your choice.

> Because after having this hash one can build up all necessary info fr=
om it:

Depending on your definition of "necessary".

> #finding blobs with SHA indicated in $Id$ keword
> $ git log --no-abbrev --raw --all | grep SHA-1

yeah. These are all starting from commit which introduced
the hash under a specific path, ending at the commit where
the path contains another SHA-1.

> # little script or regexp here (don=E2=80=99t have it)
> $ pull out path from result
>
> # last commit for the path with all corresponding info
> $ git log -1 HEAD path
>
> So, this seems to cover most of the needs of people who would like to
> use keywords expansion, if they are not ready to forget about them=E2=
=80=A6
>
> Does it make sense?

Not much. You'll always get a long list of commits which didn't
change the damned blob. And you have absolutely no way
to find out exactly which of the commits have produced
the blob you're looking at (because you decided to do away
with the information).

What's so hard with storing the SHA-1 of the *commit*, anyway?
