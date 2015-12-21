From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [git-for-windows] Case insensitive branch names
Date: Mon, 21 Dec 2015 20:08:12 -0000
Organization: OPDS
Message-ID: <93EE538CE2634272BABFCEB55C6A091E@PhilipOakley>
References: <D350A5BC87B74A53B5BE4B10BC658208@PhilipOakley> <CACsJy8CEYaf9NA4J_2u1cqsikYvtR7nz=FEiwAxsKMLSREDhCg@mail.gmail.com> <xmqqa8p3hfej.fsf@gitster.mtv.corp.google.com> <5678434B.5040506@web.de>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252;
	format=flowed	reply-type=original
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Git List" <git@vger.kernel.org>,
	"git-for-windows" <git-for-windows@googlegroups.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>,
	"Duy Nguyen" <pclouds@gmail.com>,
	=?Windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Dec 21 21:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aB6kn-0005j8-4K
	for gcvg-git-2@plane.gmane.org; Mon, 21 Dec 2015 21:08:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751783AbbLUUIP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Dec 2015 15:08:15 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:7174 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751766AbbLUUIN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Dec 2015 15:08:13 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2DnCQBIW3hWPH0FFlxeGQEBAg8BAQEBgwpSbYdOhQSxHwENgWQlhWIBAwEBgSw5FAEBAQEBAQEGAQEBAUABJBuELwUBAQEBAgEIAQEoAQUeAQEhCwIDBQIBAxUDCSUUAQQIEgYHAwYBDQYBEggCAQIDAQqHfwMKDAqzW4ctDRWDbgwhhlaEfoJTgWGDcoEaBY03iUkBgTKECIYYhB2TK4dcIAEBhEY+NAEBAYM0gUsBAQE
X-IPAS-Result: A2DnCQBIW3hWPH0FFlxeGQEBAg8BAQEBgwpSbYdOhQSxHwENgWQlhWIBAwEBgSw5FAEBAQEBAQEGAQEBAUABJBuELwUBAQEBAgEIAQEoAQUeAQEhCwIDBQIBAxUDCSUUAQQIEgYHAwYBDQYBEggCAQIDAQqHfwMKDAqzW4ctDRWDbgwhhlaEfoJTgWGDcoEaBY03iUkBgTKECIYYhB2TK4dcIAEBhEY+NAEBAYM0gUsBAQE
X-IronPort-AV: E=Sophos;i="5.20,460,1444690800"; 
   d="scan'208";a="76775379"
Received: from host-92-22-5-125.as13285.net (HELO PhilipOakley) ([92.22.5.125])
  by out1.ip02ir2.opaltelecom.net with SMTP; 21 Dec 2015 20:35:15 +0000
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282814>

=46rom: "Torsten B=F6gershausen" <tboegi@web.de>
>
> On 2015-12-21 18.37, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> On Mon, Dec 21, 2015 at 6:01 PM, Philip Oakley <philipoakley@iee.or=
g>=20
>>> wrote:
>>>> On the Git User's list, Diego J. reported that:
>>>>
>>>> 'When I "checkout" a branch using different Upper Case/Lower Case =
than=20
>>>> the
>>>> original, the branch doesn't show in "git branch [--list]"' [1]
>>>>
>>>> While case sensitivity for filenames is a common issue on Windows =
and=20
>>>> the
>>>> like, I haven't seen any discussion regarding ref name sensitivity=
 -=20
>>>> any
>>>> pointers to past discussions?
>>> Multiple ref backend [1] should solve this.
>> Yup, I had the same reaction.  Instead of restricting the namespace
>> of branches even on systems that do not have this problem, use a ref
>> backend that is not limited by the underlying filesystem.  A much
>> better solution.

My thought was more that on a case preserving FS we (that FS Git=20
implementation) might warn if they have ended up not on a valid branch =
name.=20
It felt wrong that the checkout reported success.

>>
>> In addition to the LMDB backend, it might not be a bad idea to add
>> another filesystem-based backend that encodes the refnames safely on
>> case insensitive or case destroying filesystem.  That way, those who
>> do not want an extra dependency but do want case sensitive refnames
>> would have an option, and having two non-default backends with quite
>> different semantics may be a good way to ensure that the API for
>> refs backend is kept sane.

A suitable case sensitive, case preserving backend would solve it for t=
hose=20
using it, which will be a help. Though those that don't will still need=
 to=20
be careful.

>
> This has been reported (probably a couple of times),
> one copy I have here was under "Branch Name Case Sensitivity"
> around Feb/March 2014.

=46ound the thread=20
http://thread.gmane.org/gmane.comp.version-control.git/242768/focus=3D2=
42846
though I try to avoid having a 'don't do that' response for some of the=
se=20
potentially hazardous cases (though the cost benefit may not justify it=
;-)

>
> The lstat() in refs.c can not be fixed, as the underlying OS/FS think=
s
> that lstat("nocase") =3D=3D lstat("NoCase") and
> open("nocase") =3D=3D NoCase").
>
> The the "real name" will not be detected, unless somebody does
> opendir(), readdir() and closedir().
> This is expensive (in terms of execution time), and nobody
> has tried to do something.

That's probably a key bit of info I didn't know - that the true file na=
me=20
can't be known without that overhead. Various stackoverflow Q&As [1] sh=
ow=20
that others have also had some difficulties...

>
> One cheap solution would be to run "git pack-refs" internally,
> either from C-code inside Git itself, or from a script.
>

--
Philip
[1] Windows methods of getting true file name (allegedly)
http://stackoverflow.com/questions/4763117/how-can-i-obtain-the-case-se=
nsitive-path-on-windows/4763137#4763137
http://stackoverflow.com/questions/478826/c-sharp-filepath-recasing/479=
198#479198
http://stackoverflow.com/questions/74451/getting-actual-file-name-with-=
proper-casing-on-windows
