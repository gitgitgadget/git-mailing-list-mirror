From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: [PATCH] git-submodule should obey --quiet for subcommands
Date: Wed, 23 Sep 2009 22:33:30 +0100
Message-ID: <57518fd10909231433i773aff78kae6b763d0a533279@mail.gmail.com>
References: <57518fd10909210946p425d275fy76362a4b2ccc0e05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 23 23:33:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqZTK-0002Bb-S4
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 23:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751731AbZIWVds convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 Sep 2009 17:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbZIWVds
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 17:33:48 -0400
Received: from mail-yw0-f174.google.com ([209.85.211.174]:52433 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbZIWVdr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Sep 2009 17:33:47 -0400
Received: by ywh4 with SMTP id 4so1275091ywh.33
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 14:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=qJ2gI56xoSz050k8sTpO8j/scUxwldFWMBsn2Pjy3J4=;
        b=k8fQwXYLs6PJzI6bqYgF8AEurCABPGYlNwrztiF69cXQu/YaBC7pe/7rRobIaY7/Eo
         enYX/+ZaCPBg4jDLCnqxdAGn3zSPIJbL/nu/GR8c0luQBxs5dnImY8zTsSyfo652+c0y
         WLwMYsZA5ax8a1QivJGMiQd6538BteRX6/Dhc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=qiKXwHfJmZc/XAakkYMIXRJlY8Tfmj7GsQCzxfuSqYvs+gRcItGs5tnppQkXcUSl7f
         YGo89gqQCcDh3TpHu7LrX9ayfHXfHhUT24WpTUpI4F0oE+k+L3nsFF9yeqbfiDE0Qbi+
         TTlbR3QqQLQcz79Oi+t3/p3sDQpiKJkVR+UhI=
Received: by 10.150.254.16 with SMTP id b16mr5108521ybi.11.1253741631193; Wed, 
	23 Sep 2009 14:33:51 -0700 (PDT)
In-Reply-To: <57518fd10909210946p425d275fy76362a4b2ccc0e05@mail.gmail.com>
X-Google-Sender-Auth: fb1553403dba0ac1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129008>

On Mon, Sep 21, 2009 at 5:46 PM, Jonathan del Strother
<maillist@steelskies.com> wrote:
> Make sure that --quiet is passed through to git-clone & git-fetch.
>
> Signed-off-by: Jonathan del Strother <jon.delStrother@bestbefore.tv>
> ---
> clone & fetch are extremely noisy - perhaps something like the follow=
ing?
>
> =C2=A0git-submodule.sh | =C2=A0 =C2=A06 +++---
> =C2=A01 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-submodule.sh b/git-submodule.sh
> index bfbd36b..1e1066e 100755
> --- a/git-submodule.sh
> +++ b/git-submodule.sh
> @@ -106,9 +106,9 @@ module_clone()
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -n "$reference"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0then
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git-clone "$refere=
nce" -n "$url" "$path"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git-clone ${GIT_QU=
IET:+-q} "$reference" -n "$url" "$path"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git-clone -n "$url=
" "$path"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git-clone ${GIT_QU=
IET:+-q} -n "$url" "$path"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0die "Clone of '$url' into submodule path '=
$path' failed"
> =C2=A0}
> @@ -450,7 +450,7 @@ cmd_update()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if test -z "$nofetch"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(unset GIT_DIR; cd "$path" &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git-fet=
ch) ||
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git-fet=
ch ${GIT_QUIET:+-q}) ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die "Unable to fetch in submo=
dule path '$path'"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0fi
>
> --
> 1.6.5.rc1.44.ga1675.dirty
>


No takers?  Perhaps I should explain my interest in this patch : we
use Capistrano to deploy our Rails app which contains a bunch of
submodules.  It's done over ssh, so the 'git submodule update' step
during deployment spews something along the lines of :

Receiving objects: 0% (0/401), 1.55 MiB | 424 KiB/s
Receiving objects: 1% (4/401), 2.15 MiB | 612 KiB/s
Receiving objects: 2% (8/401), 2.90 MiB | 510 KiB/s
=2E...
=2E.
=2E

all the way up to 100% to the console.  Currently we're just directing
stdout to /dev/null, since --quiet failed to accomplish much, but it
seems like something along the lines of this patch would be useful.

Unless someone has a better implementation...?
