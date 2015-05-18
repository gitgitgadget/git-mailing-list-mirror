From: Luke Diamand <luke@diamand.org>
Subject: Re: git p4 clone - exclude file types
Date: Mon, 18 May 2015 21:59:41 +0100
Message-ID: <555A52BD.1030802@diamand.org>
References: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: FusionX86 <fusionx86@gmail.com>, Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 18 23:00:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuS9B-0001HK-Ad
	for gcvg-git-2@plane.gmane.org; Mon, 18 May 2015 23:00:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754527AbbERVAV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2015 17:00:21 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37549 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbbERVAT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2015 17:00:19 -0400
Received: by wibt6 with SMTP id t6so83392639wib.0
        for <git@vger.kernel.org>; Mon, 18 May 2015 14:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=9RcmXpQQaVEjhn05wIYrcz/eTXLYJQswvXDXfAlVZig=;
        b=Vm08EWcAO2ilhu1OWnWk8UPiUj6ZOkG4y6oWSPnk2xTzs+de1qrvAeHINdxK09mpNu
         eYIGSi/nn2xa99HjInEOgJowXeblE1yGmokfr4t10UuSL0JNs79UzPkhfIetQoZA4XLi
         vPKsOUL+K75dIOJYvgPAh84O4s0XhIQf5rMPw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=9RcmXpQQaVEjhn05wIYrcz/eTXLYJQswvXDXfAlVZig=;
        b=aOgwrIaZMnzEw9PCOmE8/VPmo+l1XBkICN7/ubDI1pwNP4BeuDoCIOT6LlqRQ5ZrB0
         qQFdynyYxgp47BbUz9lk+tDmuGr0nUblUBxWLpSc+RbV8ytHkf2HprFg+exUfJUpsTJW
         SlSf8f4aisNc7hK30wtZyK30hu1zZZ6pypPc1aJM2Co63o00Yp2ASfyM8YLHZ3Dcut6D
         4y88W9elnXn5S15rdT7KAi3E2Jn2l1DLWCTNcCsV83dmVeP71f+G5j0XzI/pjPRXWr/9
         wzCR/nkEHN/l8dvFC7WNnus3OsBEx59czCIyrUjyyOX1D6fPtiJb7DutGUhbJny6EZzX
         pUMg==
X-Gm-Message-State: ALoCoQnsJyc7O7O4s5i/Kj+44WWJFgX60OA0YLDhF/niQ9iczVLITYVHepvu6+IAo3JTTE/Xs8xQ
X-Received: by 10.180.187.170 with SMTP id ft10mr25317539wic.75.1431982818241;
        Mon, 18 May 2015 14:00:18 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by mx.google.com with ESMTPSA id uc9sm18607754wjc.7.2015.05.18.14.00.16
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 14:00:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <CAFcBi88K-HEn4JCVkONq3h4O9XS1FFX0OXch2d-VJ2bLEsPM0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269319>

On 18/05/15 18:59, FusionX86 wrote:
> Hello,
>
> Anyone know of a way to 'git p4 clone' and exclude files by type or
> name? For example, I want to clone a depot, but not pull down any .exe
> files. Haven't been able to find an answer in docs or other searches.

I think you can use a client spec which excludes the files you want.

First, create a client spec that excludes the files you don't want:

Client: myclient
View:
     //depot/mystuff/...  //myclient/...
     -//depot/mystuff/...exe  //myclient/...exe

Then clone with the --use-client-spec option:

$ export P4CLIENT=myclient
$ git p4 clone --use-client-spec //depot/mystuff

And later on, when you want to catch up:

$ cd mystuff
$ git p4 sync --use-client-spec

Luke
