From: Adam Brewster <adambrewster@gmail.com>
Subject: Re: Merging to and from non-current branches.
Date: Tue, 4 Aug 2009 23:33:27 -0400
Message-ID: <c376da900908042033x312f2e8bx966359c514e0bc9d@mail.gmail.com>
References: <D5200130-C7D7-4010-BF62-3A3374F2E3B0@mgreg.com>
	 <alpine.LNX.2.00.0908042236240.2147@iabervon.org>
	 <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: "lists@mgreg.com" <lists@mgreg.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 05:33:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MYXFy-0001kQ-AD
	for gcvg-git-2@gmane.org; Wed, 05 Aug 2009 05:33:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933866AbZHEDda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Aug 2009 23:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933863AbZHEDda
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Aug 2009 23:33:30 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:53473 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933862AbZHEDd3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Aug 2009 23:33:29 -0400
Received: by ewy10 with SMTP id 10so828665ewy.37
        for <git@vger.kernel.org>; Tue, 04 Aug 2009 20:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KEQOVk6uYNpe23Ok+RdV43hJMA0U4s8V6xIjDCghYbU=;
        b=dwLvIoxTE0WFRAbM4NXW2mKTtVwgm5kZsP7sUM1RtygTkLOhmNgNQrT4D8Lbx74eYK
         vPvnQ0SCxg+lTlY8siqIhqWcVuH2aL9fVZZL3IgsK/z63d1qp8nW74X1Fbs/B5wvki6B
         l+onME0JEP+alFPqELYjrG/awxScryHkdUiK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=PpFzldRIDgKwoAuBxLJx6jVbXnKoVVVLBLedq79VdAnHTK+gmcNJ03w9JaP5jabKPF
         jfhwHqM+Qh1sRXa14qkdZ3oso9y2DF4GdmMJQFbXxfxrc1Nw51JofW+ANAsq07bJjQtR
         TNNoJtqKJ/jVnKcrA4MLIbg5K3LYC++Hic8FY=
Received: by 10.216.89.16 with SMTP id b16mr21128wef.57.1249443207755; Tue, 04 
	Aug 2009 20:33:27 -0700 (PDT)
In-Reply-To: <518952FC-626C-43FB-BD53-98DE849C9751@mgreg.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124845>

In case it helps, I think that if you're on branch dev, and you `merge
master`, you should get a commit that's substantially similar to that
that you'd get if you're on master and you `merge dev`.

The most noticeable difference should be that if you `checkout master
&& merge dev` the master is updated to point to the merged commit,
whereas if you `checkout dev && merge master` dev is updated to the
new commit.

(If there are conflicts, then the merge processes will differ more
significantly, but hopefully the human should be able to sort that
out.)

You should be able to use git-reset and git update-ref to clean up the
mess if that's not good enough.

Adam Brewster

On Tue, Aug 4, 2009 at 10:48 PM, lists@mgreg.com<lists@mgreg.com> wrote=
:
>
> On Aug 4, 2009, at 10:45 PM, Daniel Barkalow wrote:
>
>> On Tue, 4 Aug 2009, lists@mgreg.com wrote:
>>
>>> Hi All,
>>>
>>> I've been reading up on some of the GIT commands and I'm not sure i=
f what
>>> I
>>> want/need exists. =A0Basically I want to merge all changes from one=
 branch
>>> to
>>> another, regardless of whether I'm in either of those branches. =A0=
At the
>>> very
>>> least I would like to merge an existing "development" branch with t=
he
>>> "master"
>>> branch without needing to first check out master. =A0I've seen reba=
se, but
>>> I'm
>>> not absolutely sure what that's doing. =A0Thoughts?
>>
>> It can't work, because you need to be able to use the working tree t=
o
>> resolve any conflicts that arise during the merge. Merging without
>> checking out a branch is a bit like building without checking out a
>> branch; it would be avoiding using the filesystem for what it's ther=
e for.
>>
>> =A0 =A0 =A0 =A0-Daniel
>> *This .sig left intentionally blank*
>>
>
>
> Hi Daniel,
>
> I appreciate your post. =A0I understand what you're saying, and I'm n=
ot so
> much concerned about the logistics of what need to occur so much as a=
 single
> command to intuitively handle it. =A0I've been doing a great deal of
> incremental development lately and it becomes rather tedious to have =
to
> checkout master, merge dev, re-checkout dev and proceed. =A0I'm not s=
ure why
> this isn't currently possible with a single command. =A0I suppose I c=
ould
> write a shell script to do so, but that's a little less "native" than=
 I'd
> like.
>
> Best,
>
> Michael
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
