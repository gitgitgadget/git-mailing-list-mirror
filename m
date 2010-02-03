From: demerphq <demerphq@gmail.com>
Subject: Re: extra headers in commit objects
Date: Wed, 3 Feb 2010 20:40:17 +0100
Message-ID: <9b18b3111002031140u66acfebbu9e398a600cbcabaa@mail.gmail.com>
References: <20100203174041.GC14799@spearce.org>
	 <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
	 <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
	 <20100203192612.GD14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 20:40:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncl5P-0006Zf-PI
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 20:40:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757599Ab0BCTkW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Feb 2010 14:40:22 -0500
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53872 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806Ab0BCTkU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 14:40:20 -0500
Received: by bwz19 with SMTP id 19so431254bwz.28
        for <git@vger.kernel.org>; Wed, 03 Feb 2010 11:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V8HyPnQ/5AEoh+wIheXYyveNll5r6osSMnfobPu6eeM=;
        b=KnGbNDwel2FRXjaJ/VNt7u+GCZbZ35+DiOhD5tcjClyfwr3wUZfhStmMigP3dmnE3o
         RWWP8ZfWf71nPIkmRlVsmFgh4m7arNcuZJ0RUkuSssvAuMCcmP3YOkD7r6QmTMHZbJ67
         YqL3g//IkFaGEGyu2P91kOTiQjPyoGht4+gt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=OYeqatbmgGbG74QD1Tw9BMfjEGacu5CM3Hvh8JShEFFqm/PHgLqkBtPupa7qi9bAo5
         SgxLPOrrGhDUM460Utfafw+bcmB8kcKBHdfVcOdHuIdRRgV5tBK/y/SfYrreNKvFWx8K
         ZgHOCJv4q8xuR6jHJoGMQEqz3OsIUJMPOnTms=
Received: by 10.239.191.203 with SMTP id c11mr3164hbi.65.1265226017732; Wed, 
	03 Feb 2010 11:40:17 -0800 (PST)
In-Reply-To: <20100203192612.GD14799@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138869>

On 3 February 2010 20:26, Shawn O. Pearce <spearce@spearce.org> wrote:
> demerphq <demerphq@gmail.com> wrote:
>> On 3 February 2010 19:15, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Wed, 3 Feb 2010, Shawn O. Pearce wrote:
>> >
>> >> Am I correct that core C developers are still under the opinion
>> >> that extra headers in a commit object aren't encouraged?
>> >
>> > I would say so.
>> >
>> > [...]
>> >> At the end of the day, is it a bug that C git doesn't support
>> >> working with extra commit headers? ?IMHO, no, because, we've
>> >> rejected these in the past, and its not part of the Git standard.
>> >> And other implementations shouldn't be trying to sell it that way=
=2E
>> >
>> > Agreed. ?And this was discussed in great length on this list on fe=
w
>> > occasions already (probably more than a year back).
>>
>> One problem, is that if you take the approach you say then you
>> basically guarantee that a new git that DOES add new headers will
>> break an old git that doesnt know about the headers, and actually
>> doesnt care about them either.
>
> As I understand it, the current stance is:
>
> 1) A compliant Git implementation ignores any headers it doesn't
> =A0 recognize that appear *after* the optional "encoding" header.

Ignores but passes through?

> 2) A compliant Git implementation does not produce any additional
> =A0 headers in a commit object, because other implementations cannot
> =A0 perform any machine based reasoning on them.
>
> 3) All implementations would (eventually) treat all headers equally,
> =A0 that is they all understand what author, committer, encoding are
> =A0 and process them the same way. =A0Any new headers should equally
> =A0 be fully cross-implementation.
>
>> So it would essentially mean that if you ever have to change the
>> commit format you will be in a position where new git commits will b=
e
>> incompatible by design with old git commits.
>
> So, we can change the format by adding a new header, after the
> optional "encoding" header.
>
> But such a change needs to be something that an older Git will
> safely ignore (due to rule 1), and something that a newer Git can
> make really effective use of (due to rule 2 and 3). =A0And that newer
> Git must also safely deal with commits missing that new header, due
> to the huge number of commits out in the wild without said header.
>
> And don't even get me started on amending commits with new unknown
> headers. =A0Existing implementions of Git tools will drop the extra
> headers during the amend, because the headers are viewed as part
> of the commit object data... and during an amend you are making a
> totally new object.
>
> For example, git-gui would drop any extra headers during an amend,
> because its running `git commit-tree` directly without any way to
> tell commit-tree this is for an amend of an existing commit, vs. a
> completely new commit... because either way its a new commit object.
>
>> Shouldn't an old git just ignore headers from a new git?
>
> Yes, see above.

Right, which seems to sum to up to "that boat sailed, forget about
it", which is fair enough.

Which I say from the point of view of arbitrary headers not approved
by the git dev team. You can ensure that any new *approved* headers
have the semantics that "if they arent passed through it doesnt
matter", whereas you cant know whether a header should be passed
through or not that comes from some other source.

Well unless you introduced a convention that some header prefix is to
be preserved on amend, but other prefixes shouldnt be.

I can imagine that might be a nasty place to go tho. :-)

Anyway, thanks a lot for taking the time to explain this a bit more.

cheers,
Yves





--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
