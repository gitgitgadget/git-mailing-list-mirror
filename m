Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EF2091F404
	for <e@80x24.org>; Wed, 14 Mar 2018 02:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933056AbeCNC01 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 22:26:27 -0400
Received: from mail-qt0-f179.google.com ([209.85.216.179]:42866 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932809AbeCNC00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 22:26:26 -0400
Received: by mail-qt0-f179.google.com with SMTP id t6so1912736qtn.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 19:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=OO1d66+nmUpGN/5jjtNQh7Dbs7HlygPZGIzpD3GlwKs=;
        b=hUzXUDrCXGGQSNq1QACGPDLSdBQj08YLpcD025DZcsnFsdizbohU/8syJYjKKvv89j
         6ju+kqu/q3vgCn5cmFHHqIPLaPHzBFZnzrsLXJ7N7CrJjsBVPgNd8D1nK0d65Dox/5hm
         1MHIQz/LJhQG3XVpK1kIJ2PWmI3KhH36O8qQ88Ygwdi++2XBjzQPRkY9P30Q8dMuCQHC
         6HEULNpfmx2+X4Xq+2yU6Y+SHaUgHwE+IAxoEc/Hv7KIIds23CcnSBOrNLowrDHHiQmy
         inX5SrLCyWNOO2jZfBqyprRM8lsCbMvQKSdgTkSW/1AFKAlKyV767Lg6E0QSxS+Ch3nJ
         QGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=OO1d66+nmUpGN/5jjtNQh7Dbs7HlygPZGIzpD3GlwKs=;
        b=m33BdH7zMgvEuQfHYWManMrG9zKEQM19Kh3jRrDhOWzMEQ3/JfBCqdyFJipQQHyj3w
         xN4FxzhD9pYdMAJINQ09eKw6pfDEW1ss5IODi1hKa4XRN5l6EswIdB5xg7RMb8whBN3n
         LOE74g/4ySXWz2ExPywh3dlr2ruGPrQTl5mgI0+et1pnCCVP9/uAo+NwpjBL1oPjBf/s
         BOB7l3w9D9ftlWCiPBb7ASJ+sCBVd/e90GJsjfxv0zhgFymjYEL+3HBoxoO4ph4P0y0l
         6ny7qfB87oq4mwxiKzoSbMlZAautkutxYuYTa/t9MqcKVSKmEIB+3B8AzDg2YmFi3Dff
         b8cg==
X-Gm-Message-State: AElRT7FUqnPL/Tg1fab74sOoSWdypBIJ2mlqP+xvc+kn+QUDypGnG77Z
        taKyWL3rL8Zrg/E1dihjsHI=
X-Google-Smtp-Source: AG47ELsDV3W+WLMTcfev6FTlxjIjDnKjRU0+P1Yc0SDkEIIK9diuBsC6PkeBqGQ0Kv9HDLvNGVx1iA==
X-Received: by 10.237.32.66 with SMTP id 60mr4610008qta.332.1520994385357;
        Tue, 13 Mar 2018 19:26:25 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id o128sm812382qkf.57.2018.03.13.19.26.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 19:26:24 -0700 (PDT)
Subject: Re: [PATCH v5 04/13] csum-file: add CSUM_KEEP_OPEN flag
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        jonathantanmy@google.com, sbeller@google.com, szeder.dev@gmail.com,
        ramsay@ramsayjones.plus.com, Derrick Stolee <dstolee@microsoft.com>
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
 <1519698787-190494-5-git-send-email-dstolee@microsoft.com>
 <e1264d9a-9d6c-b294-6d56-46382a28b280@gmail.com>
 <xmqqsh931wl1.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9d491d74-87e5-e6b7-362f-c5f166b3ea35@gmail.com>
Date:   Tue, 13 Mar 2018 22:26:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqsh931wl1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/13/2018 5:42 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> On 2/26/2018 9:32 PM, Derrick Stolee wrote:
>>> This patch is new to the series due to the interactions with the lockfile API
>>> and the hashfile API. I need to ensure the hashfile writes the hash value at
>>> the end of the file, but keep the file descriptor open so the lock is valid.
>>>
>>> I welcome any susggestions to this patch or to the way I use it in the commit
>>> that follows.
>>>
>>> -- >8 --
>> I haven't gotten any feedback on this step of the patch. Could someone
>> take a look and let me know what you think?

Let me just say that I appreciate the level of detail you provided in 
answering this question. The discussion below is very illuminating.

> Let's follow the commit-graph writing codepath to see what happens:
>
> 	fd = hold_lock_file_for_update(&lk, graph_name, 0);
> 	...
> 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
>
> The caller creates a lockfile, and then wraps its file descriptor in
> a hashfile.
>
> 	hashwrite_be32(f, GRAPH_SIGNATURE);
> 	...
>
> Then it goes on writing to the hashfile, growing the lockfile.
>
>          ...
> 	write_graph_chunk_large_edges(f, commits.list, commits.nr);
>
> 	close_commit_graph();
>
> And after writing all data out (oh by the way, why aren't we passing
> commit_graph instance around and instead relying on a file-scope
> static global?)...

Yeah, we should remove the global dependence. Is this a blocker for the 
series?

After this lands, I plan to add a one-commit patch that moves all global 
"commit_graph" state to the_repository in the spirit of Stefan's 
patches. For now, this is equivalent to "close_all_packs()".

> 	hashclose(f, final_hash, CSUM_CLOSE | CSUM_FSYNC | CSUM_KEEP_OPEN);
>
> We ask for the final hash value to be written to the file (and also
> returned to us---although you do not seem to use that at all).  See
> a comment on this, though, at the end.

I'm not using the final_hash anymore, since we are using the 
"$GIT_DIR/objects/info/commit-graph" filename always. If we make the 
file incremental, then we can use "final_hash" to name the split files. 
For now, I'll remove final_hash in favor of NULL.

> 	commit_lock_file(&lk);
>
> And then, we put the lockfile to its final place, while closing its
> file descriptor.
>
> The overall API sounds sensible, from the above.
>
> However.
>
> The function whose name is hashclose() that takes a flag word whose
> possible bit value includes "Please close this thing" feels strange
> enough (does it mean the hashclose() function does not close it if
> CSUM_CLOSE is not given?), but adding another to the mix that lets
> us say "Please close this (with or without FSYNC), oh by the way
> please leave it open" feels a bit borderline to insanity.
>
> I _think_ the word "close" in the name hashclose() is about closing
> the (virtual) stream for the hashing that is overlayed on top of the
> underlying file descriptor, and being able to choose between closing
> and not closing the underlying file descriptor when "closing" the
> hashing layer sort of makes sense.  So I won't complain too much
> about hashclose() that takes optional CSUM_CLOSE flag.

I agree this "close" word is incorrect. We really want 
"finalize_hashfile()" which may include closing the file.

> But then what does it mean to give KEEP_OPEN and CLOSE together?

This should have been a red flag that something was wrong.

> The new caller (which is the only one that wants the nominally
> nonsensical CLOSE|KEEP_OPEN combination, which is shown above) wants
> the final checksum of the data sent over the (virtual) stream
> computed and written, and the file descriptor fsync'ed, but the file
> descriptor kept open.  As we _DO_ want to keep the verbs in flags
> CSUM_CLOSE and CSUM_FSYNC to be about the underlying file
> descriptor, I think your new code for KEEP_OPEN that is inside the
> if() block that is for CSUM_CLOSE is an ugly hack, and your asking
> for improvements is very much appreciated.
>
> Let's step back and see what different behaviours the existing code
> wants to support before your patch:
>
>      - hashclose() is always about finializing the hash computation
>        over the data sent through the struct hashfile (i.e. the
>        virtual stream opened by hashfd()).  The optional *result can
>        be used to receive this hash value, even when the caller does
>        not want to write that hash value to the output stream.
>
>      - when CSUM_CLOSE is given, however, the hash value is written
>        out as the trailing record to the output stream and the stream
>        is closed.  CSUM_FSYNC can instead be used to ensure that the
>        data hits the disk platter when the output stream is closed.
>
>      - when CSUM_CLOSE nor CSUM_FSYNC is not given, hash value is not
>        written to the output stream (the caller takes responsibility
>        of using *result), and the output stream is left open.
>
> I think the first mistake in the existing code is to associate
> "close the underlying stream" and "write the hash out to the
> underlying stream" more closely than it should.  It should be
> possible to "close the underlying steam" without first writing the
> hash out to the underlying stream", and vice versa.
>
> IOW, I think
>
>          hashclose() {
>                  hashflush();
>                  the_hash_algo->final_fn();
>                  if (result)
>                          hashcpy(result, f->buffer);
>          +       if (flags & CSUM_HASH_IN_STREAM)
>          +               flush(f, f->buffer, the_hash_algo->rawsz);
>          +       if (flags & CSUM_FSYNC)
>          +               fsync_or_die();
>                  if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
>          -               flush();
>          -               if (flags & CSUM_FSYNC)
>          -                       fsync_or_die();
>                          if (close(f->fd))
>                                  die_errno();
>                          fd = 0;
>                  } else
>                          fd = f->fd;
>                  if (0 <= f->check_fd) {
>                          ...
>                  }
>                  free(f);
>                  return fd;
>          }
>
> with would be a good first "preliminary preparation" step.
>
> Existing callers that pass CSUM_FSYNC or CSUM_CLOSE now need to also
> say "I want the resulting hash in the output stream", but that
> allows your later caller to omit CSUM_CLOSE and then ask for
> HASH_IN_STREAM alone.
>
> Existing callers can expect that FSYNC alone means fsync and close,
> but your caller wants hashclose() to compute the hash, write the hash
> to the output stream, and fsync the output stream, and return
> without closing the output stream.  For that, you'd make FSYNC not
> to imply CLOSE, and you'd need to vet all the existing callers that
> use FSYNC are OK with such a change.  And then the above would
> become
>
>          hashclose() {
>                  hashflush();
>                  the_hash_algo->final_fn();
>                  if (result)
>                          hashcpy(result, f->buffer);
>                  if (flags & CSUM_HASH_IN_STREAM)
>                          flush(f, f->buffer, the_hash_algo->rawsz);
>                  if (flags & CSUM_FSYNC)
>                          fsync_or_die();
>                  if (flags & CSUM_CLOSE) {
>                          if (close(f->fd))
>                                  die_errno();
>                          fd = 0;
>                  } else
>                          fd = f->fd;
>                  if (0 <= f->check_fd) {
>                          ...
>                  }
>                  free(f);
>                  return fd;
>          }
>
> Once we reach that state, the new caller in write_commit_graph()
> does not have to pass nonsensical CLOSE|KEEP_OPEN combination.
> Instead we can do
>
> 	hashclose(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC);
>
> or something like that, I would think, without having KEEP_OPEN.

