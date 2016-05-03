From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 73/83] builtin/apply: make write_out_results() return -1
 on error
Date: Tue, 3 May 2016 16:55:23 +0200
Message-ID: <CAP8UFD1L4TgE-4mzB3bCShgYe9CBFXC+yzi7sKCjHcwBWWJ=AA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-74-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cTpTYowkeO-cDd-87aAw_tRHvdhV4BaBveg25MvsDAd4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 03 16:55:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axbjW-00046j-Rz
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 16:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933192AbcECOz1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 10:55:27 -0400
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38260 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933005AbcECOzZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 10:55:25 -0400
Received: by mail-wm0-f41.google.com with SMTP id g17so44114297wme.1
        for <git@vger.kernel.org>; Tue, 03 May 2016 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=wx1k0Aqer01aTVHeG5AinBSzi7jSnGGb9Uf9JQqXRv0=;
        b=pLCY1+QhwuQ2QQhjQtWMJIB8AMjBC3sjP3uSqDmbsTQiWa2/z9FSED1Sx2UB/+mIW2
         ZZX4dNZNXOZBGRJ1pH/+M/dONA5ZiN8moacekvj3ODc4/CisZT9anaXFF/WhZv7utiRW
         3fHMSvSfnxQFWDiEjfz2kllL32m2BSAndbA1VXTqVjX8lO+7U3GRta2MfcqBxZcrkMbh
         Lulhn506g68k5HTAOLU1mXXdr0yCoH4npIcqMh/yomkTDgtnt5tdX2oHmfOINr0pQSia
         CbDlFuVHtFdrg19sv8I+53AMwcVGG2Nzu4ynpiqOM0d+PuFcsoU4RnNfUgN333JELYNu
         vD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=wx1k0Aqer01aTVHeG5AinBSzi7jSnGGb9Uf9JQqXRv0=;
        b=kTl2Z91rZu1gZcacgqSHsxTDqK6w5cos9oqaS/hUFdeGd3kCwkl28XkiEByf5HtzHR
         rzCrur4AZTcqPPiFwgsvuH9w7wneA21knnhVJJKkD4QuPAIYh/XGteGZopJn69HcXyvn
         goeqnQqT78u4eqD2tD1ZfTEAQbYwhqr41Ysm0M8ylIR6HPUSHDZrvf6odsPhJebsX96/
         wRCGg7c0IZeOzSGMkFiaEhuyjVd1bzENofffEeDifTDWEMe0t2V4to9gIaiThjb5GJ9f
         Vd5tvPRZZQ7hcM2VEdiJkClI8HETRln8SJI/geeNyxtt54pyu/jIBK9bFSjF6QbaGRRK
         Kptw==
X-Gm-Message-State: AOPr4FXKHDkhfdsPqrtFbd+lOmzOtaKGReIobAWj1ZHFCn7KyAXMfiQDUSxbQZbKzu25J1jrJfQ6R17L9H0E0g==
X-Received: by 10.28.158.79 with SMTP id h76mr24302582wme.79.1462287323748;
 Tue, 03 May 2016 07:55:23 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 07:55:23 -0700 (PDT)
In-Reply-To: <CAPig+cTpTYowkeO-cDd-87aAw_tRHvdhV4BaBveg25MvsDAd4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293401>

On Mon, May 2, 2016 at 7:42 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -4381,7 +4387,7 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>>                                 errs = 1;
>>                         else {
>>                                 if (write_out_one_result(state, l, phase))
>> -                                       exit(1);
>> +                                       return -1;
>
> Isn't this leaking 'string_list cpath'?

Yes, it is. Will fix.

>>                                 if (phase == 1) {
>>                                         if (write_out_one_reject(state, l))
>>                                                 errs = 1;
>> @@ -4484,11 +4490,16 @@ static int apply_patch(struct apply_state *state,
>>             !state->apply_with_reject)
>>                 return -1;
>>
>> -       if (state->apply && write_out_results(state, list)) {
>> -               if (state->apply_with_reject)
>> +       if (state->apply) {
>> +               int res = write_out_results(state, list);
>> +               if (res < 0)
>>                         return -1;
>
> Mentioned previously: Leaking 'list', 'buf', 'fn_table'.

Yeah, already fixed.

>> -               /* with --3way, we still need to write the index out */
>> -               return 1;
>> +               if (res > 0) {
>> +                       if (state->apply_with_reject)
>> +                               return -1;
>> +                       /* with --3way, we still need to write the index out */
>> +                       return 1;
>
> Not the fault of this patch, but this 'return' in the original code
> was also leaking 'list', 'buf', 'fn_table', right?

Yeah, already fixed.
