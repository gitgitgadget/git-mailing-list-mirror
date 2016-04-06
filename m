From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 0/6] tag: move PGP verification code to tag.c
Date: Wed, 6 Apr 2016 03:18:38 -0400
Message-ID: <CAPig+cQ4n5j4Q-WF-0cd=2+5eSAaimh3A7La+8Fe9Ox4anjtBQ@mail.gmail.com>
References: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Wed Apr 06 09:18:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anhji-0000x0-C3
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 09:18:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754451AbcDFHSk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 03:18:40 -0400
Received: from mail-ig0-f194.google.com ([209.85.213.194]:34962 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753270AbcDFHSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 03:18:39 -0400
Received: by mail-ig0-f194.google.com with SMTP id ya17so6010209igc.2
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 00:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=oRE2CqrEvwCHebSU86PwDzQEn/vIJSfdl3N3n7F9J+k=;
        b=WqqUkkpwXWx6dxrUDPr+0TiIlbX21rGqBt2jPqaTcdRjRUiU0kNNZaGyyfu/GNRhgC
         0SBELB6wjWhN0B14a089geDuDqZsPahMt7SBtAuTMyCONV+XQbspRpQ7MzlOhOaDLzq7
         HUqcyKrvCQjHHZVNifqbCRtRKYFibJM6ly8guggJP5dnxxzwhZ837irtVKyxtlURLX3z
         wKkif/aPC/PFnF4wt3aO4zEYIKJXBfHwVOY23eCtbZMGj38duUk5c2GUYD6X8rlWLdTB
         /vvzMIy4olsK1+JemKgBQGD4GqD/F1z21AzS8KLBv7fME/FGt+ue6v9Wo+kn2mkPNo8S
         HhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oRE2CqrEvwCHebSU86PwDzQEn/vIJSfdl3N3n7F9J+k=;
        b=iTXDAKwqk9gDM4Ui7dscv7Y2qZ2zIDAnKpp2kfCzToSqw8rtv1SorJAzgPtFjU62GM
         ac+52iPSWc3dzjSqTtxicvEG7GbWqGOuzhvnZZ9nl5FZj9hAHXATt4bExDoZRsIKGOHg
         tmqG3ua3eEuH7MSymXcNn3d5A3/gFoqyal76prhBgkNIC9L6ENKw9oHDtzfFLmJAOyid
         jE8/nFDKiQJ54HTG4urVJzFiH1d90hwLYR2D2ree00lRzyKPnglQEdEByV4PHGKNoJAN
         8RbCrlxCUqtX5L/JW8BMpQMrzspvsOFh2fXMZMRB7UJhEhpiUgA63Yl/kgqsbp/V2/ah
         nZpw==
X-Gm-Message-State: AD7BkJJqgYQ32JX7H7xDJ/jZ69isZEYu6t3e12/My6iVpxosVghT2hEsryNifak631Uvr8SHnCdglWwGzYRmoA==
X-Received: by 10.50.92.37 with SMTP id cj5mr21867098igb.91.1459927118932;
 Wed, 06 Apr 2016 00:18:38 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Wed, 6 Apr 2016 00:18:38 -0700 (PDT)
In-Reply-To: <1459872449-7537-1-git-send-email-santiago@nyu.edu>
X-Google-Sender-Auth: OzX37U1BEFwoNjfcu09jy6vko9w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290832>

On Tue, Apr 5, 2016 at 12:07 PM,  <santiago@nyu.edu> wrote:
> v5 (this):
> Added helpful feedback by Eric
>
>  * Reordering of the patches, to avoid temporal inclusion of a regression
>  * Fix typos here and there.
>  * Review commit messages, as some weren't representative of what the patches
>    were doing anymore.
>  * Updated t7030 to include Peff's suggestion, and added a helped-by line here
>    as it was mostly Peff's code.
>  * Updated the error-handling/printing issues that were introduced when.
>    libifying the verify_tag function.

This version is a more pleasant read, easier to digest and understand.
All of my review comments were minor; nothing demanding a re-roll. As
such, this version is:

    Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

If you do happen to re-roll based upon the review comments, feel free
to add my Reviewed-by: (but not if you make larger changes).

Thanks.
