From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Move unsigned long option parsing out of pack-objects.c
Date: Mon, 22 Jun 2015 15:08:09 -0700
Message-ID: <xmqqbng7flbq.fsf@gitster.dls.corp.google.com>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
	<1434911144-6781-1-git-send-email-charles@hashpling.org>
	<1434911144-6781-3-git-send-email-charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 00:08:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79t3-0004cl-98
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 00:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751724AbbFVWIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 18:08:14 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34975 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751267AbbFVWIM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 18:08:12 -0400
Received: by igblr2 with SMTP id lr2so41446471igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 15:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=qXICHGhcbQuXjLGnUIvK5l74vEszv2XQMeENTlvYVik=;
        b=JcyCCBWBlURGo6jS6gjxl9k5jrqyY0+8jHZV0MtVaiS+fMaWJeRT8hQxvE9JGr9AxB
         dfHQ6KywdAZJG+aZ+S6yolnqUmpMXBd/IpIoB8R748s/3kpoBZ6sAZUNdEaPgDPDXDG+
         f49FDB3slVrk+4bXSRmmo0W+aG9jeaqHbyLZ6pzO70GvsADOtMMEP1aUgk9+xJv0xTPz
         mJtOKhtZOUropIN/D/qrZPtmpdwaUcEdH4Xja9xNvq+0O92t4Hguixxa4/2DoUDtxIyw
         873YR7yobJCVMSQmw2E/OK7VqFU9v110HGc7JP81y9HP5cKTzCFh0I7/Fazsf3n1qQQK
         pQ6A==
X-Received: by 10.50.138.136 with SMTP id qq8mr24397254igb.27.1435010892155;
        Mon, 22 Jun 2015 15:08:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id a2sm8404342igx.3.2015.06.22.15.08.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 15:08:11 -0700 (PDT)
In-Reply-To: <1434911144-6781-3-git-send-email-charles@hashpling.org> (Charles
	Bailey's message of "Sun, 21 Jun 2015 19:25:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272427>

Charles Bailey <charles@hashpling.org> writes:

> From: Charles Bailey <cbailey32@bloomberg.net>
>
> The unsigned long option parsing (including 'k'/'m'/'g' suffix parsing)
> is more widely applicable. Add support for OPT_MAGNITUDE to
> parse-options.h and change pack-objects.c use this support.
>
> The error behavior on parse errors follows that of OPT_INTEGER.
> The name of the option that failed to parse is reported with a brief
> message describing the expect format for the option argument and then
> the full usage message for the command invoked.
>
> This is differs from the previous behavior for OPT_ULONG used in

s/is //; (locally fixed--no need to resend).
