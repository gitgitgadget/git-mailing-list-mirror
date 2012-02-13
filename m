From: =?iso-8859-1?Q?Sidney_San_Mart=EDn?= <s@sidneysm.com>
Subject: Re: [PATCH] Support wrapping commit messages when you read them
Date: Mon, 13 Feb 2012 16:26:24 -0500
Message-ID: <46957CEB-5E48-4C11-8428-9A88C3810548@sidneysm.com>
References: <8DE6E894-B50D-4F7E-AE18-C10E7E40A550@sidneysm.com> <7vfwg99dom.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 13 22:26:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rx3Ps-0004Yb-F4
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 22:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758180Ab2BMV01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Feb 2012 16:26:27 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42474 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755973Ab2BMV00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Feb 2012 16:26:26 -0500
Received: by qadc10 with SMTP id c10so1909808qad.19
        for <git@vger.kernel.org>; Mon, 13 Feb 2012 13:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sidneysm.com; s=google;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=QMf9hUZ+Rf76KM3L3JbBuG/JUuBMOZFKcxuiOI22ws4=;
        b=ocE27TQ2XByimJzB59LxtxmOgWyPLD5tObG2wwhmUPnznP8M1ktEsfAPQt+Ov2VXhU
         mn4ItRzxTDBACiGK5EjgRirsV10+oaWPkTbkMppRpUdbVMuPSb+t8DcJax1j+OsaEdSx
         4Ty8VT/GwDqWJUDRfv1P2wA6jqUataZ7CzxdU=
Received: by 10.229.77.66 with SMTP id f2mr10396000qck.4.1329168385398;
        Mon, 13 Feb 2012 13:26:25 -0800 (PST)
Received: from [10.66.81.164] (h-64-236-128-13.nat.aol.com. [64.236.128.13])
        by mx.google.com with ESMTPS id gr8sm7936425qab.19.2012.02.13.13.26.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 13 Feb 2012 13:26:24 -0800 (PST)
In-Reply-To: <7vfwg99dom.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
X-Gm-Message-State: ALoCoQnPhwRNOgwnNJX1McfMWPJHgXqMG2rJMbgZENHaQgYoZYzyTxnA7/tzrfrXKP7Y3535+jNM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190675>

Hey Junio,

I apologize for the delay, I do want to keep working on this idea. I ha=
d to put it down but should have more time now if you're willing to kee=
p talking about it.

Thanks for taking the time to look at my first patch.

On Dec 25, 2011, at 4:57 AM, Junio C Hamano wrote:

>> Fairly simpleminded line wrapping that makes commit messages
>> readable if they weren=92t wrapped by the committer.
>=20
> This does not say anything useful, other than "this is a na=EFve
> implementation of message wrapper" and invites "So what?".
>=20
> The most simple-minded solution is to reject such commits with crappy=
 log
> message.
>=20
> After all, SCM is merely a method to help communication between
> developers, and sticking to the common denominator is a proven good w=
ay to
> make sure everybody involved in the project can use what is recorded =
in
> the repository. This is not limited only to the log message, but equa=
lly
> applies to filenames (e.g. don't create xt_tcpmss.c and xt_TCPMSS.c i=
n the
> same directory if you want your project extractable on case insensiti=
ve
> filesystems) and even to the sources.
>=20
> You need to justify the cause a bit better. Why is such a new logic
> justified?

You=92re right, that sentence doesn't say anything.

I agree that projects need to have standards for their commit messages,=
 but I also think that line wrapping should be taken care of by the com=
puter so that the humans can think about the content of their commit me=
ssages. It's easier for everyone.

It also makes sense to not assume the user is using an 80-column termin=
al. Like I mentioned in another email, other tools work this way (e.g. =
manpages). It turns out that "git help" already has code to detect the =
width of the terminal, and it formats its output to fit it. I want to a=
dapt that logic for this feature.

How about replacing that paragraph with this:

=93Git didn=92t previously support formatting commit messages for a use=
r=92s terminal, and the common practice has been to pre-wrap commit mes=
sages to under 80 columns. This is necessary for some projects, especia=
lly those which trade patches over email where mail clients might damag=
e longer lines, but in many cases it=92s only done so that the messages=
 are readable in "git log" and the like. Supporting line wrapping in gi=
t lets users choose to leave their commit messages unwrapped and have t=
hem formatted for their terminal when displayed.=94

>> - Use strbuf_add_wrapped_text() to do the dirty work
>> - Detect simple lists which begin with "+ ", "* ", or "- " and inden=
t
>>  them appropriately (like this line)
>> - Print lines which begin with whitespace as-is (e.g. code samples)
>=20
> I suspect the above would make it more palatable than format=3Dflowed
> brought up in earlier discussions, which is unsuitable for nothing bu=
t
> straight text.
>=20
>> Add --wrap[=3D<width>] and --no-wrap to commands that pretty-print c=
ommit
>> messages, and add log.wrap and log.wrap.width configuration options.
>=20
> Why do you need two separate options and configurations that look as =
if
> they are independent but in reality not?  If you say "no wrap", there=
 is
> no room for you to say "wrap width is 72".
>=20
> I would expect something like:
>=20
> --log-message-wrap, --log-message-wrap=3D72, --log-message-wrap=3Dno=20
>=20
> with --log-message-wrap=3Dyes as a synonym for --log-message-wrap to =
give
> consistency. The corresponding configuraiton would be log.messageWrap
> whose values could be the usual bool-or-int.

I stole this from other options: --progress/--no-progress, --color/--co=
lor=3D[<when>]/--no-color, --track/--no-track, etc.

The separate wrap/wrap.width config options were so that you could set =
it separately to auto or always and also specify a width. But, I don't =
know if that's needed anymore. See below.

>> log.wrap defaults to never, and can be set to never/false, auto/true=
,
>> or always. If auto, hijack want_color() to decide whether it=92s
>> appropriate to use line wrapping. (This is a little hacky, but as fa=
r
>> as I can tell the conditions for auto color and auto wrapping are th=
e
>> same.
>=20
> Why does coloring have _anything_ to do with line wrapping? Maybe you=
r
> personaly preference might be "wrap and color if interactive terminal=
" but
> that is conflating two unrelated concepts. A user may not expect colo=
ring
> on a dumb interactive terminal, but wrapping may still be useful.

It doesn=92t =97 I used want_color() so that I could get the patch out =
there without making other changes to the codebase or duplicating its c=
ode, so you could comment on the rest of it. I'll get it out of the nex=
t version of the patch, which I'll try to get to you later today or tom=
orrow.

>> log.wrap.width defaults to 80.
>=20
> This does not deserve a comment as I already rejected the "two
> configuration" approach, but do not use three-level names this way. W=
e try
> to reserve three-level names only for cases where the second level is=
 used
> for an unbound collection (e.g. "remote.$name.url", "branch.$name.mer=
ge").
> that is user-specified.

OK, that was a misunderstanding on my part. Actually, I would be in fav=
or of getting rid of that option completely, moving in support for dete=
cting the terminal width from "git help" and making it just a boolean, =
auto-only. How does that sound?

Sidney