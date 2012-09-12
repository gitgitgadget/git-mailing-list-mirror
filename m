From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Wed, 12 Sep 2012 21:05:33 +0700
Message-ID: <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 12 16:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBna7-0005lZ-AG
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 16:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154Ab2ILOGK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Sep 2012 10:06:10 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:55664 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150Ab2ILOGF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Sep 2012 10:06:05 -0400
Received: by ieje11 with SMTP id e11so2945868iej.19
        for <git@vger.kernel.org>; Wed, 12 Sep 2012 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=H/cwAi/BLDB5DTiL3x8aXiy6oPGDUsh1/ys678hWMts=;
        b=qQJz6noepiHzinjOUX3dyNnchZm9k7cKuQHwFKNgTIGP1gzU6VdkxgIMkl50WJSsw4
         0NtCwVqtawH62BcOBamhbKtNg9m3KWE9R5nnKv35y9iwvgXKnKug8c3XnFO2Rl4RxePS
         ikHwBg7IbEWppfmur1/TCtl840B88ieJe8qSer2cWkfq8LtJc1TiPew5txx9YfDMq4NJ
         JcyGt9guMBdO0W2jWTxhN1hTsRN8qiPcja3IvAe2vN58MeKg30aEGyyUev29J1EwiZjh
         8mxdO9pT2OWS/VFK3aOatB7hmmnjhRH2esRFr7GS3m6Y+O0/HsZpzKaoka7dKGF18hb4
         DI4g==
Received: by 10.43.134.70 with SMTP id ib6mr5669557icc.37.1347458764736; Wed,
 12 Sep 2012 07:06:04 -0700 (PDT)
Received: by 10.64.64.72 with HTTP; Wed, 12 Sep 2012 07:05:33 -0700 (PDT)
In-Reply-To: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205297>

Should I interpret the silence as "I don't care, if you want it, go
for it" or "not acceptable, but no reasons given"? I'd like some form
of it in. Reverting the i18n diffstat patch is the last resort that I
really don't want to do.

On Sun, Aug 26, 2012 at 2:26 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The l10n effort leads to a situation where a contributor can submit a
> patch with some auto-generated information in his language, which may
> not be the team's language. We need to make sure exchange medium like
> patch is always in a common language that the team understands.
>
> Now this team language may not necessarily be English. However there
> are technical difficulties involved in switching between two
> languages. The only way I can think of, on top of gettext, is provide
> git translations in multiple domains. Say diff machinery uses
> "git-diff" domain while the rest is in "git". We can drive gettext to
> use language X for diff machinery, and Y for the rest. For that, we
> replace gettext() with dgettext().
>
> It's cumbersome. And there has not been any sign that there will be
> a real user for it. So I assume that the "team language" will always
> be English. It's simpler and should cover 90% of the user base. If
> someday people ask for that, supporting it is simply a matter of
> rewriting C_() and CQ_() macros in the first patch to use dgettext()
> instead.
>
> Switching between a language and English is easier. We just need an
> if/else to decide whether to call gettext(). Which is what the first
> patch does, just for certain parts of diff machinery. Error messages
> will alway be in native language.
>
> The second patch puts format-patch output in English unconditionally.
> Again I'm partly lazy and not so sure that there will be needs for
> format-patch to produce in native language. If someone needs it, we
> can introduce a new config key that flip no_l10n flag back to 0.
>
> More commands may follow format-patch. I think that 'apply' should al=
so
> use English for non-tty output, unless users request it to be in loca=
l
> language. IOW local language is treated pretty much like coloring.
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy (2):
>   Allow to print diffstat in English regardless current locale
>   format-patch: always print diffstat in English
>
>  builtin/apply.c |  2 +-
>  builtin/log.c   |  1 +
>  diff.c          | 19 ++++++++++++-------
>  diff.h          |  3 ++-
>  4 files changed, 16 insertions(+), 9 deletions(-)
>
> --
> 1.7.12.rc1.27.g6d3049b.dirty
>



--=20
Duy
