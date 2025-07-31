Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECD915573F
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 14:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753973826; cv=none; b=TPwXvnszdLASIs+rNZjnkaBeQ8c772dk7G25Kd2aTu6pmyE/XY0txpZZ5N4mmgGhwd2cOjxHoWNNWP0N/RwJ9hHcisa95969p5obZ3w1qHRaNzAVtrn2TZzw7rcNaJPlMz8JE2DmzF6wu6MiRHLqU8ZugDd/RTvxhL72xZl2vmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753973826; c=relaxed/simple;
	bh=z4ED9cj8nHDmpmEdmOm8Z6WGb1GBlcGQs4+3uDBUs34=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Nt+yn90g9zqHfLpq3hgXeMz3o/hDrJJw0ZcobH8kBitt/VWIJt9Vu6QD5lU6cnW+jhZ2cW6HH6vzupPiOXZSbbbGRgirRGHFnhi1Gc/UZV3+DEF6U4dJLgaAIQ7k+Eci/QOwV8FSuGHFsMvmVYAwhj56lwWA3I3fIXdZOy4sric=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dou3Gcn9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IS2Sbo9U; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dou3Gcn9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IS2Sbo9U"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 4D465EC173B;
	Thu, 31 Jul 2025 10:57:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 31 Jul 2025 10:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1753973822;
	 x=1754060222; bh=YWfY9BQKa61Fzm0C+SRmT7KxdMdxIEUSa6BOVWVzKvI=; b=
	Dou3Gcn9B5amDRW14pZaoike3Rd/urU9p5U4QAO/dcrHGc6yfiPaZZuTzMi3n/n/
	HXlq/uNK8rOAtwO/sYm3IKgfjn/MEhHajK4CnBB8SpmYxJ/Tg9vO+JIyWZdxaknq
	xW/2HJBe8sszyui29+YLyqycX7thKnI/ZeZZIWBbr0rUYVB74QIvRfs2xb5QB3Go
	oMtK4PA/SJzojEsDsvYI0XI7gP+WF+RK/yumfPpF8RM6lVA4+cQL5z7NsVChcmjr
	hj6BO0K64OaqxaFO3qI5gMdSS7uTBfC4HtF2Ckl0BBZ6pfstVSfA5OtLhRH9Wv8r
	KZQ8DUf+jFS648W/YKlJyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1753973822; x=
	1754060222; bh=YWfY9BQKa61Fzm0C+SRmT7KxdMdxIEUSa6BOVWVzKvI=; b=I
	S2Sbo9UIUZ7mQO1eLDkZsRR5vJA9DH1HdKnAen5lICQNnmvd/kbdpkBPZuFOokzI
	KSm5JDpDag+eib2bQAQGo+7fRRcF7yFe6ZNBogjQEfB5QJIhA0jN3s1DDYBoNnY/
	aChrmAbzPw0XrG+VaRFJLxEZue6R6+9vjNfcPGb3VGxctaJozUxcpx7HnEd9gl7D
	/59aMNWoGXI6/BHUlNXbNHRSlJ7ukR9Tw1xXbGrEcZW58mDyi+y7CewChE568MhK
	hXcQKtFs0Rk7kr5SQGXTp5kFI2TuHT+fL/Y7y8VsEVn3CprsB3pL9a5JiFgZkl7w
	Hl9N7WQQSVVkP+W7Y2t0A==
X-ME-Sender: <xms:PYSLaO-HKEiZmPCQ79HpXksdq0Qw1AvyIHWth6-thUE2q3kik4RxAg>
    <xme:PYSLaHL1ef5Ubap9tKw8VMJL5C0I6fJ964_y7VL-DH4rxuHCWKaoApUYXmfdoJN42
    gpvX0BbwNhy3PWVcg>
X-ME-Received: <xmr:PYSLaEddd_FgvRws8l_BA82JY8VZd6bj6afBY2byoFrzHL1jKwcQxoilNNbznxG9kzwsB-HOYS3J4XxzEXmH2ebzR83jzxWomXYCtzGdwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdduudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeduudevjeffffegjeegheeiteeuffdtvdehleegfeefvedtgeetlefhkeevtedtheen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhope
    hpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PYSLaG9QigMLtVXDjRSd5f8XkfqKMsrhJOD93vv_CPF65WCP1r0XZA>
    <xmx:PYSLaBoYrL1Fy6l_wori3iRDUv3n-PBEKTviW4635_FG3rXd0Dt5Bg>
    <xmx:PYSLaLAV7jH0VJbxlLZDNxO1u9tNbCDzIhdnSZ7gV84G1k5hMNUrsQ>
    <xmx:PYSLaDxg6cb7ZCrpsCtgsS4bweL1EMO1nF9bYgxZ_fRDc0J1to6DLQ>
    <xmx:PoSLaCY51NHHkye0t24AfR2HoF0YpXhF8H9e5GK5c8_RYORmo5W3m7pf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 10:57:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4ec0797e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 31 Jul 2025 14:56:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/6] builtin/remote: rework how remote refs get renamed
