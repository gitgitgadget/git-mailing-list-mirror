From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v6 02/42] refs.c: allow passing NULL to ref_transaction_free
Date: Wed, 14 May 2014 08:14:11 -0700
Message-ID: <CAL=YDWkV1QbhEB=LSX6mvJWonMz81xE4j1xd2O+J413po968ag@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-3-git-send-email-sahlberg@google.com>
	<20140513224422.GX9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 17:14:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wkasr-0003zv-3P
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 17:14:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbaENPON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 11:14:13 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:55771 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447AbaENPOM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 11:14:12 -0400
Received: by mail-vc0-f174.google.com with SMTP id lh14so2636936vcb.33
        for <git@vger.kernel.org>; Wed, 14 May 2014 08:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LMnTxrFkFg5ozE5FYxrA3jGZRHDLJHW4ykEXEIy0uGw=;
        b=Rw7Y999BPXctrGX02QtI6lVAcc6ZhG3pchzLGR1Z8JZnlf5htyeDo2YWp+klWMrs+n
         eug3u5qiho8qAL0o1z0AumYj6RqvWCFbY6FJVVFE8zVfLxR7yV9MTpHE8u0wYpq6UmbE
         V9j/z4Mxo2DtmuH8LZ5cXJYT7mak9amfRIey+lnsolefdxVg7JV2f+LbmNNgt+LK0Gun
         +uetPxbv406mENq5wFPCl7MzhZRlcEoeiDg16Me40gedfe3d90VoVInoJhZ6dsHWTsz6
         9vXDlhjDSkOdtFutDnatt5E0FXK5V7K+GJTwvLIJw9l0QfggPIb6b9nTHFhOMKRAuHwI
         sd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LMnTxrFkFg5ozE5FYxrA3jGZRHDLJHW4ykEXEIy0uGw=;
        b=X49zVEITyRt6bCyE+NbccuvhojGcIPq4d3Jxm6qFHEOw0hR2wVCrlflwNqSHgK/nC6
         p+chRV+jNlK98DjVNR9j7dQYywpXjqhdaFLgtOqrHJOeZjdS4+Zb+Lc9kqZ4aKh7fWgY
         oG0XXVQkkjdY4RNnc+LU08821o/GwA/4zEvLmMv61Cba7h4PZhfebS2UuLPRyWRf/jOM
         Q0TL1kYvHdKm6YYEiTlq2bPM/2XCNbuAwgp86KWh7UGfjT1fhb9ASuMVJzi3LAnnhe68
         +ycy5ruwuxatNNL+CoDv9nqcptEHZOdMtYqQ97/YF1AxjIsOHHb1xG6UMWbjD8hb7LaV
         +LaQ==
X-Gm-Message-State: ALoCoQlgsvHjb5fSyc9icgOEJSKzMAOoY9Iz1N2NVPFg9++mQ8Bh+/MKQD8uGguaZ7FoJcG+QpJH
X-Received: by 10.58.112.8 with SMTP id im8mr1966751veb.35.1400080451474; Wed,
 14 May 2014 08:14:11 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 14 May 2014 08:14:11 -0700 (PDT)
In-Reply-To: <20140513224422.GX9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248917>

Thanks.
I changed the commit message.

On Tue, May 13, 2014 at 3:44 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Allow ref_transaction_free to be called with NULL and in extension allow
>> ref_transaction_rollback to be called for a NULL transaction.
>
> In extension = as a result?
>
> Makes sense.  It lets someone do the usual
>
>         struct ref_transaction *transaction;
>         int ret = 0;
>
>         if (something_fails()) {
>                 ret = -1;
>                 goto cleanup;
>         }
>         ...
>
>  cleanup:
>         ref_transaction_free(transaction);
>         return ret;
>
> just like you can already do with free().
>
>> This allows us to write code that will
>>
>>   if ( (!transaction ||
>>         ref_transaction_update(...))  ||
>>       (ref_transaction_commit(...) && !(transaction = NULL)) {
>>           ref_transaction_rollback(transaction);
>>           ...
>>   }
>
> Somewhere in the whitespace and parentheses I'm lost.
>
> Is the idea that when ref_transaction_commit fails it will have
> freed the transaction so we need not to roll back to prevent a
> double free?  I think it would be simpler for the caller to
> unconditionally set transaction to NULL after calling
> ref_transaction_commit in such a case to avoid use-after-free.
>
> Even better if it is the caller's responsibility to free
> the transaction.  At any rate, it doesn't seem related to this
> patch.
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3303,6 +3303,9 @@ static void ref_transaction_free(struct ref_transaction *transaction)
>>  {
>>       int i;
>>
>> +     if (!transaction)
>> +             return;
>
> Except for the unclear commit message,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
