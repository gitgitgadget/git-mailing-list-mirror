From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 5/5] rm: delete .gitmodules entry of submodules
 removed from the work tree
Date: Thu, 8 Aug 2013 20:55:13 +0200
Message-ID: <20130808185513.GC24549@paksenarrion.iveqy.com>
References: <51F8187F.7040603@web.de>
 <51F81957.1000709@web.de>
 <52014B4D.3090602@web.de>
 <7v8v0efrs3.fsf@alter.siamese.dyndns.org>
 <20130807182809.GA15123@paksenarrion.iveqy.com>
 <5203D128.7030705@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Aug 08 20:52:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7VJU-0000l5-Ae
	for gcvg-git-2@plane.gmane.org; Thu, 08 Aug 2013 20:51:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966125Ab3HHSvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Aug 2013 14:51:52 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:63033 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966099Ab3HHSvv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 14:51:51 -0400
Received: by mail-la0-f49.google.com with SMTP id ev20so2372667lab.36
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LmF5VwrLy3nYi3lSLHJT7KQZvusDSjUBnDj9sJe8Uzs=;
        b=bmY+Sy+PBb7W142N87It+IBzrxtZY1xSBTjFWpt6lVAHSq88LzCgDk77CX8DqtUrPM
         yn2L6+wBG+NM2KGDbSkGTeYo2rnaPquszWSQwPE4trRmfacDrFYh7y8icLmKMNOH9oha
         nAKF5ZDVjbc+BbycfVEXQtm36Wr+3s7rLBCQJpYYJMFKvt9q2O87D4kocPk+rqWL2S0N
         R9EgxYdhnHPTrdnxr9/gRfLElOZJqgb8rv33vYK8kxtJVdHwmsoNhl9FjfKf7L+WyNFF
         h5f7hUAJ4pHqyhYN+8TW9Csg9tajG0z8eBeGtSy80gMZee8Ybttm6qmsDRvTX8zyzMKQ
         0KIw==
X-Received: by 10.112.160.97 with SMTP id xj1mr2954456lbb.35.1375987910228;
        Thu, 08 Aug 2013 11:51:50 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id i9sm5249789laa.3.2013.08.08.11.51.48
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 08 Aug 2013 11:51:49 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V7VMf-0002uF-Iq; Thu, 08 Aug 2013 20:55:13 +0200
Content-Disposition: inline
In-Reply-To: <5203D128.7030705@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231918>

On Thu, Aug 08, 2013 at 07:11:04PM +0200, Jens Lehmann wrote:
> Am 07.08.2013 20:28, schrieb Fredrik Gustafsson:
> > On Tue, Aug 06, 2013 at 02:11:56PM -0700, Junio C Hamano wrote:
> >> Thanks, will replace the top two commits and queue.  Looks like we
> >> are getting ready for 'next'?
> >=20
> > I'm a bit curious about if we should move towards a reentrent libgi=
t
> > (which would for example make multithreading easier) or not.
>=20
> I'm not aware of such an effort in core Git (I always thought that
> libgit2 is the project doing what you seem to aim for).
>=20
> > If so, I suggest that this patch only use die() in builtin/. Howeve=
r I
> > know that there's a lot of die() all over libgit today, I'm curious
> > about what direction we're heading.
>=20
> The die() calls are just one part. Global variables are another issue=
,
> we have memory which is implicitly freed on exit ... so unless we
> commit ourselves to fix all those issues I see no point in moving the
> die() calls into builtin/ in my series.

Okay, thanks for your answer.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
