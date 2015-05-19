From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Wed, 20 May 2015 00:30:26 +0200
Message-ID: <1432074626.14498.16.camel@kaarsemaker.net>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	 <5661061272076a1883cfde1087be4a42@www.dscho.org>
	 <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	 <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	 <1432070690.14498.4.camel@kaarsemaker.net>
	 <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
	 <1432072167.14498.12.camel@kaarsemaker.net>
	 <xmqqmw10p6ad.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 20 00:30:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuq1y-0007SA-Rn
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 00:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbbESWaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2015 18:30:30 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:33687 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbbESWa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2015 18:30:29 -0400
Received: by wicmx19 with SMTP id mx19so132083724wic.0
        for <git@vger.kernel.org>; Tue, 19 May 2015 15:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=EvEk2fdDgsg4t1jJCpz2YI4JnOrrcXWd7L9yviJbDy8=;
        b=NkqdaiGfXzJTad41IXrXhdRfVI/pwPJ1+exc6eJ7EXLYelCst8LrWdvKYCrtCZMchR
         P7OVoE6E9yGT0rUXrQU1GyIToQ9kkLgPtPr1tSJaNJ51qTjOM8Ebfq5Gca+nFalnYn4V
         tK87pONHrJwrYbvJJjUVn40U6pqq+5lLPChxhyChMFLCIq7IJTCqz29xM5Y2WTE2PLIK
         Tarro35xih44ABCdzMARboHlbtQPp7ZdKZHt9GUjGZNrbj0iWoOgFYp4yewkZQCaU8tm
         Zs017j071rqy8mkIEO/9FaZCC8pLyyCC+x7+yYVSbYVpDQKicrYsCRAZAy/UTka8vfaI
         A4Yg==
X-Gm-Message-State: ALoCoQm51KP+01+Xfjs+ScVAMDoZVW0mmZMycc3OyFYbz2En15ohRULerSOQKf49wNUYCzK0c8/n
X-Received: by 10.194.205.37 with SMTP id ld5mr56047792wjc.14.1432074628519;
        Tue, 19 May 2015 15:30:28 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id um5sm23741048wjc.1.2015.05.19.15.30.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2015 15:30:27 -0700 (PDT)
In-Reply-To: <xmqqmw10p6ad.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269428>

On di, 2015-05-19 at 15:10 -0700, Junio C Hamano wrote:
> Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:
> 
> > I've actually done it differently while implementing:
> >
> > 1) Make test_commit recognize --tags and stop creating tags unless
> >    specified
> > 2) while ! prove --state=save,failed {
> >        Find and fix tests that now need --tags
> >    }
> 
> That was what I feared.  The result of that process is the hardest
> to reason about and review.
> 
> > For the actual patch series I'll add -p the changes slightly
> > differently:
> >
> > 1/N: Make test_commit recognize a --tags parameter but not change
> > behaviour.
> 
> Make test will pass after this one.
> 
> > 2/N - N-1/N: Add --tags where necesary (or other fixes as appropriate)
> > N/N: Only write tags when --tags is passed to test_commit.
> 
> And untouched ones will continue passing.
>
> Only when you remove --tags from ones that need (i.e. the caller
> needs to create the necessary tags), we will see a patch and unless
> there is mistake in the conversion, the result should pass.

I'm not quite sure I understand what you're trying to say. You seem to
be worried that there will be silent successes for tests that should
fail after N/N if I take the proposed approach. I have no idea how that
could happen though.

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
