From: skillzero@gmail.com
Subject: Re: [RFC PATCH v3 8/8] --sparse for porcelains
Date: Mon, 17 Aug 2009 17:23:39 -0700
Message-ID: <2729632a0908171723n1c70798bp3169c813d5734c70@mail.gmail.com>
References: <1250005446-12047-1-git-send-email-pclouds@gmail.com>
	 <200908160137.30384.jnareb@gmail.com>
	 <alpine.DEB.1.00.0908161002460.8306@pacific.mpi-cbg.de>
	 <alpine.DEB.1.00.0908171101090.4991@intel-tinevez-2-302>
	 <7vtz06xxao.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0908171817570.4991@intel-tinevez-2-302>
	 <7vws52uvxq.fsf@alter.siamese.dyndns.org>
	 <alpine.DEB.1.00.0908172347220.8306@pacific.mpi-cbg.de>
	 <2729632a0908171602m3c05c97bx9ce31e8960df9198@mail.gmail.com>
	 <alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 18 02:23:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdCUO-00021W-Ib
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 02:23:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758467AbZHRAXk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Aug 2009 20:23:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758464AbZHRAXk
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 20:23:40 -0400
Received: from mail-qy0-f196.google.com ([209.85.221.196]:34841 "EHLO
	mail-qy0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758462AbZHRAXj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Aug 2009 20:23:39 -0400
Received: by qyk34 with SMTP id 34so2465531qyk.33
        for <git@vger.kernel.org>; Mon, 17 Aug 2009 17:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wju3ZGLg2jklEnD8RLzwX7ZQgl6XNzprF+a6/0k0KRk=;
        b=LfI8dH1kyWRSitFyn0RDC795LI7vWJJQj5BDxI4Rd2B+KOG+ksTBWsmProzuP5neVp
         MbUYw0wK7iQDPKMxHIpk6MyKtCMjsa3fpGSIHX5bJjuWqE0F1/0lIWSjSL7nVQr6SoCl
         i6RLRjyxJdgl43c9kI469TdvAUr4NDFv/AR08=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gfoh/5hl96XepJo49m5VxkEKQW+A7zQ/1PZxzrAYkKAs3yHrYYWAZs1gy/GxKFX0nq
         g7isIPlXgfOurwe0Qi8+r0Qwltq1Bo5SVXhnSy5FvSpIqQAwDaSHZvuxZILBDjA4P0Np
         m/rEqMkJ1s18E7uWbwYSPUFjooUdBLoj6MzCo=
Received: by 10.224.36.104 with SMTP id s40mr4858232qad.296.1250555020228; 
	Mon, 17 Aug 2009 17:23:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0908180111340.8306@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126328>

On Mon, Aug 17, 2009 at 4:16 PM, Johannes
Schindelin<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Mon, 17 Aug 2009, skillzero@gmail.com wrote:
>
>> On Mon, Aug 17, 2009 at 3:02 PM, Johannes
>> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>>
>> > And here comes the problem: if something is treated untracked beca=
use
>> > it was outside of the sparse checkout, then I want it to be treate=
d as
>> > untracked _even if_ I happened to broaden the checkout by editing
>> > .git/info/sparse. =C2=A0The file did not just magically become sub=
ject to
>> > overwriting just because I edited .git/info/sparse (which could be=
 a
>> > simple mistake).
>>
>> Maybe I'm misunderstanding what you're saying, but why would you wan=
t a
>> file that's become part of the checkout by editing .git/info/sparse =
to
>> still be treated as untracked?
>>
>> If I have a file on that's excluded via .git/info/sparse then I edit
>> .git/info/sparse to include it and switch to a branch that doesn't h=
ave
>> that file, I'd expect that file to be deleted from the working copy =
if
>> the content matches what's in the repository. If it's modified then =
I'd
>> expect the branch switch to fail (like it would without a sparse
>> checkout).
>
> First things first: with sparse checkout, you should not check out
> _anything_ outside of the focus of the sparse checkout.
>
> So I contend that you would only end up with a sparse'd-out file
> that was formerly tracked if you did something wrong. =C2=A0That shou=
ld not
> happen.

I was thinking if you copied the file there manually and changed
=2Egit/info/sparse to include it. I would expect git checkout, git
status, etc. to act as just as if I had never excluded it via
=2Egit/info/sparse, similar to .gitignore and .git/info/exclude.

> The thing is: we need a way to determine quickly and without any
> ambiguity whether a file is tracked, assumed unchanged, or sparse'd-o=
ut
> (which Nguy=E1=BB=85n calls no-checkout).
>
> And if we change .git/info/sparse, that state _must not_ change. =C2=A0=
We did
> not touch the file by editing .git/info/sparse, so the state must be
> unchanged.

I don't know enough to have an opinion on assume-unchanged vs
no-checkout, but if you edit .git/info/sparse it seems like it should
affect whether git cares about a file or not. If a file previously had
the no-checkout bit and you change .git/info/sparse to include the
file, the next time you do something with git, I would expect it to
start caring about that path. For example, I can edit .gitignore and
=2Egit/info/exclude and it notices the next time I use git without
having to do anything special.
