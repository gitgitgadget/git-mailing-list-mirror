From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] refs.c: make ref_transaction_create a wrapper for ref_transaction_update
Date: Wed, 19 Nov 2014 17:12:17 -0800
Message-ID: <CAGZ79kaW3xGjepcXFZYYUTuDqbEixVA4rH-FMcG0hyEoCVqizQ@mail.gmail.com>
References: <1416433224-29763-1-git-send-email-sbeller@google.com>
	<1416433224-29763-2-git-send-email-sbeller@google.com>
	<20141120011038.GB6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 02:12:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrGIV-0004Tv-6Q
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 02:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756646AbaKTBMb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Nov 2014 20:12:31 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:61432 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754910AbaKTBMS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Nov 2014 20:12:18 -0500
Received: by mail-ie0-f174.google.com with SMTP id rl12so1769249iec.5
        for <git@vger.kernel.org>; Wed, 19 Nov 2014 17:12:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TjxprgO7ouJezogcgi50/uD11q27DPYOngnmM+igdk4=;
        b=GQSGH7C4rvVRvKFBWtId9tVKV5EPJYD7Vo5CQZAMuUQebJ0n07hCyUddjYc0fRmTys
         rJGmDv1FdfmyXQVXfvIYrilcDa58Cn7Ms7qzs+tuZxOe3CwN3EXCDDTi+pxiZqN0oi7f
         RLrprSNFsnGXyKwKQIqyci2DaJxrwzbqrI9ORHmXX+cazAD2GPyw/OI5W+QK5cp2O6Hx
         NsiJ3r940I7zvAtnsGd1PdsDQCM0LAiaBAmzScEYXJ3/f9pYWooLgqsCovUxQdHq0CyX
         KDfC0WoMdNaYXCZaOmuxSkV/ImUFso1EdMaFF1C7AagMvpd+GhoGR+cHlE1m/tyuOm6Y
         VpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TjxprgO7ouJezogcgi50/uD11q27DPYOngnmM+igdk4=;
        b=Of0SbO5pAYPXAkTH2M9yLaDh9LRqchOuH7wprVgUOdu0k54HV9QPdhe4TfRqVGnHIa
         A9XN6M0IS+CtUyaV7e/9g3WgTrTSGRWtcmAXbt0ZP+zTOZakM4rNeBA9qxpNKQSqYRlm
         7UyZ35alpdkY6nFh3fcKME8keTvI7uNsNiSVe1b4QsHPWM/ud/8L7IubD+57FSNYI1Iq
         wcAZtH3VBP4cNA63qj9GZdp8Qb3K95eFTtkJZZeTJ1M9r4rPix0sZ/5zlsKI38cxQ6LQ
         tAya6kCi9zwUhWnQS6D5Yjf66Z9wpWt15I0BsQRzGuE5XfFqNN8fiUQkigVboxW0AphH
         k6hQ==
X-Gm-Message-State: ALoCoQl1gCjFI9PXaQ1Y+Ia6HqwHWRRz+zKIqA2CKR8aaKxkwinUTDJzo/MggQ29gttnQ+QREO2x
X-Received: by 10.50.79.229 with SMTP id m5mr6555107igx.10.1416445938055; Wed,
 19 Nov 2014 17:12:18 -0800 (PST)
Received: by 10.107.1.199 with HTTP; Wed, 19 Nov 2014 17:12:17 -0800 (PST)
In-Reply-To: <20141120011038.GB6527@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am sorry for not having asked before.
As I picked up the patches, you had sign offs pretty much at any patch.
I'll remove them from future patches when sending to the list.

On Wed, Nov 19, 2014 at 5:10 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Stefan Beller wrote:
>
>> From: Ronnie Sahlberg <sahlberg@google.com>
>>
>> The ref_transaction_update function can already be used to create refs by
>> passing null_sha1 as the old_sha1 parameter. Simplify by replacing
>> transaction_create with a thin wrapper.
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  refs.c | 27 ++-------------------------
>>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> I feel a bit ashamed to have my sign-off peppering all these patches
> that I didn't have anything to do with except preparing to send them
> to the list once or twice.  I'd be happier if my sign-off weren't
> there.
>
> Except for that,
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
