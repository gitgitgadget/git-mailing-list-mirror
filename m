From: Elijah Newren <newren@gmail.com>
Subject: Re: git fast-export issue -- anyone know if this is a bug or a 
	feature?
Date: Mon, 9 Feb 2009 07:15:21 -0700
Message-ID: <51419b2c0902090615q55126245k5d8962ebca5894c3@mail.gmail.com>
References: <51419b2c0902082131o512e966l1fb3029c7513b02e@mail.gmail.com>
	 <alpine.DEB.1.00.0902091216220.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 09 15:17:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWWwh-0003qh-RS
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 15:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756684AbZBIOP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 09:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756322AbZBIOPZ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 09:15:25 -0500
Received: from yx-out-1718.google.com ([74.125.44.156]:26420 "EHLO
	yx-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251AbZBIOPY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 09:15:24 -0500
Received: by yx-out-1718.google.com with SMTP id 4so829408yxp.8
        for <git@vger.kernel.org>; Mon, 09 Feb 2009 06:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=d7AlCbEijHx32jUCSEkaP55x2OoA1KKlGMOk9hBarx4=;
        b=ZVVWNHUm89cLG394gO0/BAHe0di5WZNjJKjUBQYI/8RwEvnr+GbY47UKbeuwjxW/Sq
         POa5EQPYRQUMTX+TeF/8ofwUaxMRbIskJgPyG7+HjOTgqk4ptQXmPhe0I8k/C7CGgHHp
         YDOowrhhky2JrE+FX0lotV8fu0jOX34jg40sk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GC0zbUturTDv73n1nqCXslkRNPr/3IVqbH+3HMuUdnaBOpPFTVFTLE/a2K1Wwe+o7K
         3KrO25HzFwX4AINkmkue4gGfWjUEBkEKSdoLpSIrj4x/KwxCgQfxRALmRSyVEnQ3JYlz
         DSORBZ0NEqScwSVdaVhgILlNw0QvGzaEHBFJo=
Received: by 10.150.198.20 with SMTP id v20mr815352ybf.8.1234188921543; Mon, 
	09 Feb 2009 06:15:21 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0902091216220.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109075>

On Mon, Feb 9, 2009 at 4:17 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sun, 8 Feb 2009, Elijah Newren wrote:
>
>> In the source repository, I noticed that 6 of the earliest commits in
>> one root of history looked like:
>>
>>      /--E
>>     /  /
>> A--C--D
>>   /
>>  B
>>
>> In the "mirrored" repository, I notice this history had been modified
>> so that it looked like
>>
>>         E
>>        /
>> A--C--D
>>   /
>>  B
>>
>> The latter history seems much more sane to me; since D is a child of
>> C, making E a merge of C and D seemed really weird.  I did pour over
>> the output of git fast-export --all to see if the merge directives
>> were as expected, in order to see whether git fast-export or git
>> fast-import were to be credited with the history fix.  It looks to me
>> like git-fast-export reports no merge parents for E, so this seems to
>> be on the fast-export side.
>>
>> Is this, by chance, intentional?  (I'm using git-1.6.0.6, if it matters.)
>
> Nope.
>
> Please try to make a reproduction recipe (preferably as a patch to t9301);
> it seems that you are half-way there already.

Okay, I'll work on it.  Sadly, making a branch based on commit E and
trying to run using <E> instead of "--all" didn't reproduce the bug,
so it must require some additional things to trigger this issue.  I
think I triggered the same issue on a closely related cvs2git-created
repository that's only about 350M, so at least I have something
smaller to work with.  It may take me a while, but I'll report back
when I've found more.

Elijah
