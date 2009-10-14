From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] checkout: add 'pre-checkout' hook
Date: Wed, 14 Oct 2009 08:49:10 +0200
Message-ID: <36ca99e90910132349o25322021l266124bd8b0d30b3@mail.gmail.com>
References: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, elliot@catalyst.net.nz
To: Sam Vilain <sam.vilain@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Wed Oct 14 08:55:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxxlY-0007wB-SG
	for gcvg-git-2@lo.gmane.org; Wed, 14 Oct 2009 08:55:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbZJNGtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 14 Oct 2009 02:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754817AbZJNGtt
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Oct 2009 02:49:49 -0400
Received: from mail-fx0-f227.google.com ([209.85.220.227]:60887 "EHLO
	mail-fx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754582AbZJNGts convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2009 02:49:48 -0400
Received: by fxm27 with SMTP id 27so11156982fxm.17
        for <git@vger.kernel.org>; Tue, 13 Oct 2009 23:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xDHwXkpdbUyscAXYcPgq/eDyLEnclIQaDUChPYpL318=;
        b=pv3mC6scR458mWJBHyt1ETsN2AuCzu9vNisqbYa4T4akZjd49tdNTZ1BFXJ8JvLgTO
         9iYwHnQa6sw1Yiq/X+VoRTj7/5wZjxMoDHVh6jnbIzz5SMRfCeVMq7/j2nWGdgB7v86l
         AO38wQJD/8tAUk3AzjYo5Ku8ry6HpgrLXHOOs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=GFpH/A9gkicmc2pg+JiZJosFbzGP1URM/b7w+f6FfMXiJiCBrkY9o6mkJcU6sTQD2o
         a/nVR6MEZAeF7YXEZ24cuBw9RjnvJdaTDSgeoSynBYpiMJHJ6k6UFWiyvnAAR6HTbJOq
         PCn5jsJhK5pJ3oqSVY2wtjKIi3RV8y5Xlx28A=
Received: by 10.223.17.65 with SMTP id r1mr2050179faa.5.1255502950553; Tue, 13 
	Oct 2009 23:49:10 -0700 (PDT)
In-Reply-To: <1255495525-11254-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130261>

On Wed, Oct 14, 2009 at 06:45, Sam Vilain <sam.vilain@catalyst.net.nz> =
wrote:
> diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
> index 06e0f31..8dc3fbf 100644
> --- a/Documentation/githooks.txt
> +++ b/Documentation/githooks.txt
> @@ -143,21 +143,31 @@ pre-rebase
> =C2=A0This hook is called by 'git-rebase' and can be used to prevent =
a branch
> =C2=A0from getting rebased.
>
> +pre-checkout
> +-----------
>
> -post-checkout
> -~~~~~~~~~~~~~
> -
Why do you change the caption from subsection (Ie. ~~~) to section (Ie.=
 ---)?

> -This hook is invoked when a 'git-checkout' is run after having updat=
ed the
> +This hook is invoked when a 'git-checkout' is run after before updat=
ing the
> =C2=A0worktree. =C2=A0The hook is given three parameters: the ref of =
the previous HEAD,
> =C2=A0the ref of the new HEAD (which may or may not have changed), an=
d a flag
> =C2=A0indicating whether the checkout was a branch checkout (changing=
 branches,
> =C2=A0flag=3D1) or a file checkout (retrieving a file from the index,=
 flag=3D0).
> -This hook cannot affect the outcome of 'git-checkout'.
> +This hook can prevent the checkout from proceeding by exiting with a=
n
> +error code.
>
> =C2=A0It is also run after 'git-clone', unless the --no-checkout (-n)=
 option is
> =C2=A0used. The first parameter given to the hook is the null-ref, th=
e second the
> =C2=A0ref of the new HEAD and the flag is always 1.
>
> +This hook can be used to perform any clean-up deemed necessary befor=
e
> +checking out the new branch/files.
> +
> +post-checkout
> +-----------
Ditto.

> +
> +This hook is invoked when a 'git-checkout' is run after having updat=
ed the
> +worktree. =C2=A0It takes the same arguments as the 'pre-checkout' ho=
ok.
> +This hook cannot affect the outcome of 'git-checkout'.
> +
> =C2=A0This hook can be used to perform repository validity checks, au=
to-display
> =C2=A0differences from the previous HEAD if different, or set working=
 dir metadata
> =C2=A0properties.

Bert
