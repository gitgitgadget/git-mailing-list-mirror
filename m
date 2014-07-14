From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v20 23/48] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Mon, 14 Jul 2014 10:55:00 -0700
Message-ID: <CAL=YDWmDCtDTiLeGUM+=0DQL-JWF8a+yqmK20YSoGcuvpazREQ@mail.gmail.com>
References: <1403275409-28173-1-git-send-email-sahlberg@google.com>
	<1403275409-28173-24-git-send-email-sahlberg@google.com>
	<53BBDD4F.20403@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:55:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6kT5-0000Kj-1b
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756770AbaGNRzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 13:55:08 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:35108 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756767AbaGNRzC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 13:55:02 -0400
Received: by mail-vc0-f178.google.com with SMTP id la4so1227992vcb.23
        for <git@vger.kernel.org>; Mon, 14 Jul 2014 10:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rAmEITPRm6PAx0/KIjvrswPDkBhCjQseoJn2yOk7Hus=;
        b=DbTl8lhkyxB0cxncrSxMjhfflnW9h1gPhDJVL8y1kNaZJD7fPTLc+ue8djP2yRYaOe
         lcQq5d660ylEuGGlD19Y/FtCkF5u+gu4/sxvOHmNV/1XP5y+Ix43xC/Pc3dXnUylJzdj
         aQTt6Ivl3hGSlI1QV87domSYNlQu9VaVE6PBmFsYEh0L2iPFo0kxnlR2T2epI5BUReiq
         EQJGzy5RCSm37GXXeXu/qxHSS2DtcdtjDtEONKgWGGpbL0zjFFytaEJy0jDQJ7lnx5k1
         shkrgjHsZf9xCbHuIbP8mEV4a/GesnjPoJv6OjvjE5B7E1H03QGLhVkVxGsKvdGx0Bie
         GxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=rAmEITPRm6PAx0/KIjvrswPDkBhCjQseoJn2yOk7Hus=;
        b=FeGSBlfNaeQfuYVfLzf1J1IBBT3dyKw1hv1eCtGy2mPfWRIPTomEzlUFDcam8vhBV1
         xnwfa8YvIuD1FVNy8EB8NeBW2k1/XVcJDLDSoKMD2YmHM2FYSVtjs1Wj27iFxzvRIqq9
         T11+OxJZCrqNis/1uFe3HNWweGqhP1deD0hydTKE16AE0TZVK0ZUsynBEHnacnnarqSS
         uHFKVUhJ4y5EQotleSB7zJ1TeF5Gx6A5KiEgoiHxnrhhev5RFHQ4+PLi05rd1ZtCuwXV
         Gs9tsPJozm3WkAtlZQCow/aiEo3DN72S3+KrmEhvGLvz3fH9JVlW9b5CZpBuJUQTeJhd
         jjwA==
X-Gm-Message-State: ALoCoQlPvrtMfno+G/ZqZiVzQrQfVIX0rcj2r0WECg8rGfA4wzWSaWyFFd5Bsgu2DqDPokZkLgow
X-Received: by 10.52.0.177 with SMTP id 17mr14592746vdf.12.1405360501015; Mon,
 14 Jul 2014 10:55:01 -0700 (PDT)
Received: by 10.52.136.166 with HTTP; Mon, 14 Jul 2014 10:55:00 -0700 (PDT)
In-Reply-To: <53BBDD4F.20403@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253504>

I updated the comments.

Status is used in a later series to track certain errno settings. This
used to be done here but was moved to a later series.
I removed the status field for now and will re add it later when we
start using it.

Thanks!


