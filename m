From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: fix multi selected file operation
Date: Tue, 18 Oct 2011 08:31:39 +0200
Message-ID: <CAKPyHN0NUyd2E0UuJGpWoFNQw8h4kUkqP5Lcz0ywKjFNEgXsqw@mail.gmail.com>
References: <87cab38f99075f149a9abe7caf4ec139a0a48213.1318580310.git.bert.wesarg@googlemail.com>
	<87ehydhnwk.fsf@fox.patthoyts.tk>
	<CAKPyHN0iaS301r_d+kc-AVRNVKUprhdMwDpdD0HDf7nKbsPR3Q@mail.gmail.com>
	<877h43l0f3.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Oct 18 08:31:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RG3DG-0004nV-RA
	for gcvg-git-2@lo.gmane.org; Tue, 18 Oct 2011 08:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755672Ab1JRGbm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Oct 2011 02:31:42 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50241 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab1JRGbl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2011 02:31:41 -0400
Received: by vcge1 with SMTP id e1so224621vcg.19
        for <git@vger.kernel.org>; Mon, 17 Oct 2011 23:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GUa/j87MCxiQ2I1vCIpNL0V8OPta6O8i3UssRnQJkMU=;
        b=bwl6y2wFPclUReNSPjd0iUiaHXahJzy3r1QIwxhHqY7IoRDqG+zBvACuWONYVf3jEQ
         NPM0j2OO0S+Ffywy+oAf1YSUy+TTljO40sbNeu36J6sIYANjXIsA2c6BDMb8ltZgPu9Q
         XyFHnF8etiSLn63YAS1v5ZEp9gdRnWmaCrzx4=
Received: by 10.52.69.9 with SMTP id a9mr1040544vdu.17.1318919499963; Mon, 17
 Oct 2011 23:31:39 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Mon, 17 Oct 2011 23:31:39 -0700 (PDT)
In-Reply-To: <877h43l0f3.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183861>

On Tue, Oct 18, 2011 at 00:26, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>Hi,
>>
>>On Sun, Oct 16, 2011 at 00:48, Pat Thoyts
>><patthoyts@users.sourceforge.net> wrote:
>>> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>>>
>>>>The current path for what we see the diff is not in the list of sel=
ected
>>>>paths. But when we add single paths (with Ctrl) to the set the curr=
ent path
>>>>would not be used when the action is performed.
>>>>
>>>>Fix this by explicitly putting the path into the list before we sta=
rt
>>>>showing the diff.
>>>>
>>>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>>>---
>>>> git-gui.sh | =C2=A0 =C2=A01 +
>>>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>>>
>>>>diff --git a/git-gui.sh b/git-gui.sh
>>>>index f897160..e5dd8bc 100755
>>>>--- a/git-gui.sh
>>>>+++ b/git-gui.sh
>>>>@@ -2474,6 +2474,7 @@ proc toggle_or_diff {w x y} {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [concat $after [list ui_ready]]
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>>>> =C2=A0 =C2=A0 =C2=A0 } else {
>>>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set selected_path=
s($path) 1
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 show_diff $path $=
w $lno
>>>> =C2=A0 =C2=A0 =C2=A0 }
>>>> }
>>>
>>> It is not clear what I should be looking for to test this. Can you
>>> re-write the commit message to be more clear about what you are
>>> fixing. Is this multiple unstaged files in the staging box? If so I
>>> don't see what path display is changing.
>>
>>Sorry, for this bad description. I will give you a recipe here what t=
o
>>do to expose the problem. I try later to form this into a new commit
>>message:
>>
>>You have 2 modified, not staged files A and B. Your current view show=
s
>>the diff for A. Adding B to the selection via Ctrl+Button1 and than
>>perform the "Stage To Commit" action from the "Commit" menu results
>>only in the staging of B.
>>
>>Note, using Shift+Button1 (i.e. 'adding a range of files to the
>>selection') results in the staging of both files A and B.
>>
>>Bert
>
> Ah ok - that explains things and I can see the issue now. I think
> something like:
>
> "When staging a selection of files using Shift-Click to choose a rang=
e
> of files then using Ctrl-T or the Stage To Commit menu item will stag=
e
> all the selected files. However if a non-sequential range is selected
> using Ctrl-Click then only the last name selected gets staged. This
> commit fixes this to properly stage all selected files by explicitly
> adding the path to the list before showing the diff."

Thanks for this. A slight, but important, change to the second last sen=
tence:

"...using Ctrl-Click then all but the first name selected gets staged."

Its the first which does not get staged. Ie. that one, which was
selected just by a Click to view the diff.

Bert

>
> will do.
>
> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
