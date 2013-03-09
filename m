From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH 3/3] match_basename: use strncmp instead of strcmp
Date: Sat, 9 Mar 2013 09:47:59 +0100
Message-ID: <20130309084759.GA8688@paksenarrion.iveqy.com>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362802190-7331-4-git-send-email-pclouds@gmail.com>
 <7v4nglf1w3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 09:48:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEFRk-0006MJ-BD
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 09:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756128Ab3CIIri convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Mar 2013 03:47:38 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:33555 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051Ab3CIIrh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 03:47:37 -0500
Received: by mail-la0-f50.google.com with SMTP id ec20so2459095lab.37
        for <git@vger.kernel.org>; Sat, 09 Mar 2013 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=XGmxEvjd+e5sEUkGj+NaqbQqUY0GQW8xj2+B8Fs1L5M=;
        b=0tQsSVIFBEa+rUu+O4ivyGoAaTB1DkfABSYu7AIEKYRSRC4w7mVdkqSndztCxODT/4
         xh/Rm5oa34/c7gWKv3kCSuxx2uS8zviSYSaXgCxfYzim2GfWJKZN6WxemBGBueFLsbJa
         WmYASj6U2qhP/VAOA6XjTcsj5VWSNref30fiEQAZZ67a7ZSyYH9+HS9Z1swSfJ12XjK/
         QENVScBZea/tD/HeNZVxKbFxMPYjdEguGQjQ6t3lsXX7q8WFfKWH9/op90brD+thbx1U
         1z6WFE5YkxwPPMtzw90tFf7d+XkqPE1rpobzj37ZsIaaYgJZ2mOQIDi1rniygN4rXpvm
         mFuQ==
X-Received: by 10.152.47.97 with SMTP id c1mr4575414lan.6.1362818856007;
        Sat, 09 Mar 2013 00:47:36 -0800 (PST)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id fz10sm2412330lbb.12.2013.03.09.00.47.34
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 09 Mar 2013 00:47:34 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UEFRf-0004Pc-Ls; Sat, 09 Mar 2013 09:47:59 +0100
Content-Disposition: inline
In-Reply-To: <7v4nglf1w3.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217713>

On Fri, Mar 08, 2013 at 11:50:04PM -0800, Junio C Hamano wrote:
> At the same time, I wonder if we can take advantage of the fact that
> these call sites only care about equality and not ordering.

I did an RFC-patch for that (that I mistakenly didn't sent as a reply t=
o
this e-mail). And I believe that you're correct. My solution is inspire=
d
of curl's strequal.

Is the reason for git not to care about lower/upper-case for beeing abl=
e
to support windows? Or is there any other smart reason?

I was also thinking about discarding files by looking at their
modification date. If the modification timestamp is older than/or equal=
 to
the latest commit, there's probably no reason for examine that file any
further. I'm not sure about the side effects this may imply though. I
think they can be quite nasty. Is this something worth digging more in
or am I already on the wrong path?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
