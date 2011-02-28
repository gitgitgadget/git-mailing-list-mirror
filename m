From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [1.8.0] fix branch.autosetupmerge and branch.autosetuprebase
Date: Mon, 28 Feb 2011 18:43:52 -0500
Message-ID: <AANLkTi=nhc=a6wW9BPiDy_2rbZQCVmhZ75u7MuF33w06@mail.gmail.com>
References: <AANLkTi=Ei-Gr3=O0_dfaCekQ0+nB8v1kZYT7sTw-Ydm+@mail.gmail.com> <A8063D85-43A0-474A-8467-DE8473F52ECB@spy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Dustin Sallings <dustin@spy.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:44:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuClP-0003k1-MH
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626Ab1B1XoX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 18:44:23 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:33901 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435Ab1B1XoW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 18:44:22 -0500
Received: by iyb26 with SMTP id 26so3384198iyb.19
        for <git@vger.kernel.org>; Mon, 28 Feb 2011 15:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=s3n50mS48wWRU8eXWV/1sNbIc4F7QztGnjS6E3n9FM8=;
        b=U8yAtMt/vdBDFZkYyLMSgxo2ChEuJswCudfzoMXrgVY72kVQAtnLdOjuonByM++VC3
         jww1WuxB8QpU3SNrbykpA5lebfx7kXBJa18HdnREOgWWdd6ciIojzC+SKcAPO2Vxbgsd
         ZNq2wurzY5JDLobWwJvfJZhuoG60lyho8Ou04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=P5ualemzcYNcHr3o9Dlkstgrh26qy/aVVFG25etlKFE/ja3hofs/VpsLS3NUfjbaWw
         bkT89KCdmwe9WtGNEnHUxFiz+nHBseKRiaTwNWaK3Tsdw9B9o9ubXMcZY4IgUMrSh1UD
         mCT8cat6O/UTCuEmdlTuzvwiWAhipV+YPmuwc=
Received: by 10.42.138.68 with SMTP id b4mr5824636icu.56.1298936662070; Mon,
 28 Feb 2011 15:44:22 -0800 (PST)
Received: by 10.231.40.2 with HTTP; Mon, 28 Feb 2011 15:43:52 -0800 (PST)
In-Reply-To: <A8063D85-43A0-474A-8467-DE8473F52ECB@spy.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168166>

On Mon, Feb 28, 2011 at 6:03 PM, Dustin Sallings <dustin@spy.net> wrote=
:
>
> On Feb 28, 2011, at 14:37, Jay Soffian wrote:
>
> 2. Deprecate branch.autosetuprebase. Pull's default action shouldn't
> be specified when the branch is created. Rather, add a "pull.rebase"
> boolean defaulting to false, and which is overridden per-branch by
> branch.<name>.rebase.
>
> Do you mean to say ``pull.rebase'' configured to true would do the sa=
me
> thing?

Effectively, yes. If a user specifies "pull.rebase true" in their
=2Egitconfig or repo .git/config, then when they "git pull" while on
branch <name>, pull will rebase, unless branch.<name>.rebase exists
and is set to false.

any branches that don't have an explicit "branch.<name>.rebase =3D fals=
e" will

> If so, I'm fine with killing off branch.autosetuprebase. =C2=A0The go=
al is to
> have something I can easily give to other people so that we all work =
the
> same way.

Understood. I recently have the same goal, but my users have
pre-existing branches that they setup before I told them to "git
config branch.autosetuprebase true". Now they need to go configure
every one of those branches to rebase by default.

It would be nice if I could just tell them "git config --global
pull.rebase true" and have it affect all their repos and branches. :-)

j.
