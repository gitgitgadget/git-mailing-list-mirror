From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Tue, 28 Jul 2015 11:13:50 +0200
Message-ID: <CAP8UFD2x5rz18hUXmJVWw81EMEVZc5Hm=_GUwfuc6Fo--8Ukfw@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
	<1438066594-5620-1-git-send-email-Karthik.188@gmail.com>
	<1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 11:14:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK0xS-00070x-8f
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 11:13:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbbG1JNx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 05:13:53 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37317 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752691AbbG1JNw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 05:13:52 -0400
Received: by wibud3 with SMTP id ud3so149895288wib.0
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 02:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZzgActvb3nryHXwZl8B2bSBWVdfDo1tKhGdcOnGt0CI=;
        b=LD+y4W6fRzcx/ibchBvLN7FTN3tvw4QrNMCCSv6cnCBHFKpBy3PxkQl6fNitt8ZBZT
         MtPTykq9Y8rWodj+YJYWEbsw20yC2XhUlz/r+vJ3OCCQDVRgsemUsfQCGK/80FUFUsF/
         wdfAQej62rsphB7e/eRIdGSuxxQ92Apap865mOOo6aURagZJdWt5f0999aZjq5/bOgxy
         3T91fKY/t5GkbDkqRqwHi1kxHn74dixBGz7JKEQCVnSa4w34C3/xhDUJ3xawv5KrstqZ
         Sx8FZrFkJLOtvsVS7gdJK9Fum6Bl1/LY9PvjtedIk0i09HOiEJg2I2oh3VKxJ6G6nAnL
         rDdA==
X-Received: by 10.180.86.163 with SMTP id q3mr4756253wiz.75.1438074830992;
 Tue, 28 Jul 2015 02:13:50 -0700 (PDT)
Received: by 10.194.36.106 with HTTP; Tue, 28 Jul 2015 02:13:50 -0700 (PDT)
In-Reply-To: <1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274761>

On Tue, Jul 28, 2015 at 8:56 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> @@ -712,6 +713,15 @@ static void populate_value(struct ref_array_item *ref)
>                         v->modifier_atom = 1;
>                         v->pad_to_right = 1;
>                         continue;
> +               } else if (starts_with(name, "colornext:")) {
> +                       char color[COLOR_MAXLEN] = "";
> +
> +                       if (color_parse(name + 10, color) < 0)
> +                               die(_("unable to parse format"));

Maybe use skip_prefix(), and die() with a more helpful message.

> +                       v->s = xstrdup(color);
> +                       v->modifier_atom = 1;
> +                       v->color_next = 1;
> +                       continue;
>                 } else
>                         continue;
