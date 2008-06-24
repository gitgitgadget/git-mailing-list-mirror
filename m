From: "Klas Lindberg" <klas.lindberg@gmail.com>
Subject: Re: git-fetch remote tag to local branch fails
Date: Tue, 24 Jun 2008 16:01:13 +0200
Message-ID: <33f4f4d70806240701o1c00cef2g688a188970964b0f@mail.gmail.com>
References: <33f4f4d70806240517h5e3ae420h263dd0c2d6bae459@mail.gmail.com>
	 <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 16:04:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB96x-0000r0-TI
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 16:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbYFXOBQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Jun 2008 10:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754335AbYFXOBQ
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 10:01:16 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:56130 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754692AbYFXOBP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Jun 2008 10:01:15 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1178712fgg.17
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 07:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=tL+xJV+YGoMgJ3VtTNBRzMWsOjTlJMCVj15CJMuPepI=;
        b=n+JWxf/gUxH7GOOHI0nm6uRAngz1aHLkUVznhxYhGSXS6C3VQcBuYKf65Xy+OC1c9q
         /qhhjBp17X0e2bEXKPfuv1nfjpatIqe1Pm4W6DlEizMI9iqVu/3xB79SWmNiCUkyZ2Hq
         pvYlDgW8fvjeXmf6yY09kr/95n9ziCF6GXGSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=kEv+RTSWOFq3ZwTafbrlBqqJidECSDOSVyEViOGuAgDAPWYT9J8jCcrgYBIGEaQAnm
         hl+/XmZ/53R6FVXyaQZRylLZ/4VVk4mCKDk7i1Ao7UxBIuPpDsdbW2sDYCz6sgHeHkDI
         JGNDZaEFkUDBlkRoeQg1DGj4eqIvv3J5wryHI=
Received: by 10.86.52.6 with SMTP id z6mr9006196fgz.18.1214316073425;
        Tue, 24 Jun 2008 07:01:13 -0700 (PDT)
Received: by 10.86.68.16 with HTTP; Tue, 24 Jun 2008 07:01:13 -0700 (PDT)
In-Reply-To: <8aa486160806240638o221b01d2i2f46cc8f0f3760a3@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86058>

Hello

> git tag -l
foo_tag
test_tag
>

> git branch -a
>

At this point, I can create the branch "b" from "foo_tag", so the
fetch did get me a remote tag. It just didn't update a local branch
with the contents (or create a new one).

Something that also confuses me is that if branch "b" already exists, t=
hen

> git-pull bogustree refs/tags/foo_tag:refs/heads/b

actually does update branch "b". I find the behaviour quite inconsisten=
t.

Unfortunately it isn't a solution for me to fetch tags and then create
branches from the tags. I need to be able to update existing branches,
and I have to do that without first making such a branch the current
branch.

Any suggestions?

/Klas

On Tue, Jun 24, 2008 at 3:38 PM, Santi B=E9jar <sbejar@gmail.com> wrote=
:
> On Tue, Jun 24, 2008 at 14:17, Klas Lindberg <klas.lindberg@gmail.com=
> wrote:
>> Hi
>>
>> I have a repository "bogustree" that contains tags "test_tag" and
>> "foo_tag" (both on the same branch, with "test_tag" pointing to an
>> older commit).
>> I also have repository "R", which contains "test_tag" from "bogustre=
e"
>> and a branch "b" created from "test_tag". The active branch in R is
>> "master".
>>
>> Now I want to do the following from R:
>>
>> git-fetch bogustree refs/tags/foo_tag:refs/heads/b
>>
>> but this fails with the message given below. The interesting part is
>> that git-fetch tries to write a "non-commit object" and indeed I hav=
e
>> no idea what this thing is (the commit pointed to by "foo_tag" has
>> commit ID cab0a25388f1884a1ab16bd0d66f877c0b36f1d5).
>
> non-commit object is an object that is not a commit, like a tag, a
> blob or a tree, and you are trying to write a tag in refs/heads/. Onl=
y
> commits objects (no tags) are allowed in refs/heads/.
>
>
>> Another
>> interesting detail is that the command fails and then continues
>> anyway. That seems wrong in itself.
>>
>> # remote: Counting objects: 6, done.
>> # remote: Compressing objects: 100% (2/2), done.
>> # remote: Total 4 (delta 0), reused 0 (delta 0)
>> # Unpacking objects: 100% (4/4), done.
>> # error: Trying to write non-commit object
>> 5f61233bc5dad0f3e25ecea65457f5bb528174d2 to branch refs/heads/B
>> # From /home/qliklas/bogustree/b/b
>> #    72f0622..5f61233  foo_tag    -> b
>> # From /home/qliklas/bogustree/b/b
>> #  * [new tag]         foo_tag    -> foo_tag
>> #  * [new tag]         test_tag   -> test_tag
>
> Are you sure it is written as a branch? What is the output of "git ta=
g
> -l" and "git branch -a"?
>
>
>>
>> Why can't I fetch like this? The manual page for git-fetch says that
>>
>>       <refspec>
>>              The canonical format of a <refspec> parameter is +?<src=
>:<dst>;
>>              that is, an optional plus +, followed by the source ref=
,
>>              followed by a colon :, followed by the destination ref.
>>
>>              The remote ref that matches <src> is fetched, and if <d=
st> is
>>              not empty string, the local ref that matches it is fast
>>              forwarded using <src>. Again, if the optional plus + is=
 used,
>>              the local ref is updated even if it does not result in =
a fast
>>              forward update.
>>
>> so I think it should be OK?
>
> as long as <src> are commit objects.
>
> Santi
>
