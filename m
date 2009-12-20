From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Sun, 20 Dec 2009 15:23:11 +0000
Message-ID: <a5b261830912200723s131f0b93w2f5ab94f19faf86a@mail.gmail.com>
References: <87my1ev4gi.fsf@users.sourceforge.net>
	 <alpine.DEB.1.00.0912201412420.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>, msysgit@googlegroups.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 20 16:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMNcu-0005s2-Cj
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 16:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753760AbZLTPXP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Dec 2009 10:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbZLTPXP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Dec 2009 10:23:15 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:39087 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbZLTPXO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Dec 2009 10:23:14 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1148625eyd.19
        for <git@vger.kernel.org>; Sun, 20 Dec 2009 07:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AnWeTwEfHr66uKJDHp9Z+NPEA+j48eLrqHArvx9reYI=;
        b=wYzuDWY4G0sLBNp6aO9hxnfjeuoTRF9Z0Er4373YgwEsQFCUAh9paQ2F7S9qZxaHor
         eIAl5WcVRWxb+tqSVOrXrppWWMgSHjhN7+O1Ub4vEC3jZCNz8BOzHKm95hDn3rli6Atc
         hOmUVnlhAeDhgSLb+8zmeXZ686WFOsZVG1we0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=g1bDfSd2qHl8lCtccnRpPcP6FXwPE6qwrJL8X2tVMNcaKlykb1DX9Erh7fbb1YIjb8
         iL0nztndOXvFXIypnEc7l68jtEAiVM+tP/LRRhAu4yhTvMZC3ynI8xDIwzaBLNEueBL3
         qPHg+DolJChsAhdvF33ddCvWTEEzj6G+5d/lU=
Received: by 10.216.88.137 with SMTP id a9mr2269288wef.119.1261322591938; Sun, 
	20 Dec 2009 07:23:11 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0912201412420.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135530>

2009/12/20 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>>
>> =C2=A0On Windows and MacOSX ttk defaults to the native look as much =
as possible.
>> =C2=A0On X11 the user may select a theme using the TkTheme XRDB reso=
urce class.
>
> Maybe you could describe a quick way to set that resource?

echo '*TkTheme: clam' | xrdb -merge -

Or edit ~/.Xdefaults or maybe ~/.Xresources to add a line containing
 *TkTheme: clam
Used to be the X resource database was the way to customize X11. The
builtin themes are:
default: thin borders, kind of windows98ish
classic: motif style
alt: more windowsy still.
clam: based on some version of the XFCE look a few years ago.

On Windows you also get winnative, xpnative or vista but the intention
is that Tk just makes everything look native by selecting the correct
theme when it starts up. MacOSX gets an aqua theme. There is some work
in progress to get the Qt or Gtk styling engines to draw the ttk
elements so that it can pick up the current GNOME/KDE desktop -
effectively making it look native on such systems there too. However,
on Windows is where this stuff makes the most difference and works
best.

You can of course just run git-gui in any git repository to see how it
looks at the moment. However I put up another screenshot at
http://www.patthoyts.tk/screenshots/git-gui-old.png which is the
unmodified git-gui code with tcl8.5. The fonts look worse with 8.4
(even on windows).

> As to the patch: it is huge. =C2=A0I suspect that it would be easier =
to read
> and verify if it was done in two patches: the first one introducing h=
elper
> procs that replace the existing repeated code, and a second patch tha=
t
> modifies only the helper procs to handle ttk if desired. =C2=A0You di=
d that
> with pad_label, but that proc is not defined in a central place, but
> limited to about.tcl.

I could split it up but it is quite hard to validate without switching
themes to ensure you got everything. I toggle through some themes
looking for unchanged widgets or rogue borders.
I did find a bug in the choose_rev conversion when I rechecked with
tcl 8.4 so I will reissue this.

Pat Thoyts
