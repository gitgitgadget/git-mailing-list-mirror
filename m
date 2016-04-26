From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 09/83] builtin/apply: move 'check' global into 'struct apply_state'
Date: Tue, 26 Apr 2016 18:26:31 +0200
Message-ID: <CAP8UFD2rD5qo7TBPFdP5BifOGuWHAtZA2BNGDqnY_feoCfmKeQ@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-10-git-send-email-chriscool@tuxfamily.org>
	<CAGZ79kYUr9wQ--898OeyqVw_upqxfVNRsOveUAPSn=PtXZ4xBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 26 18:26:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av5p3-000438-Cp
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 18:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752231AbcDZQ0p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 12:26:45 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36561 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbcDZQ0m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 12:26:42 -0400
Received: by mail-wm0-f51.google.com with SMTP id v188so138346177wme.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 09:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=VP/PZHnuhVGRcwBMRn+Bw+lTUzK8tYRfnTWwsmwUtjs=;
        b=XaV0xXjZz9YnaumntMeUcGP6BMNTsV6HPgxtbPCP9ZVvBFN0DwtkEqS8Pjf+njqLng
         K6gYILOuCSE9MIURpMIeXanKPCRSsr7EjwgJxTkleZQHRdWhUmWnJ9zBa2+e3dpCS4Nr
         y6Fhlhq7ilLHpXDKkHyeYohqvyZBfo4SCoRSByLoT8qB41pNzBMpY6dN3RgDp4iEt4oY
         oGaLa0yCzUXdSfUFSzTRZQa/6hLTipSmrUP3bAyIXwYpI0YzJ/Qmm/36hip26a0qDQBN
         Md/jAT+daIMdElAvQ1Z7jSPhaaXgqu9ehkHCuvFy1qs83um0O9KUJQvi1jRu81buU6YI
         hYdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VP/PZHnuhVGRcwBMRn+Bw+lTUzK8tYRfnTWwsmwUtjs=;
        b=Hmls1PiBiZkmuxAUTWfEdr32RsSBB4Lq/eEim2mXUbDns/h1H4Gr5CyQ4ZteWFkiSc
         0V5mTwiYE3ZdXbZ5szQhVp8d+vy+kqqXy/bh+5NzoGVm//a6TcgVbTV9HmPwI3g8wE+I
         G3aVHa2fvOCjmf5J3rG7cStj79WPYYjrbzGNKz333Vv/6HawMFIMlmAE9OmjyBLNGuyX
         7344+jmOLf9u1U6c20+WU1bm0NmfpKObLD+VxnOybooyeASKEFJolPfGZQ0YnBokVD99
         RDQj7lOM6/plW6xun4fcmmnG/jASCFmof5+i6vPfVw64GtiMKUHL01bZAQaR4hzOPZqG
         NsUQ==
X-Gm-Message-State: AOPr4FVDAI3oeknBq+/8Xp3uqUY9tDyOAs2bsMw0uIL3+KEKiJP7Pds5YJSzBh/2rJ6pA1qgxe2gbFWxZyAZsQ==
X-Received: by 10.28.54.33 with SMTP id d33mr4987800wma.62.1461687991316; Tue,
 26 Apr 2016 09:26:31 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Tue, 26 Apr 2016 09:26:31 -0700 (PDT)
In-Reply-To: <CAGZ79kYUr9wQ--898OeyqVw_upqxfVNRsOveUAPSn=PtXZ4xBQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292611>

On Mon, Apr 25, 2016 at 8:57 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> index ad81210..6c628f6 100644
>> --- a/builtin/apply.c
>> +++ b/builtin/apply.c
>> @@ -25,12 +25,15 @@ struct apply_state {
>>         const char *prefix;
>>         int prefix_length;
>>
>> +       /*
>> +        *  --check turns on checking that the working tree matches the
>> +        *    files that are being modified, but doesn't apply the patch
>
> This is true, but at this part of the file/code we rather want to know what
> `check` does, instead of what the command line option --check does.
> (They are 2 different things, though one leading to the other one?) How about:
>
>     /*
>      * Only check the files to be modified, but do not modify the files.
>      */
>
>
>>  /*
>> - *  --check turns on checking that the working tree matches the
>> - *    files that are being modified, but doesn't apply the patch
>
> Oh I see it was moved from here. Not sure if we want to rename
> comments along the way or just keep it in this series.

I kept the existing comments when they were still relevant.
It could be a cleanup to change them to something like what you
suggest, but as it is not important for this series which is already
long, I prefer to leave it for now.
