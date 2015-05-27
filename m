From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 6/8] am: extract patch, message and authorship with git-mailinfo
Date: Wed, 27 May 2015 15:13:20 -0700
Message-ID: <xmqqh9qxk6tb.fsf@gitster.dls.corp.google.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-7-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 00:13:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjZm-0001Yu-UX
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845AbbE0WNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:13:23 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:34270 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbbE0WNW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:13:22 -0400
Received: by igbhj9 with SMTP id hj9so99505380igb.1
        for <git@vger.kernel.org>; Wed, 27 May 2015 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Hn2pipGqwmrxgVpnCT9F8pv85tFJP007EwF0TX2GBgY=;
        b=av5onRrKYcdisBPMbNwfQyNqdZWvULiUDYwc4LBX9ryLah12HjSoUIXnScpnLq8IEA
         +bjj7WaLJ8umSfEbkYDsPZuxPwJmA2VsL9bJuc3jUHwAHE+o+NV+XteYPSQIIStXP9qZ
         Gy+BfwwzP7dUWfEXSJ4Ngdw+aPQUpFTEgZEDiSNYNVNtBVRkMVDwzF+FpfR+/YY9Ek+M
         NpsQg4rkNIXGvBka8fdogANaGsHIxNXf3o1ntfeO/VNUnleiN1nx2XNjIZp+ay++V/dJ
         2gmAbS1zQ22Fg3L4/fHMQ3+whyoqNwBHkvfXEMiIARVJ0xJQ4VxSZJvoZYQNg9Tyyed1
         b9pw==
X-Received: by 10.107.8.40 with SMTP id 40mr46602732ioi.38.1432764801668;
        Wed, 27 May 2015 15:13:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:91c7:752b:4513:7344])
        by mx.google.com with ESMTPSA id j20sm580881igt.16.2015.05.27.15.13.21
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 27 May 2015 15:13:21 -0700 (PDT)
In-Reply-To: <1432733618-25629-7-git-send-email-pyokagan@gmail.com> (Paul
	Tan's message of "Wed, 27 May 2015 21:33:36 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270109>

Paul Tan <pyokagan@gmail.com> writes:

> +static const char *msgnum(const struct am_state *state)
> +{
> +	static struct strbuf fmt = STRBUF_INIT;
> +	static struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_reset(&fmt);
> +	strbuf_addf(&fmt, "%%0%dd", state->prec);
> +
> +	strbuf_reset(&sb);
> +	strbuf_addf(&sb, fmt.buf, state->cur);

Hmph, wouldn't ("%*d", state->prec, state->cur) work or am I missing
something?
