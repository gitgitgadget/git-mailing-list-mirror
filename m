Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F2E201A0
	for <e@80x24.org>; Mon,  3 Jul 2017 21:25:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdGCVZh (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jul 2017 17:25:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:33167 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752406AbdGCVZg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jul 2017 17:25:36 -0400
Received: by mail-qt0-f196.google.com with SMTP id c20so24925068qte.0
        for <git@vger.kernel.org>; Mon, 03 Jul 2017 14:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=und6Fyu6rC/BVcQINPiQ1GlvslVkxiXBQD7CmQElhNI=;
        b=u434WSf7gRdGWXZELlUzCv3TME1R1VFTP09Coz5gJmPqKsuJgr8CTViUYzzv7OZgm8
         Wujg77uDMLWaZKWJFkCw8LQ5JEMTwxruk7tqHHM+uRTYxKq+CXM3By3p+kmNVJ0bz95I
         wG2GCZcGStZTqnHKkEjng4HJZxouU2Us2z1VtSjwT7BrzsE16Hw79GrpYzW1xnhN8B/e
         k4MEHmaxgiI5eXtV30GDJse79ZEP8YNlo8FY0w8hLclxzhVSOJPP5KNOvrOj095yPHJ6
         mIDp0bXKttT1tmhzzP/IZTLHNfb9SVTMg8Uh4KN44bxfZ5yzEhqDALhAXMmkW/HOUbYG
         +YIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=und6Fyu6rC/BVcQINPiQ1GlvslVkxiXBQD7CmQElhNI=;
        b=r4omwUsuOjN04jSlMU2Uvi8jUk+qPNcJEsFXs/5nScr8hC2ibYXV4lhN+F+3Wdx+TM
         zXbp7k0h8ijWLXFkM4nwrt+mv9NY271vwihsA6QJ+xuJzoBbWWX3l9lu3m2JcZK55t1h
         HRd32zMjX3p8Kwz2tl3pmXejviPlK72LZrHC/M+lDa6dEGEjegSSDSjjD8+7IFC6jKyZ
         3vwU9npr5DKBYzZQOR+hklKcxlWKlr5bap/kWX5He2G4ZNe3IFNhtJHtJpXf+xSZb1VI
         Q+BvmU9r+uHN+/lNstgzqfyQCXweYeFMN4bE+Qkd13Hyd4aGA93EqILcK9R5/gjPFR8F
         9DXQ==
X-Gm-Message-State: AKS2vOxaRPo6uKk3VsHANUWuMAu4x0wFHDSZcC5oE7L8o3NjeYLWgEjx
        P4mSM81BPSvpFQ==
X-Received: by 10.237.37.193 with SMTP id y1mr43494776qtc.140.1499117135019;
        Mon, 03 Jul 2017 14:25:35 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id d44sm14336300qta.55.2017.07.03.14.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jul 2017 14:25:34 -0700 (PDT)
Subject: Re: [PATCH v5 3/7] fsmonitor: teach git to optionally utilize a file
 system monitor to speed up detecting new or changed files.
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170610134026.104552-4-benpeart@microsoft.com>
 <CAP8UFD1kL9i93HnnigYcB9U8u2dUijHj5djey5k=33VrFaWUBw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6b05b590-2fda-31e4-e07e-bda10f510cc4@gmail.com>
Date:   Mon, 3 Jul 2017 17:25:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <CAP8UFD1kL9i93HnnigYcB9U8u2dUijHj5djey5k=33VrFaWUBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/27/2017 11:43 AM, Christian Couder wrote:
> On Sat, Jun 10, 2017 at 3:40 PM, Ben Peart <peartben@gmail.com> wrote:
> 
>> +int read_fsmonitor_extension(struct index_state *istate, const void *data,
>> +       unsigned long sz)
>> +{
>> +       const char *index = data;
>> +       uint32_t hdr_version;
>> +       uint32_t ewah_size;
>> +       int ret;
>> +
>> +       if (sz < sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t))
>> +               return error("corrupt fsmonitor extension (too short)");
>> +
>> +       hdr_version = get_be32(index);
> 
> Here we use get_be32(), ...
> 
>> +       index += sizeof(uint32_t);
>> +       if (hdr_version != INDEX_EXTENSION_VERSION)
>> +               return error("bad fsmonitor version %d", hdr_version);
>> +
>> +       istate->fsmonitor_last_update = get_be64(index);
> 
> ...get_be64(), ...
> 
>> +       index += sizeof(uint64_t);
>> +
>> +       ewah_size = get_be32(index);
> 
> ... and get_be32 again, ...
> 
>> +       index += sizeof(uint32_t);
>> +
>> +       istate->fsmonitor_dirty = ewah_new();
>> +       ret = ewah_read_mmap(istate->fsmonitor_dirty, index, ewah_size);
>> +       if (ret != ewah_size) {
>> +               ewah_free(istate->fsmonitor_dirty);
>> +               istate->fsmonitor_dirty = NULL;
>> +               return error("failed to parse ewah bitmap reading fsmonitor index extension");
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +void write_fsmonitor_extension(struct strbuf *sb, struct index_state *istate)
>> +{
>> +       uint32_t hdr_version;
>> +       uint64_t tm;
>> +       struct ewah_bitmap *bitmap;
>> +       int i;
>> +       uint32_t ewah_start;
>> +       uint32_t ewah_size = 0;
>> +       int fixup = 0;
>> +
>> +       hdr_version = htonl(INDEX_EXTENSION_VERSION);
> 
> ... but here we use htonl() instead of put_be32(), ...
> 
>> +       strbuf_add(sb, &hdr_version, sizeof(uint32_t));
>> +
>> +       tm = htonll((uint64_t)istate->fsmonitor_last_update);
> 
> ... htonll(), ...
> 
>> +       strbuf_add(sb, &tm, sizeof(uint64_t));
>> +       fixup = sb->len;
>> +       strbuf_add(sb, &ewah_size, sizeof(uint32_t)); /* we'll fix this up later */
>> +
>> +       ewah_start = sb->len;
>> +       bitmap = ewah_new();
>> +       for (i = 0; i < istate->cache_nr; i++)
>> +               if (istate->cache[i]->ce_flags & CE_FSMONITOR_DIRTY)
>> +                       ewah_set(bitmap, i);
>> +       ewah_serialize_strbuf(bitmap, sb);
>> +       ewah_free(bitmap);
>> +
>> +       /* fix up size field */
>> +       ewah_size = htonl(sb->len - ewah_start);
> 
> ... and htonl() again.
> 
> It would be more consistent (and perhaps more correct) to use
> put_beXX() functions, instead of the htonl() and htonll() functions.

I agree that these are asymmetric.  I followed the pattern used in the 
untracked cache in which write_untracked_extension uses htonl and 
read_untracked_extension uses get_be32. I can change this to be more 
symmetric.

> 
>> +       memcpy(sb->buf + fixup, &ewah_size, sizeof(uint32_t));
>> +}
> 
>> +/*
>> + * Call the query-fsmonitor hook passing the time of the last saved results.
>> + */
>> +static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *query_result)
>> +{
>> +       struct child_process cp = CHILD_PROCESS_INIT;
>> +       char ver[64];
>> +       char date[64];
>> +       const char *argv[4];
>> +
>> +       if (!(argv[0] = find_hook("query-fsmonitor")))
>> +               return -1;
>> +
>> +       snprintf(ver, sizeof(version), "%d", version);
>> +       snprintf(date, sizeof(date), "%" PRIuMAX, (uintmax_t)last_update);
>> +       argv[1] = ver;
>> +       argv[2] = date;
>> +       argv[3] = NULL;
>> +       cp.argv = argv;
> 
> Maybe it would be nicer using the argv_array_pushX() functions.

When the number of arguments is fixed and known, I prefer avoiding the 
dynamic allocations that come along with the argv_array_pushX() functions.

> 
>> +       cp.out = -1;
>> +
>> +       return capture_command(&cp, query_result, 1024);
>> +}
>> +
>> +static void mark_file_dirty(struct index_state *istate, const char *name)
>> +{
>> +       struct untracked_cache_dir *dir;
>> +       int pos;
>> +
>> +       /* find it in the index and mark that entry as dirty */
>> +       pos = index_name_pos(istate, name, strlen(name));
>> +       if (pos >= 0) {
>> +               if (!(istate->cache[pos]->ce_flags & CE_FSMONITOR_DIRTY)) {
>> +                       istate->cache[pos]->ce_flags |= CE_FSMONITOR_DIRTY;
>> +                       istate->cache_changed |= FSMONITOR_CHANGED;
>> +               }
>> +       }
>> +
>> +       /*
>> +        * Find the corresponding directory in the untracked cache
>> +        * and mark it as invalid
>> +        */
>> +       if (!istate->untracked || !istate->untracked->root)
>> +               return;
>> +
>> +       dir = find_untracked_cache_dir(istate->untracked, istate->untracked->root, name);
>> +       if (dir) {
>> +               if (dir->valid) {
>> +                       dir->valid = 0;
>> +                       istate->cache_changed |= FSMONITOR_CHANGED;
>> +               }
>> +       }
> 
> The code above is quite similar as what is in mark_fsmonitor_dirty(),
> so I wonder if a refactoring is possible.

I've felt the same way and looked at how to refactor it better a number 
of times but never came up with a way that made it simpler, clearer and 
easier to maintain.  I'm happy to review a patch if you can figure out 
something better. :)

> 
>> +}
>> +
>> +void refresh_by_fsmonitor(struct index_state *istate)
>> +{
>> +       static int has_run_once = 0;
>> +       struct strbuf query_result = STRBUF_INIT;
>> +       int query_success = 0;
>> +       size_t bol = 0; /* beginning of line */
>> +       uint64_t last_update;
>> +       char *buf, *entry;
>> +       int i;
>> +
>> +       if (!core_fsmonitor || has_run_once)
>> +               return;
>> +       has_run_once = 1;
>> +
>> +       /*
>> +        * This could be racy so save the date/time now and the hook
>> +        * should be inclusive to ensure we don't miss potential changes.
>> +        */
>> +       last_update = getnanotime();
>> +
>> +       /*
>> +        * If we have a last update time, call query-monitor for the set of
>> +        * changes since that time.
>> +        */
>> +       if (istate->fsmonitor_last_update) {
>> +               query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION,
>> +                       istate->fsmonitor_last_update, &query_result);
>> +               trace_performance_since(last_update, "query-fsmonitor");
>> +       }
>> +
>> +       if (query_success) {
>> +               /* Mark all entries returned by the monitor as dirty */
>> +               buf = entry = query_result.buf;
>> +               for (i = 0; i < query_result.len; i++) {
>> +                       if (buf[i] != '\0')
>> +                               continue;
>> +                       mark_file_dirty(istate, buf + bol);
> 
> It looks like bol is always equal to i here...
> 
>> +                       bol = i + 1;
>> +               }
>> +               if (bol < query_result.len)
>> +                       mark_file_dirty(istate, buf + bol);
> 
> ... and here too. As it is not used below, I wonder if you really need
> the bol variable.

bol saves the position of the beginning of the current line while i 
iterates through the remainder of the string looking for the NULL.

However, the entry variable is no longer used so I will remove it.

> 
>> +               /* Mark all clean entries up-to-date */
>> +               for (i = 0; i < istate->cache_nr; i++) {
>> +                       struct cache_entry *ce = istate->cache[i];
>> +                       if (ce_stage(ce) || (ce->ce_flags & CE_FSMONITOR_DIRTY))
>> +                               continue;
>> +                       ce_mark_uptodate(ce);
>> +               }
