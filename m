From: Eugene Sajine <euguess@gmail.com>
Subject: Re: feature "git tag -r" to show tags and commits they are pointing 
	to
Date: Fri, 23 Oct 2009 10:48:57 -0400
Message-ID: <76c5b8580910230748n620ad3a8o58811732be7c369f@mail.gmail.com>
References: <76c5b8580910221424n220449b9vda26f032174b6fa7@mail.gmail.com>
	 <7vr5svf6x9.fsf@alter.siamese.dyndns.org>
	 <76c5b8580910221930s4b31b180t8298c262d9d9f421@mail.gmail.com>
	 <7v8wf2ejna.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 16:49:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1LSG-0001GJ-Qr
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 16:49:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbZJWOsy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 23 Oct 2009 10:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752059AbZJWOsy
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 10:48:54 -0400
Received: from mail-gx0-f216.google.com ([209.85.217.216]:60568 "EHLO
	mail-gx0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752050AbZJWOsx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Oct 2009 10:48:53 -0400
Received: by gxk8 with SMTP id 8so10443738gxk.1
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PZOK2mPZZe8zxflh3wBYdcqeOuS/G6KTmLdazxkjDVU=;
        b=k8gAT96sdD+MGT6yTwOJKFalif/DP9zI49u3pMCDL3s9b4DTXgooPfZH/hnA3K2Uyv
         H2kpMDUZHnl44wkoYS5E2uMD+SfYpEO+vGWPrcAr8acmhPsi9jF1guqEb7z4nQw9blyj
         8KwkoGyxN0yR4KnTTUE/PZa8ZEx5KM6C0gwhk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X9in/vWFqiK6A/0ASahtfLJyI6GkZOEwyf8/mFgOnVQgwfraN/N/843N8QOJIkkTo7
         wu6ZrNr/Npc6oUQhf3vyIf9fgue4QhNNUmUv9m3aUkDzQ3hm9jGGlLRx2nSXVMwyQJH4
         VouLAOLiKvahr+H61v1OnMiQm8nbZcxGn9Tek=
Received: by 10.90.217.11 with SMTP id p11mr2247060agg.82.1256309337807; Fri, 
	23 Oct 2009 07:48:57 -0700 (PDT)
In-Reply-To: <7v8wf2ejna.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131105>

> You do not have to live with a tag that points at another tag that po=
ints
> at a commit.
>
> You can still tag the commit directly with your new tag, and you do n=
ot
> need to have the exact commit object name to do so. =C2=A0You just te=
ll the
> tool to follow the tag chain to get to the pointed-to object, like th=
is:
>
> =C2=A0 =C2=A0$ git tag -a -m "my message" newtag oldtag^0
>
> This assumes [*1*] that the old tag points at (strictly speaking, "mi=
ght
> point at") a commit object, and uses "^0" (zeroth parent of) operator=
 to
> make sure that the object the newtag points at (the last argument to =
the
> "git tag" command, i.e. "oldtag^0" in this example) is a commit objec=
t,
> not an annotated tag "oldtag" itself.
>
> That is what I meant by "just as usable as hexadecimal to the tools".
>
>>> ... "v0.1" is
>>> much more useful than 8794hke to humans, and these tag names are ju=
st as
>>> usable as the hexadecimal commit object names to the tools. =C2=A0Y=
ou can say
>>> "git show v0.1^0" and "git show 8794hke" and get the same thing.
>
> [Footnote]
>
> *1* A tag can point at any object, not necessarily a commit. =C2=A0If=
 oldtag
> points at a tree object (or a blob object), oldtag^0 will fail, becau=
se
> the operator "^0" is "zeroth parent of", and is applicable only to a
> commit. =C2=A0In general, you can write
>
> =C2=A0 =C2=A0$ git tag -a -m "my message" newtag oldtag^{}
>
> The "^{}" operator is a special case of "^{type}" operator; the forme=
r
> means "dereference the tag repeatedly until it becomes something that=
 is
> not a tag", and the latter means "dereference the tag repeatedly unti=
l it
> becomes something of that type". =C2=A0I.e. "oldtag^0" is "oldtag^{co=
mmit}".
>

Junio,

Thank you very much for such detailed explanation! I do appreciate it.


Eugene
