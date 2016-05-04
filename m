From: Shin Kojima <shin@kojima.org>
Subject: Re: [PATCH v2] gitweb: apply fallback encoding before highlight
Date: Wed, 4 May 2016 17:34:55 +0900
Message-ID: <20160504083449.GA46041@skmba.local>
References: <xmqqbn4ouz7u.fsf@gitster.mtv.corp.google.com>
 <1462280451-43388-1-git-send-email-shin@kojima.org>
 <xmqq7ffbng8p.fsf@gitster.mtv.corp.google.com>
Reply-To: shin@kojima.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Shin Kojima <shin@kojima.org>, git@vger.kernel.org,
	Christopher Wilson <cwilson@cdwilson.us>,
	Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 10:35:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axsH6-0005De-VU
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 10:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757780AbcEDIfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 04:35:09 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:32894 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757774AbcEDIfF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 04:35:05 -0400
Received: by mail-pa0-f66.google.com with SMTP id gh9so4287515pac.0
        for <git@vger.kernel.org>; Wed, 04 May 2016 01:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kojima-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lbTNeV+oO0zv+AOyhv9w2ztzxmDXHE8vi6Be4S9HuY8=;
        b=ZS7/5299Ex6g5+1jxyQ7VWOyTnOqT9CMiWvEDYL64YayXzdPLZHt7cCzCdoJrp1sDd
         G1bNFvhf+PtmfH842W+TUYbFHZf4rRWMnhxKeJUbbl0iJ3Yq/Pnb5gCONrA33lskO1+j
         QlB6fBFt1+K1TbO48Oy+hvJnZN1AL+nASWbreL8fdny7axqJO0nnvyZwxYFs550k9WCi
         hiD8CLnY4W9xyJ2VVHGsIwcin1DHXAhD57vyss1MMDEjQtWpAnIdp17N5ZLMlZ+EidcV
         /C1B9sTJV8CsdO6n5HelH2mRovuq7H+Df98DSQNK8OQ5JCBmZDM3rTnsaK/43OBfs3mu
         pRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=lbTNeV+oO0zv+AOyhv9w2ztzxmDXHE8vi6Be4S9HuY8=;
        b=iH74obljlGiRF+RqnkEYOWJeMGWkqsjuhkxFmCRHzepOSjfqLtI03+HpreC7Jbkvo9
         1d3KSHDFq3Y91UvKpTQbcPq8DxAFzuzKfX48MG3zTXZl+G11DFrAEOvEVFZGoNKcbNmk
         iZpAx2N885cFnMKegGdXpdO8HPMqywolJLNoJfaRk/FJA2Z8BLAW/zbdypLFxVD6aj4f
         0TyC7DOJcS6f8Y809B87bPQUvefikMG2NtVpnNTxAt3Qz8ssLDU/iti1yrxPFARj5xqk
         hQUaFO11KPlVnxND2ECp1Q+j7yv3LgncM0a8LMJaZCFmntlnvO9B8pJ9/Q/BeBlsyG+z
         ztcA==
X-Gm-Message-State: AOPr4FUXnvmtI94hMUvTLPcu7YAFQ1kqIMhPuer6W0c3In3ITDXP4KKx+OmiszNTjPeOng==
X-Received: by 10.66.182.161 with SMTP id ef1mr10142771pac.40.1462350904906;
        Wed, 04 May 2016 01:35:04 -0700 (PDT)
Received: from skmba.local (244.125.148.210.rev.vmobile.jp. [210.148.125.244])
        by smtp.gmail.com with ESMTPSA id u2sm3984398pan.45.2016.05.04.01.35.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 May 2016 01:35:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq7ffbng8p.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293518>

On Tue, May 03, 2016 at 11:33:42AM -0700, Junio C Hamano wrote:
> Shin Kojima <shin@kojima.org> writes:
> 
> > Some multi-byte character encodings (such as Shift_JIS and GBK) have
> > characters whose final bytes is an ASCII '\' (0x5c), and they
> > will be displayed as funny-characters even if $fallback_encoding is
> > correct.
> 
> Just out of curiosity, do people still use Shift_JIS aka MS-Kanji?
> It feels so last-decade, if not last-century ;-)

Yes, they do. There are still tons of code from 90's lying around.

For migrating our codebase from cp932 (Windows31J/MS-Kanji), I keep
failing to persuade my boss saying it has no incentives to do so.

I can say this patch, to consider $fallback_encoding while
highlighting, is fairly rational.  But I also feel this is too much
just for specific outdated character encodings, it is completely
useless for the most part of gitweb users in the world.

I would rather prefer to generate feedback from you all to convince
our management if this patch is not acceptable.
