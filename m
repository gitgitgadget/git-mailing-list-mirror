From: Tanay Abhra <tanayabh@gmail.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Tue, 07 Oct 2014 01:13:36 +0530
Message-ID: <5432F0E8.7020705@gmail.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com> <1412256292-4286-6-git-send-email-tanayabh@gmail.com> <xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com> <542DB2FE.609@gmail.com> <xmqqmw9emdax.fsf@gitster.dls.corp.google.com> <542DB711.9040503@gmail.com> <xmqqiok2m494.fsf@gitster.dls.corp.google.com> <vpqeguptz5k.fsf@anie.imag.fr> <xmqq1tqpm2na.fsf@gitster.dls.corp.google.com> <vpq4mvlgchj.fsf@anie.imag.fr> <xmqqeguolxow.fsf@gitster.dls.corp.google.com> <5432E67B.8070604@gmail.com> <CAPc5daXa_Maz3nTr4s=fxxL9FYs8VbndqX-2R_iwo4KRHCKQhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 06 21:43:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XbECA-0006Vn-3f
	for gcvg-git-2@plane.gmane.org; Mon, 06 Oct 2014 21:43:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbaJFTnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Oct 2014 15:43:42 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:38568 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991AbaJFTnl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Oct 2014 15:43:41 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so5750802pad.25
        for <git@vger.kernel.org>; Mon, 06 Oct 2014 12:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=xYSKim99W0BZuxn+U4835MNPQHINLrCIe/VlDzHe7ew=;
        b=gC88uN2TfydjWAh1de25G/R7ZCiWuiil1CWnABVqsSsMsfm13hKE/dv2qrAdc/QIQk
         PTKCM7eFA//3pn8Stg3l/AgKziYsIvm/cxk6uwVEbfDXCN+WCWrfBc76nb1zAX2z1jRZ
         7yC24wJdm6OcbXq+Ojor8prGO2y9Ymt8mfAVu2h6IKsyCn6l+8YtU8wfhOU9pJhopWtE
         EItTCXu0UYZez2fBzqXpVBLEyHZSyi9xn3Ke57awHy+UIALtqdXUejZyDDUrRXH7T2np
         ba/9jsSg/k+PlmPJROgW8uaFkD/ORl+xFdA6bR/JJU6JJcX69mPRu+ATgjDUsDN3yUfI
         TxSg==
X-Received: by 10.70.36.79 with SMTP id o15mr3400783pdj.6.1412624621518;
        Mon, 06 Oct 2014 12:43:41 -0700 (PDT)
Received: from [127.0.0.1] ([223.176.254.133])
        by mx.google.com with ESMTPSA id fs10sm11814785pdb.82.2014.10.06.12.43.39
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 06 Oct 2014 12:43:40 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <CAPc5daXa_Maz3nTr4s=fxxL9FYs8VbndqX-2R_iwo4KRHCKQhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257917>

On 10/7/2014 12:58 AM, Junio C Hamano wrote:
> 
> The point is to prevent"git config --add foo.baz anothervalue" starting from
> 
> --- --- ---
> [foo]
>   bar = some
> [unset] variable = foo.baz
> --- --- ---
> 
> from adding foo.baz next to existing foo.bar. We would want to end up with
> 
> --- --- ---
> [foo]
>   bar = some
> [unset] variable = foo.baz
> [foo]
>   baz = anothervalue
> --- --- ---
> 
> So "When dealing with foo.baz, ignore everything above the last unset.variable
> that unsets foo.baz" is what I meant (and I think that is how I wrote).
>


Yes, that was what I inferred too, I should have worded it more carefully, thanks.