My new solution works this way. The only caveat is that existing callers 
end up with this diff:

- hashclose(f, _, CSUM_FSYNC);
+ hashclose(f, _, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);

Perhaps this is acceptable, as it is very clear about what will happen. 
It is easy to recognize that in the existing implementation, CSUM_FSYNC 
implies CSUM_CLOSE which further implies CSUM_HASH_IN_STREAM.

> I am actually wondering if it is worth making CSUM_FSYNC not imply
> CSUM_CLOSE.  There aren't that many existing callers of hashclose()
> that uses FSYNC, so vetting all of them and replacing their FSYNC
> with (FSYNC|CLOSE) is not all that difficult, but if this new caller
> is an oddball then another strategy may be to do the fsync_or_die()
> on the caller side, something like:
>
>                  hashclose(f, NULL, CSUM_HASH_IN_STREAM);
>          +       fsync_or_die(fd, get_lock_file_path(&lk));
>                  commit_lock_file(&lk);
>
> And then we can keep the "FSYNC means fsync and then close" the
> current set of callers rely on.  I dunno if that is a major issue,
> but I do think "close this, or no, keep it open" is far worse than
> "do we want the resulting hash in the stream?"

I'm not happy with this solution of needing an extra call like this 
in-between, especially since hashclose() knows how to FSYNC.

