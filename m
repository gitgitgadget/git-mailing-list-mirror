From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/5] read-cache: add watchman 'WAMA' extension
Date: Tue, 03 Nov 2015 14:49:41 -0500
Organization: Twitter
Message-ID: <1446580181.4131.36.camel@twopensource.com>
References: <1446386146-10438-1-git-send-email-pclouds@gmail.com>
	 <1446386146-10438-2-git-send-email-pclouds@gmail.com>
	 <1446501799.4131.24.camel@twopensource.com>
	 <CACsJy8Bb0BVsCdgDQe9JWPUOR9Hw+963Zph3HMZA6Zmzr2THMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 20:50:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZthbS-0007Lr-EE
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 20:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbbKCTtt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2015 14:49:49 -0500
Received: from mail-qg0-f46.google.com ([209.85.192.46]:35276 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932354AbbKCTto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Nov 2015 14:49:44 -0500
Received: by qgbb65 with SMTP id b65so22693791qgb.2
        for <git@vger.kernel.org>; Tue, 03 Nov 2015 11:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=Z2+VE4VuuWpwaT72NcnLOLkVFL5jKMf2yN/AvO3JYYo=;
        b=Sh9ZPtTBjxGrQIVG+zj3axlRKDX5CHSjkAfb1ynrkeentoh0utfcFxuoVNlMyVptoE
         p9sJy9aRLMiBOj+I7LCHobFVuqYI1ES7ong2L98flT1UlgsRwNjtoVE5l3y69D8ePFv1
         4R3C7eiBMVHPwb/UpoZ+s9qiz9ivJK1G7i+r+nYGimlajhr905MxRMTRedPVw++DYkix
         jNWQkmnD5ksZhiu73i2V2zc5VXfJAJ6cFSXdFdYUVQ204hpG3Vy0rvhorMM114NPz5ge
         CAYcehqcEVENBpolp45UN74+wgrGDrnJFC+kz9TKiG0Zc+4CdltFuz8bm94pbrqDgsrd
         UV3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=Z2+VE4VuuWpwaT72NcnLOLkVFL5jKMf2yN/AvO3JYYo=;
        b=STwKx/bkD9JURReRB5krtY3jwjXov7ia5QVwCy6/1pGcSgj7B/wWhHzwS8b3T0TjY9
         AK4CQjqmXiqcjsWezi4N3wd9jHcu4pcXD+/u7wvWdJoLa8mDliU+PrW+erzZMRo8VG9I
         +gt4gbSPj4lHslHq2GsmQIwMHXZq82CQWr6MqpjKWzFoLRgn70Gk3B73eunLHvab5p9b
         kq69LI9iUOUpcSyl3reMDl0k//X3MXH32lHHlLPQGRQSHFCSyGJd4v7+ikXzPxniuoZg
         6npSbeCU2GE+ic//Su/nuqIwBtnLy5xKKCMoSidqgp0nUzWQT2gYh/l2CoTDSJJrepc9
         PyKw==
X-Gm-Message-State: ALoCoQnj26EQSZKONS4+OdsOjVjszewCCys30ZDBXJZaYRg+Am+679BtphyZHml/xjPBL2PKoGgn
X-Received: by 10.141.28.136 with SMTP id f130mr41821073qhe.66.1446580183893;
        Tue, 03 Nov 2015 11:49:43 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e7sm10309311qkj.19.2015.11.03.11.49.42
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 11:49:43 -0800 (PST)
In-Reply-To: <CACsJy8Bb0BVsCdgDQe9JWPUOR9Hw+963Zph3HMZA6Zmzr2THMA@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280812>

On Tue, 2015-11-03 at 20:17 +0100, Duy Nguyen wrote:
> On Mon, Nov 2, 2015 at 11:03 PM, David Turner <dturner@twopensource.c=
om> wrote:
> > On Sun, 2015-11-01 at 14:55 +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=
=8Dc Duy wrote:
> >>
> >>+#define CE_NO_WATCH  (0x0001)
> >
> > This name seems very confusing to me.  CE_NO_WATCHMAN_STAT?
> > CE_UNKNOWN_TO_WATCHMAN?
>=20
> Files that are known updated. Maybe CE_WATCHMAN_DIRTY?

+1

> > (one reason it may seem more confusing to me than to others is that
> > Twitter's code has a concept of files that we don't watch at all e.=
g.
> > Intellij's .idea dir).
> >
> >> @@ -322,6 +325,7 @@ struct index_state {
> >>       struct untracked_cache *untracked;
> >>       void *mmap;
> >>       size_t mmap_size;
> >> +     char *last_update;
> >
> > Might be worth a comment explaining what this is.
>=20
> It's the clock value from watchman when we query file status. Will
> make a note. Or maybe I should just rename it to watchman_clock.

Either way would work for me.
