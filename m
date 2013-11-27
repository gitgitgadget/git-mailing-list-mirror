From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 27/28] clone: use git protocol for cloning shallow repo locally
Date: Tue, 26 Nov 2013 20:36:42 -0500
Message-ID: <CAPig+cS1rbX4DZSv-V5_fOY8bfT5jUvXZCtAWpSfhcHUNhV8LQ@mail.gmail.com>
References: <1385351754-9954-1-git-send-email-pclouds@gmail.com>
	<1385351754-9954-28-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 02:36:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlU3l-0002F7-7x
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 02:36:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759497Ab3K0Bgr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Nov 2013 20:36:47 -0500
Received: from mail-la0-f41.google.com ([209.85.215.41]:64890 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752650Ab3K0Bgo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Nov 2013 20:36:44 -0500
Received: by mail-la0-f41.google.com with SMTP id eo20so4841860lab.14
        for <git@vger.kernel.org>; Tue, 26 Nov 2013 17:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=KMGdl3v3DHlHL9zZiSjr2XZh67On1Piz4y5VNgVdK7Y=;
        b=xAUjSBbq9P1hOOcXZs84VIX4uG4rPLm/vuHYrhcYO7Zi5juHmuGOxyV47KMrbHqnIw
         8v+CVsOSxrYNuHcI5WBlrVlvL0KAYp1b4EvIsz4ljkK8qobJ7VfuC5PgeAQAyBckjAf5
         lRfJq8Ma80ajIZqS1sRTzRxDIXVQSapnwQZ9o4lQ7XnmdEg/g65HW3BJJ+vPtjUcEIgl
         u+r8e1lTS0XjiUxwnuKX5bW4Lq/zjzd2ej5lCCFnt7Yeb5Y+L8BQrRRvdLih2rBurC1R
         VIeI2ffxg9STg9J1PdgPpgosDeiIYT/S+u20WY5rAtu5E59TmwDmntrOQdnHUO+5hVoY
         gm6Q==
X-Received: by 10.112.37.134 with SMTP id y6mr88455lbj.29.1385516202215; Tue,
 26 Nov 2013 17:36:42 -0800 (PST)
Received: by 10.114.175.130 with HTTP; Tue, 26 Nov 2013 17:36:42 -0800 (PST)
In-Reply-To: <1385351754-9954-28-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: P0qBt49pAcx5_KGCtBQl_RhMWRc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238402>

On Sun, Nov 24, 2013 at 10:55 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc=
 Duy
<pclouds@gmail.com> wrote:
> clone_local() does not handle $SRC/shallow. It could be made so, but
> it's simpler to use fetch-pack/upload-pack instead.
>
> This used by be caught by the check in upload-pack, which is triggere=
d

s/used by/used to/

> by transport_get_remote_refs(), even in local clone case. The check i=
s
> now gone and check_everything_connected() should catch the result
> incomplete repo. But check_everything_connected() will soon be skippe=
d
> in local clone case, opening a door to corrupt repo. This patch shoul=
d
> close that door.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
