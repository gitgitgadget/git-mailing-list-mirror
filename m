From: Alex Bennee <kernel-hacker@bennee.com>
Subject: Re: [PATCH] Add -k option to cvsexportcommit to squash CVS keywords
Date: Mon, 1 Jun 2009 07:57:41 +0100
Message-ID: <b2cdc9f30905312357k3b2e876ald60a212d11213a8c@mail.gmail.com>
References: <b2cdc9f30905280636p404525e2u6f3eb21700b6da66@mail.gmail.com>
	 <7vk53xqap6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 08:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB1Sv-0000HU-Rl
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 08:57:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbZFAG5m convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2009 02:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752513AbZFAG5l
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 02:57:41 -0400
Received: from mail-pz0-f177.google.com ([209.85.222.177]:36950 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbZFAG5l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2009 02:57:41 -0400
Received: by pzk7 with SMTP id 7so5837721pzk.33
        for <git@vger.kernel.org>; Sun, 31 May 2009 23:57:42 -0700 (PDT)
Received: by 10.142.162.9 with SMTP id k9mr1745585wfe.129.1243839461913; Sun, 
	31 May 2009 23:57:41 -0700 (PDT)
In-Reply-To: <7vk53xqap6.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: b7f8355a33a41e95
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120447>

2009/5/31 Junio C Hamano <gitster@pobox.com>:
> Alex Bennee <kernel-hacker@bennee.com> writes:
>
>> <snip>
>>
>>
>> From a1a9477d6e332617526aaab488602552b77832d9 Mon Sep 17 00:00:00 20=
01
>
> Thanks.
>
> You would want to put all the commentary up to here below the "---" l=
ine,
> if you want to give an introductory text that is not part of your pro=
posed
> commit log message.

I'm not sure I quite follow. The email is an email with description
above followed by the output of git-format-patch -1. Or should the
email commentary be part of the commit commentary? Should I have just
fired the commit at the mailing list direct from the command line?

>
>> From: Alex Bennee <alex@bennee.com>
>> Date: Thu, 28 May 2009 14:31:51 +0100
>> Subject: [PATCH] Add -k option to cvsexportcommit to squash CVS keyw=
ords
>
> You generally do not want these three lines, unless the "From: " your
> e-mail shows is different from the name and e-mail of the real author=
 of
> the patch.
>
> I presume you would want alex-at-bennee-dot-com in the commit, so in =
this
> case it might be Ok, but then it may be more straightforward to use t=
hat
> name on the "From: " line of your e-mail to begin with, but on the ot=
her
> hand, you have a commit as kernel-dash-hacker-at-the-same-domain in o=
ur
> history already. =A0If you prefer the latter, you do not need any of =
the
> above three lines (the subject is the same as your e-mail "Subject: "
> anyway).

Hmmm yes. My actual email is as referenced, kernel-hacker is the alias
I use for my mailing list activity. If people have questions they wish
to email me directly about I would assume the master email makes the
best option for the commit message?

>
>> Depending on how your CVS->GIT conversion went you will have some
>> unexpanded CVS keywords in your
>> GIT repo. If any of your git commits touch these lines then the patc=
h
>> application will fail. This
>> patch addresses that by filtering files before applying the patch
>> ---
>
> The message is wrapped in a funny way, and it lacks sign-off.

Arrgh. It looks like the Google mail client has futzed with it. Trying
to get inline patches not munged by mail clients seems to be an
exercise in frustration. Usually I would create an attachment which
would then stay unmolested, however inline is the preferred posting
style for the list.

I'll resend with a sign-off.

>
> Isn't it "expanded" (not "unexpanded") keyword the problem you are tr=
ying
> to address? =A0"By filtering files" in what way? =A0I can guess "filt=
ering them
> back to unexpanded form", but please do not make me guess.

The files in the CVS tree will have expanded keywords, in the GIT tree
they will be in the unexpanded state. This patch will return the files
in the working CVS tree to the unexpanded state so the patch from the
GIT tree applies cleanly.

I'll try and re-word to make it clearer.

>
>> diff --git a/Documentation/git-cvsexportcommit.txt
>> b/Documentation/git-cvsexportcommit.txt
>> index 2da8588..b328dd4 100644
>> --- a/Documentation/git-cvsexportcommit.txt
>> +++ b/Documentation/git-cvsexportcommit.txt
>> @@ -63,6 +63,9 @@ OPTIONS
>> =A0-u::
>> =A0 =A0 =A0 Update affected files from CVS repository before attempt=
ing export.
>>
>> +-k::
>> + =A0 =A0 Filter CVS keywords (like $Revision$) before applying patc=
h.
>> +
>
> "Filter in what way" applies here as well.
>
> Is it really sufficient to unmunge "$Revision$? and "$Id"? =A0What ab=
out
> "$Date$", for example?

You're right. Lazily I had only hit the previous cases in the actual
problem files I had. I'll have a dig in the manual and add the rest.

>
>> @@ -266,9 +266,32 @@ foreach my $f (@files) {
>> =A0 =A0 =A0 $dirty =3D 1;
>> =A0 =A0 =A0 warn "File $f not up to date but has status '$cvsstat{$f=
}' in your
>> CVS checkout!\n";
>> =A0 =A0 =A0}
>> +
>> + =A0 =A0# Depending on how your GIT tree got imported some of the C=
VS
>> + =A0 =A0# expansion keywords would have been squashed. This will br=
eak
>> + =A0 =A0# application of the patch if you touched any lines that ha=
d them.
>
> I am not quite getting this comment. =A0"Squashed" sounds like "$Revi=
sion$"
> without expansion instead of "$Revision: 1.4 $"; I thought the issue =
you
> are addressing is that the automated change that comes from the CVS s=
ide
> to the expanded keyword gets in the way, i.e. if these always were
> "squashed", then you would not have to fight with spurious conflicts.
>
>> + =A0 =A0if ($opt_k)
>> + =A0 =A0{
>
> This open brace come on the same line as "if", like "if (...) {" to m=
atch
> the style of the surrounding code.
>
>> + =A0 =A0 my $orig_file =3D"$f.orig";
>> + =A0 =A0 rename $f, $orig_file;
>> + =A0 =A0 open(FILTER_IN, "<$orig_file") or die "Cannot open $orig_f=
ile\n";
>> + =A0 =A0 open(FILTER_OUT, ">$f") or die "Cannot open $f\n";
>> + =A0 =A0 while (<FILTER_IN>)
>> + =A0 =A0 {
>> + =A0 =A0 =A0 =A0 my $line =3D $_;
>> + =A0 =A0 =A0 =A0 $line =3D~ s#\$Revision:[ \.\d]+ \$#\$Revision\$#;
>> + =A0 =A0 =A0 =A0 $line =3D~ s#\$Id: [^\$]+\$#\$Id\$#;
>
> When there is no '/' in substitution or pattern, it is _far_ easier t=
o
> read if you used the standard s/foo/bar/, not custom s#foo#bar#.

I'd used # as there where \'s to escape some of the meta-characters
and I find large numbers of \/'s hard to follow.

>
> Can "$Revision:" immediately be followed by a digit while "$Id:" must
> always be followed by a whitespace? =A0I doubt it.
>
> Why isn't this something like:
>
> =A0 =A0 =A0 =A0$line =3D~ s/\$(Revision|Id|Date|....):[^\$]+\$/\$\1\$=
/g;
>
> or even (not bothering to enumerate the possible set of keywords):
>
> =A0 =A0 =A0 =A0$line =3D~ s/\$([A-Z][a-z]+):[^\$]+\$/\$\1\$/g;

I bow to your superior regex formulation ;-)

I'll resend in a bit.

--=20
Alex, homepage: http://www.bennee.com/~alex/
CV: http://www.bennee.com/~alex/cv.php
