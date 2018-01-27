Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 201FC1F404
	for <e@80x24.org>; Sat, 27 Jan 2018 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeA0A2a (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 19:28:30 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:38613 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751363AbeA0A23 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 19:28:29 -0500
Received: by mail-wr0-f181.google.com with SMTP id a1so1916640wri.5
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 16:28:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:user-agent:date:message-id:mime-version;
        bh=9ttK5S3jfgGAvZrCkS2KrRVzRXp1+I/AoLCUPSCq6qs=;
        b=FYsWpG2CpiqL+C+k61xStBPGKW/TPY9dHkiue9ho7ck3FIx9+QifFDpBUrHkKBCTld
         KTIX70TX7nVA4T0TZpxQ6Wei8DaNOFtIT+wKxxNlu+STKit9EWN6c+gtTJ8vwGPyKlZ4
         K5ZvkD+0U5HPJJ+//Sl/A8q7AO/+LwQ9KqAZ2lt4c2skfSYw5l4h9nDSyxm9uQ0w4qP5
         S9CwLjyng3cnMUrxJ4RlhV/uTyl/yD2WcDTdBHN1lRWTgFEsSr6f6D8AejzcMJhfk+mJ
         tsIs2CnU61pUBX0B8J9H4PvalnahIuPrdagaqN6thnnyhLgcV6eMFVd4uvQVV3+d7Sko
         5Y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:user-agent:date:message-id
         :mime-version;
        bh=9ttK5S3jfgGAvZrCkS2KrRVzRXp1+I/AoLCUPSCq6qs=;
        b=tPuyAY8Zfg9aJMFxr90KKtp7iXs0/WKiyoYextznK9NyKWdlf6f9CIk4Xkzh32j+di
         cczGa9wEZaOmQ2/3YHiJj1ivD8xCkkELmiISL97CeTEFHPfTVDgRbB3FhnI6Y0brDLa5
         9jHZ4NM2TCV0ASUJS35NgDnXTsyxbiw0/I+Ppmu2Fa8SMFu4JTFOR+dtzNahYtbNCmaP
         c/SfLXXfMvX/8GlGi789g7vjUpZ7RPmIkFhLs+vtmvmjhOTTHtkVHSAVhGZoyGcnozTM
         4hG7CmGxFgma8l+YAxecEAgg3GZyjQ4mpmHy9chkZmfxtz56DIElVt16sx99lFBnU0Oj
         ugTQ==
X-Gm-Message-State: AKwxytfDWueg/6NMuhzBiUxY9NvkV402SNdWv5q0+B5mQziSZr7JntCo
        0rXdL2uNyUqAgrvj6vVrRxqwxey+
X-Google-Smtp-Source: AH8x225hQ4YgAEL1ZmEI8xXD1BAfU0ZPIInM23DxHKiYYx7fyK7EnzDkhS1VdytkcNM2Cb0XoOnZ1g==
X-Received: by 10.223.186.77 with SMTP id t13mr14082763wrg.89.1517012907235;
        Fri, 26 Jan 2018 16:28:27 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id z81sm4300367wmc.32.2018.01.26.16.28.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jan 2018 16:28:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git <git@vger.kernel.org>
Cc:     Ben Peart <benpeart@microsoft.com>,
        Alex Vandiver <alexmv@dropbox.com>,
        Christian Couder <christian.couder@gmail.com>,
        David Turner <dturner@twopensource.com>
Subject: Some rough edges of core.fsmonitor
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.0-alpha3
Date:   Sat, 27 Jan 2018 01:28:25 +0100
Message-ID: <87efmcw3fa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I just got around to testing this since it landed, for context some
previous poking of mine in [1].

Issues / stuff I've noticed:

1) We end up invalidating the untracked cache because stuff in .git/
changed. For example:

    01:09:24.975524 fsmonitor.c:173         fsmonitor process '.git/hooks/fsmonitor-watchman' returned success
    01:09:24.975548 fsmonitor.c:138         fsmonitor_refresh_callback '.git'
    01:09:24.975556 fsmonitor.c:138         fsmonitor_refresh_callback '.git/config'
    01:09:24.975568 fsmonitor.c:138         fsmonitor_refresh_callback '.git/index'
    01:09:25.122726 fsmonitor.c:91          write fsmonitor extension successful

Am I missing something or should we do something like:

    diff --git a/fsmonitor.c b/fsmonitor.c
    index 0af7c4edba..5067b89bda 100644
    --- a/fsmonitor.c
    +++ b/fsmonitor.c
    @@ -118,7 +118,12 @@ static int query_fsmonitor(int version, uint64_t last_update, struct strbuf *que

     static void fsmonitor_refresh_callback(struct index_state *istate, const char *name)
     {
    -       int pos = index_name_pos(istate, name, strlen(name));
    +       int pos;
    +
    +       if (!strcmp(name, ".git") || starts_with(name, ".git/"))
    +               return;
    +
    +       pos = index_name_pos(istate, name, strlen(name));

            if (pos >= 0) {
                    struct cache_entry *ce = istate->cache[pos];

With that patch applied status on a large repo[2] goes from a consistent
~180-200ms to ~140-150ms, since we're not invalidating some of the UC
structure

2) We re-write out the index even though we know nothing changed

When you first run with core.fsmonitor it needs to
mark_fsmonitor_clean() for every path, but is there a reason for why we
wouldn't supply the equivalent of GIT_OPTIONAL_LOCKS=0 if all paths are
marked and we know from the hook that nothing changed? Why write out the
index again?

3) A lot of time spend reading the index (or something..)

While the hook itself takes ~20ms (and watchman itself 1/4 of that)
status as a whole takes much longer. gprof reveals:

    Each sample counts as 0.01 seconds.
      %   cumulative   self              self     total
     time   seconds   seconds    calls  ms/call  ms/call  name
     15.38      0.02     0.02   221690     0.00     0.00  memihash
     15.38      0.04     0.02   221689     0.00     0.00  create_from_disk
      7.69      0.05     0.01  2216897     0.00     0.00  git_bswap32
      7.69      0.06     0.01   222661     0.00     0.00  ce_path_match
      7.69      0.07     0.01   221769     0.00     0.00  hashmap_add
      7.69      0.08     0.01    39941     0.00     0.00  prep_exclude
      7.69      0.09     0.01    39940     0.00     0.00  strbuf_addch
      7.69      0.10     0.01        1    10.00    10.00  read_one
      7.69      0.11     0.01        1    10.00    10.00  refresh_index
      7.69      0.12     0.01        1    10.00    10.00  tweak_fsmonitor
      7.69      0.13     0.01                             preload_thread

The index is 24M in this case, I guess it's unpacking it, but I wonder
if this couldn't be much faster if we saved away the result of the last
"status" in something that's quick to access, and then if nothing
changed we just report that, and no need to re-write the index (or just
write the "it was clean at this time" part).

4) core.fsmonitor=false behaves unexpectedly

The code that reads this variable just treats it as a string, so we do a
bunch of work for nothing (and nothing warns) if this is set and 'false'
is executed. Any reason we couldn't do our standard boolean parsing
here? You couldn't call your hook 0/1/true/false, but that doesn't seem
like a big loss.

1. https://public-inbox.org/git/CACBZZX5a6Op7dH_g9WOFBnejh2zgNK4b34ygxA8daNDqvitFVA@mail.gmail.com/
2. https://github.com/avar/2015-04-03-1M-git
