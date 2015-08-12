From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v10 02/13] ref-filter: print output to strbuf for formatting
Date: Wed, 12 Aug 2015 18:52:57 +0530
Message-ID: <CAOLa=ZT_2pZhfmumJM=twPcPryQfbDvGCRFxGVDQo8YZqwRVcw@mail.gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
 <1439129506-9989-3-git-send-email-Karthik.188@gmail.com> <xmqqh9o5so22.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 15:23:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPW0L-0006c0-BL
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 15:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933718AbbHLNXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 09:23:30 -0400
Received: from mail-ob0-f173.google.com ([209.85.214.173]:34064 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752303AbbHLNX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 09:23:27 -0400
Received: by obbfr1 with SMTP id fr1so12305213obb.1
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lMhfcSO1+1mnhYKW9bQ589rxupgVKDnc71ysGnlt6gc=;
        b=0mUkx1Txhq89IrWXD5cA1ulL7y4oPNohPPTYD3RG6lIMiio20Ii9EmYqjyxKbCauGV
         W8nvP9+SG91uZjfetKOju0tJUu2IT9GRZJy/wjBFrRXawSMroawd4iOVb33MrUyDwPfo
         o0G+uVDRy1njj7fMOy4RrF8z2ahMg54f3oAHKIfCm9Rd5EMEPp6dy0v5jzzK6DYI0acM
         6wwGgZbRCM9QK/VwVzlVjvV619SAKwbwb/x9jOUI/5jkT4ibC6SsKvF8eipawy7/Qqhz
         vEcfTq6U1SEP/Gd73cJBGIvGrScla5++08WFDWc2yZ1s2rN1QhTW60/cBl5/Xg73fV41
         cdJg==
X-Received: by 10.182.33.38 with SMTP id o6mr29892439obi.41.1439385806550;
 Wed, 12 Aug 2015 06:23:26 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Wed, 12 Aug 2015 06:22:57 -0700 (PDT)
In-Reply-To: <xmqqh9o5so22.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275764>

On Tue, Aug 11, 2015 at 11:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> @@ -1283,9 +1279,11 @@ void show_ref_array_item(struct ref_array_item *info, const char *format, int qu
>>               if (color_parse("reset", color) < 0)
>>                       die("BUG: couldn't parse 'reset' as a color");
>>               resetv.s = color;
>> -             print_value(&resetv, quote_style);
>> +             format_quote_value(&resetv, quote_style, &output);
>
> Mental note: I _think_ the logic to scan the string and set
> need_color_reset_at_eol that happens at the beginning can be removed
> once the code fully utilizes formatting-state information.  A
> coloring atom would leave a bit in the formatting state to say that
> the line color has been changed to something other than reset, and
> then this "at the end of line" code can decide if that is the case
> and add a "reset" thing here (i.e. the code inside the "if
> (need_color_reset_at_eol)" block shown here does not need to change,
> but the "if" condition would).
>
>

This could be done, when we implement color as a state :) Thanks for the note


-- 
Regards,
Karthik Nayak
