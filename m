Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1B4C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337AD21655
	for <git@archiver.kernel.org>; Thu,  7 May 2020 19:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DogeDyU0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgEGTiY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 15:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGTiX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 15:38:23 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F1AC05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 12:38:23 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f3so2224566ioj.1
        for <git@vger.kernel.org>; Thu, 07 May 2020 12:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=MSdZGF5JjXkeJc5OAtINM5edsBHq5UJwmh+vziQPbK8=;
        b=DogeDyU01vmhrPp1qVLvh4egj7ps4yOEObUoIQnV1M55GxbrsmU3t2r02bO3u92obL
         xhtJqfKXQalmLaXdtlHKd/0UDZTQHydt02tbkq3lCOOOtjy+IEsN/PJ6adYGpQob/Tmp
         XDjygZjyK/k+ScjoQo/YOdd6cVElJiTTyGj8yxMejZLHxC4FpcT0ZxLaeV0HnD1tbnxz
         gfR49FrcLDEc4oCBVFYDVMuLgUsfngyiDCC+zGFRx+Ww6jtkvwtR/BGiuMTL5gGSu2xJ
         VaMMC/NtCSCE9ncqjRnL8cnGVSiHEkKgLm6Lrn1/yyiReD5/5MSIJJC8NtO1+V6KibV4
         z3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=MSdZGF5JjXkeJc5OAtINM5edsBHq5UJwmh+vziQPbK8=;
        b=BjQg8b9wgXjpRoZ1zmQbfaY00X2OBljkoa9gLzMPGMethOf/p4tA6WK6oXlwhJGBq8
         obQWbwXTlqu9DfgW3qOaRnXijiAEOC+LjLN9h2OHMXdOrodSBXTKlN3tpK7Mmo+Md7q4
         lzJOjisdBqoLaoouOwNVHKK2iddbPXp+ZjbG1qkgWk6GTCkmatQxp9wdFcetvZv4kcOm
         7czFNw0DzC4Q73jYMiMRwA/EXOzoSfQKlVXCoTahRUrORNC4jpen7HLgw5MSf7FnMJYg
         f3GrlbWHFdtHruFQyQpdpHD5QI2q+uktA0z64nJ7xA0BPMqshzZlBce/MPY+0V/tfov/
         Kyvg==
X-Gm-Message-State: AGi0PubkNXXsbvnPPfgKUkT18MhgVkRruszj/HNLXlmSyrZGZM1m9yhx
        YgGBtjqIx4Q351f7V4XrnaKAMSu7puAwVxu++Vr/Yfnr
X-Google-Smtp-Source: APiQypK689qyavos9gVAHivsdyonpkEltuT/focQltjr92yrEcbj1/V3LrcjZ8QtLazfevUSjIP/iwI9hJ3iodXKKWA=
X-Received: by 2002:a02:8447:: with SMTP id l7mr15647054jah.54.1588880303080;
 Thu, 07 May 2020 12:38:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAH8yC8nAsF7HT__AhsRk08wpa_Bjsc6RXoZuomVbM1CWeG8QeA@mail.gmail.com>
 <20200507191140.rm5dynfgbxgutiz5@tb-raspi4>
In-Reply-To: <20200507191140.rm5dynfgbxgutiz5@tb-raspi4>
Reply-To: noloader@gmail.com
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Thu, 7 May 2020 15:38:07 -0400
Message-ID: <CAH8yC8nMCJzmODZ9QE3kqSfyUO8uH_zJOgiOLV_bN-Ec=95KmQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGNobW9kOiBtaXNzaW5nIG9wZXJhbmQgYWZ0ZXIg4oCYYStyd3jigJk=?=
To:     =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 7, 2020 at 3:11 PM Torsten B=C3=B6gershausen <tboegi@web.de> wr=
ote:
>
> On Wed, May 06, 2020 at 10:03:01PM -0400, Jeffrey Walton wrote:
> > Hi Everyone,
> >
> > Git 2.26.2 passes its self tests on OS X using libiconv-utf8mac.
>
> I think this sounds like good news; what is libiconv-utf8mac ?
> Something you compiled ?
> Anything you want to share with us ?

You can find libiconv-utf8mac at https://github.com/fumiyas/libiconv-utf8ma=
c.

Jeff
