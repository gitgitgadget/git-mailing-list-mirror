From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 01/15] strbuf: introduce strbuf_split_str_omit_term()
Date: Mon, 25 Jan 2016 11:42:08 +0530
Message-ID: <CAOLa=ZRhViUntR4yO66imd7D6KN+CCqkREGPVRfTfyN3zLQoAw@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-2-git-send-email-Karthik.188@gmail.com> <xmqq7fjnkexv.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZTKiGM1XLr7UuNVX_e_qN4RAGfvOh6daaxcOeZ9xa2TdA@mail.gmail.com> <CAPig+cQ2-ddENz4dKsvTW-tOrwugUGa4g-3PySMTBsHsrtO93w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 07:12:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNaOJ-0008T2-W4
	for gcvg-git-2@plane.gmane.org; Mon, 25 Jan 2016 07:12:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752018AbcAYGMk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2016 01:12:40 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34520 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbcAYGMi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2016 01:12:38 -0500
Received: by mail-vk0-f67.google.com with SMTP id e6so5243666vkh.1
        for <git@vger.kernel.org>; Sun, 24 Jan 2016 22:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6LFeUkh3PCDEDeVQ4+fbyQ8Oo+/Ixh32iHHG6GilQZk=;
        b=GfXp+EjIxltEBmX7xvADHurS4/q843Tn1etD5rQ7eeiZ+U2ajrXhkwnnsxHcflJE92
         3mL3iwOYrhpJi/bSB3807olfpMzgcFsg4ccLodqvf1RdMQK92Q3A1MecyczySOuIyFnq
         OQYWkXaaW9Gjr60vntP/aitf+mj5E2KOPF3lQPqdNzkPGF5POPCvRQbLBGjIzKtcwiyy
         ClWY8EUni2KyLcRRUjPgscOetITQn54vEtyp6zdeMjfI++MvQ/L8gtAuTJ2VNOPR9Nue
         Fnj/Eob8TOvJyOOZJUk6aGHmIGMjvpWRc8ImILVOvU/GwFzbhRB+38W7yEEgtw9ji9Dv
         HjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=6LFeUkh3PCDEDeVQ4+fbyQ8Oo+/Ixh32iHHG6GilQZk=;
        b=gzT+3CubPI6wWhGf1taJvmfENnC37AShPWLiwbyDWuF62cktL4STRebDDJPYNK91We
         s06HzfI1oO4tO/NltBgjtQfELuGuS19GjYGb5ilMW/nKIUylQv8E2+Fch0jnIMpn48Rw
         Zx1T6Dm72EUzJ9qGYwMt6v9e0uvCisICM6/0zP6H3NY52YzvQ4ewFjz+iCkP94OYRsIt
         PmmzrwE14ZtEbZiPoJqkD3ETm8m270oda2hFJ0wC1FC84A+DLTnLQ1qbxScf1pqEMSUc
         cZ9DSQtZAlkrmL9YchECsx5omUFeIepcUeWkBipJX/aLHhiP9uOGGBNnj6WU7aDSzj7s
         M2Tw==
X-Gm-Message-State: AG10YOREEyUjkPgO3h1ZRxbhPZcijI/L8rJl5udErzIRQvwCcrpvXZtf7n/TAIBytzdBNI1JbvJpL4NsAoR2zg==
X-Received: by 10.31.54.75 with SMTP id d72mr133148vka.30.1453702357412; Sun,
 24 Jan 2016 22:12:37 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Sun, 24 Jan 2016 22:12:08 -0800 (PST)
In-Reply-To: <CAPig+cQ2-ddENz4dKsvTW-tOrwugUGa4g-3PySMTBsHsrtO93w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284716>

On Fri, Jan 22, 2016 at 1:17 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Wed, Jan 6, 2016 at 2:27 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> On Wed, Jan 6, 2016 at 12:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>       while (slen) {
>>>>               int len = slen;
>>>> +             const char *end = NULL;
>>>>               if (max <= 0 || nr + 1 < max) {
>>>> -                     const char *end = memchr(str, terminator, slen);
>>>> +                     end = memchr(str, terminator, slen);
>>>>                       if (end)
>>>>                               len = end - str + 1;
>>>>               }
>>>>               t = xmalloc(sizeof(struct strbuf));
>>>>               strbuf_init(t, len);
>>>> -             strbuf_add(t, str, len);
>>>> +             strbuf_add(t, str, len - !!end * !!omit_term);
>>>
>>> Perhaps using another variable would make it easier to follow?
>>> Either using a boolean that tells us that the terminating byte
>>> is to be omitted, i.e.
>>>
>>>         int len = slen;
>>>         int omit = 0;
>>>         if ( ... we are still splitting ... ) {
>>>                 const char *end = memchr(...);
>>>                 if (end) {
>>>                         len = end - str + 1;
>>>                         omit = !!omit_term;
>>>                 }
>>>         }
>>>         strbuf_init(t, len - omit);
>>>         strbuf_add(t, str, len - omit);
>>>
>>> or an integer "copylen" that tells us how many bytes to copy, which
>>> often is the same as "len" but sometimes different by 1 byte?
>>
>> This is done based on Eric's suggestion [1]. Although its a little off normal
>> convention. I find it small and simple. So I'm okay with either, your suggested
>> change or the existing code.
>
> A "copylen" variable would probably result in the clearest code since
> it states explicitly what an otherwise opaque expression like (!!end *
> !!omit_term) means, thus is easier to reason about.

Sure, I think this would do:

diff --git a/strbuf.c b/strbuf.c
index b552a13..81e279d 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -115,7 +115,7 @@ void strbuf_tolower(struct strbuf *sb)
 }

 struct strbuf **strbuf_split_buf(const char *str, size_t slen,
-                                int terminator, int max)
+                                int terminator, int max, int omit_term)
 {
        struct strbuf **ret = NULL;
        size_t nr = 0, alloc = 0;
@@ -123,14 +123,18 @@ struct strbuf **strbuf_split_buf(const char
*str, size_t slen,

        while (slen) {
                int len = slen;
+               int copylen = len;
+               const char *end = NULL;
                if (max <= 0 || nr + 1 < max) {
-                       const char *end = memchr(str, terminator, slen);
-                       if (end)
+                       end = memchr(str, terminator, slen);
+                       if (end) {
                                len = end - str + 1;
+                               copylen = len - !!omit_term;
+                       }
                }
                t = xmalloc(sizeof(struct strbuf));
-               strbuf_init(t, len);
-               strbuf_add(t, str, len);
+               strbuf_init(t, copylen);
+               strbuf_add(t, str, copylen);
                ALLOC_GROW(ret, nr + 2, alloc);
                ret[nr++] = t;
                str += len;


-- 
Regards,
Karthik Nayak
