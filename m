From: Brandon Turner <bt@brandonturner.net>
Subject: Re: [PATCH] completion: ignore chpwd_functions when cding
Date: Wed, 8 Oct 2014 16:50:16 -0500
Message-ID: <CAMUzdXkQcbwhmJRYog+X_9B_cdWv6FkTrVFT__Dsw2k+qKN0=g@mail.gmail.com>
References: <1412740394-34061-1-git-send-email-bt@brandonturner.net>
	<xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 08 23:50:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xbz8J-0004h8-3z
	for gcvg-git-2@plane.gmane.org; Wed, 08 Oct 2014 23:50:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbaJHVuS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 17:50:18 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36041 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932133AbaJHVuR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 17:50:17 -0400
Received: by mail-ig0-f179.google.com with SMTP id h18so456082igc.12
        for <git@vger.kernel.org>; Wed, 08 Oct 2014 14:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brandonturner.net; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=yR904qsrSt3BblJNa1CZcUvLQS7ABX1HGzQQoHszlnk=;
        b=HOOBJ+MFdwzThlKcGnaNagzj/q4rvgTY61t/ORMFgMAl3ePaHmJHOMUd/Wlk0KQehP
         VqjWfh9APk80XCyr8LKbxVBeArKWp7aw1tZXFfKb5IxaXOJbJl8kPVccliL8i44Cjr81
         xjQu3VB35ZsKfa4odsXS5LTTTXBHTo1wVWrco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=yR904qsrSt3BblJNa1CZcUvLQS7ABX1HGzQQoHszlnk=;
        b=WhZKMXzbthTbZMULwmr5EX+VpOBaThrqnuXQd3k7kWtjwgLsXA1kGlRx3A/+nVNsb8
         zbUJyF54srkbdgeBS5vs1F0BqNBFPf4FYnAuJFzFw2pxpSUXVCj53yXVwEM3lSvCaWG1
         UVpJFJBTLEhDHBDuDld6PLFZWQvHdoBV3Qcrfymeqo23KEBxa96wbnxWte1+MdTdQf78
         fL2baEPLpELDz64msjsv0KoSehfGzjFKkYcq0yzEj4A8qcXwOKxMPqdmsFwNhVZH0bNu
         1XgLLX7BC7wKt41LEZeoisMSojIyV51w09Ticz5PeHY1BTCbJSz4JAjv+0V8S66TsMjO
         HA3g==
X-Gm-Message-State: ALoCoQkBzTunHMUOitQYdYqSJXA+B1ZK6I+NmBO3QlBFk/Q9PWz23YyEpsF4n2LCHXobKhXBtgBs
X-Received: by 10.50.43.193 with SMTP id y1mr889815igl.32.1412805016833; Wed,
 08 Oct 2014 14:50:16 -0700 (PDT)
Received: by 10.64.230.66 with HTTP; Wed, 8 Oct 2014 14:50:16 -0700 (PDT)
X-Originating-IP: [128.177.65.10]
In-Reply-To: <xmqqh9zebfc6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 8, 2014 at 1:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
>
> Can you mention that this is abomination limited only to zsh
> somewhere in the log message?  Or does bash share the same glitch?
>
> If this is limited to zsh, I wonder if we can take advantage of the
> fact that we have git-completion.bash and git-completion.zsh to
> avoid contaminating shared part of the code.

I'm going to submit two versions of the patch:
v2 - addresses the log message, but the patch still applies to bash
and zsh
v3 - moves the change to git-completion.zsh as an override, bash is
unaffected

>From my testing, bash is unaffected, so v3 would be an ok fix.  Since
we cannot control what functions users add to chpwd_functions, v2 might
make more sense.
