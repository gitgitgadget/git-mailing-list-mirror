From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 1/3] index-helper: fix UNIX_PATH_MAX redefinition error
 on cygwin
Date: Mon, 11 Apr 2016 17:55:49 -0400
Organization: Twitter
Message-ID: <1460411749.5540.22.camel@twopensource.com>
References: <570ADAEE.20201@ramsayjones.plus.com> <570B2605.4040305@web.de>
	 <570BA6EF.7020202@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Torsten =?ISO-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 11 23:56:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apjoc-0003k8-Rv
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 23:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755418AbcDKVzy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Apr 2016 17:55:54 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34265 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755156AbcDKVzw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2016 17:55:52 -0400
Received: by mail-qg0-f50.google.com with SMTP id c6so157235638qga.1
        for <git@vger.kernel.org>; Mon, 11 Apr 2016 14:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SttqILvjciLEjkmy6Z/aigQ8GJDf5KT5aSi4o5LtQm8=;
        b=Tt1/Z6Nrwdc7liKbL95GWwLGu/avG4NtdLUrEV9TxmUTa18gBIFfE59ir73Y+7U86q
         bt07KATmzOvIHyl/A3m3RtxxX04iWzRcrWA+NB9703empGts3CH2mDdOnFNN0YPwhOyY
         U5TY4d6VhOLzXuWhnMD3aHvfSBRjF2x4TjrgADU2qiT2zAB8yE516FYQBSrCfLW0o8q5
         CtJwjivERn/RH09f44xbiU4iDO86iVzaarJWQW03bu9uv99Mrhe6MD0Q1J2QdNmu75Zm
         kI+VmjjHyHJjlfHDaVe5acaFKlsdO2vDUsnaV6S+6Hw1k8peGQYa9MUkXTPQjpzc57cI
         odWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SttqILvjciLEjkmy6Z/aigQ8GJDf5KT5aSi4o5LtQm8=;
        b=gqqtKxGOQjNZfaxS4Z5tBFT4F4ZRWPEHl33M/ClQngj/hsrWitV2w91u9dx5WS9N6A
         peT3f6/AHSoVjB9g0+SvUQB4VFXCvhtGD5k7was3CY9iLMH04JxO8aVgZtE5OQ0B6Lfo
         mq8xMRzTA8r2bsZOXhm4AicCnLGNYxbcNa9moaEL3wjoQa0OQaETfCAptSJQlvnzMaUZ
         Uk2ze4jhTc8evRtrKdvqigTdhivcY5YdcMvJFCxHTNERM4FFDbIaW5cpUzG7o83t3PLp
         Us4C+qoO8d9QM61LHyiVwQe/BYNuuYrN58C2XdDln/660wwHQ4M5k6J344kDjOtb1ZlE
         uXyg==
X-Gm-Message-State: AD7BkJKhMeMl4fNVJyP+PGHKeAY2BIHjpcxr/1vnGJcu/Gb+VdSqYzwoZKYNOjirAiEK2A==
X-Received: by 10.140.234.151 with SMTP id f145mr34406870qhc.51.1460411751158;
        Mon, 11 Apr 2016 14:55:51 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id o128sm12030999qhb.34.2016.04.11.14.55.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2016 14:55:50 -0700 (PDT)
In-Reply-To: <570BA6EF.7020202@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291236>

On Mon, 2016-04-11 at 14:30 +0100, Ramsay Jones wrote:
>=20
> On 11/04/16 05:20, Torsten B=C3=B6gershausen wrote:
> > On 04/11/2016 12:59 AM, Ramsay Jones wrote:
> > The header mentions cygwin, but changes it for linux, BSD and Mac
> > OS as well.
> > Is this intentional ?
>=20
> Yes. I only compile on 32/64-bit linux and 64-bit cygwin these days,
> so I only
> noticed the warnings (yes I wrote error, but it should be warning) on
> cygwin.
> Other systems may suffer the same warnings, of course.
>=20
> > > Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> > > ---
> > >   git-compat-util.h | 17 -----------------
> > >   index-helper.c    |  4 ++--
> > >   read-cache.c      |  2 +-
> > >   3 files changed, 3 insertions(+), 20 deletions(-)
> > >=20
> > > diff --git a/git-compat-util.h b/git-compat-util.h
> > > index 0e35c13..c90c8c6 100644
> > > --- a/git-compat-util.h
> > > +++ b/git-compat-util.h
> > > @@ -1043,21 +1043,4 @@ struct tm *git_gmtime_r(const time_t *,
> > > struct tm *);
> > >   #define getc_unlocked(fh) getc(fh)
> > >   #endif
> > >   -#ifdef __linux__
> > > -#define UNIX_PATH_MAX 108
> > > -#elif defined(__APPLE__) || defined(BSD)
> > > -#define UNIX_PATH_MAX 104
> > > -#else
> > Can we use a #elif __CYGWIN__ here to fix the re-definition just
> > for cygwi ?
>=20
> As I said in the cover letter, that is an option - but why bother
> with
> UNIX_PATH_MAX at all?

Will remove UNIX_PATH_MAX in favor of sizeof().

Thanks.