On Tue, Jul 8, 2014 at 5:00 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 06/20/2014 04:43 PM, Ronnie Sahlberg wrote:
>> Track the status of a transaction in a new status field. Check the field for
>
> The status field is not set or used anywhere.  The field that you use is
> "state".
>
>> sanity, i.e. that status must be OPEN when _commit/_create/_delete or
>> _update is called or else die(BUG:...)
>>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  refs.c | 40 +++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 39 insertions(+), 1 deletion(-)
>>
>> diff --git a/refs.c b/refs.c
>> index 9cb7908..8c695ba 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3387,6 +3387,25 @@ struct ref_update {
>>  };
>>
>>  /*
>> + * Transaction states.
>> + * OPEN:   The transaction is in a valid state and can accept new updates.
>> + *         An OPEN transaction can be committed.
>> + * CLOSED: If an open transaction is successfully committed the state will
>> + *         change to CLOSED. No further changes can be made to a CLOSED
>> + *         transaction.
>> + *         CLOSED means that all updates have been successfully committed and
>> + *         the only thing that remains is to free the completed transaction.
>> + * ERROR:  The transaction has failed and is no longer committable.
>> + *         No further changes can be made to a CLOSED transaction and it must
>> + *         be rolled back using transaction_free.
>> + */
>> +enum ref_transaction_state {
>> +     REF_TRANSACTION_OPEN   = 0,
>> +     REF_TRANSACTION_CLOSED = 1,
>> +     REF_TRANSACTION_ERROR  = 2,
>> +};
>> +
>> +/*
>>   * Data structure for holding a reference transaction, which can
>>   * consist of checks and updates to multiple references, carried out
>>   * as atomically as possible.  This structure is opaque to callers.
>> @@ -3395,6 +3414,8 @@ struct ref_transaction {
>>       struct ref_update **updates;
>>       size_t alloc;
>>       size_t nr;
>> +     enum ref_transaction_state state;
>> +     int status;
>
> The status field should probably be deleted.
>
>>  };
>>
>>  struct ref_transaction *ref_transaction_begin(struct strbuf *err)
>> @@ -3437,6 +3458,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>  {
>>       struct ref_update *update;
>>
>> +     if (transaction->state != REF_TRANSACTION_OPEN)
>> +             die("BUG: update called for transaction that is not open");
>> +
>>       if (have_old && !old_sha1)
>>               die("BUG: have_old is true but old_sha1 is NULL");
>>
>> @@ -3457,6 +3481,9 @@ int ref_transaction_create(struct ref_transaction *transaction,
>>  {
>>       struct ref_update *update;
>>
>> +     if (transaction->state != REF_TRANSACTION_OPEN)
>> +             die("BUG: create called for transaction that is not open");
>> +
>>       if (!new_sha1 || is_null_sha1(new_sha1))
>>               die("BUG: create ref with null new_sha1");
>>
>> @@ -3477,6 +3504,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>>  {
>>       struct ref_update *update;
>>
>> +     if (transaction->state != REF_TRANSACTION_OPEN)
>> +             die("BUG: delete called for transaction that is not open");
>> +
>>       if (have_old && !old_sha1)
>>               die("BUG: have_old is true but old_sha1 is NULL");
>>
>> @@ -3532,8 +3562,13 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>       int n = transaction->nr;
>>       struct ref_update **updates = transaction->updates;
>>
>> -     if (!n)
>> +     if (transaction->state != REF_TRANSACTION_OPEN)
>> +             die("BUG: commit called for transaction that is not open");
>> +
>> +     if (!n) {
>> +             transaction->state = REF_TRANSACTION_CLOSED;
>>               return 0;
>> +     }
>>
>>       /* Allocate work space */
>>       delnames = xmalloc(sizeof(*delnames) * n);
>> @@ -3595,6 +3630,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>       clear_loose_ref_cache(&ref_cache);
>>
>>  cleanup:
>> +     transaction->state = ret ? REF_TRANSACTION_ERROR
>> +             : REF_TRANSACTION_CLOSED;
>> +
>>       for (i = 0; i < n; i++)
>>               if (updates[i]->lock)
>>                       unlock_ref(updates[i]->lock);
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
