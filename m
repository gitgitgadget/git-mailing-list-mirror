From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: Suggestion on git-push --porcelain
Date: Wed, 10 Feb 2010 19:18:32 +0800
Message-ID: <be6fef0d1002100318v902689xc937cd332ac752b3@mail.gmail.com>
References: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
	 <7vmxzhn6fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Larry D'Anna" <larry@elder-gods.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 12:18:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfAad-0004Mv-I3
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 12:18:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab0BJLSe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Feb 2010 06:18:34 -0500
Received: from mail-iw0-f201.google.com ([209.85.223.201]:53794 "EHLO
	mail-iw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753560Ab0BJLSd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Feb 2010 06:18:33 -0500
Received: by iwn39 with SMTP id 39so9653604iwn.1
        for <git@vger.kernel.org>; Wed, 10 Feb 2010 03:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=rrOCh/DPlRS3HpE0svAkfJI/Mk4jTqL/k5t09SIOXPw=;
        b=cEpqzWJ189+M6N5HJB8fiCj621rM/dJ0g2pgXGx/yyOJpDIkAPmGegLVhsPhbLKY4+
         ig5R4k72q2QF3WV9hg1AIRXYg/uP/i0BigvBYLrVybdft2rhbxd8DAddShpQsYd+oPy7
         DP2qruzf1m1K8iy9yZJppNkfWlmQAD//zMHn0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ijJ+8tdGF3FJA97FYDNz2FnIO7Z07h/M+89OGO6ntCfvReKCR6zoL6woeSL0Y5K3+O
         fNt29iu9Nz1Hi2SNf6gGLdUeVRImlu00DKz237taHolzlD9ctihkpitct2f4QRi4cMRq
         TUt2/6cpdicTSlULK8j2pOnKYa9rhleSG2FL8=
Received: by 10.231.167.204 with SMTP id r12mr158092iby.31.1265800712698; Wed, 
	10 Feb 2010 03:18:32 -0800 (PST)
In-Reply-To: <7vmxzhn6fp.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139504>

Hi,

On Wed, Feb 10, 2010 at 10:57 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Tay Ray Chuan <rctay89@gmail.com> writes:
>
>> =A0 $ git push --porcelain
>> =A0 PORCELAIN To git://foo.com/git/myrepo.git
>> =A0 PORCELAIN uptodate refs/heads/baz:refs/heads/baz 1234ab ba4321
>> =A0 PORCELAIN nonff refs/heads/bar:refs/heads/bar 2345cd 3456de
>>
>> This is an "positive" approach, in the sense that we don't remove
>> anything from the current output; we just add more printf("PORCELAIN=
")
>> lines to wherever is appropriate.
>
> Sorry, but I don't see what that would solve. =A0For example, we used=
 not to
> give the destination to the standard output stream, but that line car=
ries
> a necessary information and Larry's series corrects that.

I sense a chicken-and-egg situation here.

Printing a "To: <destination>" to stdout is a correction as far as the
current non-prefixed output scheme is concerned.

If a prefixed scheme (or some other output scheme) is adopted, then
where, or whether, the "To: <destination>" is printed, is not relevant
to porcelain script writers - they just get ignored.

> In your "prefix with PORCELAIN" scheme, such a change will start addi=
ng a
> new line "PORCELAIN To ..." that older implementations may not be pre=
pared
> to see.

The original --porcelain patch only "porcelained" the output for ref
updates, such as

  =3D TAB refs/heads/master:refs/heads/master TAB [up to date]
  - TAB :refs/heads/foobar TAB [deleted]
 ...

In addition, the "To: <destination>" patch --porcelain is fairly
recent - I don't think it has left 'pu', has it? Should we worry about
breaking compatibility on something not out yet?

--=20
Cheers,
Ray Chuan
