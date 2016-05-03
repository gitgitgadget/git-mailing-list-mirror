From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 67/83] builtin/apply: make build_fake_ancestor() return -1
 on error
Date: Tue, 3 May 2016 15:52:37 +0200
Message-ID: <CAP8UFD0FcxrmqXjJZpdkc0akY4ZDGGY+dEwDg-EGAFAXV_=e5w@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-68-git-send-email-chriscool@tuxfamily.org>
	<CAPig+cSMLCg49O3tf=g2qDi-TUz-xsdW-ac_Eze9g=XsCKSSJA@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Tue May 03 15:52:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axakl-0003He-Ph
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 15:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515AbcECNwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 09:52:40 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35047 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbcECNwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 09:52:39 -0400
Received: by mail-wm0-f52.google.com with SMTP id e201so147627526wme.0
        for <git@vger.kernel.org>; Tue, 03 May 2016 06:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=nBIanzPglCbqqbhD8tFQvXQnm2UxUvWfM9VReTdoxsA=;
        b=kmZuSChZNLw8e71DkSQM7z9l9QIuKq2xivas98JIxjBcbijw/dzc5v3aPJZAt5QPeO
         fGdLLsSaPG7p04ONaatKjF6luyhWds7Ew4SMx1lBxEtbMrcXTW89VV5kazoG5Q7IxOS4
         cP07SEG1Y4GOSK1lCPILD6D0m6S+hJyVgc4/UDlEtOXeN2Lw0Wf5nuBUdgcNbJmRxntH
         cYcq36R8PWMqoppB5Q9485QadxggHf/uE5TOj673i5m3Bo3URl2g1j6mTFBQV1mbHfSn
         MKV0bTXsiXij9G1LeEGFvUrXKpvl0b21OZ1zGEcb1d+n+7h8+Jmw/QZU+Qa5U9lFC/hT
         GbtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=nBIanzPglCbqqbhD8tFQvXQnm2UxUvWfM9VReTdoxsA=;
        b=DGfyRGqvQ8ywIjGGxgVH7KaNpXe4r57ialpUzUH1H6R0ezQKCR95iobuxXmFvRd5Ab
         stoFg2/27Rcp7xgl885S5Xz6tMBrc72IhPWxIvTs0aNMNPrqkorM21f78ZT9YXBtWJvi
         GmiM9w2YqSgOQwfbC3X225KORnLZlXv3zX7QRKhWK51mg3oInKukV45d42KhzAbK/ogp
         jQqRC5UC8ZiYJt7UbJn1b0E/+k556PV537AuNyRtEGPVsP7DAejzVflvYh/XtF/bqsI3
         0k79jcsJrJbvdm6LOQ1OHhbOGyFCGOk3M01UvirrsWkLFvQJ9/gcdjcbCPiPURxc1ga+
         BiBw==
X-Gm-Message-State: AOPr4FUPIf6466fVR9YpkBwY7aWduQwEAifUWybVqlToQVvcNDsnsaJ8lCgDFSJy7c+1wlK/n1TGVBtQ2jeEOA==
X-Received: by 10.194.117.70 with SMTP id kc6mr3351253wjb.94.1462283557665;
 Tue, 03 May 2016 06:52:37 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Tue, 3 May 2016 06:52:37 -0700 (PDT)
In-Reply-To: <CAPig+cSMLCg49O3tf=g2qDi-TUz-xsdW-ac_Eze9g=XsCKSSJA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293399>

On Mon, May 2, 2016 at 9:32 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>> diff --git a/builtin/apply.c b/builtin/apply.c
>> @@ -3913,31 +3913,34 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
>>                 ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
>>                 if (!ce)
>> -                       die(_("make_cache_entry failed for path '%s'"), name);
>> +                       return error(_("make_cache_entry failed for path '%s'"),
>> +                                    name);
>>                 if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
>> -                       die ("Could not add %s to temporary index", name);
>> +                       return error("Could not add %s to temporary index",
>> +                                    name);
>
> What happens to 'ce' here? Does it leak?

Yeah, I think it leaks.

>>         }
>>
>>         hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
>>         if (write_locked_index(&result, &lock, COMMIT_LOCK))
>> -               die ("Could not write temporary index to %s", filename);
>> +               return error("Could not write temporary index to %s", filename);
>
> What happens with 'result'? Does it need to be discarded?

Yeah, I think so.

>>         discard_index(&result);
>> +       return 0;
>>  }
>>
>>  static void stat_patch_list(struct apply_state *state, struct patch *patch)
>> @@ -4470,8 +4473,9 @@ static int apply_patch(struct apply_state *state,
>>                 return 1;
>>         }
>>
>> -       if (state->fake_ancestor)
>> -               build_fake_ancestor(list, state->fake_ancestor);
>> +       if (state->fake_ancestor &&
>> +           build_fake_ancestor(list, state->fake_ancestor))
>> +               return -1;
>
> Same comment as earlier patches: Leaking 'list', 'buf', 'fn_table'.

Ok, I will take care of these.

Thanks,
Christian.
