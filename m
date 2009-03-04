From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] Make the 'lock file' exists error more informative
Date: Wed, 4 Mar 2009 15:03:13 +0000
Message-ID: <43d8ce650903040703v2a743797rc30724f8c1c608e7@mail.gmail.com>
References: <1236178844-7958-1-git-send-email-johnflux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 16:04:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LeseM-0002FJ-2R
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 16:04:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbZCDPDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Mar 2009 10:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751692AbZCDPDQ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 10:03:16 -0500
Received: from yw-out-2324.google.com ([74.125.46.30]:35047 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbZCDPDQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Mar 2009 10:03:16 -0500
Received: by yw-out-2324.google.com with SMTP id 5so2173483ywh.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=5LTJ88GiN+3wq8ewnOm9vA2bWIUxvZ2VBnX3WjcfVUE=;
        b=VpyQrVuXw0ixE81HOqAvvSZViFSLqcQVD7BonBCd7yMXHNtrqZ1FRLWX90H3kxklhc
         80sYg/8ZhKxixsKIHfGTCz7UJOLphKzQ+jo8dtsifBDuYqgaeHP8QY2gujII7vDm7Loz
         5fgH1F8Wy/TMGznuZ16BSC5gZLfyJW1WTdwqA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=oreiaDHCuox2oMs71l7cGRrNJWZ/Wa848CvuDO0KIjvjT7AXdHFeKd7geJtgMs8qFk
         CI7sR7voidpzSFnnq3ixGu8ZnhPGdX/UO4Br4uGaCh1gUVnMu2DVJHXgdAFb6S/xmCv1
         z/Q0TyKU9Tt80RpbdhzslUCEzPY7FLebfZFIQ=
Received: by 10.142.126.6 with SMTP id y6mr4231180wfc.153.1236178993664; Wed, 
	04 Mar 2009 07:03:13 -0800 (PST)
In-Reply-To: <1236178844-7958-1-git-send-email-johnflux@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112219>

Argh, I'm so sorry.  After all that, I went and sent a broken version.
 Plus I just noticed another bug.  Will retry..


2009/3/4 John Tapsell <johnflux@gmail.com>:
> It looks like someone did 90% of the work, then forgot to actually us=
e
> the function
> ---
> =C2=A0lockfile.c | =C2=A0 =C2=A02 +-
> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 1db1a2f..6772f38 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -184,7 +184,7 @@ int hold_lock_file_for_append(struct lock_file *l=
k, const char *path, int flags)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fd =3D lock_file(lk, path, flags);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (fd < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (flags & LO=
CK_DIE_ON_ERROR)
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 die("unable to create '%s.lock': %s", path, strerror(errno));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 unable_to_lock_index_die(path, strerror(errno));
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return fd;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> --
> 1.6.2.rc1.3.g7d31b.dirty
>
>
