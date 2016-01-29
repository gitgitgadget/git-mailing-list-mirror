From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 10/10] diffcore-pickaxe: support case insensitive match
 on non-ascii
Date: Fri, 29 Jan 2016 01:38:12 -0500
Message-ID: <CAPig+cQ+Vufk9itMfMsP5jsSNUNiGQ7BmgJ_aq6wGjQZ+1K3QQ@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1453982183-24124-11-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 07:38:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP2hF-0005oe-KO
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 07:38:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcA2GiN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 01:38:13 -0500
Received: from mail-vk0-f68.google.com ([209.85.213.68]:33680 "EHLO
	mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751700AbcA2GiM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2016 01:38:12 -0500
Received: by mail-vk0-f68.google.com with SMTP id n1so2474898vkb.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 22:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=y8MNeGqv5mPRokbDFXjRdU0BXjiMIO5ApNalHTQfXTY=;
        b=z3AmE4YFSwpz21iw3zqKVuupl6/hsRjLK6fynD9Wr/dJVw+BBIsHKhJWDF94lZksla
         PIMV3W2mbLnixzn1g1SE2/yT5DDpK0WaSjHKkmbAi/Vpd755Dqei+akvozawUuISAuEL
         LCMtlYpdHfu+tccC2KzTZqw4DQ6SDnm8neiuEw2WzFoPjuBv1AcdG5D9tv6rnrH2Eiwa
         37r3Pajao8l+sm27Zip7aeDd7p9K1CWKalKAyYjiz7zwDYSh8HAL2XaHD1SaqHy6owbe
         isBfW8o3GOOj4E5sjNjvOf8o5WIF8zaFGCfD4Z/3L2tmKpf9gYcM1vs4mkAw2lVfLipk
         Gauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=y8MNeGqv5mPRokbDFXjRdU0BXjiMIO5ApNalHTQfXTY=;
        b=VryukSPiuSsLyNJ6SXEZiuSQCO1VAPw53Fhj94OH3cY/o/lhQtmRRayHVhiDjRd35U
         rdhk4Z23hiy3v64cnvMfTn+IZx80P1yMF2hPnBVXjc+blcYF+Y+0ysrKp3nUC7w3KXpt
         WZfJ26zHmDNgYKA6ggT7CChkkb1Kk4cbRHxyW8XBmO09144Dae8bnb5HxFN/PnYRBr9T
         W8lEqtfaLAELDqUptVy/fnVPwnrkLZtvlqeGs9LOcUfXRa8Gwhz6u6YDewnYOb025GNz
         ecaUvh1f651rEiT9qkG++8lxiBGiURurIGD835yS5JYv9/alaNTHJcMB9nubyqqQO7wd
         NjcQ==
X-Gm-Message-State: AG10YOTOi2A1BzXkPTHCmOwUYN/eAvhak9bbELx4yul5TBwuneATssARDfJlCRKw1nvtUkNj1SBApbDs88LvMA==
X-Received: by 10.31.168.76 with SMTP id r73mr4767474vke.117.1454049492105;
 Thu, 28 Jan 2016 22:38:12 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 28 Jan 2016 22:38:12 -0800 (PST)
In-Reply-To: <1453982183-24124-11-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: ywbnEmXuEEDHy7lzPXm9jytgXsU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285066>

On Thu, Jan 28, 2016 at 6:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Similar to the "grep -F -i" case, we can't use kws on icase search
> outside ascii range, so we quote the string and pass it to regcomp as
> a basic regexp and let regex engine deal with case sensitivity.
>
> The new test is put in t7812 instead of t4209-log-pickaxe because
> lib-gettext.sh might cause problems elsewhere, probably..

s/\.\.$/./

> Noticed-by: Plamen Totev <plamen.totev@abv.bg>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
