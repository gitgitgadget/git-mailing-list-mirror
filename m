From: Dmitry Gutov <dgutov@yandex.ru>
Subject: Re: 'git diff-index' doesn't honor the 'diff.algorithm' variable
Date: Sun, 15 May 2016 13:25:24 +0300
Message-ID: <8e5a7045-77f7-acb0-de7f-3e8f72479ec3@yandex.ru>
References: <9d15b6c8-ed97-7352-3df1-efab1b4ffadb@yandex.ru>
 <xmqqshxk7aa8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 15 12:26:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1tFN-00024l-0i
	for gcvg-git-2@plane.gmane.org; Sun, 15 May 2016 12:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201AbcEOKZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 May 2016 06:25:29 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34976 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752514AbcEOKZ2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2016 06:25:28 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so12202101wme.2
        for <git@vger.kernel.org>; Sun, 15 May 2016 03:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=TodJRbnIsQzM7PXS7WRfiPD65iL3GPm1/mN3u+b5YpQ=;
        b=MMgWV+WGi7pZ9y0nQ0VB/+wIT71wuJ4QVBzzB+P8mD7cVVL7Hx2Xds5/xZN8+7yc7G
         WSy1sXzZtzngBoKFQQh6Ny+0qGlSHshTa3ZdJyGJ0mXQ32ldFGcw9bJMouE1sn1h+M3X
         49s2lWhXLWbXAqVfub6mQxqxYs2RrVdy1Tuj6513aEphowRpbtSokHsl3HDJhqagOJHF
         N2Dt6UHtfyMJszrjDKranoD2pIMVX/KkW2PKD8m/4AykqneSCUSYmHHuf0ltxxYbY06C
         y42WCz/Jh/SG1xeyxHsHU39i3fEcbS4jXRBVtIz9UORawjpTuBYnnmbpdHMmZsPTj0F4
         ut2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:subject:to:references:cc:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=TodJRbnIsQzM7PXS7WRfiPD65iL3GPm1/mN3u+b5YpQ=;
        b=Cnm4As6y0S/xZxawTxAGsddXRj8uS8QB34IWNNoJaM1gDy0PsXeuJp4S1Qx2drnh82
         1QN50lx4oiVievNJcrEnsz/vaCZCBZNFeA1vSWX9omCvmh+2Hoqa6tw5Vy2xfKEbnGPE
         hrKTb9GlNu9/MS9msIL2rlJfvSl9Jy57p5ZMXdsoga95KCdkW/LuXGJ/nwmd7XijPKgk
         1dUk0MAF0opqDxdLomsdpYGuEGuZpiQeuDSSKym0oDJ+34rJHwqtz+xZJatDwZ0G3Y2O
         5xPOc5pDjpWzs8yjMHNCSwy0s0RLDaa/+QMjUe/3oqoaWvjirvXBPb3Hprdcww11LtKY
         RXOA==
X-Gm-Message-State: AOPr4FWd7B7dqBb0bUq9rjGa0RcUBmUNSP0h0fU/xhktimze0rRiT1s92okjxGQxrIZPsg==
X-Received: by 10.28.62.15 with SMTP id l15mr12403836wma.30.1463307926237;
        Sun, 15 May 2016 03:25:26 -0700 (PDT)
Received: from [192.168.1.2] ([185.105.175.24])
        by smtp.googlemail.com with ESMTPSA id r123sm12579845wmg.20.2016.05.15.03.25.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 15 May 2016 03:25:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1
In-Reply-To: <xmqqshxk7aa8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294648>

Hi Junio,

On 05/14/2016 09:40 PM, Junio C Hamano wrote:

> The variable belongs to UI config, meant for Porcelain "git diff",
> together with things like "diff.color", "diff.context", etc.

OK, that makes sense. You might want to fix the man page, though, it 
says, like the 'git diff' one, "For instance, if you configured 
diff.algorithm variable to a non-default value and want to use the 
default one, then you have to use --diff-algorithm=default option.".

> A script that calls diff-index, if it wants to honor end-users'
> UI config variables, is allowed to use 'git config' to read them and
> turn them into appropriate command line options.  e.g.
>
>     algo=$(git config diff.algorithm)
>     case "$algo" in
>     minimal|histogram|patience) algo=--$algo ;;
>     *) algo= ;;
>     esac
>
>     ...
>     git diff-index $algo ... other args ...
>
> or something like that.

Thanks, but we don't distribute any custom Git porcelains with Emacs. We 
usually can't rely on bash being available either. Doing an extra 
process call from Emacs for this niche a feature doesn't seem like a 
great idea either. To clarify, the problem is that `M-x vc-diff' doesn't 
honor the diff.algorithm option.

I'll have to see why we using 'git diff-index' there directly. Maybe we 
could switch to 'git diff'.
