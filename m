From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] general style: replaces memcmp() with starts_with()
Date: Wed, 12 Mar 2014 20:51:37 +0700
Message-ID: <CACsJy8DUhqn_ESzT-KpAdrWvWcLbPUiXDmBZXu7UtHU+M0GLgw@mail.gmail.com>
References: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Quint Guvernator <quintus.public@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 14:52:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNjZu-0001Hh-OG
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 14:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbaCLNwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 09:52:10 -0400
Received: from mail-qc0-f172.google.com ([209.85.216.172]:56366 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754350AbaCLNwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 09:52:09 -0400
Received: by mail-qc0-f172.google.com with SMTP id i8so11376781qcq.31
        for <git@vger.kernel.org>; Wed, 12 Mar 2014 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=AJLKfD6F4WTsMj5t1xx9uQRWwY3FlN7eOO0KDsIww7w=;
        b=s8ReisIg3k7WYD/eJaI+UC8pJmF7EVPjNsigj3/LQlfA2j/YsBb/l3dY85wZs2n40W
         VUW3Y9vWLblvho20OGD7jtDm7Z85t6IEGCmqZT0u+gac3DT87kSTurDjHx+fpaAKwb85
         dLAuAIPN9s87JDu1OjltSU57m2z1MfESZwEDVNC+tXxISHlsqn/vyGDExHQrYyNIxAHh
         L5Q7pClhS8kP1dMYdD2t/f3ecW9qtGY7wwY3SSstoZUY0fxJId0odHIsd7EKHsEi86pI
         e7MKsbV+gYahPAtwhcVCF6Fg2uhg8Ahho9cAE9pLdlolGKYAqK0agzxdYvUBAdbdx2DJ
         pviQ==
X-Received: by 10.140.40.5 with SMTP id w5mr52418715qgw.65.1394632328547; Wed,
 12 Mar 2014 06:52:08 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Wed, 12 Mar 2014 06:51:37 -0700 (PDT)
In-Reply-To: <1394631854-11208-1-git-send-email-quintus.public@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243938>

On Wed, Mar 12, 2014 at 8:44 PM, Quint Guvernator
<quintus.public@gmail.com> wrote:
> diff --git a/builtin/apply.c b/builtin/apply.c
> index a7e72d5..8f21957 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -846,8 +846,8 @@ static int has_epoch_timestamp(const char *nameline)
>          * YYYY-MM-DD hh:mm:ss must be from either 1969-12-31
>          * (west of GMT) or 1970-01-01 (east of GMT)
>          */
> -       if ((zoneoffset < 0 && memcmp(timestamp, "1969-12-31", 10)) ||
> -           (0 <= zoneoffset && memcmp(timestamp, "1970-01-01", 10)))
> +       if ((zoneoffset < 0 && starts_with(timestamp, "1969-12-31")) ||
> +           (0 <= zoneoffset && starts_with(timestamp, "1970-01-01")))
>                 return 0;

It is not a plain search/replace. starts_with(..) == !memcmp(...). So
you need to negate every replacement.
-- 
Duy
