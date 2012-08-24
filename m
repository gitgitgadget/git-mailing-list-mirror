From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 0/6] Gettext poison rework
Date: Fri, 24 Aug 2012 10:51:45 +0200
Message-ID: <CACBZZX7V3A02sPQex4zpBE8Tkmc2d037tJBfhn-6DeK_MwY2Hw@mail.gmail.com>
References: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 10:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4pcp-0006JX-Ig
	for gcvg-git-2@plane.gmane.org; Fri, 24 Aug 2012 10:52:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757441Ab2HXIwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Aug 2012 04:52:12 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:49746 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753528Ab2HXIwH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Aug 2012 04:52:07 -0400
Received: by obbuo13 with SMTP id uo13so3721835obb.19
        for <git@vger.kernel.org>; Fri, 24 Aug 2012 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=GEWuhnFieEh02pAidbLt8SHDqzq1TN0guTLOuFqY/kw=;
        b=tyQsrjToGjWnaqXr3XhOgkCnwsJNjEoNcS3nQphqesz+XFf8ud2oWorqfZZZVbvtJR
         iNnHdusgJxb+SA+S1K0jZKUj7i9X3LVdnsLfRjRZDq0nH2KHRn6ZxP1Ka/DeQl85Lt1G
         lHbOUGFQZsI6yWp07U469siqxq4t0AboFOzo9GKb0gQtdx+7Or6YJeMDA/w1sDDcPOUg
         3rkPDrmgilRl/fX6bTlPakt4WUgT/wrUf6RJLOeU3d7Y/gPcSmhQxpEVw7/atGtA7S+i
         tbKJiQgAnKnfYbU9byP+zLFM9onSIbiiGk+ZVn+prP3vqpvOuRFeqtUdCWB9qjqVFGOE
         qhnA==
Received: by 10.60.27.6 with SMTP id p6mr3328946oeg.37.1345798325220; Fri, 24
 Aug 2012 01:52:05 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Fri, 24 Aug 2012 01:51:45 -0700 (PDT)
In-Reply-To: <1345786986-10826-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204190>

On Fri, Aug 24, 2012 at 7:43 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Still WIP but I'm getting closer. I dropped test-poisongen and starte=
d
> to use podebug [2] instead. Less code in git. podebug does not preser=
ve
> shell variables yet. I'll follow that up at upstream [1].
>
> With this series, if you have translation toolkit installed, you coul=
d
> do
>
>     make pseudo-locale L=3D<your language code>
>     make GETTEXT_POISON=3D$LANG test
>
> podebug supports a few way of rewriting translations. Currently
> "unicode" is used but you can change it via PODEBUG_OPTS
>
> t9001 is not happy with $LANG !=3D C though. May need to add some
> prereq there.
>
> [1] http://bugs.locamotion.org/show_bug.cgi?id=3D2450
> [2] http://translate.sourceforge.net/wiki/toolkit/podebug

The reason I didn't do something like this to begin with is that
gettext/glibc doesn't have support for fake locales, so you'd have to
appropriate a real one for tests. It's good to see you poking the
gettext mailing list about adding support far thot.

But something like podebug gets around that quite nicely, so we can
still have the testing the poison stuff was intended for, without the
complexity of supporting it throughout all our i18n code.
