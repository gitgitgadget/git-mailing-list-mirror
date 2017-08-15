Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 559C6208B8
	for <e@80x24.org>; Tue, 15 Aug 2017 18:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752971AbdHOSkm (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Aug 2017 14:40:42 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33213 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752780AbdHOSki (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2017 14:40:38 -0400
Received: by mail-pg0-f48.google.com with SMTP id u5so10664453pgn.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2017 11:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iPGj2tWT/VI1RkLRIcci9fsbSfSLp1m+/NW10jhyXbQ=;
        b=NMrmjc85Yc56GlIoTk62eoGm/iHjmNhP0VncGEM9HsoKO0rRbIL7mtFfTfVOB8mcx7
         Ef6vh3O++jzkvWAF+k5hrUM/BpS2yoADDtuqGtXlXoHvaumS8Wj0ec46/7YIu0FMt6rT
         NCtHBibtOnIhG3O0mWv2jkxxCQlte8mi6ZICNMEjIE2CEXusivl9sGmSUBeCi4nZP+CI
         8dpN1Y5JR2ExeR49ztuHL+7TLng1rE3nqkgBQEemQiMx/ni8KzzhpOZGxhOxsuW8H8Vc
         Fmpfyrluy8aFK43KTOfxLCD7rhIXRs4+f6TQYMt6/gF9Z+FhiHKi0N/Ta95Y0Hc846Iu
         BDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iPGj2tWT/VI1RkLRIcci9fsbSfSLp1m+/NW10jhyXbQ=;
        b=A53k5m+k43EK2nCYa0dsUTGAtNa2fF20OFfGR5iMuAJJa6xiTi5eJ9MQFRLJPIOCTJ
         5IvMWcDdIq1ezehucT5wXBqyQwtAltnhh/DsuL9Ou83UCX7i1hoxg2B602X9KBhk3nf5
         PCIsKl7TpPfwIPcWsolFce+me2VlmgH5/48dItUmjvfQZ0qQYm6Uzy4OU+/Msab5a2B6
         L8g0bfs9ZopTWq114j+g8hmoCK9Gmy91ozsHipXoIsqENNpGp/bePaMvfgG2tJkHANBf
         YdPnajFVou/KiP701hcN/52fGrQMNy47QkpQHdp6DMI21QBV4/1Qc0M3KR/5ODRRJNWs
         /46g==
X-Gm-Message-State: AHYfb5jS5aQbeXkgqBd9wxhVxInbvi49p+kVfkPoXTqipJx4DoSusLt1
        xjEJUeOANkQOul92auYZComx0jeXxA==
X-Received: by 10.84.129.6 with SMTP id 6mr33158954plb.289.1502822438008; Tue,
 15 Aug 2017 11:40:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Tue, 15 Aug 2017 11:40:37 -0700 (PDT)
In-Reply-To: <CAGZ79kbf52Uu-Th9W20QZV204A81kOAPTj2x6JkEP1rN=GTYtw@mail.gmail.com>
References: <cover.1502780343.git.martin.agren@gmail.com> <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
 <cff383c2-ca57-caba-5a46-7dec4abc25a4@jeffhostetler.com> <CAGZ79kbf52Uu-Th9W20QZV204A81kOAPTj2x6JkEP1rN=GTYtw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 15 Aug 2017 20:40:37 +0200
Message-ID: <CAN0heSoXysu=6E_ScfWQVLOk805V=j7AYJi=z62SmNkP5U=A9Q@mail.gmail.com>
Subject: Re: tsan: t3008: hashmap_add touches size from multiple threads
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 August 2017 at 20:17, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Aug 15, 2017 at 10:59 AM, Jeff Hostetler <git@jeffhostetler.com> =
wrote:
>>
>>
>> On 8/15/2017 8:53 AM, Martin =C3=85gren wrote:
>>>
>>> Using SANITIZE=3Dthread made t3008-ls-files-lazy-init-name-hash.sh hit
>>> the potential race below.
>>>
>>> What seems to happen is, threaded_lazy_init_name_hash ends up using
>>> hashmap_add on the_index.dir_hash from two threads in a way that tsan
>>> considers racy. While the buckets each have their own mutex, the "size"
>>> does not. So it might end up with the wrong (lower) value. The size is
>>> used to determine when to resize, but that should be fine, since
>>> resizing is turned off due to threading anyway.
>>
>>>
>>>
>>> If the size is ever used for something else, the consequences might
>>> range from cosmetic error to devastating. I have a "feeling" the size i=
s
>>> not used at the time, although maybe it is, in some roundabout way whic=
h
>>> I'm not seeing.
>>
>>
>> Good catch!  Yes, the size field is unguarded.  The only references to
>> it that I found were used in _add() and _remove() in the need-to-rehash
>> check.
>>
>> Since auto-rehash is turned off, this shouldn't be a problem, but it
>> does feel odd to have a possibly incorrect size due to races.
>>
>> Rather than adding something like (a cross-platform version of)
>> InterlockedIncrement(), I'm wondering if it would be better to
>> disable/invalidate the size field when auto-rehash is turned off
>> so we don't have to worry about it.
>>
>> Something like this:
>>
>>
>> $ git diff
>> diff --git a/hashmap.c b/hashmap.c
>> index 9b6a12859b..be97642daa 100644
>> --- a/hashmap.c
>> +++ b/hashmap.c
>> @@ -205,6 +205,9 @@ void hashmap_add(struct hashmap *map, void *entry)
>>         ((struct hashmap_entry *) entry)->next =3D map->table[b];
>>         map->table[b] =3D entry;
>>
>> +       if (map->disallow_rehash)
>> +               return;
>> +
>>         /* fix size and rehash if appropriate */
>>         map->size++;
>>         if (map->size > map->grow_at)
>> @@ -223,6 +226,9 @@ void *hashmap_remove(struct hashmap *map, const void
>> *key, const void *keydata)
>>         *e =3D old->next;
>>         old->next =3D NULL;
>>
>> +       if (map->disallow_rehash)
>> +               return;
>> +
>
>
> Once we have these two checks, the check in rehash itself becomes
> redundant (as any code path leading to the check in rehash already
> had the check).
>
> Which leads me to wonder if we want to make the size (in/de)crease
> part of the rehash function, which could be
>
>     adjust_size(struct hashmap *map, int n)
>
> with `n` either +1 or -1 (the increase value). Depending on 'n', we could
> compute the newsize for the potential rehash in that function as well.
>
> Note sure if that is a cleaner internal API.
>
>>         /* fix size and rehash if appropriate */
>>         map->size--;
>>         if (map->size < map->shrink_at)
>> diff --git a/hashmap.h b/hashmap.h
>> index 7a8fa7fa3d..ec9541b981 100644
>> --- a/hashmap.h
>> +++ b/hashmap.h
>> @@ -183,7 +183,8 @@ struct hashmap {
>>         const void *cmpfn_data;
>>
>>         /* total number of entries (0 means the hashmap is empty) */
>> -       unsigned int size;
>> +       /* -1 means size is unknown for threading reasons */
>> +       int size;
>
> This double-encodes the state of disallow_rehash (i.e. if we had
> signed size, then the invariant disallow_rehash =3D=3D=3D (size < 0)
> is true, such that we could omit either the flag and just check for
> size < 0 or we do not need the negative size as any user would
> need to check disallow_rehash first. Not sure which API is harder
> to misuse. I'd think just having the size and getting rid of
> disallow_rehash might be hard to to reused.

(Do you mean "might be hard to be misused"?)

One good thing about turning off the size-tracking with threading is
that someone who later wants to know the size in a threaded application
will not introduce any subtle bugs by misusing size, but will be forced
to provide and use some sort of InterlockedIncrement(). When/if that
change happens, it would be nice if no-one relied on the value of size
to say anything about threading. So it might make sense to have an
implementation-independent way of accessing disallow_rehash a.k.a.
(size < 0).

For example a function hashmap_disallow_rehash(), except that's
obviously taken. :-) Maybe the existing function would then be
hashmap_set_disallow_rehash(). Oh well..

>
>>
>>         /*
>>          * tablesize is the allocated size of the hash table. A non-0 va=
lue
>> @@ -360,6 +361,15 @@ int hashmap_bucket(const struct hashmap *map, unsig=
ned
>> int hash);
>>  static inline void hashmap_disallow_rehash(struct hashmap *map, unsigne=
d
>> value)
>>  {
>>         map->disallow_rehash =3D value;
>> +       if (value) {
>> +               /*
>> +                * Assume threaded operations starting, so don't
>> +                * try to keep size current.
>> +                */
>> +               size =3D -1;
>> +       } else {
>> +               /* TODO count items in all buckets and set size. */
>> +       }
>>  }
>>
>>  /*
>>
>>
>> Jeff