Date: Thu, 31 Jul 2025 16:56:48 +0200
Message-Id: <20250731-pks-remote-rename-improvements-v2-0-dda6f083674d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADCEi2gC/4WNQQrCMBBFr1JmbSQdmlhceQ/posapHSRJSUJQS
 u/uWHDt6vM+M++vkCkxZTg3KySqnDkGATw04OYxPEjxXRhQo9EnNGp5ZpXIx0ISYfRy4JcUK3k
 KJaveOEKLbWdJg0iWRBO/9oHrIDxzLjG9973aftufuv+nrq3SarKmm/BmnBnpIg9H9jBs2/YBO
 JZGMskAAAA=
X-Change-ID: 20250725-pks-remote-rename-improvements-85ce262146e0
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Han Jiang <jhcarl0814@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is the result from the discussion at [1]. On the one
hand this series fixes the reported bug where dangling symrefs are not
renamed via `git remote rename`.

On the other hand this series reworks the logic used to rename remotes
so that we use two transactions instead of one transaction per ref. This
fixes quadratic runtime behaviour, where renaming 10k refs takes ~4
minutes, 100k takes hours. This results in a significant speedup with
both the "files" backend (benchmarked with a smaller number of refs to
retain sanity):

    Benchmark 1: rename remote (refformat = files, revision = HEAD~)
      Time (mean ± σ):     238.770 s ± 13.857 s    [User: 91.473 s, System: 143.793 s]
      Range (min … max):   204.863 s … 247.699 s    10 runs

    Benchmark 2: rename remote (refformat = files, revision = HEAD)
      Time (mean ± σ):      2.103 s ±  0.036 s    [User: 0.360 s, System: 1.313 s]
      Range (min … max):    2.011 s …  2.141 s    10 runs

    Summary
      rename remote (refformat = files, revision = HEAD) ran
      113.53 ± 6.87 times faster than rename remote (refformat = files, revision = HEAD~)

For the "reftable" backend we see a significant speedup, as well, but
not as extreme as with the "files" backend:

    Benchmark 1: rename remote (refformat = reftable, revision = HEAD~)
      Time (mean ± σ):      8.604 s ±  0.539 s    [User: 4.985 s, System: 2.368 s]
      Range (min … max):    7.880 s …  9.556 s    10 runs

    Benchmark 2: rename remote (refformat = reftable, revision = HEAD)
      Time (mean ± σ):      1.177 s ±  0.103 s    [User: 0.446 s, System: 0.270 s]
      Range (min … max):    1.023 s …  1.410 s    10 runs

    Summary
      rename remote (refformat = reftable, revision = HEAD) ran
        7.31 ± 0.79 times faster than rename remote (refformat = reftable, revision = HEAD~)

But in any case, it's one more case where the "reftable" backend
outperforms the "files" backend.

The series is built on top of e4ef0485fd7 (The fourteenth batch,
2025-07-24) with ps/reflog-migrate-fixes at de7cc0782a7 (refs: fix
invalid old object IDs when migrating reflogs, 2025-07-25) merged into
it.

I'd normally have withheld sending until that series was merged to
"next", but given that I promised to send something on Friday already I
decided to just get it out. In any case, if that causes problems I'm
happy to wait a bit before this series here gets merged into "seen".

Changes in v2:
  - Insert another commit to fix sign-comparison warnings.
  - Some code formatting fixes.
  - Drop the infrastructure to reuse buffers. It didn't really help much
    with performance anyway.
  - I'm now using a single transaction to rename references so that we
    have proper atomicity. Conflicts are detected early before any
    changes are performed in the repository and an advice is printed
    indicating what has happened.
  - Link to v1: https://lore.kernel.org/r/20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im

Thanks!

Patrick

[1]: <CANrWfmQWa=RJnm7d3C7ogRX6Tth2eeuGwvwrNmzS2gr+eP0OpA@mail.gmail.com>

