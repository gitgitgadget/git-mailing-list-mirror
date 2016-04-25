From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 78/83] Move libified code from builtin/apply.c to apply.{c,h}
Date: Mon, 25 Apr 2016 20:46:48 +0700
Message-ID: <CACsJy8Cb20L=y_=J6S5=rngvH1n0aWvtf5eJrXP-df0aoiJyrQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org> <1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:47:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1augrG-0003KI-MZ
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 15:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754672AbcDYNrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 09:47:20 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33543 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754484AbcDYNrT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 09:47:19 -0400
Received: by mail-lf0-f52.google.com with SMTP id y84so19230829lfc.0
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 06:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qBkchVm6sKXhVkPAGfKYBXsYr8VlQxEsJ4axGeo/bx0=;
        b=k4gxVfOMH6O1+VGU94M/PZ40qINzAv7u6Ca+qUEg8TE44w7ZFa8Qjji4d2Ap8C6OZW
         cj/crBpr6GTrNsprlDpYZnRktyAMooi5zYtcl7GUPdtps/whOqmdCqmBNpcSdHJOn6BN
         LAgat6gZfiLk4lyKDcUnN1rnAgITRajDlT0+6whxX8fA4rAnpnGXWY+DsdzxfdO9kU/Y
         W62VIdoig2PUGTexdgowhHNXtykU2EiszlwSfgT5exGR/LhNk1f9YotdqaYHlRuEJ5s1
         F+blz/ulnbnzWBW5MpT4d2xmOilSxPLgdiXPL3eZG1B/H5xcOLaY03NaTnECFCiSyP0K
         uKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qBkchVm6sKXhVkPAGfKYBXsYr8VlQxEsJ4axGeo/bx0=;
        b=jYlQqJz3IIjtu33sZ2dfiqRVsdT+JDclaaA0duBMUsoCyBN2/DLUGpWQ0x9qOv7Oi9
         VyQFUiJxb+Q0yJRtU7B09gbRzLV5ozCKxKcEQqpN7QUcBXbQDkJILNw7/dMEmt4Gh+/b
         ywBPpiKEqDvcaT33AaoC6CWPaLAvmlBt9oRuD34zhuJfQfbVj4E2+iWZTI0IwpkEze6C
         R5I/dF25/+9xcHxhuBxvRYzoMReVjt/lljbYPN46sQcXrCBcDuDzOFMAtgyuI8Thraid
         1Hp55xNU6ZKogfISy26KcQq1HELTUwV3/SAqUT1MhkhVF8lUbhruYOieqA6d+4UQGRy4
         2PQA==
X-Gm-Message-State: AOPr4FU0gP/Sk08qSWDe5e8OP0ga6nLU/RkKiNmt1cxOUYt4XTr5ynRzIMFWwI+5mhLuqU4FyEH6ricVVSltbg==
X-Received: by 10.25.23.155 with SMTP id 27mr9639157lfx.3.1461592037635; Mon,
 25 Apr 2016 06:47:17 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 06:46:48 -0700 (PDT)
In-Reply-To: <1461504863-15946-79-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292478>

On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  apply.c         | 4678 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  apply.h         |   19 +
>  builtin/apply.c | 4677 ------------------------------------------------------
>  3 files changed, 4695 insertions(+), 4679 deletions(-)

Maybe if you can rearrange functions in the right order in
builtin/apply.c first and move everything in one patch (i.e. apply.c
is created here), rename detection kicks in realizes apply.c is a
rename of (old) builtin/apply.c and only shows the diff of (new)
builtin/apply.c which is about 90 lines... I haven't tested if this is
true though.
-- 
Duy