> An alternative design of the above is without making
> CSUM_HASH_IN_STREAM a new flag bit.  I highly suspect that the
> calling codepath _knows_ whether the resulting final hash will be
> written out at the end of the stream or not when it wraps an fd with
> a hashfile structure, so "struct hashfile" could gain a bit to tell
> hashclose() whether the resulting hash need to be written (or not).
> That would be a bit larger change than what I outlined above, and I
> do not know if it is worth doing, though.

This certainly seems trickier to get right, but if we think it is the 
right solution I'll spend the time pairing struct creations with stream 
closings. At the moment, I'm not sure what to do with the following 
snippet from builtin/pack-objects.c that uses different flags (including 
0) depending on the situation:

         /*
          * Did we write the wrong # entries in the header?
          * If so, rewrite it like in fast-import
          */
         if (pack_to_stdout) {
             hashclose(f, oid.hash, CSUM_CLOSE);
         } else if (nr_written == nr_remaining) {
             hashclose(f, oid.hash, CSUM_FSYNC);
         } else {
             int fd = hashclose(f, oid.hash, 0);

It may be solvable if I dig a bit deeper than I have so far.

Below is my attempt at making the proposed change concrete, including 
adding flags to all existing callers to preserve behavior.

-- >8 --

 From 976ff3902f8a5a1b0132a4032a4000bb330737f7 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <dstolee@microsoft.com>
Date: Mon, 26 Feb 2018 14:45:44 -0500
Subject: [PATCH] csum-file: refactor hashclose() method

If we want to use a hashfile on the temporary file for a lockfile, then
we need hashclose() to fully write the trailing hash but also keep the
file descriptor open.

Do this by adding a new CSUM_HASH_IN_STREAM flag along with a functional
change that checks this flag before writing the checksum to the stream.
This differs from previous behavior since it would be written if either
CSUM_CLOSE or CSUM_FSYNC is provided.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
  builtin/pack-objects.c | 4 ++--
  bulk-checkin.c         | 2 +-
  csum-file.c            | 8 ++++----
  csum-file.h            | 5 +++--
  pack-bitmap-write.c    | 2 +-
  pack-write.c           | 5 +++--
  6 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index a197926eaa..530ddd0677 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -837,9 +837,9 @@ static void write_pack_file(void)
                  * If so, rewrite it like in fast-import
                  */
                 if (pack_to_stdout) {
-                       hashclose(f, oid.hash, CSUM_CLOSE);
+                       hashclose(f, oid.hash, CSUM_HASH_IN_STREAM | 
CSUM_CLOSE);
                 } else if (nr_written == nr_remaining) {
-                       hashclose(f, oid.hash, CSUM_FSYNC);
+                       hashclose(f, oid.hash, CSUM_HASH_IN_STREAM | 
CSUM_FSYNC | CSUM_CLOSE);
                 } else {
                         int fd = hashclose(f, oid.hash, 0);
                         fixup_pack_header_footer(fd, oid.hash, 
pack_tmp_name,
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 9d87eac07b..8108bacc79 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -35,7 +35,7 @@ static void finish_bulk_checkin(struct 
bulk_checkin_state *state)
                 unlink(state->pack_tmp_name);
                 goto clear_exit;
         } else if (state->nr_written == 1) {
-               hashclose(state->f, oid.hash, CSUM_FSYNC);
+               hashclose(state->f, oid.hash, CSUM_HASH_IN_STREAM | 
CSUM_FSYNC | CSUM_CLOSE);
         } else {
                 int fd = hashclose(state->f, oid.hash, 0);
                 fixup_pack_header_footer(fd, oid.hash, 
state->pack_tmp_name,
diff --git a/csum-file.c b/csum-file.c
index 5eda7fb6af..735cd2d3d5 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -61,11 +61,11 @@ int hashclose(struct hashfile *f, unsigned char 
*result, unsigned int flags)
         the_hash_algo->final_fn(f->buffer, &f->ctx);
         if (result)
                 hashcpy(result, f->buffer);
-       if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
-               /* write checksum and close fd */
+       if (flags & CSUM_HASH_IN_STREAM)
                 flush(f, f->buffer, the_hash_algo->rawsz);
-               if (flags & CSUM_FSYNC)
-                       fsync_or_die(f->fd, f->name);
+       if (flags & CSUM_FSYNC)
+               fsync_or_die(f->fd, f->name);
+       if (flags & CSUM_CLOSE) {
                 if (close(f->fd))
                         die_errno("%s: sha1 file error on close", f->name);
                 fd = 0;
diff --git a/csum-file.h b/csum-file.h
index 992e5c0141..a5790ca266 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -27,8 +27,9 @@ extern void hashfile_checkpoint(struct hashfile *, 
struct hashfile_checkpoint *)
  extern int hashfile_truncate(struct hashfile *, struct 
hashfile_checkpoint *);

  /* hashclose flags */
-#define CSUM_CLOSE     1
-#define CSUM_FSYNC     2
+#define CSUM_CLOSE             1
+#define CSUM_FSYNC             2
+#define CSUM_HASH_IN_STREAM    4

  extern struct hashfile *hashfd(int fd, const char *name);
  extern struct hashfile *hashfd_check(const char *name);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index e01f992884..471481f461 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -535,7 +535,7 @@ void bitmap_writer_finish(struct pack_idx_entry **index,
         if (options & BITMAP_OPT_HASH_CACHE)
                 write_hash_cache(f, index, index_nr);

-       hashclose(f, NULL, CSUM_FSYNC);
+       hashclose(f, NULL, CSUM_HASH_IN_STREAM | CSUM_FSYNC | CSUM_CLOSE);

         if (adjust_shared_perm(tmp_file.buf))
                 die_errno("unable to make temporary bitmap file readable");
diff --git a/pack-write.c b/pack-write.c
index d775c7406d..f72df5a836 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -170,8 +170,9 @@ const char *write_idx_file(const char *index_name, 
struct pack_idx_entry **objec
         }

         hashwrite(f, sha1, the_hash_algo->rawsz);
-       hashclose(f, NULL, ((opts->flags & WRITE_IDX_VERIFY)
-                           ? CSUM_CLOSE : CSUM_FSYNC));
+       hashclose(f, NULL, CSUM_HASH_IN_STREAM | CSUM_CLOSE |
+                          ((opts->flags & WRITE_IDX_VERIFY)
+                          ? 0 : CSUM_FSYNC));
         return index_name;
  }

--
2.14.1

