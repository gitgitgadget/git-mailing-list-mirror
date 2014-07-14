From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Mon, 14 Jul 2014 09:42:49 +0900
Message-ID: <CAFT+Tg-FmtfmhuTr8-tbbOtDs73p0qzQoT+UVdu3bZLizJbWOQ@mail.gmail.com>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
	<CAPig+cRwJhyZ=R_HGs9JKUFLuJxoS=abrD9+HuoWDiA5oJrtjw@mail.gmail.com>
	<CAFT+Tg8pJrdoD4M1uy6A=PPJaSrq_QcRUQdxdrA-T5sJiZ7j1Q@mail.gmail.com>
	<xmqqoawt19jr.fsf@gitster.dls.corp.google.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 02:42:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6UM2-0003bL-K2
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 02:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbaGNAmv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 20:42:51 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:39997 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbaGNAmu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 20:42:50 -0400
Received: by mail-ie0-f175.google.com with SMTP id x19so2739066ier.20
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 17:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=yd7Ot206DIANudTwv/yf1S+qMe2RnhUMJzRZbxupv6s=;
        b=0BjVJ/N7chNX6qMDamA/WmGjMGpmQOGs3YOtVJBR6XCqJyRY9dLv7kNjoyWcUMrjhx
         Cum6H1MJ6h5GDGKKKp+6XFhX2fx2NuIFMInBOptlp1vOvoM3jLuBH7QKhpIBedLNXVGT
         h7jFqpcmy3y3mCnxvuqoDi9zVn88OD3CgkTePtEGkQx4q/tteOXnz6n2WulORe2+CClP
         AvE5cgFB2M/EdbU5gsuf0FlEgKP1Tu8F0C0Byn5ngOU/S663rPzglS5rfJnuwzW5OXuj
         SyCZ69+Hx5jl3LPVuELIEzTgpcrUkQ46T1GzU91BsgjBCgkOMXTXScUmUk4hqon3Jmfz
         JBbQ==
X-Received: by 10.42.212.207 with SMTP id gt15mr18523143icb.47.1405298569297;
 Sun, 13 Jul 2014 17:42:49 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Sun, 13 Jul 2014 17:42:49 -0700 (PDT)
In-Reply-To: <xmqqoawt19jr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253461>

2014-07-14 1:57 GMT+09:00 Junio C Hamano <gitster@pobox.com>:
>
> If you do not want floating point (and I think we tend to avoid it
> when we do not need it), you can realize that in your use of "0.1"
> and "0.01" and "0.001" there is nothing fundamentally floating-point;
> you can measure how many digits below the two-byte string zero-dot
> you would want upfront (by counting num_langs), and show an integer
> counter zero-padded to the left to that width.
>
> That would avoid having to even worry about a possible funny case
> where subtracting 0.01 ten times from 0.1 may not yield zero (or the
> result of subtracting nine times may not reach 0.01) due to rounding
> errors accumulating, which was the first thing that came to my mind
> when I saw your loop.

You're right; We don't need floating point numbers. I'll try to fix it.
