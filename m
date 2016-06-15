From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: Re: [PATCH v2 0/6] convert various shell functions in git-bisect to C
Date: Wed, 15 Jun 2016 23:39:06 +0530
Message-ID: <CAFZEwPO3z6FPwigM3GUecp95wBHaMetvHStj01oeOfSfgG84-A@mail.gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
 <20160615140026.10519-1-pranit.bauva@gmail.com> <CAPig+cTV8Mum1b7XxUit4Kn5WBX2kukWvvjkhOCqxnFtcjfp0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 20:09:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDFFe-0005q3-IP
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 20:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620AbcFOSJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2016 14:09:10 -0400
Received: from mail-qk0-f177.google.com ([209.85.220.177]:36625 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbcFOSJI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2016 14:09:08 -0400
Received: by mail-qk0-f177.google.com with SMTP id p10so31233448qke.3
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 11:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oQvvFHxb1Dj/IeRPD2oIvY3otEg540drP+rFi1qLHgw=;
        b=AykdwSu5/qi4lcUdLojAbOmsadqJS1/p0DJkhsLAil39/FARAcJHJH8SiKOrzJZHUQ
         38mvuZ34RYfChdvBNMoi6baLJdms2sPUS+uLJ5f/DDp1SVArFtmLcToHS8wclZik41tq
         XzQ6+3F1TzeZ4oxoNrt+pWQ0mgmfv5XOiUgy7SBwU9++dVfExJ+jXipcmdnYE0XBcxON
         GtaWmoY0RRuComUhBYW+ZncfdJxHRcp8WaIp4pLUGrR9TGuJ1eefzdAMzBebTyF5Mg9l
         GdB0iKAAjxL/QSCOCdIb88Px2TxX6mmaPY7tI9TSsU/IihvuB5HKoVabltAwy+sQIbjM
         ax0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oQvvFHxb1Dj/IeRPD2oIvY3otEg540drP+rFi1qLHgw=;
        b=k3mn8QlIj48Uv4c97JiCY0bK1H00hPPraP6a7y5Q+fGDwUIK3NhLH0kQVP5ml2QmF1
         iQhccSdF0u1Fk2u7H1TGbwKFzEV5CnHj9T0ZJtLFYT6WNIDQuUDwGSGxIpbMm8GRfn2D
         yCCe5Tx0i4WFCOgxJ5gvvGz9Z0nIsMXyVo4WO2zXOVnKYzzKcCEAirGe5g0uUQkOP5qs
         DeNVvJodstnOUvrnIaxKdTQYtwvsbc55ABJ3DbhAxNyd/LQMiJlm8T87T8+h7qcgVQSR
         8hKUsa0TbVjaG3yCogqEOMtu9m6I3wqjqrRgRGWwK0r4FEzDBDkbv3++/PouxSpuCEdC
         89CA==
X-Gm-Message-State: ALyK8tJrZm6x/F8ufDbd3zY/v00J4XHJXb4YoXwvK9WG9U6DUfdSMcR4fZxB9yNBTvmLRhR9k4W6itAy075j4A==
X-Received: by 10.37.231.137 with SMTP id e131mr23939ybh.7.1466014146861; Wed,
 15 Jun 2016 11:09:06 -0700 (PDT)
Received: by 10.129.116.193 with HTTP; Wed, 15 Jun 2016 11:09:06 -0700 (PDT)
In-Reply-To: <CAPig+cTV8Mum1b7XxUit4Kn5WBX2kukWvvjkhOCqxnFtcjfp0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297383>

Hey Eric,

On Wed, Jun 15, 2016 at 11:23 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jun 15, 2016 at 10:00 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>> Changes wrt previous version:
>>  * Use STRING_LIST_INIT_NODUP to avoid leaks in bisect_clean_state()
>>  * Use test_path_is_missing in the patch 2/6
>>  * drop file_size()
>>  * move is_empty_file() method from builtin/am.c to wrapper.c
>>  * use static for methods
>>  * remove the variable status in bisect_reset() altogether and put the whole
>>    thing inside the if block.
>>  * one more method converted namely bisect_write().
>
> As an aid to reviewers, in the future, please also include in the
> cover letter an interdiff between the previous and current version of
> the patch series. Thanks.

Sure!

Regards,
Pranit Bauva
