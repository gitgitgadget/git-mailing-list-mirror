From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 32/41] refs.c: make delete_ref use a transaction
Date: Tue, 3 Jun 2014 09:59:12 -0700
Message-ID: <CAL=YDW=W4V-Eb8nK5dx_dKyVHuKDwvGJhLihosgmGZx8kO-O2w@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-33-git-send-email-sahlberg@google.com>
	<20140530172808.GG12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 18:59:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrs3c-0004iU-Bh
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 18:59:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbaFCQ7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 12:59:16 -0400
Received: from mail-ve0-f175.google.com ([209.85.128.175]:63121 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933297AbaFCQ7N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 12:59:13 -0400
Received: by mail-ve0-f175.google.com with SMTP id jw12so7314491veb.34
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 09:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=49V2wXTSPKfJVSqfuupak1H3MfbmxH5lyzahVIED+tA=;
        b=URoiUYmQ9bNprkARJRur32WAh/MIcpGqgZwPYJ8mWhRC3fvQrmeTRbq8h5hDTcxHHC
         i6RI2hwB0BzmICvE4G52I3PHr/+10VtuPVlsr14ozuasqKel0sWuD/cgx/oelg8U519K
         hCWPcp52IUh/7O36uyGAFPFXIbmb8Os3Z6kOpgfdTH69nWdSdqlIws3vMt1IJ7fOJxS3
         CAbT9OUJKVqXBkFpHBvX0M6BtKkb3DXjR5E9z/m1o4GH0Rzs5b5W97XhGYxxtlJibEMk
         ZK9aGRZO7jfbZyGFiFsfdfFXgD2mADU6So4iZOEO+56UhqawZx8V1YAXYwa8YYG5Jj0r
         Zl2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=49V2wXTSPKfJVSqfuupak1H3MfbmxH5lyzahVIED+tA=;
        b=f0hO/8QeJu/8MjMwZVmEmIfwC7KJNvl6kgkX5jtzGxtpP/JvpgI5Ll9LvNZAirhiIc
         t+T7U2gOcrC+5NDayzvFnK70Em9FDdY8N+g3EwOM0n0cerBZzXxApZJsrTVBEdlJwQjj
         ZHghKvPwnemw6f2K80DW5z258fH8EjDttHftfMdugv9qrbcQhFJ+SYd3ltNAuNuvPu7W
         IfMUU9KN7esGFSijrNdzzc7PlLAwMRtNid0TZCgBG7rk+Ilkh/vKlb9X8atF70B6msQn
         iW1EviOAu7vnSIkMfIBI7g/Aoeff+owpDb5u3EyF1b5F6Mk+bfb/u5sKlJNZbc6DxYpx
         6lew==
X-Gm-Message-State: ALoCoQl9TfALNqVtklyMI9H6tA77KEowdwADEuSqAI1t9tmCIfvW+aBsAEXxd9G6uOBQd3aRL5xR
X-Received: by 10.220.53.72 with SMTP id l8mr38434026vcg.16.1401814752424;
 Tue, 03 Jun 2014 09:59:12 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 09:59:12 -0700 (PDT)
In-Reply-To: <20140530172808.GG12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250630>

Thanks!

On Fri, May 30, 2014 at 10:28 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 34 +++++++++++++---------------------
>>  1 file changed, 13 insertions(+), 21 deletions(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> [...]
>> +++ b/refs.c
> [...]
>> @@ -2542,24 +2537,21 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>>
>>  int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
>>  {
> [...]
>> +     if (!transaction ||
>> +         ref_transaction_delete(transaction, refname, sha1, delopt,
>> +                                sha1 && !is_null_sha1(sha1), &err) ||
>> +         ref_transaction_commit(transaction, NULL, &err)) {
>> +             error("%s", err.buf);
>> +             ref_transaction_free(transaction);
>> +             strbuf_release(&err);
>>               return 1;
>> +     }
> [...]
>> -     ret |= repack_without_ref(lock->ref_name);
>
> The old return value could be 1 or -1 depending on how the deletion
> failed.  Now it's consistently 1.
>
> The only callers I see that care are cmd_symbolic_ref and
> cmd_update_ref, for which 1 is better (-1 would result in an exit
> status of 255, which means something like "died with signal 127").
>
> Thanks,
> Jonathan
