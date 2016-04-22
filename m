From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 0/6] Move PGP verification out of verify-tag
Date: Fri, 22 Apr 2016 13:22:47 -0400
Message-ID: <CAPig+cR9i1a7pxOxV4QU2TnoJWKn4mHHVT2tG3+uRysw=sc6qQ@mail.gmail.com>
References: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Fri Apr 22 19:22:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aten9-0003RK-Do
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbcDVRWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:22:49 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:32855 "EHLO
	mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754330AbcDVRWs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:22:48 -0400
Received: by mail-io0-f194.google.com with SMTP id x35so4113944ioi.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=uVuJTosJDIvgDO7L7y89TCJfjJrDZ6MIyKH4yA2Rqrk=;
        b=CYpBQGgQizqn08SyyLkXnU+4wxyh3OPrN4nv5oprJmKsLMfQQQaaCV2uhUplIkOGz+
         xDzKct94fUP4shwulCRoXCARcSG+W2p+tx2pEsBctU6wYrmsCnB3lM+ctUHXshfArI/y
         5FwnGIX9nDz0FKc655ldxO0dZsKaiYpvbD9D50UsNED7GdodmftlRGCbzcSphS9/LYP6
         7qsDcv/FxHI7kLRZkfoHQHlOy+tM+u7ZMShDoeJ9UH9tFLa6aMQ0xb2JUITfDzWLNmtU
         w59e825PrKoPFXs8xSj5+FTkSB33WmtOPmTFWJ+Tq4SKKq+mcP4oIYlJQQSixeUuZono
         8XVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=uVuJTosJDIvgDO7L7y89TCJfjJrDZ6MIyKH4yA2Rqrk=;
        b=Stvrt8cszD/6vAb773NCsrVemxcz3bT/+CnxH+uuTMiTkghoE0FGlSAI4+Zktc3eOs
         a38XHjGgJ4+I5Jy5WVaKSOvrmo9fxh6mgfSn4Keol1FeQyvQRcqwHKP5PsjgkCjnA0i6
         0cP4EA5SInmBxeBQHDaXyuncpWFs3ELQkvWgI29q65pxmaOh2Kb9GEooGBchctVj6Tzx
         CAkOXxVO0wcLM4rqfyaoOarhGsjxZkgnwJl6/NDXuniZKRsT5jtp7MEcnfYL/grwDVBV
         SNQRaGT0nt56wFsQmskVHIQ1ztekN2gvQpUGj56h8j3pSXF8x9RAN7MnjzjgA1XfDaoQ
         Yc7A==
X-Gm-Message-State: AOPr4FVLubWBZvNT1NcqKJTQsUWPAPSPF+aGvvJ8fkXA9Ug+wDfv2SsRhvo19L4Q9u1vbTKLFI2Xd9oVJsw2Rw==
X-Received: by 10.107.47.10 with SMTP id j10mr23878870ioo.168.1461345767223;
 Fri, 22 Apr 2016 10:22:47 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Fri, 22 Apr 2016 10:22:47 -0700 (PDT)
In-Reply-To: <1461336725-29915-1-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: PvRimZ1iDr2vA5svQ14d4zR5n9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292229>

On Fri, Apr 22, 2016 at 10:51 AM,  <santiago@nyu.edu> wrote:
> This is a follow up of [1], [2], [3], [4], [5], [6], and [7].  patches 1/6,
> 2/6, and 3/6, are the same as the corresponding commits in pu.
>
> v8:
> Minor nits, I decided to quickly reroll to drop the extern qualifier in tag.c:
>   * Eric pointed out that we could block-scope the declaration of name and sha1
>     in b/verify-tag.c, for 4/6
>   * There was a typo in 6/6
>   * I dropped the extern qualifier in tag.c for 5/6 as suggested by Ramsay
>     Jones[8]

Thanks, this version seems to address the few minor review comments
from v7. Regardless of the whitespace nit in patch 5/6, this series is
still:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
