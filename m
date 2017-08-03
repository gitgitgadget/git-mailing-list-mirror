Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB75E2047F
	for <e@80x24.org>; Thu,  3 Aug 2017 07:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751140AbdHCHql (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 03:46:41 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33400 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdHCHqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 03:46:40 -0400
Received: by mail-qk0-f171.google.com with SMTP id a77so3291173qkb.0
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 00:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VmpQysL96LhiJ+bSBZv17yKHEOW63Ski3lbBuuTKL/Q=;
        b=ND29tEGCQwdRZPrHtqd6n1YBwZ5Vbo/tlMjo/3W1H5ar9f1BZmab7GSObGj87ySnH6
         6h01Our2eaEcCfdl+4TYFtGyh/FTAsCp4R3AAvi4axkH8R4EPQ9VcG4zEdLbya+GWQe7
         HumBZ7cFrDCNXIqpcPQj5kCahyC6GUPAVJ/BwFj5LFDRd6Yupq1eD936pBJxutJPs4Fs
         6+selip7PT/yF6Oua9htnRP168dN/PbHbcehNsh7cUZ9ZgVrG618NuGengnmt9gpU98L
         bgaVLEaRSL1PuRnscruDSl1SBgY+g8qsUqAEXHFwi92Mzf5hJzFtmD3Pt7Mf3gd9snPU
         G9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VmpQysL96LhiJ+bSBZv17yKHEOW63Ski3lbBuuTKL/Q=;
        b=KVX5VjpG4OwtSrC27ESZN1gvBaCDzhVQAi8iTKpZ2k5dgeVzfhB+pPifCkqyXm0A+O
         YZh3dKOhQ3rWbArQIE0YWVItvWF/bZAKssEBrHOWegW92n+kVnCiBdCtfddFhgxWpBSw
         ZCjqDAh1v84qSPFzrdXX/B0aHMz6DRHRI33bdHqjLUNqDd6BXHERG/TuyJLfwkaKvVyO
         lb0qiKplmkqGgauZmyHC64ubfQS32vWicoAqd+5juLeyTXoqc6v18Gv+Pa6ATtmy5GuK
         67eVmka1lAD3wrCM1wvbEahuhuMUeQ9F8ExbuP/Olo9P/nVGrp8JkI5Nt/MPnmXg7DyY
         aCAg==
X-Gm-Message-State: AHYfb5gzlFBnN1yAfO1xc0PvzRiMCXx+Qmdrtcx8IzIQ0fK7Z6GsXY1o
        kkqhVJ9oBpMLq1ZuCpyK1AGtrL3tgw==
X-Received: by 10.55.71.76 with SMTP id u73mr1329134qka.25.1501746399455; Thu,
 03 Aug 2017 00:46:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.13 with HTTP; Thu, 3 Aug 2017 00:46:38 -0700 (PDT)
In-Reply-To: <xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
 <20161130210420.15982-2-chriscool@tuxfamily.org> <xmqqmvggbl6m.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 3 Aug 2017 09:46:38 +0200
Message-ID: <CAP8UFD0ecFW2Sk0fr3ysAXPERNp1RiBMqZMTjYxgt_mvtY-kaw@mail.gmail.com>
Subject: Re: [RFC/PATCH v3 01/16] Add initial external odb support
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(I realized that I didn't answer this email about the v3 version.
Sorry about this late answer.)

On Thu, Dec 1, 2016 at 12:30 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> From: Jeff King <peff@peff.net>
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>
> By the time the series loses RFC prefix, we'd need to see the above
> three lines straightened out a bit more, e.g. a real message and a
> more proper sign-off sequence.

Yeah, it is better in the v5 series I will send really soon now.

>> +static struct odb_helper *find_or_create_helper(const char *name, int len)
>> +{
>> +     struct odb_helper *o;
>> +
>> +     for (o = helpers; o; o = o->next)
>> +             if (!strncmp(o->name, name, len) && !o->name[len])
>> +                     return o;
>> +
>> +     o = odb_helper_new(name, len);
>> +     *helpers_tail = o;
>> +     helpers_tail = &o->next;
>> +
>> +     return o;
>> +}
>> +
>> +static int external_odb_config(const char *var, const char *value, void *data)
>> +{
>> +     struct odb_helper *o;
>> +     const char *key, *dot;
>> +
>> +     if (!skip_prefix(var, "odb.", &key))
>> +             return 0;
>> +     dot = strrchr(key, '.');
>> +     if (!dot)
>> +             return 0;
>
> Is this something Peff wrote long time ago?  I find it surprising
> that he would write this without using parse_config_key().

parse_config_key() is used now.

>> +struct odb_helper_cmd {
>> +     struct argv_array argv;
>> +     struct child_process child;
>> +};
>> +
>> +static void prepare_helper_command(struct argv_array *argv, const char *cmd,
>> +                                const char *fmt, va_list ap)
>> +{
>> +     struct strbuf buf = STRBUF_INIT;
>> +
>> +     strbuf_addstr(&buf, cmd);
>> +     strbuf_addch(&buf, ' ');
>> +     strbuf_vaddf(&buf, fmt, ap);
>> +
>> +     argv_array_push(argv, buf.buf);
>> +     strbuf_release(&buf);
>
> This concatenates the cmdname (like "get") and its parameters into a
> single string (e.g. "get 454cb6bd52a4de614a3633e4f547af03d5c3b640")
> and then places the resulting string as the sole element in argv[]
> array, which I find somewhat unusual.  It at least deserves a
> comment in front of the function that the callers are responsible to
> ensure that the result of vaddf(fmt, ap) is properly shell-quoted.

I added a comment.

> Otherwise it is inviting quoting errors in the future (even if there
> is no such errors in the current code and command set, i.e. a 40-hex
> object name that "get" subcommand takes happens to require no
> special shell-quoting consideration).

Yeah, but I am not sure how this could be done better.

>> +int odb_helper_fetch_object(struct odb_helper *o, const unsigned char *sha1,
>> +                         int fd)
>> +{
>> +     struct odb_helper_object *obj;
>> +     struct odb_helper_cmd cmd;
>> +     unsigned long total_got;
>> +     git_zstream stream;
>> +     int zret = Z_STREAM_END;
>> +     git_SHA_CTX hash;
>> +     unsigned char real_sha1[20];
>> +
>> +     obj = odb_helper_lookup(o, sha1);
>> +     if (!obj)
>> +             return -1;
>> +
>> +     if (odb_helper_start(o, &cmd, "get %s", sha1_to_hex(sha1)) < 0)
>> +             return -1;
>> +
>> +     memset(&stream, 0, sizeof(stream));
>> +     git_inflate_init(&stream);
>> +     git_SHA1_Init(&hash);
>> +     total_got = 0;
>> +
>> +     for (;;) {
>> +             unsigned char buf[4096];
>> +             int r;
>> +
>> +             r = xread(cmd.child.out, buf, sizeof(buf));
>> +             if (r < 0) {
>> +                     error("unable to read from odb helper '%s': %s",
>> +                           o->name, strerror(errno));
>> +                     close(cmd.child.out);
>> +                     odb_helper_finish(o, &cmd);
>> +                     git_inflate_end(&stream);
>> +                     return -1;
>> +             }
>> +             if (r == 0)
>> +                     break;
>> +
>> +             write_or_die(fd, buf, r);
>> +
>> +             stream.next_in = buf;
>> +             stream.avail_in = r;
>> +             do {
>> +                     unsigned char inflated[4096];
>> +                     unsigned long got;
>> +
>> +                     stream.next_out = inflated;
>> +                     stream.avail_out = sizeof(inflated);
>> +                     zret = git_inflate(&stream, Z_SYNC_FLUSH);
>> +                     got = sizeof(inflated) - stream.avail_out;
>> +
>> +                     git_SHA1_Update(&hash, inflated, got);
>> +                     /* skip header when counting size */
>> +                     if (!total_got) {
>> +                             const unsigned char *p = memchr(inflated, '\0', got);
>
> Does this assume that a single xread() that can result in a
> short-read would not return in the middle of "header", and if so, is
> that a safe assumption to make?

I am not sure what would go wrong in case of a short read.
My guess is that as long as we test that p is not NULL below we should be fine.
As Peff wrote this code, he could probably answer much better than me.

>> +                             if (p)
>> +                                     got -= p - inflated + 1;
>> +                             else
>> +                                     got = 0;
>> +                     }
>> +                     total_got += got;
>> +             } while (stream.avail_in && zret == Z_OK);
>> +     }
>> +
>> +     close(cmd.child.out);
>> +     git_inflate_end(&stream);
>> +     git_SHA1_Final(real_sha1, &hash);
>> +     if (odb_helper_finish(o, &cmd))
>> +             return -1;
>> +     if (zret != Z_STREAM_END) {
>> +             warning("bad zlib data from odb helper '%s' for %s",
>> +                     o->name, sha1_to_hex(sha1));
>> +             return -1;
>> +     }
>> +     if (total_got != obj->size) {
>> +             warning("size mismatch from odb helper '%s' for %s (%lu != %lu)",
>> +                     o->name, sha1_to_hex(sha1), total_got, obj->size);
>> +             return -1;
>> +     }
>> +     if (hashcmp(real_sha1, sha1)) {
>> +             warning("sha1 mismatch from odb helper '%s' for %s (got %s)",
>> +                     o->name, sha1_to_hex(sha1), sha1_to_hex(real_sha1));
>> +             return -1;
>> +     }
>> +
>> +     return 0;
>> +}
>
> OK.  So we call the external helper with "get" command, expecting
> that the helper returns the data as a zlib deflated stream, and
> validate that the data matches the expected hash and the expected
> size, while also saving the contents of the deflated stream to fd.
> Presumably the caller opened a fd to write into a loose object?  I
> do not see this code actually validating that the loose object
> header, i.e. "<type> <len>\0", matches what the caller wanted to see
> in obj->size and obj->type.  Shouldn't there be a check for that,
> too?

Yeah, it would be better with a check. It also looks like checking
that must take into account possible short-read that could happen (as
discussed above), so for now I will see if we need to fix the header
reading, before taking a look at this.

> I am tempted to debate myself if it is a sensible design to require
> "get" to return a loose object representation, but cannot decide
> without seeing the remainder of the series.  An obvious alternative
> is to define the "get" request to interface with us via the raw
> contents (not even deflated) and leave the deflating to us, i.e. Git
> sitting on the receiving end, which would allow us to choose to
> store it differently (e.g. we may want to try streaming it into its
> own pack using the streaming.h API, for example).

There is now both a get_raw_obj and a get_git_obj to handle both cases.
