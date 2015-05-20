From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Wed, 20 May 2015 10:11:46 +0200
Message-ID: <1432109506.18433.0.camel@kaarsemaker.net>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	 <5661061272076a1883cfde1087be4a42@www.dscho.org>
	 <xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	 <6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	 <CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	 <1432070690.14498.4.camel@kaarsemaker.net>
	 <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
	 <1432072167.14498.12.camel@kaarsemaker.net>
	 <xmqqmw10p6ad.fsf@gitster.dls.corp.google.com>
	 <1432074626.14498.16.camel@kaarsemaker.net>
	 <CAPc5daUF_yotXVf_=CFz_q1GBXVdq8pJxeuNuv=BAC54TJVT9w@mail.gmail.com>
	 <xmqqegmcour4.fsf@gitster.dls.corp.google.com>
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
X-From: git-owner@vger.kernel.org Wed May 20 10:12:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yuz6c-0006jK-0m
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 10:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751596AbbETILx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 04:11:53 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:33684 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751502AbbETILt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 04:11:49 -0400
Received: by wgjc11 with SMTP id c11so44092133wgj.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 01:11:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=Q5/eRT3FZCVf+6n0tppnoAUnBp2d2ATqyT483s8VRkE=;
        b=QJbHApg/le6AtUuMfJynyGizlBSe8JlDVjXqwDZmiNjhHYhu07NCuj9d9rEqZZTyHK
         TRC2TqHsJBRN9VDeE4qogQSRjbKWSQPUW43vA6c3nTy/kuZ64LiKqevoePMdjlrsPOG6
         kl0XAaJO+BPvYmUI2TTm/GRggFRMgzWFn/tkVIGcbBYwsGsyPixbG3y/nbLCJAyZTjlF
         G/hReC7BJUlyYGTF7OOmLHNHTMcWBaXsNi86m0chRMfbR4OJwiyT9rXoJ/0ThyXmqiYT
         +VMLAqi6G2agu7YfxxyRdvtx/SdpP4MWHBYNjXmPvq5ovCQRAs/vFartsjzAQcvV534X
         +szw==
X-Gm-Message-State: ALoCoQlW2aBZfcaoQK5Gt2AAt/FyG/BDGsg2aD3Of8RssyNqt+XD2fjLaB/vub7csM15KuMhWsuK
X-Received: by 10.180.85.42 with SMTP id e10mr38711649wiz.17.1432109508661;
        Wed, 20 May 2015 01:11:48 -0700 (PDT)
Received: from spirit.local (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id ng5sm2092652wic.24.2015.05.20.01.11.47
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 01:11:47 -0700 (PDT)
In-Reply-To: <xmqqegmcour4.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269449>

On di, 2015-05-19 at 19:19 -0700, Junio C Hamano wrote:
> Hopefully now you have some idea how your approach is problematic.

Yes, thanks for the thorough explanation!

Two more bad sideeffects, so two more reasons not to take this approach:

- test_must_fail tests might now fail for the wrong reason, undetectedly
  ("ref does not exist" instead of "can't handle ref")
- same for TODO tests

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
