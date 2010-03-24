From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Question about .git/objects/info/alternates
Date: Wed, 24 Mar 2010 14:23:15 -0500
Message-ID: <20100324192315.GA19322@progeny.tock>
References: <a038bef51003221026i379ee16ej6e0e6defcf0048dd@mail.gmail.com>
 <20100323024223.GA12257@progeny.tock>
 <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 24 20:23:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuWAr-0000xc-Nv
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 20:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932897Ab0CXTX0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Mar 2010 15:23:26 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44817 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932871Ab0CXTXU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 15:23:20 -0400
Received: by pwi5 with SMTP id 5so4240820pwi.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 12:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=5SXhYioiU13juOZKdaUZJplwZgYKfLAVuFa7cjj87y8=;
        b=dXR4tYjB/ICVzeb3KRTzNNTwj2aMnR+/Rx6RIqITHxDxJ8f4drpBT9I3l0gp7XCpzd
         jpy60HSvuRSf05V9rGfPoa8Za6joXBg2WbPm46fkd67h0lM7k4G5gsuPh5Ri7YUxHvEu
         UA9aRQc3WpVF0ssX2MED7jzpR0Zlv13FMRRRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Tqfjz+o86Lo/IgOebo/eofMYbkMLfU4/A/bmOOx0DUP4w0r+ZQ9jsTsFZeP0k8Eqc1
         b/2eodLOJPIHQ6RiMHR+UazRrE5YgejsqwQOCpiiSR9JsHh6XWvi/RKhoAF7n0PWiO36
         2pv+7Grf/HuZARaMnHZXWPWocNxAodTx027WU=
Received: by 10.114.250.19 with SMTP id x19mr4057140wah.4.1269458599256;
        Wed, 24 Mar 2010 12:23:19 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm269145iwn.11.2010.03.24.12.23.17
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 12:23:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a038bef51003241153g33445607qb3ab750e08b0584@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143108>

Chris Packham wrote:

> It occurs to me that the UI around alternates is a bit lacking i.e.
> there isn't a git command to display the alternates in use or to add
> them to an existing repository (or at least I couldn't find one
> skimming the docs or googling). So here's my attempt to add a 'git
> alternates' command which can display, add or remove an alternate.

Quite welcome!

Something like this explanation probably belongs in the commit
message.  That way, years down the line, people don=E2=80=99t need to t=
rawl
the list archives to see what your goal was.

Comments:

> From a5c64de20937da132376d717f19a1d52b54701d2 Mon Sep 17 00:00:00 200=
1
> From: Chris Packham <judge.packham@gmail.com>
> Date: Wed, 24 Mar 2010 11:34:11 -0700

Redundant next to the email header.  It is useful to be able to include
fields that differ from the e-mail header (often Subject:,
sometimes Date:, sometimes From:), but aside from that, this metadata
should be omitted when sending patches to the git mailing list.

> +#
> +# Runs through the alternates file calling the callback function $1
> +# with the name of the alternate as the first argument to the callba=
ck
> +# any additional arguments are passed to the callback function.
> +#
> +walk_alternates()
> +{
> +    local alternates=3D$GIT_DIR/objects/info/alternates
> +    local callback=3D$1

I couldn=E2=80=99t find any other uses of =E2=80=9Clocal=E2=80=9D in-tr=
ee.  I assume old shells
don=E2=80=99t support it.

Will this be a problem for recursion?  Maybe the callback should be
called in a subshell.

> +    shift
> +
> +    if [ -e $alternates ]; then
> +        while read line
> +        do
> +            $callback $line $*

Probably "$line" "$@" instead of $line $* would be more flexible.

> +#
> +# Walk function to display one alternate object store and, if the us=
er
> +# has specified -r, recursively call show_alternates on the git
> +# repository that the object store belongs to.
> +#
> +show_alternates_walk()
> +{
> +    say "Object store $1"
> +    say "    referenced via $GIT_DIR"
> +
> +    local new_git_dir=3D${line%%/objects}

use of local.

> +    if [ "$recursive" =3D=3D "true" -a "$GIT_DIR" !=3D "$new_git_dir=
" ]

Should use =3D instead of =3D=3D (portability).  Also git scripts tend =
to
spell out 'test' and avoid the -a and -o operators:

	if test "$recursive" =3D true && test "$GIT_DIR" !=3D "$new_git-dir"

though that is not a hard and fast rule.

> +add_alternate()
> +{
[...]
> +    touch $GIT_DIR/objects/info/alternates

Necessary?

> +    echo "$(readlink -f $dir)" >> $GIT_DIR/objects/info/alternates

Maybe

	readlink -f "$dir" >> $GIT_DIR/objects/info/alternates

would be simpler.

> +rewrite_alternates()
> +{
> +    if test "$1" !=3D "$2"; then
> +        echo $2 >> $3
> +    fi
> +}

What does this function do?  (Could use a comment.)

> +del_alternate()
> +{
[...]
> +    local alternates=3D$GIT_DIR/objects/info/alternates

use of local.

> +
> +    new_alts_file=3D$(mktemp $alternates-XXXXXX)

Not used elsewhere in git.  Is this needed?  Maybe a single
$GIT_DIR/objects/info/new-alternates.tmp or similar would be good
enough.

> +    # save the git from repeatedly reading a 0 length file
> +    if test $(stat -c "%s" $alternates) -eq 0; then

Not used elsewhere in core git.  test -s can help.

> +# Option parsing

See OPTIONS_SPEC in git-repack.sh for an example of how to simplify
this.

> +# Now go and do it
> +case $oper in
> +    add) add_alternate ;;
> +    del) del_alternate ;;
> +    *)   show_alternates ;;
> +esac

Thank you for your excellent work!  Looks very useful.

Regards,
Jonathan
