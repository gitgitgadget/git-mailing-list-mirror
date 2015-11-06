From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] run-command: Remove set_nonblocking
Date: Fri, 6 Nov 2015 11:00:53 -0800
Message-ID: <CAGZ79kbNpwhOF2eveux+yXibrYx+_S6KjvqLV7yEfAe5Sdg4uA@mail.gmail.com>
References: <1446747439-30349-1-git-send-email-sbeller@google.com>
	<1446747439-30349-2-git-send-email-sbeller@google.com>
	<563BBBBC.7070807@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <ericsunshine@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 20:01:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZumFv-0004LO-M5
	for gcvg-git-2@plane.gmane.org; Fri, 06 Nov 2015 20:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756486AbbKFTAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2015 14:00:55 -0500
Received: from mail-yk0-f176.google.com ([209.85.160.176]:33165 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754611AbbKFTAy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2015 14:00:54 -0500
Received: by ykdv3 with SMTP id v3so104387073ykd.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2015 11:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=P6KkKX5dzf984T2/voRdhvPmzJMDFwkV40vVV5bU4Go=;
        b=dIKWEpHE5IePLhKamtwMXqKKqwO7xm6vKKdxgpgbvLNahjD6P45GlNAxtN/bF2Vrtp
         L20NdPFaEVt/g6fqy+UovTC6mIF7tuohANtGJakVhmlGn7+l9ylseGoV41LnB04WVha9
         dZPKRfwdEKcX8IX45fIGtHYgZcRy3rk7ljxMqIr9fvOonKODGCR624vLf0Cwhj6JhM6Y
         31J3L9csiuryu59RVMPv/PNsxau9nSi23r1xzOHiEmS1ld2YdvgAOS4WcuC3RGTRZO+z
         1ygEsgJfi5Y0cxIghyaBqGqSAoTMy7MIEV0Kljgp1EyGcufuMKmMShbPnxOwrPxEttcG
         BB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=P6KkKX5dzf984T2/voRdhvPmzJMDFwkV40vVV5bU4Go=;
        b=QTCo6BARL40TGFnAp15HKCd7+4y23zhcFy66eSwsK9pUFVZL6hZqJKI98q00zbdVZ2
         /k9r7pf/9XrbW4Y2KTpxN9dNZwBWdlMFScgzIZZfSkYRpF20qkgV6BjSTtuAsdJ4EBjB
         mazT857jX48Y9TCd1cjXOnzUouyPSjsB9AEMbZRAAmURIOOv8B9VK3UmDOJZXUNDxw7y
         O8ec76yjUKtQA14GL1KLpcc4gxiJ+uty477tasyeiU9lEuEPuyeaX272cMfa39caQ6tj
         Wy4s7rpLmWj43vrWRDxTX3BJQQaMIAVp/gzy6dBtKYyB5u//isB+wW47E+eKMCCF4VPK
         c8/g==
X-Gm-Message-State: ALoCoQmsFiV1Xg/UtKxyZ8doUqobsw/86WNNDluLAEkLsHi5dP2sJc5ReKleXqFpVo3k4xQWN2A5
X-Received: by 10.13.199.133 with SMTP id j127mr12198482ywd.176.1446836453449;
 Fri, 06 Nov 2015 11:00:53 -0800 (PST)
Received: by 10.37.29.213 with HTTP; Fri, 6 Nov 2015 11:00:53 -0800 (PST)
In-Reply-To: <563BBBBC.7070807@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280999>

On Thu, Nov 5, 2015 at 12:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> However, I think that the infrastructure can be simplified even further
> to a level that we do not need additional emulation on Windows.
>
> First let me say that I find it very questionable that the callbacks
> receive a struct child_process.

ok, I try to clean that up as well. However I made this choice as we
need to set the working dir as well as the environment variables.
I guess these will go into an extra argument then


> Here is a prototype patch. Feel free to pick it up. It marks a process
> whose EOF we have found by setting .err to -1. It's probably better to
> extend the meaning of the in_use indicator for this purpose.

Thanks for the proposal, I'll take that and make in_use a tristate for now
(an enum consisting of FREE, WORKING, WAIT_CLEANUP)

Thanks,
Stefan
