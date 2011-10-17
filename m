From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: fix multi selected file operation
Date: Mon, 17 Oct 2011 07:54:10 +0200
Message-ID: <CAKPyHN0iaS301r_d+kc-AVRNVKUprhdMwDpdD0HDf7nKbsPR3Q@mail.gmail.com>
References: <87cab38f99075f149a9abe7caf4ec139a0a48213.1318580310.git.bert.wesarg@googlemail.com>
	<87ehydhnwk.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Oct 17 08:00:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFgEu-00061A-IG
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 07:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754634Ab1JQFyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Oct 2011 01:54:12 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57454 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754453Ab1JQFyL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Oct 2011 01:54:11 -0400
Received: by vws1 with SMTP id 1so2247389vws.19
        for <git@vger.kernel.org>; Sun, 16 Oct 2011 22:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=Adz/sixC2Dr41uDvPnbdW2zVWVKvneqV17DPVcI8Jl0=;
        b=ADdxnjfel2YeRvoSBXMKE0l3sxYbI7v5m1KbJj5++OAf3RBWxLZV2AfRQP19EP9Nl4
         lwqcGGm6IFH4dgfmV7NvqbmYWDjYKBA7feh/oSgD7VONfVFsnu+c5gkHy5kFuTZSaWpa
         5F4bL9gUJZLhJgoB/uN3jzlGygykzxIEePhHk=
Received: by 10.52.112.135 with SMTP id iq7mr19126865vdb.51.1318830850465;
 Sun, 16 Oct 2011 22:54:10 -0700 (PDT)
Received: by 10.52.186.36 with HTTP; Sun, 16 Oct 2011 22:54:10 -0700 (PDT)
In-Reply-To: <87ehydhnwk.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183768>

Hi,

On Sun, Oct 16, 2011 at 00:48, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
> Bert Wesarg <bert.wesarg@googlemail.com> writes:
>
>>The current path for what we see the diff is not in the list of selec=
ted
>>paths. But when we add single paths (with Ctrl) to the set the curren=
t path
>>would not be used when the action is performed.
>>
>>Fix this by explicitly putting the path into the list before we start
>>showing the diff.
>>
>>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>---
>> git-gui.sh | =C2=A0 =C2=A01 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>
>>diff --git a/git-gui.sh b/git-gui.sh
>>index f897160..e5dd8bc 100755
>>--- a/git-gui.sh
>>+++ b/git-gui.sh
>>@@ -2474,6 +2474,7 @@ proc toggle_or_diff {w x y} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [concat $after [list ui_ready]]
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 } else {
>>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set selected_paths(=
$path) 1
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 show_diff $path $w =
$lno
>> =C2=A0 =C2=A0 =C2=A0 }
>> }
>
> It is not clear what I should be looking for to test this. Can you
> re-write the commit message to be more clear about what you are
> fixing. Is this multiple unstaged files in the staging box? If so I
> don't see what path display is changing.

Sorry, for this bad description. I will give you a recipe here what to
do to expose the problem. I try later to form this into a new commit
message:

You have 2 modified, not staged files A and B. Your current view shows
the diff for A. Adding B to the selection via Ctrl+Button1 and than
perform the "Stage To Commit" action from the "Commit" menu results
only in the staging of B.

Note, using Shift+Button1 (i.e. 'adding a range of files to the
selection') results in the staging of both files A and B.

Bert

>
> --
> Pat Thoyts =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0http://www.patthoyts.tk/
> PGP fingerprint 2C 6E 98 07 2C 59 C8 97 =C2=A010 CE 11 E6 04 E0 B9 DD
>
