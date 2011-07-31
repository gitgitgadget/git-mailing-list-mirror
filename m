From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v8 0/7] bisect: Add support for --no-checkout and
 --update-ref=<ref> options.
Date: Sun, 31 Jul 2011 23:26:18 +1000
Message-ID: <CAH3AnroWm-BU1svjJqK3WzoNknWk495AJ0mxwWMq+1sgAxxnPg@mail.gmail.com>
References: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: chriscool@tuxfamily.org, gitster@pobox.com, j6t@kdbg.org,
	jnareb@gmail.com, Jon Seymour <jon.seymour@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 31 15:26:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnW2D-0007Pw-13
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 15:26:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049Ab1GaN0V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 09:26:21 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43506 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828Ab1GaN0T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 09:26:19 -0400
Received: by vws1 with SMTP id 1so3902087vws.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=GXEJV2p88/d13bZ2OzwwZWbt8jJXFafMbCsMb0Wv/jo=;
        b=qvXGdWYVGnObI/2mgL6HBxJgk1pPjUOWlg8ps7H7GvzZi0j7pfPYCCjwNxUMfPBWV/
         Q/0Fkm7Jhe+yMjOnrXnlUGzfFkS3omJzNl5U2/D+e7JzueF5a+ODTAcbYFgujA3Xc2bY
         KVUH5VOfPnAuejOhTBRuI/e93NMMukKIz9zo8=
Received: by 10.52.97.234 with SMTP id ed10mr3141928vdb.240.1312118778862;
 Sun, 31 Jul 2011 06:26:18 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sun, 31 Jul 2011 06:26:18 -0700 (PDT)
In-Reply-To: <1312113321-28760-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178248>

On Sun, Jul 31, 2011 at 9:55 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
>
> For example:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git bisect run eval '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc=3D1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if git rev-lis=
t --objects HEAD >tmp.$$; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git pa=
ck-objects --stdout >/dev/null < tmp.$$ && rc=3D0;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fi;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rm tmp.$$;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test $rc -eq 0=
;'
>

Sverre has pointed out I screwed the example up again. It should have b=
een:

git bisect start HEAD <some-known-good-commit> <boundary-commits> --no-=
checkout
git bisect run eval '
               rc=3D1;
               if git rev-list --objects HEAD >tmp.$$; then
                  git pack-objects --stdout >/dev/null < tmp.$$ && rc=3D=
0;
               fi;
               rm tmp.$$;
               test $rc -eq 0;'

I think the examples in the documentation and test are correct (modulo
an accurate description of what good choices for <boundary-commit>'s
are).

jon.
