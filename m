From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: delegate selection from gutter columns to text output
Date: Sat, 22 Oct 2011 17:41:51 +0200
Message-ID: <CAKPyHN1zTJsE5-T5LdN=86iKdQ7=SGxuVacw8aE4DvmbX4srHw@mail.gmail.com>
References: <5fc6f5d088e37508f1911f89b4d82932071045e0.1319139888.git.bert.wesarg@googlemail.com>
	<87ehy63rvx.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Sat Oct 22 17:47:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHdn3-0001hV-O8
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 17:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753562Ab1JVPly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 22 Oct 2011 11:41:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58163 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526Ab1JVPly convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 22 Oct 2011 11:41:54 -0400
Received: by vws1 with SMTP id 1so3603640vws.19
        for <git@vger.kernel.org>; Sat, 22 Oct 2011 08:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=FiMrUEnG7ey6o0ulLuieABTjaqOIYTmApMKYBp8/YwQ=;
        b=QhPEJMgJ/3kxrulTAQ/cbrbBoZQj/AKhH1SD3jwYNemoICYcPlO1Xy1TCcgD+A4LGR
         nqw3D7IEZZ+aztfyIF18gKwH2RQj9Pvf2PHxJC1wTfM0w1nwxR4K666IEtiWgutAnEqY
         cRARGoYIWHNDFWgwaPuffhx+l0//vIwZiepnI=
Received: by 10.52.72.196 with SMTP id f4mr17919213vdv.68.1319298111125; Sat,
 22 Oct 2011 08:41:51 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Sat, 22 Oct 2011 08:41:51 -0700 (PDT)
In-Reply-To: <87ehy63rvx.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184101>

On Sat, Oct 22, 2011 at 00:24, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>Selecting in the gutter columns of the blame view should make no sens=
e,
>>so delegate any selection action in these columns to the text output
>>by selecting whole lines there.
>>
>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>---
>> git-gui.sh =C2=A0 =C2=A0| =C2=A0 20 ++++++++++++++++++++
>> lib/blame.tcl | =C2=A0 =C2=A04 +++-
>> 2 files changed, 23 insertions(+), 1 deletions(-)
>>
>>diff --git a/git-gui.sh b/git-gui.sh
>>index 21033cb..cf5ed79 100755
>>--- a/git-gui.sh
>>+++ b/git-gui.sh
>>@@ -2077,6 +2077,26 @@ proc many2scrollbar {list mode sb top bottom} =
{
>> =C2=A0 =C2=A0 =C2=A0 foreach w $list {$w $mode moveto $top}
>> }
>>
>>+proc delegate_sel_to {w from} {
>>+ =C2=A0 =C2=A0 =C2=A0set bind_list [list \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<Button-1> \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<B1-Motion> \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<Double-Button-1> \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<Triple-Button-1> \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<Shift-Button-1> \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<Double-Shift-Butto=
n-1> \
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<Triple-Shift-Butto=
n-1> \
>>+ =C2=A0 =C2=A0 =C2=A0]
>>+
>>+ =C2=A0 =C2=A0 =C2=A0foreach seq $bind_list {
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set script [bind Te=
xt $seq]
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set new_script [str=
ing map [list %W $w %x 0 word line] $script]
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0foreach f $from {
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0bind $f $seq "$new_script; break"
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>+ =C2=A0 =C2=A0 =C2=A0}
>>+}
>>+
>> proc incr_font_size {font {amt 1}} {
>> =C2=A0 =C2=A0 =C2=A0 set sz [font configure $font -size]
>> =C2=A0 =C2=A0 =C2=A0 incr sz $amt
>>diff --git a/lib/blame.tcl b/lib/blame.tcl
>>index 49eae19..9ab0da5 100644
>>--- a/lib/blame.tcl
>>+++ b/lib/blame.tcl
>>@@ -210,6 +210,8 @@ constructor new {i_commit i_path i_jump} {
>>
>> =C2=A0 =C2=A0 =C2=A0 set w_columns [list $w_amov $w_asim $w_line $w_=
file]
>>
>>+ =C2=A0 =C2=A0 =C2=A0delegate_sel_to $w_file [list $w_amov $w_asim $=
w_line]
>>+
>> =C2=A0 =C2=A0 =C2=A0 ${NS}::scrollbar $w.file_pane.out.sbx \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -orient h \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -command [list $w_f=
ile xview]
>>@@ -315,7 +317,7 @@ constructor new {i_commit i_path i_jump} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $i conf -yscrollcom=
mand \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 "[list ::searchbar::scrolled $finder]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0[list many2scrollbar $w_columns yview $w.file_pane.out.sb=
y]"
>>- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bind $i <Button-1> =
"
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bind $i <Button-1> =
"+
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 [cb _hide_tooltip]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 [cb _click $i @%x,%y]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 focus $i
>
> The patch seems to be fine but I don't think I agree with the intenti=
on
> here. Currently clicking anywhere that is not marked as a link (blue
> underlined text) selects a commit and shows information in the lower
> pane. With this change, the left hand columns become inactive in rega=
rds
> to selecting a commit. I don't see why that is desirable.

Sorry, this was not intended. And I thought I took care for it with
the last hunk. I have a look at it again.

Bert

>
> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
