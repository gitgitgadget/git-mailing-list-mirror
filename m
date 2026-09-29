Received: from mail-oa2-f35.google.com (mail-oa2-f35.google.com [74.125.231.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA2325495
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 01:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644213; cv=none; b=OR0VG5CSNnoPD3cex4db4hKGO2V/Yv5ZG8eQO0grqDOR2tIhg6DnNMfoXsmB5xFzVzCZvo9v4bhiV6ByrIaBD4fvI0yXuDPqhPSn/4h0B8DkxUW5gi6oAyMnC6Xcy3USEA+O6Ui3ImETgO9Jm4VrUeLvd3a3Qc1cemcq3v0kTlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644213; c=relaxed/simple;
	bh=xlXYH5KQ8R+tCld7rNPMoFdSB1nkdQb/m6YBN8qPLnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ui+JIUcgX77MQxWS+i6icMcWyyib878upJ0dMQ9NEMBQDzkKjx4GjHgSCExQ7Wr50e2gOXyMvS/Z0LFLg81sdzyDkil1i0VW7YamXBMv5rRt8VQBdHe/Lfmml1NSg8nraFjO4vgBzePLTxdurLCopANloMM1yDxFDu8yz+uf/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=gdhuN/+H; arc=none smtp.client-ip=74.125.231.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="gdhuN/+H"
Received: by mail-oa2-f35.google.com with SMTP id 586e51a60fabf-4881ca701a4so1867200fac.2
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 18:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1790644211; x=1791249011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hq9GOfKxjSXVo6QTGJxh5Lco+JzHyLrzkK/5mSsxG8A=;
        b=gdhuN/+HLcTshlQTbydsVwte6N+EMAqGfgwNeZROg5QXbBpChtcpGEmtcCvU1TLHwf
         iXyGI1aTqqGmgk1Df0HaduKEhS/tNbYNCvFG59XwGZMi6pS1bj5D23h9bC649lTVyBa1
         Sz5w1jCs2PJWNVv+muuCyUYwX+DCd3sHU85KtBPnIPaovGnfhY5G3e+v/oaRIbiFzJoM
         kFUQ3wfNtJ2gDPfO9OSzr3Qk5hodvZijW5I/21DMGwpD6QsLIIN7Z7cKMbv++dv7mSOY
         DjXGcvaoPWNCiAyltCRPQFfq05984q1vr3qAQH+OGUzbnolvj0LNZbm9H3kYysUi2CKZ
         k9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644211; x=1791249011;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hq9GOfKxjSXVo6QTGJxh5Lco+JzHyLrzkK/5mSsxG8A=;
        b=Wc4em1lvO4ZLmfh8OjSdWLpk77HVPcroHE9YXvVese3zoWbBCTMDRMGmS/xZO42il2
         0bIPgJTtUdPEbo1PgcLzPGAdOosNgyk8x5NqGMRAZoB0PvagzTWS7b/ewZQkNtnobO2A
         KdTiJ3iZor0tE5hPhMDM0byfhmMqCBGoaUNDgMS2OUfoiIPOyba7W0h0cm7AC/H+HLZ3
         odPdYrI8PFTh47ahOXrlAYTRuRu6i8o3MuA/sXHJXuRcdeby2/ZgWZeACGUfihY5IAZM
         9JdZhpB7QbDtCp6r4/RzzlIPL7CSXUGcutZ54LvsJ8ssIC0ceTmJLNvkO+EE+ASrqlbo
         hcXA==
X-Gm-Message-State: AFuF++kXrilzc17AxD6fJ88rD9U/4HSzK800RL1OSHkNigYk7SrwklWn
	SR9F4Wm9poDKRY9qUEwePAr9pMNpbBYm7n7ks6JH8jcz1aEdlQ9XwiYr9wa1C6tnJRgMFzkod5y
	ZQ3MEY60=
X-Gm-Gg: AYBFou0tX72SizAat4vVNMnXo3mMcCDi4+sKvfuYsbV7OFXi27u2sniG+Bc57LdW28o
	A5A3O0cxpM5VB+zeL9+N30kseIxfzgJI5Blh4JmanUdOdVd3yncdCuHZ3z7O4quXgFn13jgeB9/
	LnSsK0OJ80dPYk7gLHFLc2rC48LXCl+j0uyBb15DL0DJ9y1WKaED9j6mOYizvDNfEd8gNJWl3T8
	4rH+pXgfApLo2r21HxGPktm4QTBOA+IFrMvOgko3C3DTcKimS1jZV4Gzoqz6qj3mofm6x9eLyo9
	1iasChSLjInzQhq12ri1HJUWQx8I+VGM1+4Pnpw5JHY4A/6ZTeaUKBb5Gr2m4PlAM9PXjSlInco
	VQRm3j+0d59NRjzL6dJm3Vh1s6cPe8rHII8ynU5MulY9ErtluDRykLpFO9EKL9El9vPMehM7l2t
	/9xJLvZPQxV4Yw7ctoaQ8aM3p1xdSTE/Hd6iIzAuGqme9bdVK86ojPp+Xwyq0YdVxvWs7EtRM=
X-Received: by 2002:a05:6820:81cf:b0:6b7:46e9:96ff with SMTP id 006d021491bc7-6d4411d226dmr12635159eaf.47.1790644210803;
        Mon, 28 Sep 2026 18:10:10 -0700 (PDT)
Received: from localhost ([161.97.221.21])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-493367b617fsm11903935fac.18.2026.09.28.18.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 18:10:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:10:08 -0600
From: Tyler Cipriani <tyler@tylercipriani.com>
To: Aleksei Sviridkin <f@lex.la>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] push: fix --force-if-includes when remote-tracking
 ref has no reflog
Message-ID: <arsP8IE6LuAKzYE6@localhost.localdomain>
References: <20260903010547.85469-1-f@lex.la>
 <20260905171330.34646-1-f@lex.la>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260905171330.34646-1-f@lex.la>
X-PGP-Key: https://tylercipriani.com/018FAC02.asc

On 26-09-05 20:13:30, Aleksei Sviridkin wrote:

Code looks right to me with the date=0 fallback.

push.useForceIfIncludes is meant to tighten --force-with-lease's checks.
Getting a wrong answer with advice telling me to pull would push me (pun
intended) to drop the config and ditch the feature. For
--force-if-includes, being wrong here is worse than being slow here.

Re: being slow. I tried to recreate some numbers from this thread with
my own test case using linux.git and 2k reflog entries. In the cases I
tried:

- With a commit-graph (which gc should write), walking + merge-base
   checks on 2k entries took 15ms. So a few microseconds per reflog entry
   roughly jibes with numbers from this thread.
- Without a commit-graph, each batched call to
   repo_in_merge_bases_many() walks the commit history from scratch:
   rejection took two minutes for 2k entries.

But my tests were artificial worst-case scenarios. And today, on my
build, "date" already happens to be a low number. For folks like me,
setting date=0 is a non-change and I've been unable to find any
complaints of slowness on the mailing list (or by searching the web).

For folks where date happens to be a high number: this gets the feature
working correctly. Bonus: doubling batch size after each call to
repo_in_merge_bases_many took my 2min down to 10s, locally; a viable
speed up if needed (but separate from this change).

>Since 99a1f9ae10 (push: add reflog check for "--force-if-includes",
>2020-10-03), is_reachable_in_reflog() stops walking the reflog of the
>local branch at entries older than the newest reflog entry of the
>remote-tracking ref. That timestamp is read by a callback of
>refs_for_each_reflog_ent_reverse(), so when the remote-tracking ref
>has no reflog, the variable that holds the timestamp stays
>uninitialized.
>
>With the files backend a remote-tracking ref created by "git clone"
>has no reflog and does not get one until it moves. On my machine the
>leftover value exceeds any real timestamp: the walk stops at the very
>first entry, never reaches the "Created from" entry that "checkout
>--track" wrote, and the push is rejected with "remote ref updated
>since checkout" although nothing on the remote has changed.
>
>The cut-off is an optimization that rests on an assumption: an entry
>older than the moment the remote-tracking ref last moved is not
>expected to be the one being looked for. Without a reflog there is
>no such moment, hence no cut-off to apply. Initialize the timestamp
>to zero to say exactly that: timestamp_t is unsigned, so no entry
>compares older than zero and the comparison never fires. Using
>"now", or any fixed age, would instead cut the walk off at the first
>entry older than that bound, which is how the failure happens in
>the first place. The price is paid only when no matching entry is
>found: the walk then reaches the oldest entry and falls back to the
>merge-base check over what it collected, where the cut-off would
>have stopped it earlier.

The last paragraph of this log message is hard to read for me; I think
people could come away from reading it with the wrong information.

Nits:

- The final paragraph of the log message starts with "The cut-off", but
   it's the first time you've used "cut-off." What cut-off?
- "an entry older than [...] is not expected to be the one being looked
   for" - passive voice, stacked verb phrases ("is not expected/to be"),
   and a subject separated from its verb by 9 words made this hard to
   follow. And it leaves questions: Why is <who or what> not looking at
   <what> entry?
- "Without a reflog" - which reflog? remote-tracking or local?
- Unclear referents:
     - "exactly that"
     - "that bound"

Problems (with more nits :)):

