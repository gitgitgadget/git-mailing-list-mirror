From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: support for underline styles
Date: Fri, 19 Nov 2010 11:55:09 +0100
Message-ID: <AANLkTikmFOQfv6y50JHiWef-BPyOBxUNrOohrxmoThOe@mail.gmail.com>
References: <1289815498-12287-1-git-send-email-bert.wesarg@googlemail.com>
	<87oc9lhbjx.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Nov 19 11:55:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJOci-0003ni-Sb
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 11:55:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649Ab0KSKzN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Nov 2010 05:55:13 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:39150 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0KSKzM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 05:55:12 -0500
Received: by wwa36 with SMTP id 36so4470402wwa.1
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 02:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=MKC9UD9ZhmC5HUJcJxasO8M6I2cVdbVGA5AdCegVgEk=;
        b=HDF4yHJQEL13gwMCdcyQ7qY61u1WUOKCaryMZO4j00M4Hgqt15mCEyVHgGEEMCvKDP
         B1R+f8JJgvVZJ7Rl029+KM0d1voQ8N7AdvosoudsRusyI5LjG2ljFonkVNOf43yPUS3/
         xsXMFaojG1Sp+OalZ04XCJ8GApL662YXekqcU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=pGdzFEVfYveKmDB7/CdqRZXPZEtt4lW0HTprnib2EyHvk+0diQ5+dUue+X2kBtOcJB
         jWQJO0M80f5wioMD7b88+oLUJNZQ6OantXVlnZt2g9cJFBEz3aPkY2LTLwSicmFXMxnt
         ZSMVpDVYLCp42ufRVPc8phxjMAclH56TPZNK8=
Received: by 10.227.38.143 with SMTP id b15mr2054715wbe.167.1290164110055;
 Fri, 19 Nov 2010 02:55:10 -0800 (PST)
Received: by 10.227.157.149 with HTTP; Fri, 19 Nov 2010 02:55:09 -0800 (PST)
In-Reply-To: <87oc9lhbjx.fsf@fox.patthoyts.tk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161733>

On Fri, Nov 19, 2010 at 11:00, Pat Thoyts
<patthoyts@users.sourceforge.net> wrote:
>
> Suggested-by: Bert Wesarg <bert.wesarg@googlemail.com>
> Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
> ---
>
> I left underline out because I reckon it would just make text harder =
to
> read on a gui display. It seems like the option would only be useful =
on
> monochrome terminals.
>
> If we do want to support underlines in the diff view window then we c=
an
> have a different tag rather than replicating each color to get a
> underlined version of the same color.
> Something like the following should do it:

Thanks for this simple implementation. My only concern left is the
ordering. If we have '\033[7;4;30m' than we end up using 'clri4' as
tag, which does not exists. I suspect that git does not produce such
unordered attributes. But for clarity I would suggest to keep my lsort
around the split command.

Bert

>
>
> =C2=A0git-gui.sh =C2=A0 | =C2=A0 =C2=A01 +
> =C2=A0lib/diff.tcl | =C2=A0 =C2=A02 +-
> =C2=A02 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui.sh b/git-gui.sh
> index d3acf0d..137cd72 100755
> --- a/git-gui.sh
> +++ b/git-gui.sh
> @@ -3330,6 +3330,7 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow=
4 4 blue4 5 magenta4 6 cyan4 7 gr
> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ui_diff tag configure clri3$n -background=
 $c
> =C2=A0}
> =C2=A0$ui_diff tag configure clr1 -font font_diffbold
> +$ui_diff tag configure clr4 -underline 1
>
> =C2=A0$ui_diff tag conf d_cr -elide true
> =C2=A0$ui_diff tag conf d_@ -font font_diffbold
> diff --git a/lib/diff.tcl b/lib/diff.tcl
> index 0579fa6..203ab07 100644
> --- a/lib/diff.tcl
> +++ b/lib/diff.tcl
> @@ -473,7 +473,7 @@ proc read_diff {fd cont_info} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0set prefix clr
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0foreach style [split $colbegin ";"] {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if {$style eq "7"} {append pr=
efix i; continue}
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {$style < 30 || $style > 47} {co=
ntinue}
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {$style !=3D 4 && ($style < 30 |=
| $style > 47)} {continue}
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set a "$mark linestart + $pos=
begin chars"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0set b "$mark linestart + $pos=
end chars"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0catch {$ui_diff tag add $pref=
ix$style $a $b}
> --
> 1.7.3.1.msysgit.0
>
>
