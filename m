From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git grep argument parser bug
Date: Fri, 5 Feb 2016 07:22:05 +0700
Message-ID: <CACsJy8DCn9z2hbodqFw7bL=JDwV8LfFiv52Bk__UO5y8nfcm-A@mail.gmail.com>
References: <CANzEV58SgS6P_qBequGSfA0vFy9s0-KM3xOFaU2DDz_S3OyN3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Dylan Grafmyre <dylang@conversica.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 01:22:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRUAb-0001HN-8l
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 01:22:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758279AbcBEAWh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 19:22:37 -0500
Received: from mail-lf0-f44.google.com ([209.85.215.44]:34143 "EHLO
	mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758275AbcBEAWg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 19:22:36 -0500
Received: by mail-lf0-f44.google.com with SMTP id j78so47352229lfb.1
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 16:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=fP34VDcwYGxfVDB+Cg8dUKispG3GEzDmV2K+/xttnb0=;
        b=n3AQnUT5Pj/4D8yFxqL+RTgiwdm5dmicuj8g1Vu6uLJsgkwZwLEKKlIS3S2t9LCJt0
         BcMj9c0/O9vJq7fEqlw1A3A3yjY/9Mgtjr/XivizR8RiGqmLRjWgp4+jqT2oElMQJpe0
         0djJzsCrqWgpy7XkwsJHV2opDFDVPpfDbJZo3A+LgwUGyv4ilQihJTQJbIuA4p25VJu3
         GeZqlvgVbvSgICDq43KLyFREn9UC35HE1ND2xRG+NevON7eT1Hp3h5B7Zmn7Bocjsfwt
         Lj9yD19eh7yGkEVS/K459U5O3XKPGZR+sSPXW04sMz9GOw3SP78i4SWYrhayPDMr+yQg
         Ckaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=fP34VDcwYGxfVDB+Cg8dUKispG3GEzDmV2K+/xttnb0=;
        b=kq2QhZ44O3oDS/kUsYis0H6rwtx8DbeIGMpyVcnLjrsdIFiDZun9RFGTIabP8+c/sQ
         5XsziQ26YlTalxNyMg8qw2+42Ri94R6O9Fsb26qWlIbpnMV+mjSAOaUX3Wq8hebaCih/
         /OLRT48Wp6X4yAtoQQgKOFEJWR0i7RC8flHAhr8QJw/OEiz7qoMhaBWaM/WPckroM/Ug
         oUh+pjE+3oxc9ElhwDXNG/+YSGuG0DCsdeJJXBz+EQg75voyoLMadIX8p7leet9A4THb
         Lcww+da/EwuL71lKZoEXooIaGUhaTyhxWaPatwkuNyEhDg6cEjcopZrFT0YLGkztDcrV
         l35g==
X-Gm-Message-State: AG10YOTy/cXWGgtZ5So4dDK8x8IG6CAvmwWmxAkgJyZos0SOpKO2fAtnY67sm4Hb3PxryNcvyYGlKm3nKT/Bow==
X-Received: by 10.25.5.6 with SMTP id 6mr3920435lff.3.1454631755388; Thu, 04
 Feb 2016 16:22:35 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 4 Feb 2016 16:22:05 -0800 (PST)
In-Reply-To: <CANzEV58SgS6P_qBequGSfA0vFy9s0-KM3xOFaU2DDz_S3OyN3g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285531>

On Fri, Feb 5, 2016 at 5:02 AM, Dylan Grafmyre <dylang@conversica.com> wrote:
> In both ubuntu versions of git 1.9.1 and 2.7.0
>
>     git grep '-test'
>     git grep '--help'

(Un)Quoting is done by shell and stripped out before "git" is
executed. We just don't see them.

> Or any other expressions literal leading with a single dash or double
> dash get interpreted as argument flags and not as search expressions.
>
> What I expect is grep results for the literal strings "-test" and "--help"
> What i get is git help output informing of wrong argument usage, or
> accidentally turning on flags I didn't expect.
>
> Work around; for afflicted users terminating argument parsing with `
> -- ` works as it should.
>
>     git grep -- '-test'

Or you can do "git grep -e --test". UNIX grep faces the same problem,
and also has -e to deal with it.

> Confirmed on two Ubuntu [based] systems, Ubuntu Server 14.03 and
> LinuxMint 17.3 [Cinnamon]
-- 
Duy
