From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-sh-i18n: detect and avoid broken gettext(1) implementation
Date: Fri, 20 Jan 2012 21:13:01 +0100
Message-ID: <CALxABCZJATyVRf9akmfpn3WpJ8Xt80Ky0isFOTwDGpFKvFp3nw@mail.gmail.com>
References: <CALxABCZWBtgX736Acoy-CCAz8RJb0EKnHf+7g72dOdVS+BOhSw@mail.gmail.com>
 <1327063775-28420-1-git-send-email-avarab@gmail.com> <7vobtydu0o.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 21:13:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoKpz-0003fp-Rc
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 21:13:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752509Ab2ATUNX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 15:13:23 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:42562 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752049Ab2ATUNW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 15:13:22 -0500
Received: by obcva7 with SMTP id va7so1131052obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 12:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=amscVZOQTRx0pE9pTBlqRQFeu4zU5OCN/dw/TMvVH7U=;
        b=H6G83DLzEkUJiFHuC7SSQpJO09lmgfZJy41sskgtunTxOmthr53ay5DIU8fKy0sZGH
         NH1FmGem6F1dsMFNB8/LajsnxZdU7g6m8SsHRGNYr4Z4q6VsSu75KLRDwPmoIvPx9gZ+
         i1NJYnUCfXzxRYk7xJy8eFW4iFG/JcHHLyjHE=
Received: by 10.182.122.71 with SMTP id lq7mr27926513obb.33.1327090402193;
 Fri, 20 Jan 2012 12:13:22 -0800 (PST)
Received: by 10.182.226.41 with HTTP; Fri, 20 Jan 2012 12:13:01 -0800 (PST)
In-Reply-To: <7vobtydu0o.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188899>

On Fri, Jan 20, 2012 at 21:00, Junio C Hamano <gitster@pobox.com> wrote=
:
> IOW, the first step would look like the attached patch, and then we c=
an
> replace the entire "First decide" part if/elif/fi chain with just thi=
s:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# The scheme to use
> =C2=A0 =C2=A0 =C2=A0 =C2=A0: ${GIT_INTERNAL_GETTEXT_SH_SCHEME:=3D@@GE=
TTEXT_SH_SCHEME@@}
>
> so that t/lib-gettext.sh can define and export GIT_INTERNAL_GETTEXT_S=
H to
> always get what it wants to test (fallthrough?). At build time, inste=
ad
> of, or in addition to, the $(cmd_munge_script), we could replace the
> single @@GETTEXT_SH_SCHEME@@ token above with whatever scheme we want=
 to
> use to hardcode the decision we make at the compile time.

I can imagine a Solaris system being upgraded to GNU gettext _after_ Gi=
t
installation. Hardcoding the decision might break git scripts then.
