From: Eric Scouten <eric@scouten.com>
Subject: Re: [PATCHv3] git-p4: add initial support for RCS keywords
Date: Tue, 21 Feb 2012 08:54:17 -0800
Message-ID: <CAEe=O8qui8PryuZiZNDwLk39+tKVDnh+5eP9m_WrHi=K9ekMNQ@mail.gmail.com>
References: <1329258835-17223-1-git-send-email-luke@diamand.org>
	<1329258835-17223-2-git-send-email-luke@diamand.org>
	<20120221121834.GB18317@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 17:54:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rzsyt-0005Jh-6y
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 17:54:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752674Ab2BUQyS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Feb 2012 11:54:18 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:49820 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719Ab2BUQyR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Feb 2012 11:54:17 -0500
Received: by yhoo21 with SMTP id o21so3023672yho.19
        for <git@vger.kernel.org>; Tue, 21 Feb 2012 08:54:17 -0800 (PST)
Received-SPF: pass (google.com: domain of eric.scouten@gmail.com designates 10.60.22.40 as permitted sender) client-ip=10.60.22.40;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of eric.scouten@gmail.com designates 10.60.22.40 as permitted sender) smtp.mail=eric.scouten@gmail.com; dkim=pass header.i=eric.scouten@gmail.com
Received: from mr.google.com ([10.60.22.40])
        by 10.60.22.40 with SMTP id a8mr12355006oef.59.1329843257371 (num_hops = 1);
        Tue, 21 Feb 2012 08:54:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FuoZAHDKzSox7JZzzc783pWodIfIHc6YWoBnWf3755I=;
        b=eVgMUAK2wqHLmJJ8AyC2K9RxwJzHByAqT2xg7JhjmtttGhQdsma+4B5pN5a0LiPyXI
         oisIalsnfrx4uiAfvQ2kp7OiJlYQjuLKFQTUqPt5VtDkHFYKpKRSHsy820ZH85c6zZOi
         uTiJPuaCM7aWOXWmAY1NXuXnA5nqFim/CfLOU=
Received: by 10.60.22.40 with SMTP id a8mr10568489oef.59.1329843257132; Tue,
 21 Feb 2012 08:54:17 -0800 (PST)
Received: by 10.182.61.135 with HTTP; Tue, 21 Feb 2012 08:54:17 -0800 (PST)
In-Reply-To: <20120221121834.GB18317@padd.com>
X-Google-Sender-Auth: tNwBUwXK6b2g_li5R0XOK6eFMUs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191168>

[Resent in plain-text. Apologies for dupe content to Pete and Luke.]

On Tue, Feb 21, 2012 at 04:18, Pete Wyckoff <pw@padd.com> wrote:

> luke@diamand.org wrote on Tue, 14 Feb 2012 22:33 +0000:

> > diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p=
4
> > +#
> > +# Given a type base and modifier, return a regexp matching
> > +# the keywords that can be expanded in the file
> > +#
> > +def p4_keywords_regexp_for_type(base, type_mods):
> > + =A0 =A0if base in ("text", "unicode", "binary"):
> > + =A0 =A0 =A0 =A0if "ko" in type_mods:
> > + =A0 =A0 =A0 =A0 =A0 =A0return r'\$(Id|Header)[^$]*\$'
> > + =A0 =A0 =A0 =A0elif "k" in type_mods:
> > + =A0 =A0 =A0 =A0 =A0 =A0return
> > r'\$(Id|Header|Author|Date|DateTime|Change|File|Revision)[^$]*\$'
>
> Still no ":"? =A0Won't that match too much?

> Fix the colon thing at least, then happy to add my Acked-By.

No, that would be an incorrect change. The colon is added by P4 when
it expands the keyword pattern, but it is *not* part of the pattern
required by P4 to trigger a keyword expansion.

http://kb.perforce.com/article/54/using-rcs-keywords

-Eric


--
Eric Scouten :: software developer, photographer :: Poulsbo, WA (near S=
eattle)
http://ericscouten.com :: click for Flickr, Facebook, Twitter, LinkedIn=
 links
