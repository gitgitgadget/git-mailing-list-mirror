From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 01/15] strbuf: introduce strbuf_split_str_omit_term()
Date: Thu, 21 Jan 2016 14:47:55 -0500
Message-ID: <CAPig+cQ2-ddENz4dKsvTW-tOrwugUGa4g-3PySMTBsHsrtO93w@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
	<1451980994-26865-2-git-send-email-Karthik.188@gmail.com>
	<xmqq7fjnkexv.fsf@gitster.mtv.corp.google.com>
	<CAOLa=ZTKiGM1XLr7UuNVX_e_qN4RAGfvOh6daaxcOeZ9xa2TdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 20:48:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMLD7-0001zL-Hi
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 20:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752451AbcAUTr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2016 14:47:58 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34588 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcAUTr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2016 14:47:56 -0500
Received: by mail-vk0-f66.google.com with SMTP id e6so2122277vkh.1
        for <git@vger.kernel.org>; Thu, 21 Jan 2016 11:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=wGZ3de+R6w3gwz68J14QFj60y0KC299Z1EuPqEE5fCw=;
        b=rzXilPSCzTTvy5FSSLnbUFzoUOr2ptCbqXFqupI/42BL0I9o6XugtQ3UG1HoWlJLe7
         E4jbI1rtkLny5RDhZovb8PVXfmB33oDETNXiT5Vy0y+ydUpW5/GO3vAnODlLPAq8Si+z
         miQgoOQmv490WBNgBzSVG+LTCOWCqJU05VWHA/yF104FFyO2CiVzFJW+PTYarlXBgwVF
         Ye4crVllckvay/XGgdXj+aBoVeP+bF4XYiDrui5h3X+kH7ojnueCZ02HlG01mlIn7ouf
         mPuxIUVv+cCU6FtlmBTbDuqE8oTLJPZYc+R7xfXhYwScunPqxDDH6f6KY6BMCREj0utR
         Gv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wGZ3de+R6w3gwz68J14QFj60y0KC299Z1EuPqEE5fCw=;
        b=iZk/yd39rjVBM1pB8cKiim+Yv48KZyk79ZcXq39TlupOPCnlwt9nm5MjesMSQBZzFa
         ul8xoH5LEJMFWq6OgsFMa9xCRXp384+j4KvLkPmPF5XCjcN3xJZkLEzveZaM3iUfOYnb
         vFDpbTsP00Mu2zU7AqejxDh7aN5r0QY03A3JqlPqkmkj4hjw0E5K4Nb+l9qKY1jPhnCd
         yVe+tLdMp12dKliuBYoIZb9OZB8HUEybx+3lyqpOl/q+4vzMAlkS0hb36moauOYX5+rQ
         rXMZZUFUxX2YpNdNQnqNrBvu7ZA2ucRGIzvFwLv3HC3qZ4YNplOtu/6Se6XIN0wae6Fn
         Qq5w==
X-Gm-Message-State: ALoCoQm6WZvJR1kV7UT6tKksReW0OzNBa262VW/Y6HSwQ7Bsg+VuZZbo3CVgDTXhjTjI3netohiBhrulu8tndfFJTuorRbNecQ==
X-Received: by 10.31.150.76 with SMTP id y73mr29742093vkd.84.1453405675862;
 Thu, 21 Jan 2016 11:47:55 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 21 Jan 2016 11:47:55 -0800 (PST)
In-Reply-To: <CAOLa=ZTKiGM1XLr7UuNVX_e_qN4RAGfvOh6daaxcOeZ9xa2TdA@mail.gmail.com>
X-Google-Sender-Auth: ixu-6HfADTbbuxAF0fLu7217bJU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284521>

On Wed, Jan 6, 2016 at 2:27 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> On Wed, Jan 6, 2016 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>       while (slen) {
>>>               int len = slen;
>>> +             const char *end = NULL;
>>>               if (max <= 0 || nr + 1 < max) {
>>> -                     const char *end = memchr(str, terminator, slen);
>>> +                     end = memchr(str, terminator, slen);
>>>                       if (end)
>>>                               len = end - str + 1;
>>>               }
>>>               t = xmalloc(sizeof(struct strbuf));
>>>               strbuf_init(t, len);
>>> -             strbuf_add(t, str, len);
>>> +             strbuf_add(t, str, len - !!end * !!omit_term);
>>
>> Perhaps using another variable would make it easier to follow?
>> Either using a boolean that tells us that the terminating byte
>> is to be omitted, i.e.
>>
>>         int len = slen;
>>         int omit = 0;
>>         if ( ... we are still splitting ... ) {
>>                 const char *end = memchr(...);
>>                 if (end) {
>>                         len = end - str + 1;
>>                         omit = !!omit_term;
>>                 }
>>         }
>>         strbuf_init(t, len - omit);
>>         strbuf_add(t, str, len - omit);
>>
>> or an integer "copylen" that tells us how many bytes to copy, which
>> often is the same as "len" but sometimes different by 1 byte?
>
> This is done based on Eric's suggestion [1]. Although its a little off normal
> convention. I find it small and simple. So I'm okay with either, your suggested
> change or the existing code.

A "copylen" variable would probably result in the clearest code since
it states explicitly what an otherwise opaque expression like (!!end *
!!omit_term) means, thus is easier to reason about.
