From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 1/4] gitweb: notes feature
Date: Thu, 4 Feb 2010 21:08:04 +0100
Message-ID: <cb7bb73a1002041208q54ff1f57y3202e88ae2f5f44e@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vpr4lhsfu.fsf@alter.siamese.dyndns.org> <7v4olxhrti.fsf@alter.siamese.dyndns.org> 
	<201002041821.22864.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 21:08:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nd808-0004s1-7d
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 21:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076Ab0BDUI0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2010 15:08:26 -0500
Received: from mail-ew0-f228.google.com ([209.85.219.228]:59396 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932988Ab0BDUIZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Feb 2010 15:08:25 -0500
Received: by ewy28 with SMTP id 28so3364095ewy.28
        for <git@vger.kernel.org>; Thu, 04 Feb 2010 12:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8byTttuYgqKqFCc//SzjauU++Xp0ga4X5GrMUA1hk8Y=;
        b=SSxshpO5SwOWL+ZrtsVhF7cavoC/ZsIODqRMGuTNES5O6N6XKmPYtqNkZo+krUTRSc
         cET87KQGA43pPr2PMJWXTu5S8U7WEJtILdmEAAztprugVHpz9PQTHb2Uc+C99zuiOi4S
         lFAOfMk5r5DNX4NcCNQd7N1J2T3jUrEuSHCw4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=e/ISgQCNBL1i2LcKoeEOIMdtDa9rLxQoDBNb8KF0SCryBqq/hZ6V1u9FWbA3UZTeSY
         +4tUuotFXBDRRSqKnu2p/sdJQtg9v5pk29O9jcwOKmxC4TU6hg9tiA9p+KXIHpm9/Jke
         +R/fxoUKVo1yzmq7pCZBFREMnArqARlgVr1+U=
Received: by 10.213.38.3 with SMTP id z3mr1463703ebd.69.1265314104165; Thu, 04 
	Feb 2010 12:08:24 -0800 (PST)
In-Reply-To: <201002041821.22864.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139002>

On Thu, Feb 4, 2010 at 6:21 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Thu, 4 Feb 2010, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>>>
>>>> + =A0 =A0 =A0 =A0 =A0 my %notes =3D () ;
>>>> + =A0 =A0 =A0 =A0 =A0 foreach my $note_ref (@note_refs) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $obj =3D "$note_ref:$co{'=
id'}";
>>>
>>> I think this look-up is wrong (meaning: will stop working anytime i=
n the
>>> future, and needs to be rewritten).
>>
>> IOW, the code should be reading output from:
>>
>> =A0 =A0 GIT_NOTES_REF=3D$note_ref git show -s --format=3D%N $co{'id'=
}
>>
>> as the notes tree may not be storing notes in a flat one-level names=
pace
>> like you are assuming.
>
> First, for some mechanism of deployment (IIRC Apache's mod_perl) chan=
ges
> to environment variables from CGI script are not passed to invoked
> commands (I guess for security reasons). =A0That is why gitweb uses -=
-git-dir
> parameter to git wrapper, and not GIT_DIR environment variable since
> 25691fb (gitweb: Use --git-dir parameter instead of setting $ENV{'GIT=
_DIR'},
> 2006-08-28). =A0So for proper support we would need --notes-ref (or s=
imilar)
> option to git wrapper
>
> =A0git --notes-ref=3D$note_ref show -s --format=3D%N $co{'id'}

As I mentioned on the cover letter, I was hoping to be able to make
something that could be deployable without requiring core changes and
thus a specific minimum git version. I do realize however that this is
inherently not robust (unless the code is updated if and when the
notes storage mechanism changes).

The wrapper is probably needed anyway, I would say, so it makes sense
to implement it. However, see below for a caveat about its
implementation.

> Second, parse_commit / parse_commits use
>
> =A0git rev-list -z --parents --header --max-count-X
>
> If this command automatically shows notes (or it can be modified to
> automatically show notes) after unindented "Notes:" line (as per
> git-notes documentation), then the only thing that needs to be
> changed to fill %commit{'notes'} is parse_commit_text subroutine.
>
> There would be no need for extra subroutine (and extra command, or
> even up to two extra commands per note) to get notes data.

But unless the --notes-ref is made to accept multiple refspecs, this
will only access _one_ note namespace. It is not hard to envision
situations where multiple namespaces are used for the same repo (e.g.
one to store git-svn metadata, one for bugzilla-related entries), in
which case you'd want _all_ of them to be accessible in gitweb.

And if we do support multiple refspecs for --notes-ref, we also need
some way to identify which note belongs to which namespace, of course,
in any of the output formats that include notes.

An alternative approach would be some git notes-list command that
accepts both multiple namespaces and multiple commits, and is
specifically dedicated to display notes-commits relationships
(together with notes content, obviously)

--=20
Giuseppe "Oblomov" Bilotta
