From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Mon, 23 Mar 2009 16:33:16 -0700
Message-ID: <402731c90903231633x32611e07je2df36a4b994f338@mail.gmail.com>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com>
	 <49C7A20E.7060503@drmicha.warpmail.net>
	 <20090323163343.GB16258@gmail.com>
	 <7vhc1j6czf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 00:35:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LltfO-0005Rn-MK
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 00:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZCWXdT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2009 19:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752506AbZCWXdT
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 19:33:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:34806 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbZCWXdS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 19:33:18 -0400
Received: by wf-out-1314.google.com with SMTP id 29so3077178wff.4
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PQFS00MF1GRT4ghPKvtS1XfBkSiizBJ3zqStmBypW/E=;
        b=f6o/UcZLZIcrgC4OlUC9BZgwkKaWZ3JE6hoKTHyEQPVWh+kjJuCQKNzeVq4EhHLVQY
         pDQlTQbCZ+hiKCK0IUi7Xc6XAPnixKrwakhgn4mIghSOXw067QdopgAL5tir3hSZjo81
         yVAzaaH+rhXqfvKLdHrOnMlQj8t5yswLoA33Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=KKo0gnkdHfv0dr5xXFCtTK/x1GYUUvGCwTVf1QVavCHLXrmNqbQtvQKGQY7w4B6ZDj
         jMhUFEZ+9oQYlN5LGiNnciZcVkns0PYtWfwDySCfaSqUw+gGLkpc7nv4cz0W3fyvktGB
         pzt7DAvS4NSZGckerK9pqOV1DxoQU3r2axgXI=
Received: by 10.142.68.2 with SMTP id q2mr3086680wfa.274.1237851196142; Mon, 
	23 Mar 2009 16:33:16 -0700 (PDT)
In-Reply-To: <7vhc1j6czf.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114363>

On Mon, Mar 23, 2009 at 4:22 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> David Aguilar <davvid@gmail.com> writes:
>
>> Keep in mind that the syntax that this patch added does not have fil=
e~3
>> =3D HEAD~3. =C2=A0file~3 means finding file as it existed 3 changes-=
to-file
>> ago, which is !=3D to HEAD~3 if file did not change in the last 3 co=
mmits.
>
> If your motive is to introduce inconsistency to the UI by adding this=
 kind
> of new notation _only to difftool_, I have to reconsider moving it ou=
t of
> contrib/ area.


I totally agree that this patch was half-baked, not fully defined,
and should be dropped.  I hope that doesn't influence
your decision for the rest of the patches that came before it.

The notion of "3 commits ago" is ambiguous in a merge-heavy work flow
and using ~ would only confuse things, so I'll see if we can find a bet=
ter
way to do it, but it shouldn't happen in difftool (if it happens at all=
).


>
> While I do not fundamentally oppose to add convenient notations for u=
seful
> concepts, you need to start at making sure if this "three changes ago=
" is
> a well defined concept to begin with.
>
> And it is not a well defined concept in a merge-heavy environment, un=
less
> you define what you mean by "three changes ago".
>
> If you consider this history:
>
> =C2=A0---Y---o---X---M---o mainline =3D HEAD
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /
> =C2=A0 ---A---B---C topic
>
> where A, B, C and X, Y are the only commits that touched the file you=
 are
> interested in, how do you define 3-changes-ago?
>
> Maybe X was just a totally uninteresting typofix to a comment, while =
A, B
> and C were adding a very interesting new feature. =C2=A0Don't forget =
that M
> also changes the file from either of its parents (X or C). =C2=A0Does=
 M count
> as the last change? =C2=A0Or does it not count because it is just a m=
echanical
> unconflicting merge? =C2=A0Which one of X or C is the penultimate cha=
nge? =C2=A0The
> one with an earlier committer timestamp? =C2=A0Tiebreaking with times=
tamps is
> known to be flawed in the presense of clock skew.
>
> For the consistency of the UI, "starting at HEAD, following first-par=
ent
> ancestry, find N-th commit that touches the path, ignoring all the si=
de
> branches" MUST be the semantics of a notation that uses tilde followe=
d by
> number (so file~3 must mean Y in the above picture), because HEAD~3 i=
s
> defined as "three parents ago, only following the first parent ancest=
ry".
> Anything else will invite user confusion.
>
> But I do not think it is necessarily useful to follow only the first
> parent ancestry to find "three-changes ago" (if such a concept exists=
).
> If you want a notation that means something else, such as X (because
> chronologically the commits that touched the file are M, C and X in t=
he
> ideal world that everybody has well synchronized clock), you shouldn'=
t use
> tilde-number notation but use something else.
>

Understood and thanks for the help,

--=20
    David
