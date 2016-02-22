From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] GSoC Micoproject: Hunt down signed int flags
Date: Mon, 22 Feb 2016 16:32:55 +0700
Message-ID: <CACsJy8CbGY2BNF=VYtJFReVTycae18bdkqRhmVQi76COvm5f0w@mail.gmail.com>
References: <1456053189-5221-1-git-send-email-sauravsachidanand@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Saurav Sachidanand <sauravsachidanand@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 10:33:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXms4-0004Q2-Jr
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 10:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753583AbcBVJd3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 22 Feb 2016 04:33:29 -0500
Received: from mail-lf0-f49.google.com ([209.85.215.49]:36371 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753979AbcBVJd1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Feb 2016 04:33:27 -0500
Received: by mail-lf0-f49.google.com with SMTP id 78so89570930lfy.3
        for <git@vger.kernel.org>; Mon, 22 Feb 2016 01:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=dAMN/fTm4qsmjS91oZJ9ZPLxVVWDGTIvQ+V9MOwkS2o=;
        b=mPAtSK5Q9WgaMIq1TE2gw4SdbtXMTC8DtBI3yaFpdBsOnK9eohZl/9AiYjHaW+1Com
         ZHtOMpi4rR4y0nKhaCshtX8w9V9WQTIP/ZccWMZx/thdt5/4vlZbMCbXiJHfKcdrqiXZ
         4tNgaf3OE61nflqB8x1UNH74vhderuBYI5VlSAt8F4ckOYyOsZUBI4lExTKc61fGIsTS
         7fZZJxIWDQ/PXwbFCh9qmwABWcgQXcPx8FSlqBZ3nRuNr2Mqn+hsPn8428ZYjwIELKct
         rk0FCK9x7uQf9pW3PnZd/1SDgisano9mW4bq/MjzKgXcj7/LGHBbzl+AWUkZ5KeVw4vs
         YOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=dAMN/fTm4qsmjS91oZJ9ZPLxVVWDGTIvQ+V9MOwkS2o=;
        b=KScw35ILnmbSjvozeMZfHNxFF/M2/8Rs+XK3lHkq0LOEWT+VabSHlbsmllIs4XX//L
         v1dFU17T3SzsDYvJdhkOj62/XiCtXQfbNCvKAMya7WhcnY1y5sYpl9D/uXbUO+P182a1
         0TOIGmDNvurjHwJGn4lZUJTcDOTufk34VGKPiXYhJuOhW0Q1WUPNpIcSWfT0boir81SY
         zxIplqJPdTYDX2qSmJy2DZA/s+s+htgV1290FuCx6WIikGsHMB5hYpTOfGE/QUJ+FvVO
         VOxGh5SrfKTHbRnbzVOJo67FyAQKhuWBijRqa6BzKMqqxN75t6bkVmQcfMfNFJycTaBv
         RM1Q==
X-Gm-Message-State: AG10YOR01vabpsg090dnJkFdWB7xKfuo439VHJlCIsFl1aEiiscBft9GqbNyH3hmQARJHMvpTsapW2czNis9xA==
X-Received: by 10.25.157.213 with SMTP id g204mr10444679lfe.112.1456133605497;
 Mon, 22 Feb 2016 01:33:25 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Mon, 22 Feb 2016 01:32:55 -0800 (PST)
In-Reply-To: <1456053189-5221-1-git-send-email-sauravsachidanand@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286900>

On Sun, Feb 21, 2016 at 6:13 PM, Saurav Sachidanand
<sauravsachidanand@gmail.com> wrote:
> This is patch is for a suggested micro project for GSoC 2016; namely,
> that of searching for a field of a struct that is of signed integral
> type and used as a collection of multiple bits, and converting it to
> an unsigned type if the MSB isn=E2=80=99t used in any special way.

if you use gcc, you can try to build git with -Wsign-conversion (i.e.
"make CFLAGS=3D-Wsign-conversion") with and without your patch then see
if there are any new warnings. I only checked dir.c and attr.c, there
were 4 new warnings. From a quick look, I think gcc was correct, you
just need to convert some more "int" to unsigned int" to prevent
implicit conversion.
--=20
Duy
