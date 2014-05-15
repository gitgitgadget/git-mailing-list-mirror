From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 06/44] refs.c: add an err argument ro delete_loose_ref
Date: Thu, 15 May 2014 13:00:10 -0700
Message-ID: <CAL=YDWkE4WnE1ELRJcXFEcNhSw=gv9XjqvrK_EqD3PQu8i0URA@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-7-git-send-email-sahlberg@google.com>
	<20140515190434.GF26471@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 15 22:00:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wl1pD-0000xa-5o
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 22:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754475AbaEOUAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 16:00:12 -0400
Received: from mail-ve0-f171.google.com ([209.85.128.171]:36025 "EHLO
	mail-ve0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbaEOUAL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 16:00:11 -0400
Received: by mail-ve0-f171.google.com with SMTP id oz11so1939850veb.2
        for <git@vger.kernel.org>; Thu, 15 May 2014 13:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QEEj3pNxOhpYG+5ND6g0nWPsLv7mnaGU+6GmS2Ffba4=;
        b=RNj/0Ib682xC0tTuYDi2Xwwhq5kMj24IwEuQePo4KTn6WOAgiVS253qjhCWJ9qiVAA
         s7pfGk34QlxGPLEmC1PzFDl36Em7o/M3z9eRtfuYko1G2bRmSHYazEi7LK/Ck/T48D5L
         Z9EZSuOs3MoYoVMLRiqiTBfZ0EB8u6oRI6O/9dDuIzmrXQ2i9Hj/nl2Bmt2zB1Nj5oGY
         TXyMXs3EGJtXe5K2wT6wG9Q4ZN9y856XDsxuMAU3LgIjmIo1tzx3P/wxJscjlVPxRgPJ
         CZPAdVCrYZD7Q0nSPp3lmVMnxRRzaMHmgbE1PbAw0bh7RwvuCbfh4qB6RwTeUyjhd4U7
         PDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=QEEj3pNxOhpYG+5ND6g0nWPsLv7mnaGU+6GmS2Ffba4=;
        b=kIljV2qkCar/jBF+AskVfSfGfEAD4eIDuVPk3QrWq/iMvhodk0kp4fZT8qJuyJzDVO
         Oy/tqH8F8LFlIAcQrTGU4BGdXmrprwmyD/4uBHmCKvg5Kweq2rCO6SR1Wspb45TpWpgt
         4jTT/IKNalkxoooyVChPZmUcrC7KePvi/s3CwmYTBW2Wm5GX3An+jbl8WJ7Cut5iH8nr
         70NkJoi17JcdQYpNrOCExpg8OmN5/rDFikYBP6TNlk0LCmpnMfXusUmGII6s0UzGBNah
         5o0HHft4YRqAn0OqtMBcO6ieFf4yQhDFvF/21xY8Ivf9z8LnZMBIymiZWQEpwKoodueh
         Ms8w==
X-Gm-Message-State: ALoCoQlnsglTDm5G6cQNndHJMP3Qt1ACl32RsARl+GGY73VNF/lmWzMVdZuP2HUOx0jf9FeQx1DG
X-Received: by 10.52.13.98 with SMTP id g2mr1653592vdc.46.1400184010849; Thu,
 15 May 2014 13:00:10 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Thu, 15 May 2014 13:00:10 -0700 (PDT)
In-Reply-To: <20140515190434.GF26471@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249199>

On Thu, May 15, 2014 at 12:04 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> [Subject: refs.c: add an err argument ro delete_loose_ref]
>
> s/ro/to/
> s/delete_loose_ref/delete_ref_loose/
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2484,17 +2484,22 @@ static int repack_without_ref(const char *refname)
>>       return repack_without_refs(&refname, 1, NULL);
>>  }
>>
>> -static int delete_ref_loose(struct ref_lock *lock, int flag)
>> +static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>
> Should this get an onerr flag to suppress the message to stderr
> or unconditionally suppress it when err != NULL?
>

Fixed.
I added a new function unlink_or_err that will update err if non-NULL
and unse warning() otherwise.


> [...]
>>               lock->lk->filename[i] = 0;
>> -             err = unlink_or_warn(lock->lk->filename);
>> +             res = unlink_or_warn(lock->lk->filename);
>
> It seems like in the new error handling scheme there should be a new
> variant on wrapper.c's warn_if_unremovable:
>
>         static int add_err_if_unremovable(const char *op, const char *file, struct strbuf *err, int rc)
>         {
>                 int err = errno;
>                 if (rc < 0 && err != ENOENT) {
>                         strbuf_addf(err, "unable to %s %s: %s",
>                                     op, file, strerror(errno));
>                         errno = err;
>                 }
>                 return rc;
>         }
>
>         static int unlink_or_err(const char *file, struct strbuf *err)
>         {
>                 return add_err_if_unremovable("unlink", file, err, unlink(file));
>         }
>
>                 res = unlink_or_err(lock->lk->filename, err);
