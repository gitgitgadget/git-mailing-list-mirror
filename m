From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v3 19/19] refs.c: pass **transaction to commit and have it
 clear the pointer
Date: Mon, 28 Apr 2014 10:59:19 -0700
Message-ID: <CAL=YDWkSdiUd-6A60ncGaDrFV2pc5WtRMv8iCSHHqFLkKH=pfw@mail.gmail.com>
References: <1398442494-23438-1-git-send-email-sahlberg@google.com>
	<1398442494-23438-20-git-send-email-sahlberg@google.com>
	<535B0C6F.509@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:52:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerbA-0006Or-8B
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932925AbaD1TwP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:52:15 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:46421 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbaD1TwN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:52:13 -0400
Received: by mail-vc0-f174.google.com with SMTP id ib6so2415287vcb.33
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=pz3V18tDcDU5eU5VLeZoa5mkYUQTNV8SmoDiafV/LeE=;
        b=Fj70GMszdjXgr/jEJ25TqB7RhdLAwWfehANg5aB6bwYXTu6jrxKxSxVUwxoojfGJ4w
         JlZjCS3AMBkxi8ChOiYEgcO8RL6F9XJPZ5IKzXE7KFpefdE5OwmrWJEfsFltTA1/zyk0
         ZWSs6nRD69/O5jl0+xBelo9gWI06jpOeUmW2GZ0AzPXWGJiRX2YWdoL/xN7cQfuBtAZp
         zwdYqAyeLt4aHHpxTAgdctVmOhvm7xM5zWxaotw3/501mC0Stwx8bCX1CbkeFF3JXvik
         WnA/t3p9SxQwDhaJU801+4QM4IeBfLd70Iuv2QlNXsWGEkIbbqKuG5BWUfRDgoO0S7Yz
         IeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=pz3V18tDcDU5eU5VLeZoa5mkYUQTNV8SmoDiafV/LeE=;
        b=SU6DBJQSCMy5qZvnMrfx3MN+Yb4rFaJ/fu63iqS3bLi4LYtBw7ujoLTIPuicVXZrZl
         sjMXP+aU5dKEMhsr8Rb1ViEJ9B4uVQwCXrx58rf9pnKjZjo/T9gN+Y5m2+xSbS3QKWaZ
         fUDzkkYn/hi0alfORZMnAAiJ30K9cKG7NMduOkial4pYCXmqVlituCi+5VjCxDYy6VyH
         bFks39qVhPSURGc4u2IgbeuLx16jESH3wBqygSApHYc12Gwg9NQBU/FwD3I23VTnwqJw
         ohyqHE3cKTz2/5HpVhkIGU8/sBUddGeYbWUlgjcu3bWRO2icEjbQsb55+LuC70uM85ia
         cfOw==
X-Gm-Message-State: ALoCoQkxVbZXfSWqqlcaHHRl2GC6HXF3fDJgoUl3DC3NDlkeav6cJoX7jSiDTws5orUJ/E9CzKJnpu+8UcRgb0lI/TOrsat0BHQuUXpkr09V5GeQ4WPO0zK13FMYneAaUxveNn3HtRfRTzvbCV+iHDCrmZ3IUvnkdoSNYFMl7HHGOvGJpYwmAPqzmNq1wgFeNwFwFdj9+N0O
X-Received: by 10.52.78.231 with SMTP id e7mr8393076vdx.28.1398707959943; Mon,
 28 Apr 2014 10:59:19 -0700 (PDT)
Received: by 10.52.141.13 with HTTP; Mon, 28 Apr 2014 10:59:19 -0700 (PDT)
In-Reply-To: <535B0C6F.509@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247426>

