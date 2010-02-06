From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 3/4] gitweb: show notes in log
Date: Sat, 6 Feb 2010 14:14:23 +0100
Message-ID: <cb7bb73a1002060514p33a4bcbdqb13d636cd6448998@mail.gmail.com>
References: <1265300338-25021-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<1265300338-25021-4-git-send-email-giuseppe.bilotta@gmail.com> 
	<201002061357.59245.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 06 14:14:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdkUu-0006G9-Kn
	for gcvg-git-2@lo.gmane.org; Sat, 06 Feb 2010 14:14:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab0BFNOq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Feb 2010 08:14:46 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:45853 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755485Ab0BFNOq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Feb 2010 08:14:46 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1029837eyd.19
        for <git@vger.kernel.org>; Sat, 06 Feb 2010 05:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dru8nobnnY9ZDeJfGnaQaFDcK6qIlCUY/MJMjdrpFjA=;
        b=STtzbVS+HtqpVTmMTpt3oon6WGxUAaAonki3TGnY2W38nr+aufEsUctFeBTpVa/gXt
         IGPY5y3QdNBOB5C9fs+xNOx1jQKjg0cptrmMYh1H/bZRBITCTbWYe1+mAoDQNa/svRDN
         CpLJo8Ux4W05mLWy/alcXPQq9rFP30dT3M7fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=VYsDPFCII7u4MTYt30FeKybh8EVo3VL/JX5dLv2QOhsQg865Tnkd3my3vd/LI0133S
         I5iNXKkAr5pwv56Iv6i5I6fGyu/RPgH9DtoiOQcZu75p+1kQL2nC7E40sb4DQh8+EzFc
         8ZuUc06qidMzwFHAe8EagxI5nqqc7kVoSTGDs=
Received: by 10.213.100.129 with SMTP id y1mr1766410ebn.47.1265462083234; Sat, 
	06 Feb 2010 05:14:43 -0800 (PST)
In-Reply-To: <201002061357.59245.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139162>

2010/2/6 Jakub Narebski <jnareb@gmail.com>:
> On Thu, 4 Feb 2010, Giuseppe Bilotta wrote:
>
>> The notes are shown in full to the left of the log message.
>
> Thats all good if you have wide (high resolution) screen, and your
> project follows common commit message conventions of keeping lines in
> commit message no longer than at most 80 characters, and you don't ne=
ed
> to use large size fonts.
>
> What happens if screen size is too small to contain both commit messa=
ge
> and notes? =A0Does it do the sensible thing of putting notes _below_
> commit message in such situation? =A0I do not know CSS+HTML enogh to
> answer this question myself.

The CSS forces the width of the notes div at 150px, which is the
amount left to the left of the commit message. This means that notes
will line-wrap, but they will not shift the text.

> BTW. signoff?


As usual, I forgot.

> P.S. We would probably want some support for notes also in feeds (Ato=
m
> and RSS feed), but this can be left for the future commit.

I honestly have absolutely no idea how to do that.

>> @@ -1631,6 +1631,7 @@ sub format_subject_html {
>> =A0# display notes next to a commit
>> =A0sub format_notes_html {
>> =A0 =A0 =A0 my %notes =3D %{$_[0]};
>> + =A0 =A0 my $tag =3D $_[1] || 'span' ;
>
> This could be
>
> =A0 =A0 =A0 =A0my $notes =3D shift;
> =A0 =A0 =A0 =A0my $tag =3D shift || 'span' ;
>
> and then use %$notes.

Would be much bettere, yes.

>> =A0 =A0 =A0 my $ret =3D "";
>> =A0 =A0 =A0 while (my ($ref, $text) =3D each %notes) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # remove 'refs/notes/' and an optional f=
inal s
>> @@ -1639,15 +1640,15 @@ sub format_notes_html {
>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # double markup is needed to allow pure =
CSS cross-browser 'popup'
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # of the note
>> - =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "<span title=3D'$ref' class=3D'n=
ote-container $ref'>";
>> - =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "<span title=3D'$ref' class=3D'n=
ote $ref'>";
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "<$tag title=3D'$ref' class=3D'n=
ote-container $ref'>";
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "<$tag title=3D'$ref' class=3D'n=
ote $ref'>";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 foreach my $line (split /\n/, $text) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D esc_html($line=
) . "<br/>";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> - =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "</span></span>";
>> + =A0 =A0 =A0 =A0 =A0 =A0 $ret .=3D "</$tag></$tag>";
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 if ($ret) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 return "<span class=3D'notes'>$ret</span>"=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return "<$tag class=3D'notes'>$ret</$tag>"=
;
>> =A0 =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return $ret;
>> =A0 =A0 =A0 }
>
> Nice trick, but is this distinction really necessary?

I think so.  The distinction is useful both from the structural point
of view (block elements with block elements, inline elements with
inline elements) and for CSS selection (the block case has totally
different styling than the inline case).

>> + =A0 =A0 =A0 =A0 =A0 =A0 print "$notes\n";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "<div class=3D\"log_body\">\n";
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_print_log($co{'comment'}, -final_emp=
ty_line=3D> 1);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "</div>\n";
>
> With respect to the question about what happens if the screen is not
> wide enough, shouldn't notes be put in HTML source below body (commit
> message)?

As I mentioned, notes width is fixed at the amount of the whitespace
to the left of the log, so this should not be an issue. Additionally,
putting notes below makes it much harder to let them float to the left
of the log body.


--=20
Giuseppe "Oblomov" Bilotta
