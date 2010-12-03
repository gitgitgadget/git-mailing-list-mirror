From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCHv2 6/7] web--browse: use (x-)www-browser if available
Date: Fri, 3 Dec 2010 18:40:28 +0100
Message-ID: <AANLkTimAdrqYezL5jf9OR_J5XdYW-KYhYy9n_VQAUSD8@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 18:40:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POZcb-0005M2-Px
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 18:40:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753643Ab0LCRkc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 12:40:32 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:32872 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014Ab0LCRkb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 12:40:31 -0500
Received: by eye27 with SMTP id 27so5182774eye.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 09:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=h88Y+YAY9RECPduh2H/zF4zxOPKbVo5J3fn4x/8Rvk0=;
        b=WsgyRdg/DAZsYyAWJGHOSM+DQE2HxsrqW8DafA8mQLh7fpNmvZYxdyshdRgzhW52uy
         PKnrmsmt0wS8LbTdm9u3bZfDigndRgjLu4RtNFz1uUTdKSDoFEj5e1avhd6WxclADJ9j
         kXMZTWE+j8h/bQHAEPtMj3UGikz72jivSySts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YKLVjDG+Fs/V3jaAtHEWnD1JJL41nX9B6i97Z9awGRE1/MPsR0yNWnwADgaVuAhHS8
         OcJ+7+Un9o+tNGdNuLBcJLzeKbDkV/p6ynOUWbZYdqoqmnl6RA9IWXkN7Ik1IwxILtHf
         MHZC6ITJxB5aF7NPHtvxNVg9EKr2dbq16hOpk=
Received: by 10.216.161.130 with SMTP id w2mr1968076wek.17.1291398028528; Fri,
 03 Dec 2010 09:40:28 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Fri, 3 Dec 2010 09:40:28 -0800 (PST)
In-Reply-To: <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162816>

Hi,

On Fri, Dec 3, 2010 at 5:47 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> Debian and derivatives have an alternatives-based default browser
> configuration that uses the /usr/bin/gnome-www-browser,
> /usr/bin/x-www-browser and /usr/bin/www-browser symlinks.
>
> When no browser is selected by the user and the Debian alternatives a=
re
> available, try to see if they are one of our recognized selection and
> in the affermative case use it. Otherwise, warn the user about them
> being unsupported and move on with the previous detection logic.
>
> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
> ---
> =A0Documentation/git-web--browse.txt | =A0 =A04 ++
> =A0git-web--browse.sh =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 59 +++++++=
++++++++++++++++++++++++++++--
> =A02 files changed, 60 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-web--browse.txt b/Documentation/git-we=
b--browse.txt
> index c0416e5..de034a5 100644
> --- a/Documentation/git-web--browse.txt
> +++ b/Documentation/git-web--browse.txt
> @@ -36,6 +36,10 @@ The following browsers (or commands) are currently=
 supported:
>
> =A0Custom commands may also be specified.
>
> +If no default browser is specified, and /usr/bin/x-www-browser
> +(under X) or /usr/bin/www-browser is present, they are used to deter=
mine
> +the browser to use.

It looks like /usr/bin/gnome-www-browser is missing.

> +
> =A0OPTIONS
> =A0-------
> =A0-b <browser>::
> diff --git a/git-web--browse.sh b/git-web--browse.sh
> index d0e99f5..48ea168 100755
> --- a/git-web--browse.sh
> +++ b/git-web--browse.sh
> @@ -49,6 +49,38 @@ init_browser_path() {
> =A0 =A0 =A0 =A0test -z "$browser_path" && browser_path=3D"$1"
> =A0}
>
> +# check if a given executable is a browser we like
> +valid_exe() {
> + =A0 =A0 =A0 testexe=3D"$1"
> + =A0 =A0 =A0 basename=3D$(basename $(readlink -f "$testexe"))
> + =A0 =A0 =A0 if valid_tool "$basename" ; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$basename"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser_path=3D"$testexe"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 # if the linked executable doesn't match a browser name=
,
> + =A0 =A0 =A0 # look at the version string
> + =A0 =A0 =A0 verstring=3D"$("$testexe" --version 2> /dev/null)"
> + =A0 =A0 =A0 browser=3D"$(echo "$verstring" | head -n 1 | cut -f1 -d=
' ' | tr A-Z a-z)"
> + =A0 =A0 =A0 case "$browser" in
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mozilla)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$ver=
string" | head -n 1 | cut -f2 -d' ' | tr A-Z a-z)"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 google)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"google-chrom=
e"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
> + =A0 =A0 =A0 esac
> + =A0 =A0 =A0 if valid_tool "$browser" ; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser_path=3D"$i"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0
> + =A0 =A0 =A0 fi
> +
> + =A0 =A0 =A0 echo >&2 "$basename ($browser) is not a supported brows=
er, skipping"

Why not:

echo >&2 "$basename (from $testexe) is not a supported browser, skippin=
g"

?

Otherwise we might get something like:

"newbrowser (newbrowser) is not a supported browser, skipping"

> + =A0 =A0 =A0 browser=3D""
> + =A0 =A0 =A0 return 1
> +}
> +
> =A0while test $# !=3D 0
> =A0do
> =A0 =A0 =A0 =A0case "$1" in
> @@ -106,6 +138,26 @@ then
> =A0 =A0 =A0 =A0fi
> =A0fi
>
> +# Debian and derivatives use gnome-www-browser, x-www-browser or www=
-browser to
> +# set the default browser for the system. If the user did not specif=
y a tool and
> +# we detect that one of the *www-browser links to a supported one, w=
e pick it.
> +# Otherwise, we warn the user about them being unsupported and proce=
ed to look
> +# for a supported browser.
> +if test -z "$browser" ; then
> + =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/www-browser"
> + =A0 =A0 =A0 if test -n "$DISPLAY"; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/x-www-browser $w=
wwbrowser"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -n "$GNOME_DESKTOP_SESSION_ID";=
 then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/=
gnome-www-browser $wwwbrowser"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 fi
> + =A0 =A0 =A0 for i in $wwwbrowser; do
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -x $i && valid_exe $i ; then
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 fi
> + =A0 =A0 =A0 done
> +fi
> +
> =A0if test -z "$browser" ; then
> =A0 =A0 =A0 =A0if test -n "$DISPLAY"; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0browser_candidates=3D"firefox icewease=
l google-chrome chrome chromium chromium-browser konqueror opera seamon=
key iceape w3m elinks links lynx dillo"
> @@ -133,7 +185,7 @@ if test -z "$browser" ; then
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fi
> =A0 =A0 =A0 =A0done
> =A0 =A0 =A0 =A0test -z "$browser" && die "No known browser available.=
"
> -else
> +else if test -z "$browser_path"; then

Now that you reset $browser above, I am not sure this test -z
"$browser_path" is useful...

Thanks,
Christian.