On Fri, Apr 25, 2014 at 6:31 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/25/2014 06:14 PM, Ronnie Sahlberg wrote:
>> Change ref_transaction_commit to take a pointer to a pointer for the
>> transaction. This allows us to clear the transaction pointer from within
>> ref_transaction_commit so that it becomes NULL in the caller.
>>
>> This makes transaction handling in the callers much nicer since instead of
>> having to write horrible code like :
>>       t = ref_transaction_begin();
>>       if ((!t ||
>>           ref_transaction_update(t, refname, sha1, oldval, flags,
>>                                  !!oldval)) ||
>>           (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
>>               ref_transaction_rollback(t);
>>
>> we can now just do the much nicer
>>       t = ref_transaction_begin();
>>       if (!t ||
>>           ref_transaction_update(t, refname, sha1, oldval, flags,
>>                                  !!oldval) ||
>>           ref_transaction_commit(&t, action, &err)) {
>>               ref_transaction_rollback(t);
>
> I understand the motivation for this change, but passing
> pointer-to-pointer is unconventional in a case like this.  Unfortunately
> I ran out of steam for the night before I could think about alternatives.

I see.
Yes passing a pointer to pointer is not ideal.
But I still want to be able to use the pattern
       t = ref_transaction_begin();
       if (!t ||
           ref_transaction_update(t, ...) ||
           ref_transaction_commit(t, ...)) {
               ref_transaction_rollback(t);

Maybe the problem is that ref_transaction_commit() implicitely also
frees the transaction.


What about changing ref_transaction_commit() would NOT free the
transaction and thus a caller would
always have to explicitely free the transaction afterwards?

Something like this :
       t = ref_transaction_begin();
       if (!t ||
           ref_transaction_update(t, ...) ||
           ref_transaction_commit(&t, ...)) {
               ref_transaction_rollback(t);
       }
       ref_transaction_free(t);


>
> Regarding patches 01-18, I agree with Jonathan's comments and made a few
> of my own.  I definitely don't think that code like "!(t = NULL)" should
> stay in our code base as more than a transitional state.  But I'd have
> to play with the alternatives before I can form an opinion on your
> suggestion in this patch.
>
> Thanks for working on this!
>
> Michael
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>> ---
>>  branch.c             |  4 ++--
>>  builtin/commit.c     |  2 +-
>>  builtin/replace.c    |  2 +-
>>  builtin/tag.c        |  2 +-
>>  builtin/update-ref.c |  2 +-
>>  fast-import.c        |  7 +++----
>>  refs.c               | 18 ++++++++++--------
>>  refs.h               |  3 ++-
>>  sequencer.c          |  7 +++----
>>  9 files changed, 24 insertions(+), 23 deletions(-)
>>
>> diff --git a/branch.c b/branch.c
>> index 23cde1e..5d68467 100644
>> --- a/branch.c
>> +++ b/branch.c
>> @@ -303,14 +303,14 @@ void create_branch(const char *head,
>>                       if (!transaction ||
>>                           ref_transaction_update(transaction, ref.buf, sha1,
>>                                                  NULL, 0, 0) ||
>> -                         ref_transaction_commit(transaction, msg, &err))
>> +                         ref_transaction_commit(&transaction, msg, &err))
>>                         die_errno(_("%s: failed to write ref: %s"),
>>                                   ref.buf, err);
>>               } else {
>>                       if (!transaction ||
>>                           ref_transaction_create(transaction, ref.buf, sha1,
>>                                                  0) ||
>> -                         ref_transaction_commit(transaction, msg, &err))
>> +                         ref_transaction_commit(&transaction, msg, &err))
>>                         die_errno(_("%s: failed to write ref: %s"),
>>                                   ref.buf, err);
>>               }
>> diff --git a/builtin/commit.c b/builtin/commit.c
>> index 7e4c306..3142827 100644
>> --- a/builtin/commit.c
>> +++ b/builtin/commit.c
>> @@ -1682,7 +1682,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
>>                                  current_head ?
>>                                  current_head->object.sha1 : NULL,
>>                                  0, !!current_head) ||
>> -         ref_transaction_commit(transaction, sb.buf, &err)) {
>> +         ref_transaction_commit(&transaction, sb.buf, &err)) {
>>               rollback_index_files();
>>               die(_("HEAD: cannot update ref: %s"), err);
>>       }
>> diff --git a/builtin/replace.c b/builtin/replace.c
>> index cf0f56d..51e9ddf 100644
>> --- a/builtin/replace.c
>> +++ b/builtin/replace.c
>> @@ -162,7 +162,7 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>>       if (!transaction ||
>>           ref_transaction_update(transaction, ref, repl, prev,
>>                                  0, !is_null_sha1(prev)) ||
>> -         ref_transaction_commit(transaction, NULL, &err))
>> +         ref_transaction_commit(&transaction, NULL, &err))
>>         die(_("%s: failed to replace ref: %s"), ref, err);
>>
>>       return 0;
>> diff --git a/builtin/tag.c b/builtin/tag.c
>> index dd53fb4..60b57a1 100644
>> --- a/builtin/tag.c
>> +++ b/builtin/tag.c
>> @@ -646,7 +646,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>>       if (!transaction ||
>>           ref_transaction_update(transaction, ref.buf, object, prev,
>>                                  0, !is_null_sha1(prev)) ||
>> -         ref_transaction_commit(transaction, NULL, &err))
>> +         ref_transaction_commit(&transaction, NULL, &err))
>>         die(_("%s: cannot update the ref: %s"), ref.buf, err);
>>       if (force && !is_null_sha1(prev) && hashcmp(prev, object))
>>               printf(_("Updated tag '%s' (was %s)\n"), tag, find_unique_abbrev(prev, DEFAULT_ABBREV));
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index a600ab3..4a0901d 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -373,7 +373,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>>               if (end_null)
>>                       line_termination = '\0';
>>               update_refs_stdin();
>> -             if (ref_transaction_commit(transaction, msg, &err))
>> +             if (ref_transaction_commit(&transaction, msg, &err))
>>                       die("update_ref failed: %s", err);
>>               return 0;
>>       }
>> diff --git a/fast-import.c b/fast-import.c
>> index a2b05fa..3ce2f47 100644
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1703,11 +1703,10 @@ static int update_branch(struct branch *b)
>>               }
>>       }
>>       transaction = ref_transaction_begin();
>> -     if ((!transaction ||
>> +     if (!transaction ||
>>           ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
>> -                                0, 1)) ||
>> -         (ref_transaction_commit(transaction, msg, &err) &&
>> -          !(transaction = NULL))) {
>> +                                0, 1) ||
>> +         ref_transaction_commit(&transaction, msg, &err)) {
>>               ref_transaction_rollback(transaction);
>>               return error("Unable to update branch %s: %s", b->name, err);
>>       }
>> diff --git a/refs.c b/refs.c
>> index ffa9c83..0b60250 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3401,10 +3401,10 @@ int update_ref(const char *action, const char *refname,
>>       char *err = NULL;
>>
>>       t = ref_transaction_begin();
>> -     if ((!t ||
>> +     if (!t ||
>>           ref_transaction_update(t, refname, sha1, oldval, flags,
>> -                                !!oldval)) ||
>> -         (ref_transaction_commit(t, action, &err) && !(t = NULL))) {
>> +                                !!oldval) ||
>> +         ref_transaction_commit(&t, action, &err)) {
>>            const char *str = "update_ref failed for ref '%s': %s";
>>
>>               ref_transaction_rollback(t);
>> @@ -3444,16 +3444,17 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>>       return 0;
>>  }
>>
>> -int ref_transaction_commit(struct ref_transaction *transaction,
>> +int ref_transaction_commit(struct ref_transaction **transaction,
>>                          const char *msg, char **err)
>>  {
>>       int ret = 0, delnum = 0, i;
>>       const char **delnames;
>> -     int n = transaction->nr;
>> -     struct ref_update **updates = transaction->updates;
>> +     int n = (*transaction)->nr;
>> +     struct ref_update **updates = (*transaction)->updates;
>>
>>       if (!n) {
>> -             ref_transaction_free(transaction);
>> +             ref_transaction_free(*transaction);
>> +             *transaction = NULL;
>>               return 0;
>>       }
>>
>> @@ -3527,7 +3528,8 @@ cleanup:
>>               if (updates[i]->lock)
>>                       unlock_ref(updates[i]->lock);
>>       free(delnames);
>> -     ref_transaction_free(transaction);
>> +     ref_transaction_free(*transaction);
>> +     *transaction = NULL;
>>       return ret;
>>  }
>>
>> diff --git a/refs.h b/refs.h
>> index 8135131..85127f2 100644
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -270,8 +270,9 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>>   * problem.  The ref_transaction is freed by this function.
>>   * If error is non-NULL it will return an error string that describes
>>   * why a commit failed. This string must be free()ed by the caller.
>> + * *transaction is reset to NULL in this call.
>>   */
>> -int ref_transaction_commit(struct ref_transaction *transaction,
>> +int ref_transaction_commit(struct ref_transaction **transaction,
>>                          const char *msg, char **err);
>>
>>  /** Lock a ref and then write its file */
>> diff --git a/sequencer.c b/sequencer.c
>> index 7d59f58..3f6eced 100644
>> --- a/sequencer.c
>> +++ b/sequencer.c
>> @@ -283,11 +283,10 @@ static int fast_forward_to(const unsigned char *to, const unsigned char *from,
>>       strbuf_addf(&sb, "%s: fast-forward", action_name(opts));
>>
>>       transaction = ref_transaction_begin();
>> -     if ((!transaction ||
>> +     if (!transaction ||
>>           ref_transaction_update(transaction, "HEAD", to, from,
>> -                                0, !unborn)) ||
>> -         (ref_transaction_commit(transaction, sb.buf, &err) &&
>> -          !(transaction = NULL))) {
>> +                                0, !unborn) ||
>> +         ref_transaction_commit(&transaction, sb.buf, &err)) {
>>               ref_transaction_rollback(transaction);
>>               strbuf_release(&sb);
>>               return error(_("HEAD: Could not fast-forward: %s\n"), err);
>>
>
>
> --
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