---
Patrick Steinhardt (6):
      refs: pass refname when invoking reflog entry callback
      refs: simplify logic when migrating reflog entries
      builtin/remote: fix sign comparison warnings
      builtin/remote: determine whether refs need renaming early on
      builtin/remote: rework how remote refs get renamed
      builtin/remote: only iterate through refs that are to be renamed

 builtin/fsck.c            |   9 +-
 builtin/gc.c              |   3 +-
 builtin/remote.c          | 345 +++++++++++++++++++++++++++++-----------------
 builtin/stash.c           |   6 +-
 commit.c                  |   3 +-
 object-name.c             |   3 +-
 reflog-walk.c             |   7 +-
 reflog.c                  |   3 +-
 reflog.h                  |   3 +-
 refs.c                    |  64 ++++-----
 refs.h                    |  13 +-
 refs/debug.c              |   5 +-
 refs/files-backend.c      |  15 +-
 refs/reftable-backend.c   |   2 +-
 remote.c                  |   6 +-
 revision.c                |   3 +-
 t/helper/test-ref-store.c |   3 +-
 t/t5505-remote.sh         |  73 ++++++++++
 wt-status.c               |   6 +-
 19 files changed, 372 insertions(+), 200 deletions(-)

Range-diff versus v1:

1:  ca658850cf ! 1:  67b46a7afe refs: pass refname when invoking reflog entry callback
    @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noi
      		else if (!oideq(noid, cb->oid))
      			warning(_("log for ref %s unexpectedly ended on %s"),
     -				cb->refname, show_date(cb->date, cb->tz,
    -+				refname, show_date(cb->date, cb->tz,
    - 						       DATE_MODE(RFC2822)));
    +-						       DATE_MODE(RFC2822)));
    ++				refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
      		cb->reccnt++;
      		oidcpy(&cb->ooid, ooid);
    + 		oidcpy(&cb->noid, noid);
     @@ refs.c: static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
      	return 0;
      }
    @@ refs.c: static int migrate_one_reflog(const char *refname, void *cb_data)
     
      ## refs.h ##
     @@ refs.h: int refs_delete_reflog(struct ref_store *refs, const char *refname);
    +  * The cb_data is a caller-supplied pointer given to the iterator
       * functions.
       */
    - typedef int each_reflog_ent_fn(
    -+		const char *refname,
    - 		struct object_id *old_oid, struct object_id *new_oid,
    - 		const char *committer, timestamp_t timestamp,
    - 		int tz, const char *msg, void *cb_data);
    +-typedef int each_reflog_ent_fn(
    +-		struct object_id *old_oid, struct object_id *new_oid,
    +-		const char *committer, timestamp_t timestamp,
    +-		int tz, const char *msg, void *cb_data);
    ++typedef int each_reflog_ent_fn(const char *refname,
    ++			       struct object_id *old_oid,
    ++			       struct object_id *new_oid,
    ++			       const char *committer,
    ++			       timestamp_t timestamp,
    ++			       int tz, const char *msg,
    ++			       void *cb_data);
    + 
    + /* Iterate over reflog entries in the log for `refname`. */
    + 
     
      ## refs/debug.c ##
     @@ refs/debug.c: struct debug_reflog {
2:  b119cdfd48 = 2:  239f7acd1d refs: simplify logic when migrating reflog entries
-:  ---------- > 3:  e421091721 builtin/remote: fix sign comparison warnings
-:  ---------- > 4:  0d88ed6365 builtin/remote: determine whether refs need renaming early on
3:  8d2678f27c ! 5:  8aed1ce7f5 builtin/remote: rework how remote refs get renamed
    @@ Commit message
         symrefs. On the one hand this isn't even remotely an atomic operation,
         so if we hit any error we'll already have deleted all references.
     
    -    But more importantly it is also extremely inperformant. The number of
    +    But more importantly it is also extremely inefficient. The number of
         transactions for symrefs doesn't really bother us too much, as there
         should generally only be a single symref anyway ("HEAD"). But the
         renames are very expensive:
    @@ Commit message
             The consequence here is quadratic runtime performance. Renaming a
             100k references takes hours to complete.
     
    -    Ideally we'd refactor the code to use a single transaction to perform
    -    all the reference updates atomically. But unfortunately that does not
    -    work in the case where you rename a remote so that it becomes nested
    -    into itself, as that can lead to conflicting reference updates.
    -
    -    The next-best thing is to do it in two transactions: one to delete all
    -    the references, and one to recreate the references and their reflogs.
    -    This signicantly speeds up the operation with the "files" backend. The
    -    following benchmark renames a remote with 10000 references:
    +    Refactor the code to use a single transaction to perform all the
    +    reference updates atomically, which speeds up the transaction quite
    +    significantly:
     
             Benchmark 1: rename remote (refformat = files, revision = HEAD~)
               Time (mean ± σ):     238.770 s ± 13.857 s    [User: 91.473 s, System: 143.793 s]
    @@ Commit message
               rename remote (refformat = reftable, revision = HEAD) ran
                 7.31 ± 0.79 times faster than rename remote (refformat = reftable, revision = HEAD~)
     
    +    There is one issue though with using atomic transactions: when nesting a
    +    remote into itself it can happen that renamed references conflict with
    +    the old referencse. For example, when we have a reference
    +    "refs/remotes/origin/foo" and we rename "origin" to "origin/foo", then
    +    we'll end up with an F/D conflict when we try to create the renamed
    +    reference "refs/remotes/origin/foo/foo".
    +
    +    This situation is overall quite unlikely to happen: people tend to not
    +    use nested remotes, and if they do they must at the same time also have
    +    a conflicting refname. But the end result would be that the old remote
    +    references stay intact whereas all the other parts of the repository
    +    have been adjusted for the new remote name.
    +
    +    Address this by queueing and preparing the reference update before we
    +    touch any other part of the repository. Like this we can make sure that
    +    the reference update will go through before rewriting the configuration.
    +    Otherwise, if the transaction fails to prepare we can gracefully abort
    +    the whole operation without any changes having been performed in the
    +    repository yet. Furthermore, we can detect the conflict and print some
    +    helpful advice for how the user can resolve this situation. So overall,
    +    the tradeoff is that:
    +
    +      - Reference transactions are now all-or-nothing. This is a significant
    +        improvement over the previous state where we may have ended up with
    +        partially-renamed references.
    +
    +      - Rewriting references is now significantly faster.
    +
    +      - We only rewrite the configuration in case we know that all
    +        references can be updated.
    +
    +      - But we may refuse to rename a remote in case references conflict.
    +
    +    Overall this seems like an acceptable tradeoff.
    +
         While at it, fix the handling of symbolic/broken references by using
         `refs_for_each_rawref()`. Add tests that cover both this reported issue
    -    and tests that verify that nesting remotes into itself continues to work
    -    with conflicting references.
    +    and tests that exercise nesting of remotes.
     
         One thing to note: with this change we cannot provide a proper progress
         monitor anymore as we queue the references into the transactions as we
    @@ Commit message
     
      ## builtin/remote.c ##
     @@
    + #define USE_THE_REPOSITORY_VARIABLE
      
      #include "builtin.h"
    ++#include "advice.h"
      #include "config.h"
     +#include "date.h"
      #include "gettext.h"
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
      	const char *new_name;
     -	struct string_list *remote_branches;
     -	uint32_t symrefs_nr;
    -+	struct ref_transaction *tx_create;
    -+	struct ref_transaction *tx_delete;
    ++	struct ref_transaction *transaction;
     +	struct progress *progress;
    ++	struct strbuf *err;
     +	uint32_t progress_nr;
    -+	struct strbuf *buf1, *buf2, *buf3, *err;
    -+	struct strbuf *new_refname;
     +	uint64_t index;
      };
      
     -static int read_remote_branches(const char *refname, const char *referent UNUSED,
     -				const struct object_id *oid UNUSED,
     -				int flags UNUSED, void *cb_data)
    -+static void renamed_refname(struct rename_info *rename,
    -+			    const char *refname,
    -+			    struct strbuf *out)
    ++static void compute_renamed_ref(struct rename_info *rename,
    ++				const char *refname,
    ++				struct strbuf *out)
     +{
     +	strbuf_reset(out);
     +	strbuf_addstr(out, refname);
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +		      rename->new_name, strlen(rename->new_name));
     +}
     +
    -+static int rename_one_reflog_entry(const char *old_refname UNUSED,
    ++static int rename_one_reflog_entry(const char *old_refname,
     +				   struct object_id *old_oid,
     +				   struct object_id *new_oid,
     +				   const char *committer,
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     -		} else {
     -			item->util = NULL;
     -		}
    -+	struct strbuf *identity = rename->buf1;
    -+	struct strbuf *name = rename->buf2;
    -+	struct strbuf *mail = rename->buf3;
    ++	struct strbuf new_refname = STRBUF_INIT;
    ++	struct strbuf identity = STRBUF_INIT;
    ++	struct strbuf name = STRBUF_INIT;
    ++	struct strbuf mail = STRBUF_INIT;
     +	struct ident_split ident;
     +	const char *date;
     +	int error;
     +
    -+	if (split_ident_line(&ident, committer, strlen(committer)) < 0)
    -+		return -1;
    ++	compute_renamed_ref(rename, old_refname, &new_refname);
     +
    -+	strbuf_reset(name);
    -+	strbuf_add(name, ident.name_begin, ident.name_end - ident.name_begin);
    -+	strbuf_reset(mail);
    -+	strbuf_add(mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
    ++	if (split_ident_line(&ident, committer, strlen(committer)) < 0) {
    ++		error = -1;
    ++		goto out;
    + 	}
    +-	strbuf_release(&buf);
    + 
    +-	return 0;
    ++	strbuf_add(&name, ident.name_begin, ident.name_end - ident.name_begin);
    ++	strbuf_add(&mail, ident.mail_begin, ident.mail_end - ident.mail_begin);
     +
     +	date = show_date(timestamp, tz, DATE_MODE(NORMAL));
    -+	strbuf_reset(identity);
    -+	strbuf_addstr(identity, fmt_ident(name->buf, mail->buf,
    ++	strbuf_addstr(&identity, fmt_ident(name.buf, mail.buf,
     +					  WANT_BLANK_IDENT, date, 0));
     +
    -+	error = ref_transaction_update_reflog(rename->tx_create, rename->new_refname->buf,
    -+					      new_oid, old_oid, identity->buf, msg,
    ++	error = ref_transaction_update_reflog(rename->transaction, new_refname.buf,
    ++					      new_oid, old_oid, identity.buf, msg,
     +					      rename->index++, rename->err);
     +
    ++out:
    ++	strbuf_release(&new_refname);
    ++	strbuf_release(&identity);
    ++	strbuf_release(&name);
    ++	strbuf_release(&mail);
     +	return error;
     +}
     +
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +			     const struct object_id *old_oid,
     +			     struct rename_info *rename)
     +{
    -+	struct strbuf *message = rename->buf1;
    ++	struct strbuf new_refname = STRBUF_INIT;
    ++	struct strbuf message = STRBUF_INIT;
     +	int error;
     +
     +	if (!refs_reflog_exists(get_main_ref_store(the_repository), old_refname))
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +	error = refs_for_each_reflog_ent(get_main_ref_store(the_repository),
     +					 old_refname, rename_one_reflog_entry, rename);
     +	if (error < 0)
    -+		return error;
    ++		goto out;
    ++
    ++	compute_renamed_ref(rename, old_refname, &new_refname);
     +
     +	/*
     +	 * Manually write the reflog entry for the now-renamed ref. We cannot
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +	 * Furthermore, we only append the entry in case the reference
     +	 * resolves. Missing references shouldn't have reflogs anyway.
     +	 */
    -+	strbuf_reset(message);
    -+	strbuf_addf(message, "remote: renamed %s to %s", old_refname,
    -+		    rename->new_refname->buf);
    ++	strbuf_addf(&message, "remote: renamed %s to %s", old_refname,
    ++		    new_refname.buf);
     +
    -+	error = ref_transaction_update_reflog(rename->tx_create, rename->new_refname->buf,
    ++	error = ref_transaction_update_reflog(rename->transaction, new_refname.buf,
     +					      old_oid, old_oid, git_committer_info(0),
    -+					      message->buf, rename->index++, rename->err);
    ++					      message.buf, rename->index++, rename->err);
     +	if (error < 0)
     +		return error;
     +
    ++out:
    ++	strbuf_release(&new_refname);
    ++	strbuf_release(&message);
     +	return error;
     +}
     +
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +			  const struct object_id *oid,
     +			  int flags, void *cb_data)
     +{
    ++	struct strbuf new_referent = STRBUF_INIT;
    ++	struct strbuf new_refname = STRBUF_INIT;
     +	struct rename_info *rename = cb_data;
    -+	struct strbuf *new_referent = rename->buf1;
     +	const char *ptr = old_refname;
     +	int error;
     +
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +	    !skip_prefix(ptr, "/", &ptr)) {
     +		error = 0;
     +		goto out;
    - 	}
    --	strbuf_release(&buf);
    - 
    --	return 0;
    -+	renamed_refname(rename, old_refname, rename->new_refname);
    ++	}
    ++
    ++	compute_renamed_ref(rename, old_refname, &new_refname);
     +
     +	if (flags & REF_ISSYMREF) {
     +		/*
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +		referent = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
     +						   old_refname, RESOLVE_REF_NO_RECURSE,
     +						   NULL, NULL);
    -+		renamed_refname(rename, referent, new_referent);
    ++		compute_renamed_ref(rename, referent, &new_referent);
     +		oid = NULL;
     +	}
     +
    -+	error = ref_transaction_delete(rename->tx_delete, old_refname,
    ++	error = ref_transaction_delete(rename->transaction, old_refname,
     +				       oid, referent, REF_NO_DEREF, NULL, rename->err);
     +	if (error < 0)
     +		goto out;
     +
    -+	error = ref_transaction_update(rename->tx_create, rename->new_refname->buf, oid, null_oid(the_hash_algo),
    -+				       (flags & REF_ISSYMREF) ? new_referent->buf : NULL, NULL,
    ++	error = ref_transaction_update(rename->transaction, new_refname.buf, oid, null_oid(the_hash_algo),
    ++				       (flags & REF_ISSYMREF) ? new_referent.buf : NULL, NULL,
     +				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
     +				       NULL, rename->err);
     +	if (error < 0)
    @@ builtin/remote.c: static int add_branch_for_removal(const char *refname,
     +	display_progress(rename->progress, ++rename->progress_nr);
     +
     +out:
    ++	strbuf_release(&new_referent);
    ++	strbuf_release(&new_refname);
     +	return error;
      }
      
    @@ builtin/remote.c: static void handle_push_default(const char* old_name, const ch
      	strbuf_release(&push_default.origin);
      }
      
    --
    ++static const char conflicting_remote_refs_advice[] = N_(
    ++	"The remote you are trying to rename has conflicting references in the\n"
    ++	"new target refspec. This is most likely caused by you trying to nest\n"
    ++	"a remote into itself, e.g. by renaming 'parent' into 'parent/child'\n"
    ++	"or by unnesting a remote, e.g. the other way round.\n"
    ++	"\n"
    ++	"If that is the case, you can address this by first renaming the\n"
    ++	"remote to a different name.\n");
    + 
      static int mv(int argc, const char **argv, const char *prefix,
      	      struct repository *repo UNUSED)
    - {
     @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
      	};
      	struct remote *oldremote, *newremote;
    @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
     -		old_remote_context = STRBUF_INIT;
     -	struct string_list remote_branches = STRING_LIST_INIT_DUP;
     -	struct rename_info rename;
    --	int i, refs_renamed_nr = 0, refspec_updated = 0;
    +-	int refs_renamed_nr = 0, refspecs_need_update = 0;
     -	struct progress *progress = NULL;
     +		old_remote_context = STRBUF_INIT, err = STRBUF_INIT;
     +	struct rename_info rename = {
    -+		.buf1 = &buf,
    -+		.buf2 = &buf2,
    -+		.buf3 = &buf3,
    -+		.new_refname = &old_remote_context,
     +		.err = &err,
     +	};
    -+	int i, refspec_updated = 0;
    ++	int refspecs_need_update = 0;
      	int result = 0;
      
      	argc = parse_options(argc, argv, prefix, options,
    @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
      	oldremote = remote_get(rename.old_name);
      	if (!remote_is_configured(oldremote, 1)) {
     @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
    - 		goto out;
    + 		refspecs_need_update = !!strstr(oldremote->fetch.items[i].raw,
    + 						old_remote_context.buf);
      
    - 	/*
    ++	if (refspecs_need_update) {
    ++		rename.transaction = ref_store_transaction_begin(get_main_ref_store(the_repository),
    ++							       0, &err);
    ++		if (!rename.transaction)
    ++			goto out;
    ++
    ++		if (show_progress)
    ++			rename.progress = start_delayed_progress(the_repository,
    ++								 _("Renaming remote references"), 0);
    ++
    ++		result = refs_for_each_rawref(get_main_ref_store(the_repository),
    ++				rename_one_ref, &rename);
    ++		if (result < 0)
    ++			die(_("queueing remote ref renames failed: %s"), rename.err->buf);
    ++
    ++		result = ref_transaction_prepare(rename.transaction, &err);
    ++		if (result < 0) {
    ++			error("renaming remote references failed: %s", err.buf);
    ++			if (result == REF_TRANSACTION_ERROR_NAME_CONFLICT)
    ++				advise(conflicting_remote_refs_advice);
    ++			die(NULL);
    ++		}
    ++	}
    ++
    + 	if (oldremote->fetch.nr) {
    + 		strbuf_reset(&buf);
    + 		strbuf_addf(&buf, "remote.%s.fetch", rename.new_name);
    +@@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
    + 		}
    + 	}
    + 
    +-	if (!refspecs_need_update)
    +-		goto out;
    +-
    +-	/*
     -	 * First remove symrefs, then rename the rest, finally create
     -	 * the new symrefs.
    -+	 * Note that we're using two transactions to rename the references:
    -+	 *
    -+	 *   - One transaction contains all deletions for references part of
    -+	 *     the old remote.
    -+	 *   - One transaction contains all creations of references and reflogs
    -+	 *     part of the new remote.
    -+	 *
    -+	 * This split is required to avoid conflicting ref updates when a
    -+	 * remote is being nested into itself or converted into its parent
    -+	 * directory.
    -+	 *
    -+	 * Unfortunately this means that the operation isn't atomic. But we
    -+	 * cannot avoid that, unless transactions learn to handle such
    -+	 * conflicts one day.
    - 	 */
    +-	 */
     -	refs_for_each_ref(get_main_ref_store(the_repository),
     -			  read_remote_branches, &rename);
     -	if (show_progress) {
    @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
     -					  _("Renaming remote references"),
     -					  rename.remote_branches->nr + rename.symrefs_nr);
     -	}
    --	for (i = 0; i < remote_branches.nr; i++) {
    +-	for (size_t i = 0; i < remote_branches.nr; i++) {
     -		struct string_list_item *item = remote_branches.items + i;
     -		struct strbuf referent = STRBUF_INIT;
    -+	rename.tx_delete = ref_store_transaction_begin(get_main_ref_store(the_repository),
    -+						       0, &err);
    -+	if (!rename.tx_delete)
    -+		goto out;
    - 
    +-
     -		if (refs_read_symbolic_ref(get_main_ref_store(the_repository), item->string,
     -					   &referent))
     -			continue;
     -		if (refs_delete_ref(get_main_ref_store(the_repository), NULL, item->string, NULL, REF_NO_DEREF))
     -			die(_("deleting '%s' failed"), item->string);
    -+	rename.tx_create = ref_store_transaction_begin(get_main_ref_store(the_repository),
    -+						       0, &err);
    -+	if (!rename.tx_create)
    -+		goto out;
    - 
    +-
     -		strbuf_release(&referent);
     -		display_progress(progress, ++refs_renamed_nr);
     -	}
    --	for (i = 0; i < remote_branches.nr; i++) {
    +-	for (size_t i = 0; i < remote_branches.nr; i++) {
     -		struct string_list_item *item = remote_branches.items + i;
    -+	if (show_progress)
    -+		rename.progress = start_delayed_progress(the_repository,
    -+							 _("Renaming remote references"), 0);
    ++	if (refspecs_need_update) {
    ++		result = ref_transaction_commit(rename.transaction, &err);
    ++		if (result < 0)
    ++			die(_("renaming remote refs failed: %s"), rename.err->buf);
      
     -		if (item->util)
     -			continue;
    @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
     -			die(_("renaming '%s' failed"), item->string);
     -		display_progress(progress, ++refs_renamed_nr);
     -	}
    --	for (i = 0; i < remote_branches.nr; i++) {
    +-	for (size_t i = 0; i < remote_branches.nr; i++) {
     -		struct string_list_item *item = remote_branches.items + i;
    -+	result = refs_for_each_rawref(get_main_ref_store(the_repository),
    -+				      rename_one_ref, &rename);
    -+	if (result < 0)
    -+		die(_("renaming references failed: %s"), rename.err->buf);
    ++		stop_progress(&rename.progress);
      
     -		if (!item->util)
     -			continue;
    @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
     -		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, buf3.buf))
     -			die(_("creating '%s' failed"), buf.buf);
     -		display_progress(progress, ++refs_renamed_nr);
    --	}
    ++		handle_push_default(rename.old_name, rename.new_name);
    + 	}
     -	stop_progress(&progress);
    -+	result = ref_transaction_commit(rename.tx_delete, &err);
    -+	if (result < 0)
    -+		die(_("deleting old remote refs failed: %s"), rename.err->buf);
    -+
    -+	result = ref_transaction_commit(rename.tx_create, &err);
    -+	if (result < 0)
    -+		die(_("committing new remote refs failed: %s"), rename.err->buf);
    -+
    -+	stop_progress(&rename.progress);
    - 
    - 	handle_push_default(rename.old_name, rename.new_name);
    +-
    +-	handle_push_default(rename.old_name, rename.new_name);
      
      out:
     -	string_list_clear(&remote_branches, 1);
    -+	ref_transaction_free(rename.tx_create);
    -+	ref_transaction_free(rename.tx_delete);
    ++	ref_transaction_free(rename.transaction);
      	strbuf_release(&old_remote_context);
      	strbuf_release(&buf);
      	strbuf_release(&buf2);
    @@ t/t5505-remote.sh: test_expect_success 'forbid adding superset of existing remot
     +	git remote add parent url &&
     +	git update-ref refs/remotes/parent/child $COMMIT_ID &&
     +	test_when_finished "git remote remove parent/child" &&
    -+	git remote rename parent parent/child &&
    ++	test_must_fail git remote rename parent parent/child 2>err &&
    ++	test_grep "renaming remote references failed" err &&
    ++	test_grep "The remote you are trying to rename has conflicting references" err &&
     +	git for-each-ref refs/remotes/ >actual &&
    -+	printf "$COMMIT_ID commit\trefs/remotes/parent/child/child\n" >expected &&
    ++	printf "$COMMIT_ID commit\trefs/remotes/parent/child\n" >expected &&
     +	test_cmp expected actual
     +'
     +
4:  6a68671b8f ! 6:  2fc020e25f builtin/remote: only iterate through refs that are to be renamed
    @@ Commit message
         but ultimately this is still a waste of compute as we knowingly iterate
         through references that we won't ever care about.
     
    -    Improve this by introducing `refs_for_each_rawref_in()`, which knows to
    -    only iterate through (potentially broken) references in a given prefix.
    +    Improve this by using `refs_for_each_rawref_in()`, which knows to only
    +    iterate through (potentially broken) references in a given prefix.
     
         The following benchmark renames a remote with a single reference in a
         repository that has 100k unrelated references. This shows a sizeable
    @@ Commit message
     
      ## builtin/remote.c ##
     @@ builtin/remote.c: static int rename_one_ref(const char *old_refname, const char *referent,
    - {
    + 	struct strbuf new_referent = STRBUF_INIT;
    + 	struct strbuf new_refname = STRBUF_INIT;
      	struct rename_info *rename = cb_data;
    - 	struct strbuf *new_referent = rename->buf1;
     -	const char *ptr = old_refname;
      	int error;
      
    @@ builtin/remote.c: static int rename_one_ref(const char *old_refname, const char
     -		goto out;
     -	}
     -
    - 	renamed_refname(rename, old_refname, rename->new_refname);
    + 	compute_renamed_ref(rename, old_refname, &new_refname);
      
      	if (flags & REF_ISSYMREF) {
     @@ builtin/remote.c: static int mv(int argc, const char **argv, const char *prefix,
    - 		rename.progress = start_delayed_progress(the_repository,
    - 							 _("Renaming remote references"), 0);
    + 			rename.progress = start_delayed_progress(the_repository,
    + 								 _("Renaming remote references"), 0);
      
    --	result = refs_for_each_rawref(get_main_ref_store(the_repository),
    --				      rename_one_ref, &rename);
    -+	strbuf_reset(&buf);
    -+	strbuf_addf(&buf, "refs/remotes/%s/", rename.old_name);
    +-		result = refs_for_each_rawref(get_main_ref_store(the_repository),
    ++		strbuf_reset(&buf);
    ++		strbuf_addf(&buf, "refs/remotes/%s/", rename.old_name);
     +
    -+	result = refs_for_each_rawref_in(get_main_ref_store(the_repository), buf.buf,
    -+					 rename_one_ref, &rename);
    - 	if (result < 0)
    - 		die(_("renaming references failed: %s"), rename.err->buf);
    - 
    ++		result = refs_for_each_rawref_in(get_main_ref_store(the_repository), buf.buf,
    + 				rename_one_ref, &rename);
    + 		if (result < 0)
    + 			die(_("queueing remote ref renames failed: %s"), rename.err->buf);
     
      ## refs.c ##
     @@ refs.c: int refs_for_each_namespaced_ref(struct ref_store *refs,

---
base-commit: 49e86c58e5687de1089b97288ec5d9582ee6ebd6
change-id: 20250725-pks-remote-rename-improvements-85ce262146e0

