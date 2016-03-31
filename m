From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 4/5] submodule--helper, module_clone: always operate on
 absolute paths
Date: Thu, 31 Mar 2016 16:08:02 -0700
Message-ID: <CAGZ79kb4xOraKCODeLNqHCCdpdG=2aYofVsu0MRQteBozCsswQ@mail.gmail.com>
References: <1459458280-17619-1-git-send-email-sbeller@google.com>
	<1459458280-17619-5-git-send-email-sbeller@google.com>
	<xmqqfuv6l1xf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kaAs_ZwxfhLSTw3z8JY33vGToms2z6zYEiCmRpfS6SA+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Norio Nomura <norio.nomura@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 01:08:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1allhD-0004PQ-JW
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 01:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbcCaXIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 19:08:06 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34337 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbcCaXID (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 19:08:03 -0400
Received: by mail-io0-f179.google.com with SMTP id e3so132354884ioa.1
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 16:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=4dOqO0br6KBsHEmk0YGpNHYIEuzSaRcBiEaBOmnRJlI=;
        b=VK0zQBx2uiuZa+ZDO9074wc+na+aEG2RDbLg+8cPplrd6/P9mAnRiYMMUKY30QfRDh
         DBqd4+PjlBt5RLyV9hEpvXa8uqzQh6ih4egLS1zWgnRpHQZt9nO4ifCTlNQHdlNsgpSG
         262r4iAfJ8ycRqerDxyKFXommn/j3t2pGITTX31ARZ0TiVuxjDdi7sf9sC4+qhrEeIIa
         uUJadKE09djXl8Ls2a0WATZ+nc5P9fqn+UeZa4jTri2SeS6mCpXtNUZOsRc432xECftf
         Ll2V2NiALsd5UKRKJVcLyrkEvcn7ezCu7PAiWFKlDUSPs2yBISJFrDgFN0fvURvmkXZl
         MIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=4dOqO0br6KBsHEmk0YGpNHYIEuzSaRcBiEaBOmnRJlI=;
        b=V3eFrvmFl9XfxB3l3mlog04QjOwYpNpGeSzQuIWSaDRv5203nD4HcCw2V2Hrp+EXBE
         nkLDm6g8Dy7sP0Fpe7vIpz3JbbA1ri9AEmg9xRRTtevXrrzZ/CqVJh3NXBz0wh7n9ztU
         uVPemtbgyMovGD51r5Zyn/J+NNRmfzKjDgPOXHFD3fOQ1AhWKQfgdhdAslDt72zps+eB
         iDGHXe28djda1LzCBrEDFgftn99tLIn0JSV/MCkEUn+whVGEksDACSgaZsJBEdJQn9jK
         ddPb+uVpY/Y8ntsZO5VA6Gf1yxBXogczbrgnjR9nNGJB87N8oZnPS6WlwOSPgd+e6sn8
         Venw==
X-Gm-Message-State: AD7BkJKW+Bp8q8qPThoCgepWwmSemWX+X1v2hb0YvnYERB0UfsXY93AuAgxKRod2nIdpei4UrWIC6270QbudIEb5
X-Received: by 10.107.158.138 with SMTP id h132mr1486129ioe.174.1459465682438;
 Thu, 31 Mar 2016 16:08:02 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 31 Mar 2016 16:08:02 -0700 (PDT)
In-Reply-To: <CAGZ79kaAs_ZwxfhLSTw3z8JY33vGToms2z6zYEiCmRpfS6SA+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290487>

On Thu, Mar 31, 2016 at 3:59 PM, Stefan Beller <sbeller@google.com> wrote:
>
> Further checking reveals any caller uses it with
>
>     desired= xstrdup(absolute_path(my_argument));
>
> We are loosing memory of the strbuf here. so if I we'd
> take the diff above we can also get rid of all the xstrdups
> at the callers. For now I will adhere to all other callers and use
> xstrdup(absolute_path(...) here too.

Actually there is only two occurrences of xstrdup in builtin/clone.c
