Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CF932013D
	for <e@80x24.org>; Wed, 15 Feb 2017 00:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751267AbdBOAvT (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:51:19 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33629 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750853AbdBOAuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:50:19 -0500
Received: by mail-oi0-f66.google.com with SMTP id j15so2697718oih.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1WNak34fuUQRBI710jbIjE02R2CjQBYvFmooboSXo+c=;
        b=OJKWAKzt7O2QiP+e1uPQu3lBBOFsbifjdpKQhoHloQiqhXy0EjcveXAocS48/6vg0T
         LRgYZXV98MFzH6nqSaJZjqASM7e+iRx+ZGO4fCT+l+cT7Oz+JtFkvBEYza2oziWS4sbM
         2/uoBlKeXSfe3RFLPbROigjucMrDw0ADMT/mQWE/ZJG0jVn4CZ2Qc8VZZ2hpsR+jLAGM
         OvyN88S9ulSS0WWcJLxf8o4uSYfH4U39ah1PYM/tB8VCfAagv66ObZ6cQFkO9LZCJQ4J
         LgNN6I181n1BrdAFC72VDssprILNwwSXSv2SfUgSdXUaY3mQPJvLJsS7AOfE7NCclaI8
         NsmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1WNak34fuUQRBI710jbIjE02R2CjQBYvFmooboSXo+c=;
        b=tody9FiGyorq5UgmEQJ75HXKhzuRvc6WVoqyRK3XZWmnCV2Zlm9SFuZWkiXFJIomcB
         tTH6E9/DOBi8ThSNr9HT3CaO8067gqByEaGOIa3+0w6dAqRyd2MAjnFQHKpn0MCSwBB6
         K1xx9VgXf2cC9VzJiCbdc9hEJGfPTzwgKlHmn+1j3dD14Emig+6da9TK1+0HeYWAF6j0
         QWMWy7E22bL0wHGlzc5+P15uG5lOqP/azaTjC8mKWorMa5VnhGd9hJFXNeFQE19hKXz9
         Tso9i4IIbQxZI++PnZhB+tQ2hteR9U2bIdcUw7u2lBPGppIEMht9oLhDetz8DDI6u1vg
         Cmqg==
X-Gm-Message-State: AMke39lxlU3WWibr1mgreV0yOg/oLyjrKD8UDen9pD4sjSGqdp0gIQUyouXBksP5xo6/2RzHXmpypzQ6eccIXA==
X-Received: by 10.202.173.18 with SMTP id w18mr18403211oie.146.1487119818938;
 Tue, 14 Feb 2017 16:50:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Tue, 14 Feb 2017 16:49:48 -0800 (PST)
In-Reply-To: <xmqqh93wabev.fsf@gitster.mtv.corp.google.com>
References: <20170213092702.10462-1-pclouds@gmail.com> <20170214095449.15585-1-pclouds@gmail.com>
 <xmqqh93wabev.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 15 Feb 2017 07:49:48 +0700
Message-ID: <CACsJy8BXSAUr2knrkOfO0gXYAwQoJpL2hCXy44Q37H4GE_-yVA@mail.gmail.com>
Subject: Re: [PATCH v2] clean: use warning_errno() when appropriate
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 15, 2017 at 1:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
>> All these warning() calls are preceded by a system call. Report the
>> actual error to help the user understand why we fail to remove
>> something.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.=
com>
>> ---
>>  v2 dances with errno
>
> Thanks.
>
>>
>>  builtin/clean.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/builtin/clean.c b/builtin/clean.c
>> index d6bc3aaae..3569736f6 100644
>> --- a/builtin/clean.c
>> +++ b/builtin/clean.c
>> @@ -154,6 +154,7 @@ static int remove_dirs(struct strbuf *path, const ch=
ar *prefix, int force_flag,
>>       struct strbuf quoted =3D STRBUF_INIT;
>>       struct dirent *e;
>>       int res =3D 0, ret =3D 0, gone =3D 1, original_len =3D path->len, =
len;
>> +     int saved_errno;
>>       struct string_list dels =3D STRING_LIST_INIT_DUP;
>>
>>       *dir_gone =3D 1;
>> @@ -173,9 +174,11 @@ static int remove_dirs(struct strbuf *path, const c=
har *prefix, int force_flag,
>>       if (!dir) {
>>               /* an empty dir could be removed even if it is unreadble *=
/
>>               res =3D dry_run ? 0 : rmdir(path->buf);
>> +             saved_errno =3D errno;
>>               if (res) {
>>                       quote_path_relative(path->buf, prefix, &quoted);
>
> I think this part should be more like
>
>                 res =3D ... : rmdir(...);
>                 if (res) {
>                         int saved_errno =3D errno;
>                         ... do other things that can touch errno ...
>                         errno =3D saved_errno;
>                         ... now we know what the original error was ...
>
> The reason to store the errno in saved_errno here is not because we
> want to help code after "if (res) {...}", but the patch sent as-is
> gives that impression and is confusing to the readers.
>
> Perhaps all hunks of this patch share the same issue?  I could
> locally amend, of course, but I'd like to double check before doing
> so myself---perhaps you did it this way for a good reason that I am
> missing?

One thing I like about putting saved_errno right next to the related
syscall is, the syscall is visible from the diff (previously some are
out of context). This is really minor though. I briefly thought of
introducing rmdir_errno() and friends that return -errno on error, so
we could do

res =3D ... : rmdir_errno(..);
if (res) {
    errno =3D -res;
    warning_errno(...);
}

But that's more work and the errno =3D -res is not particularly pleasing
to read. I'm fine with moving saved_errno in the error handling
blocks.
--=20
Duy
