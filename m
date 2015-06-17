From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] strbuf: stop out-of-boundary warnings from Coverity
Date: Wed, 17 Jun 2015 13:05:05 -0700
Message-ID: <CAGZ79kbwXGkBJrX793Ry1gn_5uBymrXWz=yy00WDADNjG1m-=A@mail.gmail.com>
References: <1434536209-31350-1-git-send-email-pclouds@gmail.com>
	<CAGZ79kYRfjeXGkYAv-Kn2Bk-pp2ZSzpKGHDhqMpw03scdRZAmQ@mail.gmail.com>
	<CAGZ79kbZpiz2rMbhJReFG=uRiQdj7a5qxLbRiPQQCFqcfBhikw@mail.gmail.com>
	<xmqqh9q66ss9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 17 22:05:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5JaB-0007Vp-WB
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jun 2015 22:05:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752562AbbFQUFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jun 2015 16:05:07 -0400
Received: from mail-yh0-f41.google.com ([209.85.213.41]:34428 "EHLO
	mail-yh0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752361AbbFQUFF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jun 2015 16:05:05 -0400
Received: by yhnv31 with SMTP id v31so15876693yhn.1
        for <git@vger.kernel.org>; Wed, 17 Jun 2015 13:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cXuFaAZ7CKZwM3zCxBxk1Xc30tq6DdDceG8PNsyHrWw=;
        b=fD/x/vBySF5JPZFtJ3nkdNSt4ZTHcX7TOrHxqj5rTfOV5jvOZbV6MAsBwirks2d8p7
         CGMCYFzZ527RyxNJU+JcqekgaJ+WrmbTI6ol2c5D5x2FViVjnkV6xGLXnEFMJp9U1TA7
         zQ/k6u0uqS8s6CXPLvUP9XT8UH1eMUrbbLXu4gePNlhAP5Kwb5zQfyxTohaEVSWwEtz7
         Y47B4MtorM/UwkmxmHK81OmcsdsrGP4G0hvAH6Ai9tgTUCKvbdc8VNU886PguUQLZJMW
         guRsNmqgs6uVTOiUnUBrTvMLdhFP66tDlcc1qoFGVA+nvnJuBhc6V05y8tQDMylAPRmE
         BEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cXuFaAZ7CKZwM3zCxBxk1Xc30tq6DdDceG8PNsyHrWw=;
        b=InlEhvBHgkQjmUnxlPha5r0Ytb2e42cqSkVicnyZCQygLjBwiPX2J5WTRV4h0xIEFC
         WcROiTEGqBIkyk3gZqsI+LkkUP0WhwlLtTFz4HRLtgNC3C0JBdhzSfw0y4z9hgZXDbTP
         BMVY6pUFNemjX6wzNA0cg42zMJgaYcLRJPeMB5nNs3nwVD2tbn2ne8hD6Z4LnSYoY/HD
         is8B5hnaQw1wZEKymLiRf2d2vzFmwKs0apLjDVoE7o4dnPVQC2nS6e+0binyvaZF7W6l
         yw7yO62U+vyep3SidfDnkBxMGzD6KSltKaClqjIf+qep2+rBuyGFf1Zp/gvFl7vROKNN
         LPcQ==
X-Gm-Message-State: ALoCoQnrYuaSzBAAUHxNQ3Rf3yZTSvL5dZU4r1g0fD2dmsMH4kj3HcCiMcbltbIC3V2GwwOPVluz
X-Received: by 10.129.148.4 with SMTP id l4mr9409651ywg.142.1434571505399;
 Wed, 17 Jun 2015 13:05:05 -0700 (PDT)
Received: by 10.37.26.213 with HTTP; Wed, 17 Jun 2015 13:05:05 -0700 (PDT)
In-Reply-To: <xmqqh9q66ss9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271905>

On Wed, Jun 17, 2015 at 12:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Just make strbuf_slopbuf[] large enough to keep Coverity happy. If it's
>>> happy, we'll have cleaner defect list
>>
>> It's down 31 defects, roughly 10% of all things coverity detected as
>> problematic.
>> YAY!
>
> I actually think this is too ugly to live.  If coverity is buggy and
> unusable, why aren't we raising that issue to them?

We can try to do that.
The last time I wanted them to take a look at Git, they were
unresponsive. I presume that's what you get when not being
a paying customer. :(
