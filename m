From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 04/19] refs.c: return error string from
 ref_update_reject_duplicates on failure
Date: Mon, 28 Apr 2014 11:23:01 -0700
Message-ID: <CAL=YDWkTcb327q9oqC1Ypm8n6tBgFnGsn2jiAK+fRNq1q74=8g@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-5-git-send-email-sahlberg@google.com>
	<20140425221248.GC9218@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:19:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wer4q-0007p4-9O
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:18:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755880AbaD1TSa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:18:30 -0400
Received: from mail-ve0-f170.google.com ([209.85.128.170]:40583 "EHLO
	mail-ve0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755836AbaD1TS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:18:28 -0400
Received: by mail-ve0-f170.google.com with SMTP id sa20so35065veb.15
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uTSlSQzLTBLdMU+zBdVnkj+7mq//6iqWQRFrRORc1l4=;
        b=MVrxH+NULLyxdwADQrpJGxyeQQJEflUrxZXmVG3jLRu5w7CR/O5ppd+8HshYTXOgNz
         pYXruecPgI0V8C6LOtU/ZyfPCMHh6JMClRBcsHY0KD9cHMd4HNK3R5mVNSaw0Yg4gPSf
         Rvqs83LY97GLQpZHwLi3b0cCgfb3aNjq8r74K39s3PzgGQJGnv8Xv/TeuLDeRpWBQuhp
         cfaIWoNY/9FjMdyZq96Ff3cOXP9e9CrCSR9vsqlKveO1ECdso3tQqQMAK/QSxw5Ql+6P
         C4EgAJ0VJp1WpMwlfk58EmB+pzXTjTdlL68MB4/K64P0mI9be1MaWFcTLWpkWw2dmI6J
         wKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=uTSlSQzLTBLdMU+zBdVnkj+7mq//6iqWQRFrRORc1l4=;
        b=iZeOYhCs+BEIhMfEcOVoaMv1MDjbNaDBArW3oZSf2/ulIzsTvHmGT1gAqM7o6cS8mN
         67WIvlTCA3C03ktSQ/Xb6cX0y1Ns36GfJhSgdEJ7AYje44N16yy9N4V38fAy/r4j4JPu
         NgDp7bal8ZUxtq6dkQ4KOoR7CMnXXf1O3I7eKo16VuBcaTnywveU5TKVwOl9O4EgP1SM
         tUC7lvZL/olX1ubOU1DbuEwi3FOBsNlUG21ptpV++CMPYdBIqJGHVvbjxdRzDagyPJV9
         GmOvLR2exMjhDpODMLQaiZri+wLQ1o/J6E6MUy1vgEB1CgrjLGwRHFBRqU7e2DcbGRFB
         AyIw==
X-Gm-Message-State: ALoCoQnUsba042FWDN+Yy7W9eAffsdpTkpf+VOYVnUzyls1MJww26V4/0KZ1X4zN0gUaBQeuQA7NVa1YbJL/5f7XtKJHdr/ZEawWKdcgd2icSDGjB6Tl2b/UpU22WKcD3P4dYR8BfKco1dakTB4Ey9l6lKFB6H6bGfZ2ARAoNV/uckiHVZaU0nprsHnM960OQslR5JabsYzg
X-Received: by 10.220.188.10 with SMTP id cy10mr1476478vcb.36.1398709381152;
 Mon, 28 Apr 2014 11:23:01 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 11:23:01 -0700 (PDT)
In-Reply-To: <20140425221248.GC9218@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247398>

Thanks.

Replaced with strbuf_addf() instead.

On Fri, Apr 25, 2014 at 3:12 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3393,6 +3393,7 @@ static int ref_update_compare(const void *r1, const void *r2)
>>  }
>>
>>  static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>> +                                     char **err,
>>                                       enum action_on_err onerr)
>>  {
>>       int i;
>> @@ -3400,6 +3401,11 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>>               if (!strcmp(updates[i - 1]->refname, updates[i]->refname)) {
>>                       const char *str =
>>                               "Multiple updates for ref '%s' not allowed.";
>> +                     if (err) {
>> +                             *err = xmalloc(PATH_MAX + 41);
>> +                             snprintf(*err, PATH_MAX + 41, str,
>> +                                      updates[i]->refname);
>> +                     }
>
> Same issues as the previous patch: it's too easy to get the buffer size
> wrong when updating the message (or, worse, when making it
> translatable).  aprintf or a strbuf should work better.
>
> Otherwise seems sensible.
