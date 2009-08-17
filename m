From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 23:13:19 +0700
Message-ID: <fcaeb9bf0908170913l20d3cc0ma81052589a8a685f@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com> 
	<200908142223.07994.jnareb@gmail.com> <7veird4yyi.fsf@alter.siamese.dyndns.org> 
	<200908160137.30384.jnareb@gmail.com> <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de> 
	<alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302> <fcaeb9bf0908170549w26b008bdhe67f113a58ecb4eb@mail.gmail.com> 
	<alpine.DEB.1.00.0908171524150.4991@intel-tinevez-2-302> <fcaeb9bf0908170741v210e7f4et9f1c68bc9a81ca65@mail.gmail.com> 
	<alpine.DEB.1.00.0908171712220.4991@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Aug 17 18:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md4qH-0001Sm-2P
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 18:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753632AbZHQQNi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 12:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753278AbZHQQNi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 12:13:38 -0400
Received: from mail-yw0-f173.google.com ([209.85.211.173]:55082 "EHLO
	mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752939AbZHQQNi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 12:13:38 -0400
Received: by ywh3 with SMTP id 3so4250032ywh.22
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Q6J9jVzs0H6st073juBF0JfGe+0vdpZzX8Av4pEZTec=;
        b=USXjBEYPZFAdmyYYsJI70BjBR9Bo1db0TzaMnERG6Ky+QSxN7Pr3QmO4IkoFAmNF0J
         4sYncCy3GjsNFM4e7/aOuuUyndz35DOm+vanI7sP8vyypG64Ml8vacWWvN8h9vp1D5Ee
         h4pss5RJa5BZym3Z4zy4YAKNCx9DFKx7ikOak=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=F5simomTz/MQ7OqjLmzdcpJ157SC+GbzpaeEgVhWercPxO5bi7CKtI/kcZLZj05MNC
         Rvad9ByGsJ4LlMn6GRFKDoD8nfJTzLDv9/kPsQhjPabXwPq90dT2gdvyVBLb1OMCQGr8
         pgIGiKkw3+A4BX2eSrqF8TjhxgJ3ekpJgvPvY=
Received: by 10.100.27.12 with SMTP id a12mr3540502ana.110.1250525619104; Mon, 
	17 Aug 2009 09:13:39 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908171712220.4991@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126215>

On Mon, Aug 17, 2009 at 10:19 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, Nguyen Thai Ngoc Duy wrote:
>
>> On Mon, Aug 17, 2009 at 8:35 PM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>>
>> > The problem of course is that the other branch has an ancient vers=
ion
>> > of that file (which should _not_ overwrite the current, modified
>> > version!), i.e. "git diff HEAD..other -- file" does not come empty=
=2E
>> >
>> > As 'file' is assume-unchanged, zinnnng, the file gets "updated".
>>
>> Then it is a bug. Assume-unchanged as in reading is good.
>> Assume-unchanged in writing sounds scary. Something like this should
>> fix it (not well tested though). It's on top of my series, but you c=
an
>> adapt it to 'next' or 'master' easily.
>
> No.
>
> The purpose of 'assume-unchanged' is to tell Git that it has no busin=
ess
> checking that the file is unchanged. =C2=A0It should _assume_ that it=
 is
> unchanged. =C2=A0That's what this flag says.
>
> So do you agree that assume-changed is not quite similar enough to sp=
arse
> to use the same bit?

If you define it that way, yes I agree.

>> > Another use case: documentation. =C2=A0I do not have that use case=
 yet, but
>> > I know about people who do.
>>
>> Translators usually checkout one or two files (I am Vietnamese
>> Translation Coordinator of GNOME, but well... I check them all out. =
I
>> suppose "normal" translators would not want to do like I do.)
>
> Exactly.
>
> echo /Documentation/ > .git/info/sparse
>
> Remember: the documentation contributors are the least programming-sa=
vvy
> contributors of any project.

[wanted to make a joke here, but it seemed destructive, snipped]

>> > =C2=A0Specifying what you _want_ to have checked out is much more
>> > straight-forward here than the opposite.
>>
>> I think it depends on type of projects. For documentation projects, =
you
>> may want a few files. For software projects, usually you need everyt=
hing
>> _except_ a few big directories. For WebKit, it's a bunch of test dat=
a
>> that I don't care about. Firmware in hardware-related projects or me=
dia
>> files in game projects fall in the same category. I don't have stron=
g
>> opinion on this. Either include or exclude is fine to me.
>
> Okay, let me just ask: if you have a sparse checkout, what would you =
think
> I mean when I talk about the "sparse files"?

If I have to answer in 2 seconds, "sparse files" are files in working
directory. If I have more time, I tend to think that in "sparse
<something>", something should be a container, an area, therefore
"sparse files" do not make sense to me while "sparse
checkout/worktree" does. So, .git/info/sparse-checkout (with "in"
patterns)?
--=20
Duy
