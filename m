From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] git-gui: fix browser with initial path
Date: Fri, 10 Dec 2010 09:48:43 +0100
Message-ID: <AANLkTim8BhN9czr6Jx5J28iNop4XdFDcNKbbjxddW9-i@mail.gmail.com>
References: <1290497870-28673-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 10 09:48:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQyeo-0005GJ-B2
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 09:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754667Ab0LJIso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Dec 2010 03:48:44 -0500
Received: from mail-iw0-f172.google.com ([209.85.214.172]:33792 "EHLO
	mail-iw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752207Ab0LJIso convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Dec 2010 03:48:44 -0500
Received: by iwn40 with SMTP id 40so4938165iwn.3
        for <git@vger.kernel.org>; Fri, 10 Dec 2010 00:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cujqkbl7RP0dGim7OdJFaTbhwRJ0xAt+F2X0nhjIkS0=;
        b=P2WQzNkpYSBnYCwqDYA6Zf+7i1EIuJP5i2SuSeReMafmOWql5hRIJL3oqn4kacW3Q+
         7bvLE/7pC0fmfagRB02pujXbiBD1s3IT66SxLClmd13iFvFkNnZV9JEUcyFaJIFhjll6
         SCyohFCBQCt6CpK4BNwnqYDsd1hnx29idD9cE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CMQhcxgVog8B+yCqoEjUOQm9McfQRJA5tt6fvRmoH53QmV3FRLxGUfDyL86xWgfqxS
         4rSXdIZawpjrr5E+L8uF78dDQKvsFGOHBg2hoyUER8hnB82WlVJ0bvhYZVffAUBHv+ga
         2ggizREhi0VicCxjUlQpgLKALFKFUXrgxOT/w=
Received: by 10.42.219.132 with SMTP id hu4mr273599icb.425.1291970923464; Fri,
 10 Dec 2010 00:48:43 -0800 (PST)
Received: by 10.42.176.193 with HTTP; Fri, 10 Dec 2010 00:48:43 -0800 (PST)
In-Reply-To: <1290497870-28673-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163394>

Ping.

On Tue, Nov 23, 2010 at 08:37, Bert Wesarg <bert.wesarg@googlemail.com>=
 wrote:
> The path given to the browser does not end in a slash, which results =
in bad
> path given to blame and broke [Up To Parent]. Also the path was not
> escaped before displaying.
>
> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
> ---
> =C2=A0git-gui/lib/browser.tcl | =C2=A0 =C2=A08 +++++++-
> =C2=A01 files changed, 7 insertions(+), 1 deletions(-)
>
> diff --git a/git-gui/lib/browser.tcl b/git-gui/lib/browser.tcl
> index c241572..a88a68b 100644
> --- a/git-gui/lib/browser.tcl
> +++ b/git-gui/lib/browser.tcl
> @@ -26,8 +26,14 @@ constructor new {commit {path {}}} {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wm withdraw $top
> =C2=A0 =C2=A0 =C2=A0 =C2=A0wm title $top [append "[appname] ([reponam=
e]): " [mc "File Browser"]]
>
> + =C2=A0 =C2=A0 =C2=A0 if {$path ne {}} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if {[string index =
$path end] ne {/}} {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 append path /
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0set browser_commit $commit
> - =C2=A0 =C2=A0 =C2=A0 set browser_path $browser_commit:$path
> + =C2=A0 =C2=A0 =C2=A0 set browser_path "$browser_commit:[escape_path=
 $path]"
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0${NS}::label $w.path \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-textvariable =
@browser_path \
> --
> tg: (6f10c41..) bw/git-gui/fix-browser-up (depends on: master)
>
