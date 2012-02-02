From: Frans Klaver <fransklaver@gmail.com>
Subject: Re: How best to handle multiple-authorship commits in GIT?
Date: Thu, 2 Feb 2012 14:41:09 +0100
Message-ID: <CAH6sp9P8ehXoC075dcK9ni5rJBV9iCZmLHTBr-UR+-jbD3c6Ww@mail.gmail.com>
References: <21056.1328185509@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, valerie.aurora@gmail.com
To: David Howells <dhowells@redhat.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 14:41:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rswua-0005VH-32
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 14:41:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753944Ab2BBNlL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Feb 2012 08:41:11 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58048 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab2BBNlK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2012 08:41:10 -0500
Received: by qcqw6 with SMTP id w6so1377168qcq.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 05:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=HqPOJ7DSFctQa1YkqkaINtwAma6O+Y+zlyV46Uq5SAg=;
        b=iifN8yh8gsfOzENMO4bB+KOXObt9srV5p/iu2eGC/jKMujeE5RZFd3RV2Znu8Px7kP
         53tDLX7fb5WBZLqE7VAfqGQqS5awjuIdnc/6+HvQMZwgQG8hp+tIk7z5Yxp0yIJASWNt
         8iJ2MDTriZPjV7hm567cz2V1DRN0/xeD2aW6Y=
Received: by 10.224.117.15 with SMTP id o15mr3655150qaq.97.1328190069362; Thu,
 02 Feb 2012 05:41:09 -0800 (PST)
Received: by 10.224.204.74 with HTTP; Thu, 2 Feb 2012 05:41:09 -0800 (PST)
In-Reply-To: <21056.1328185509@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189642>

Hi,

On Thu, Feb 2, 2012 at 1:25 PM, David Howells <dhowells@redhat.com> wro=
te:
>
> Hi,
>
> I've been assigned a stack of patches to maintain and try and get ups=
tream by
> my employer. =C2=A0Most of the patches currently have the authorship =
set to Val,
> but since I'll be maintaining them if they go in upstream and I've ch=
anged
> them a lot, I feel I should reassign the author field to myself so pe=
ople
> pester me rather than Val with questions about them. =C2=A0However, I=
 don't want to
> deny Val or any other contributor credit for their work on the patche=
s.
>
> I can see a number of ways of doing this, and am wondering which will=
 be best:
>
> =C2=A0(1) Ascribe multiple authorship directly in the commit. =C2=A0I=
 suspect this would
> =C2=A0 =C2=A0 require a change to GIT and its associated tools. =C2=A0=
That way I could put my
> =C2=A0 =C2=A0 name in the priority pestering spot, but doing a search=
 on authorship
> =C2=A0 =C2=A0 would still credit Val and others.
>
> =C2=A0(2) Add an extra tag 'Originally-authored-by' (or maybe 'Coauth=
ored-by' as I
> =C2=A0 =C2=A0 saw someone recommend) in amongst the 'Signed-off-by' l=
ist. =C2=A0But that
> =C2=A0 =C2=A0 doesn't give them credit in a gitweb search without cha=
nging gitweb.
>
> =C2=A0(3) Don't actually modify Val's commits to bring them up to dat=
e, but rather
> =C2=A0 =C2=A0 create a historical GIT tree with Val's commits committ=
ed as-are and then
> =C2=A0 =C2=A0 add my changes to the top in a number of large merge co=
mmits (there have
> =C2=A0 =C2=A0 been multiple major breakages due to different merge wi=
ndows).
>
> =C2=A0 =C2=A0 I dislike this approach because it doesn't produce a ni=
ce set of patches I
> =C2=A0 =C2=A0 can give to someone to review (which is a must). =C2=A0=
Plus, for the most part,
> =C2=A0 =C2=A0 it's actually easier to port Val's patches individually=
=2E
>
> Can GIT be modified to do (1)? =C2=A0Gitweb's display need only show =
one of the
> authors in the single-row-per-patch list mode, but should find a patc=
h by any
> of the authors in an author search and should display all the authors=
 in the
> commit display.

I always thought of the author field as being an indication of who is
ultimately responsible for its implementation (the one in the
pestering spot). (1) may seem desirous, but doesn't (2) seem like a
cleaner and more maintainable solution? Gitweb will show the entire
log message if people are interested in the exact change, right?

Cheers,
=46rans
