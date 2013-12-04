From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH 4/5] gitweb: Add a feature for adding more branch refs
Date: Wed, 4 Dec 2013 19:06:28 +0100
Message-ID: <CANQwDwe+a2P0Jxqw0k7sHWv3exdb4k+NU3jL3ogR-rcetd82TQ@mail.gmail.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com> <1386164583-14109-5-git-send-email-krzesimir@endocode.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 19:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoGqw-0005N3-Fw
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 19:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932909Ab3LDSHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Dec 2013 13:07:10 -0500
Received: from mail-we0-f173.google.com ([74.125.82.173]:34731 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932904Ab3LDSHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Dec 2013 13:07:09 -0500
Received: by mail-we0-f173.google.com with SMTP id u57so9730886wes.4
        for <git@vger.kernel.org>; Wed, 04 Dec 2013 10:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WLIkM3U0sUGYpJfWEOryqnVdDnktzwGwLOFg2On0q40=;
        b=I5sUYF3PLfst893STYlm9Ryl6EW3m+4NEVvUkoJbwX4G6QECnwRXzR1ivzBX+Py8t9
         fAMvU4GCbOHJ2QYUeYZJ6zZfmghA3hA7N7gf7kqB7REkgELmD144zEDbzhRjLz/lVPKh
         naPwZncQr3jXlPbeobbMG/FzZ9lZLWRNubIOfuaBPSTIDaweG/3BVG+afe1ZOHXhJQ07
         1C1earhfVNh+wTM6KKyknF9ngP1rN3q3BIiJqjUQc65p8cHGlsAao0njuV/ZWBcs+JFU
         9dsWYtpGnFCrMYF/LI0GhOSiNrLcmcCtpigMbPbL+9ylUerdpsTdNE/PGAu4nEyUtmii
         3sSw==
X-Received: by 10.180.188.229 with SMTP id gd5mr8516486wic.38.1386180428277;
 Wed, 04 Dec 2013 10:07:08 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Wed, 4 Dec 2013 10:06:28 -0800 (PST)
In-Reply-To: <1386164583-14109-5-git-send-email-krzesimir@endocode.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238797>

On Wed, Dec 4, 2013 at 2:43 PM, Krzesimir Nowak <krzesimir@endocode.com=
> wrote:
>
> Allow extra-branch-refs feature to tell gitweb to show refs from
> additional hierarchies in addition to branches in the list-of-branche=
s
> view.
>
> Signed-off-by: Krzesimir Nowak <krzesimir@endocode.com>
> Reviewed-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Jakub Nar=C4=99bski <jnareb@gmail.com>

This version is Helped-by (maybe), but not (yet!) Reviewed-by.

> ---
>  Documentation/gitweb.conf.txt | 37 +++++++++++++++++++
>  gitweb/gitweb.perl            | 85 +++++++++++++++++++++++++++++++++=
++++------
>  2 files changed, 110 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.con=
f.txt
> index e2113d9..5a77452 100644
> --- a/Documentation/gitweb.conf.txt
> +++ b/Documentation/gitweb.conf.txt
> @@ -849,6 +849,43 @@ time zones in the form of "+/-HHMM", such as "+0=
200".
>  +
>  Project specific override is not supported.
>
> +extra-branch-refs::
> +       List of additional directories under "refs" which are going t=
o
> +       be used as branch refs. For example if you have a gerrit setu=
p
> +       where all branches under refs/heads/ are official,
> +       push-after-review ones and branches under refs/sandbox/,
> +       refs/wip and refs/other are user ones where permissions are
> +       much wider, then you might want to set this variable as
> +       follows:
> ++
> +--------------------------------------------------------------------=
------------
> +$feature{'extra-branch-refs'}{'default'} =3D
> +       ['sandbox', 'wip', 'other'];
> +--------------------------------------------------------------------=
------------
> ++
> +If overriding was enabled then this feature can be configured on a

s/was/is/;

Perhaps it would better read as

    This feature can be configured on per-repository basis after settin=
g
    $feature{'extra-branch-refs'}{'override'} to true, via repository's
    `gitweb.extraBranchRefs` ...

> +per-repository basis via repository's `gitweb.extrabranchrefs`
> +configuration variable, which contains a space separated list of
> +refs. An example:
> ++
> +--------------------------------------------------------------------=
------------
> +[gitweb]
> +       extrabranchrefs =3D sandbox wip other
> +--------------------------------------------------------------------=
------------

O.K.

> ++
> +The gitweb.extrabranchrefs is actually a multi-valued configuration
> +variable, so following example is also correct and the result is the
> +same as of the snippet above:
> ++
> +--------------------------------------------------------------------=
------------
> +[gitweb]
> +       extrabranchrefs =3D sandbox
> +       extrabranchrefs =3D wip other
> +--------------------------------------------------------------------=
------------

I think this part should be better left for a separate patch. There is
important difference between single-valued and multi-valued configurati=
on
variable: with single-valued later occurrences override earlier ones,
which includes settings in more specific config file (e.g. per-reposito=
ry)
overriding setting in more general one (e.g. per-user or system-wide).

With multi-valued we won't be able to override earlier / more generic
settings... well, unless we add support for no-value, or empty-value
as clearer, i.e.

  [gitweb]
           extrabranchrefs =3D sandbox
           extrabranchrefs
 # or    extrabranchrefs =3D
           extrabranchrefs =3D wip other

resulting in ('wip', 'other').

> ++
> +It is an error to specify a ref that does not pass "git check-ref-fo=
rmat"
> +scrutiny. Duplicated values are filtered.
> +

Hmmm... 'snapshot' feature ignores invalid values, but in this case
formerly valid compression schemes might get invalid via tightening
%known_snapshot_formats, and we don't want existing config getting
suddenly invalid.

[cut]

Nice!

--=20
Jakub Narebski
