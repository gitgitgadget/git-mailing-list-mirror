From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 21:41:13 +0700
Message-ID: <fcaeb9bf0908170741v210e7f4et9f1c68bc9a81ca65@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> 
	<200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de> 
	<alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <fcaeb9bf0908170549w26b008bdhe67f113a58ecb4eb@mail.gmail.com> 
	<alpine.DEB.1.00.0908171524150.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 16:42:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md3P5-00034D-Ft
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 16:41:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbZHQOle convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 10:41:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755406AbZHQOld
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 10:41:33 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:62908 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755389AbZHQOlc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 10:41:32 -0400
Received: by ywh3 with SMTP id 3so4155311ywh.22
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 07:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=2aPb6eOJpG0ofFmgc7DkyyBdJep/61x2YUAnyk7IPTc=;
        b=fpdb/e8mcjkZ/J/Gv4G2Mk1xdiyOx8OZXsn69JJNIBDI/vgWpFu6/hthIy3CD4dNuD
         huYLl7QLbiVzCBPcZ81k4gHHgujk9schZU2uRhLvvDEgHgbyG6xGuCY8LNrynUeRkvqU
         QF13y5SBi3AR4ObMKiq0gbiiHmcIo4sxwsaFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=NZVBzzqn6pzo0EtWqnS8yoZ6oweqdBNAAlimdi6l2aTX5BsdYNusAQKDTMQv5OPJJo
         xPdszZiomCrb0EaOPwNfDXSTBO55xQmZsR9H51NAJc0SOq0CEjZFq7B0J97k7pKH96Bh
         TdzTCk9G0Kx+PZCOKaFl+oIt14r1FvxfxP75k=
Received: by 10.101.62.13 with SMTP id p13mr3485850ank.25.1250520093164; Mon, 
	17 Aug 2009 07:41:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171524150.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126189>

On Mon, Aug 17, 2009 at 8:35 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, Nguyen Thai Ngoc Duy wrote:
>
>> On Mon, Aug 17, 2009 at 4:08 PM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>> > Turns out that somebody on IRC had a problem that requires to have
>> > sparse'd out files which _do_ have working directory copies.
>> >
>> > So just having the assume-changed bit may not be enough.
>> >
>> > The scenario is this: the repository contains a file that users ar=
e
>> > supposed to change, but not commit to (only the super-intelligent
>> > inventor of this scenario is allowed to). =C2=A0As this repository=
 is
>> > originally a subversion one, there is no problem: people just do n=
ot
>> > switch branches.
>> >
>> > But this guy uses git-svn, so he does switch branches, and to avoi=
d
>> > committing the file by mistake, he marked it assume-unchanged.
>>
>> Hmm.. never thought of this use before. If he does not want to commi=
t by
>> mistake, should he add to-be-committed changes to index and do "git
>> commit" without "-a" (even better, do "git diff --cached" first)?
>
> You probably agree that this would be a _very_ fragile setup. =C2=A0V=
ery easy
> to make mistakes.
>
> But we try to get away from that, don't we? =C2=A0Git had a reputatio=
n to be
> easy fsck up for long enough.

Well.. of course I don't want Git to keep that reputation :-)

>> > Only that a branch switch overwrites the local changes.
>>
>> I don't think branch switch overwrites changes in this case. Wheneve=
r
>> Git is to touch worktree files, it ignores assumed-unchanged bit and
>> does lstat() to make sure worktree files are up to date.
>
> Well, it does there, thankyouverymuch.
>
> The problem of course is that the other branch has an ancient version=
 of
> that file (which should _not_ overwrite the current, modified version=
!),
> i.e. "git diff HEAD..other -- file" does not come empty.
>
> As 'file' is assume-unchanged, zinnnng, the file gets "updated".

Then it is a bug. Assume-unchanged as in reading is good.
Assume-unchanged in writing sounds scary. Something like this should
fix it (not well tested though). It's on top of my series, but you can
adapt it to 'next' or 'master' easily.

diff --git a/unpack-trees.c b/unpack-trees.c
index eb47676..7b9ddf6 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -538,7 +538,9 @@ static int verify_uptodate_1(struct cache_entry *ce=
,
 {
 	struct stat st;

-	if (o->index_only || o->reset || ce_uptodate(ce))
+	if (o->index_only || o->reset ||
+	    /* we are going to update worktree, don't trust ce_uptodate if
it is CE_VALID'd */
+	    (!(ce->ce_flags & CE_VALID) && ce_uptodate(ce)))
 		return 0;

 	if (!lstat(ce->name, &st)) {


>> > I suggested the use of the sparse feature, and mark this file (and
>> > this file alone) as sparse'd-out.
>>
>> Sparse checkout only removes a file if its assume-unchanged bit
>> changes from 0 to 1.
>
> The problem is not removing, but overwriting.
>
> And in this respect, 'assume-unchanged' is a very different beast fro=
m
> 'sparse'. =C2=A0I am growing more and more convinced that you cannot =
just reuse
> the assume-unchanged bit.

And assume-unchanged bit could get lost during index merging, which
may cause unexpected effect if sparse checkout bases off
assume-unchanged. Let me think more of it tonight.

>> If it's already 1, it does not care whether there is a corresponding
>> file in worktree. So something like this should work:
>>
>> git checkout my-branch
>> git update-index --assume-unchanged that-special-file
>> echo that-special-file > .git/info/sparse
>> # edit that-special-file
>> git commit -a
>> # do whatever you want, git pull/checkout/read-tree... won't touch
>> that-special-file because it's assume-unchanged already
>
> ... except if you changed .git/info/sparse and a formerly sparse'd-ou=
t
> file is overwritten by "pull". =C2=A0Not good.

Again, I think it's a bug.

>> > Is this an intended usage scenario? =C2=A0Then we cannot reuse the
>> > assume-changed bit [*1*].
>>
>> It'd be great if people tell us all the scenarios they have. My use
>> could be too limited.
>
> The use case I would have is where a collaborator wants to work only =
on
> one subdirectory and the top-level directory. =C2=A0All other subdire=
ctories
> are of no interest to him.
>
> Another use case: documentation. =C2=A0I do not have that use case ye=
t, but I
> know about people who do.

Translators usually checkout one or two files (I am Vietnamese
Translation Coordinator of GNOME, but well... I check them all out. I
suppose "normal" translators would not want to do like I do.)

> =C2=A0Specifying what you _want_ to have checked out
> is much more straight-forward here than the opposite.

I think it depends on type of projects. For documentation projects,
you may want a few files. For software projects, usually you need
everything _except_ a few big directories. For WebKit, it's a bunch of
test data that I don't care about. Firmware in hardware-related
projects or media files in game projects fall in the same category. I
don't have strong opinion on this. Either include or exclude is fine
to me.
--=20
Duy
