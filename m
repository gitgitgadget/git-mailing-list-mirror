From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree as a solution to partial cloning?
Date: Mon, 25 May 2009 11:50:08 -0400
Message-ID: <32541b130905250850h75f905e0t84287f897600187f@mail.gmail.com>
References: <8873ae500905250021p20e7096dwf5bc71c36c4047b@mail.gmail.com> 
	<32541b130905250059n7b31cc1bk688e5f4bfaf83142@mail.gmail.com> 
	<8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alexander Gavrilov <angavrilov@gmail.com>
To: Asger Ottar Alstrup <asger@area9.dk>
X-From: git-owner@vger.kernel.org Mon May 25 17:50:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8cRx-0006eq-44
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 17:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbZEYPu3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 11:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752148AbZEYPu2
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 11:50:28 -0400
Received: from yw-out-2324.google.com ([74.125.46.28]:28881 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051AbZEYPu1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 11:50:27 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1895387ywb.1
        for <git@vger.kernel.org>; Mon, 25 May 2009 08:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=lYNIELevhD4RDbBPaOZkngXJ+knGqMGRPrM8ZdBgpkQ=;
        b=bp4FnynOpdRnfz/C/kaf/hrlnpavU9mwOkeXwR5fSPmYEcDNdPKGSBdGBf5LF4jFrr
         FTBOZHIzPAUi6CRO3kJpCLwVpwaFFGspMlZaCF3S6U+w5kJo60iqw6DWLmOf4lao827C
         i3RiQXSHe7PkKiAXfPVD6TKRQ7sFKa1W0Jd84=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=O36tPERdBiOE959tFGUkPdO/A6OdGvsIuskEB10ppflWZl7Jj0rmxluY64/4QSCRT9
         qkV259RSkLS9PdvTSr7cPbJTyeudoHYQCO6uBdtGxU0qVRV5uGdnj13F2+iS8gjDoHef
         6lsDpoGV3FjQqexkxqSIqDhWxnJFQkgCoV1fg=
Received: by 10.151.98.17 with SMTP id a17mr14390645ybm.302.1243266628304; 
	Mon, 25 May 2009 08:50:28 -0700 (PDT)
In-Reply-To: <8873ae500905250233t52dce5b5v8ca88b9921a88437@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119937>

On Mon, May 25, 2009 at 5:33 AM, Asger Ottar Alstrup <asger@area9.dk> w=
rote:
> On Mon, May 25, 2009 at 9:59 AM, Avery Pennarun <apenwarr@gmail.com> =
wrote:
>> On Mon, May 25, 2009 at 3:21 AM, Asger Ottar Alstrup <asger@area9.dk=
> wrote:
>>> Does git subtree support splitting at the file level, or only at di=
rectory
>>> level?
>>
>> Currently only at the directory level. =A0In theory, there's nothing
>> stopping us from working with any subset of files... but it's really
>> much simpler this way (both to code and to explain) so I'd much rath=
er
>> leave it as is. =A0Can you reorganize your tree so that you divide t=
he
>> needed files into different subdirectories?
>
> No, that is unfortunately not so easy. If we could, I suppose we coul=
d
> use submodules instead.

Your only option may be to use git filter-branch then.  It lets you do
pretty much anything you want, although merging it back together again
could be entertaining.  (Making it correctly mergeable is by far the
trickiest part of git-subtree.)

> Are the subtree split and merge operations effective? I.e. how do the=
y
> scale with the size of the original and reduced repositories? I.e. is
> it feasible to use hooks to automate the splitting and merging
> whenever there are changes in the original or reduced repositories?

git subtree manipulates only commit objects (and a reference to the
single tree object representing the subtree in each commit) so it's
very fast and doesn't depend on file sizes or number of files.
Basically git subtree split is O(n) in the number of *commits* since
the most recent split.

Have fun,

Avery