- "there is no such moment"
   - Readability: referring back to "moment" that came 23 words before
     this "moment" made me re-read this a few times.
   - Inaccuracy: there may have been a moment when the remote-tracking
     ref last moved, but there is no reliable record of it because there
     is no remote-tracking reflog. That is, someone may have removed the
     reflog, or the reflog could have been GC'd (neither case is
     mentioned in your message).
- Most importantly, since the way I parse it is technically incorrect:
   "the walk then reaches the oldest entry and falls back to the
   merge-base check...where the cut-off would have stopped it earlier." -
   Stopped what earlier? I read this sentence split on "where" (i.e., Y
   does this, whereas X does that).

   Read that way, the final sentence reads as:

   Walk without a cut-off:

   (a) "reaches the oldest entry"
   (b) "falls back to the merge-base check"

   vs.

   Walk with a cut-off: stops earlier and therefore does neither.

   But a walk with a cut-off falls back to a merge-base check, too. The
   difference is that without a cut-off you reach the oldest entry and
   therefore pass more local reflog entries to the merge-base check;
   i.e., potentially more calls to repo_in_merge_bases_many()

>
>Signed-off-by: Aleksei Sviridkin <f@lex.la>
>---
>Changes since v2:
>  - reworded the first paragraph as you suggested
>  - explain why zero is the fallback rather than "now" or a fixed age
>  - dropped the Assisted-by trailer
>
> remote.c            |  2 +-
> t/t5533-push-cas.sh | 18 ++++++++++++++++++
> 2 files changed, 19 insertions(+), 1 deletion(-)
>
>diff --git a/remote.c b/remote.c
>index 00723b385e..6d301698ca 100644
>--- a/remote.c
>+++ b/remote.c
>@@ -2751,7 +2751,7 @@ static int check_and_collect_until(const char *refname UNUSED,
>  */
> static int is_reachable_in_reflog(const char *local, const struct ref *remote)
> {
>-	timestamp_t date;
>+	timestamp_t date = 0;
> 	struct commit *commit;
> 	struct commit **chunk;
> 	struct check_and_collect_until_cb_data cb;
>diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
>index cba26a872d..bb8878c593 100755
>--- a/t/t5533-push-cas.sh
>+++ b/t/t5533-push-cas.sh
>@@ -396,4 +396,22 @@ test_expect_success '"--force-if-includes" should allow deletes' '
> 	)
> '
>
>+test_expect_success '"--force-if-includes" should allow forced update when remote-tracking ref has no reflog' '
>+	rm -fr dst src &&
>+	test_when_finished "rm -fr dst src" &&
>+	git init --bare dst &&
>+	git push dst main main:branch &&
>+	git clone --no-local dst src &&
>+	(
>+		cd src &&
>+		# a clone leaves the remote-tracking refs without reflog
>+		# entries with the files backend, but not with reftable
>+		git reflog expire --all --expire=all &&
>+		git switch -c branch --track origin/branch &&
>+		git reset --hard HEAD^ &&
>+		test_commit D &&
>+		git push --force-if-includes --force-with-lease="branch"
>+	)
>+'
>+
> test_done

Tested: passes with the fix.

Without the fix it also passes on my machine. gdb says that the value of
date is 2 for me (Linux x86_64, gcc (Debian 14.2.0-19) 14.2.0, on
Trixie). To get the test to fail reliably, had to build with:

     make CFLAGS_APPEND=-ftrivial-auto-var-init=pattern

So, CI probably would miss date becoming uninitialized again. It also
fails with a date set to a timestamp 90 days ago due, since test dates
are 2005.

Minor nit: surrounding tests in t/t5533-push-cas.sh use
setup_src_dup_dst, which would simplify the test setup.

I'd be happy to give a Reviewed-by once the log message is clearer.

Thanks.
