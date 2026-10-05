Received: from mail-dy2-f34.google.com (mail-dy2-f34.google.com [74.125.229.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1534031E835
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 05:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791179722; cv=pass; b=CubcTMOnj83alygxS+bkCnr3q1BVmxOOf4SbuKP0rcKHXfyW8Sl5WkaTTPsbFNSAEHY2R2oMAIS2WInfH6yN5WW/OvyHhu5FxuF6LgbrcY2PDkH1+90pFmIDmFhRJL90T7xY38k3KsEW8K2Iz/VlkZXIwfl4mLfTvzCF9uIJz5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791179722; c=relaxed/simple;
	bh=oLQQDSkskPpSrSmp9luYoGeSzaeJ4ShGV2tPY+TFjY4=;
	h=In-Reply-To:References:MIME-Version:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emwtOAt4Tj4C1A7jweiMbaEo36oEXiMzGQVcS1bhb+mecoYhNDevDbZlbTi79YFziGbXciEH4GcwlMTtlYgAothM9a4lufwFSpCwkMn/es1XznZ+AuGRjyYllUlOEnUaTaPY1Vyso0+QwmPs+87B5uJUzTyrQ70Li97CMOqlVdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com; spf=pass smtp.mailfrom=kanamei.com; dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b=T/c/l79U; arc=pass smtp.client-ip=74.125.229.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kanamei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kanamei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kanamei-com.20251104.gappssmtp.com header.i=@kanamei-com.20251104.gappssmtp.com header.b="T/c/l79U"
Received: by mail-dy2-f34.google.com with SMTP id 5a478bee46e88-33be7dfcfc1so1785440eec.1
        for <git@vger.kernel.org>; Sun, 04 Oct 2026 22:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791179719; cv=none;
        d=google.com; s=arc-20260327;
        b=cVxrTzXm3NzDvjZhtQb0fy19xax9rWqiRAJMmIgOonNgWl+S7S1hF7OvY40x5QhvRc
         u0Pu2gy4N4t0gbfbdnE8wyA6PjUiKDZKBhvUtkG9hjIYXHznWs3YYNu7zX7PcqAJgTVq
         EkN7CdRag8no1Hvde8GOP13OgkSIgzVPw3408QkohWSdd3G5WWuNAYjHBeFtWzKKTia3
         RfnGzZGsll7bLFWvFFs0Vox5Q/mZSZveE3pwDCBw6A7m1KVc6ASeGDqxdmyE1AIG6FPj
         DjvvM7Ez33QPbBI/b42XjSc9cph6Hpz3XmrcnLZDGvVvvQwaLzUvp+cYaI/TWp9+OmpA
         HG5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:references:in-reply-to:dkim-signature;
        bh=VSeMKRwiNGrLBbqvJujkzAnFb0MMN4emXRESg058oV0=;
        fh=dS7ZYYEQ3xS9uUoit4NbHrS7bRskiJR+qpqNwgt9xSw=;
        b=Uq33aBsnqYmqblOrZpc5+sjTJW1Utm15aYQrW2/8o1nyuziGgTyyt7lTLd9O3KE28o
         Xb5HmRD53j03riqBWS/Kd7lUqKTBM4+MeykgYFC9wIcNkT2pL6tqCSSs2++Nw3H8G12B
         EJrgzQ8FSkdtyi1siZruBen0AND6dC0UEKMeL89jhwiCwtDCO7Z+2wmCjeDiHIITAlbV
         UHdFdnBI52hWDBERvPxMrZudUCxO9XQwJgBrvafEIWRHEv2WD2CLxBSbrJ4crvH8MjcA
         cRhkQgkjHu6Be3FcPEycBqSc6GXIHUz0pGXX54ulRqa3+VYIs/Bz7/bEChAoaN5c/Qym
         6O5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kanamei-com.20251104.gappssmtp.com; s=20251104; t=1791179719; x=1791784519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VSeMKRwiNGrLBbqvJujkzAnFb0MMN4emXRESg058oV0=;
        b=T/c/l79UevS7JVxK9y578U1+LU+z1jQH8ddgGaz+FXJxq9NRbdKameDFANfoCmRHdm
         aZoUhzOQaayd/1XpoK43tdomyC/bdOmioCZAbjKpI5LkaMzwC5T2k1Xmf4kAW/bDtjne
         jy2syvJXgTSmg+nVmWTUibfU86laQZ1cujH6ilcOoU6m2OeYUt2kubuyhsrmOQJcWVKc
         GbrAkeWIXEXgeWo5x7Jbx/ouSXp3+zcBL8uFmZp3lIHsYi9khq32gtPrA2eQOTrjJSpP
         BVpEoRpaVJHJVXCA146JG3ndHIZQkMdSaRUdKdwWQ6LCmoKQ1LHsCxUEWsj7MBTeNs4Y
         nQfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791179719; x=1791784519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:references:in-reply-to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VSeMKRwiNGrLBbqvJujkzAnFb0MMN4emXRESg058oV0=;
        b=Xp/l9RpURuH0siY6Uh2/2a26GxQA0RBDyeVseOnBSuYk/pngv8vj3QSp7Y+F1misBJ
         2qlxtfdL4AU8ENiFPRo4tbcCw9EZUUf+Cym3xCUAWLjoaQWujISsbpcPmMm4YmWAFM31
         +ekhSmTISs/7rObLpPbqev38jxar4xbGaixKM95AkNKBmIMyzMQ674Jl/UScCzxWx63c
         BLPVMZ0gvq2TOHZbNCoUVCI/CKofjvQXF7wmTREen+PciJiGps2jtkgopUx6HNztwJlY
         SVe4ZZmYyg+5Jpozm+dlHvqUpWqAaLg/i6nkVIzL8ah2+jj+XH4RXZw/DgBuDoDLRsmb
         rL1g==
X-Gm-Message-State: AFuF++lIa2Gt+eaTydpbAD4tAU38RpjlskvLRTZEwIcOC/7MALcO002R
	So8i/2MLPFnnqLWCMf7B5rMdWU4uJ24j/MlZfHnYa6nKzV2N43xSv7F8rj/7gW82/Nsy0pLy5R+
	ZlDoUbWNezlj8xqfF9eGmuMklBmt948KeENn4DEHF1Q==
X-Gm-Gg: AYBFou0x9UBbJ7WFHANwWsZbeIjDZyamZidI2ia3PR16SrHLm7QrXJdnJ+SRQGFuONn
	gj6L3ohI6oq91y2cHElOfGSL5cQHCitzzo/ig2bfGwlvDrxgTGrY06kguyzFuv6ZgkM9GZIjfFL
	DZY20rov0k5DdBiDdxp4zhozTuGCXzZCIwDsn5tatWdp+wu5DuN5T7ff3brD9HbbtWVwwSbPV8Z
	tqE/vqVp4jIPzU0Gx3uxwSJT7vxfuHsV1axV7KgHZFmSHTalgtkHfMICnaYXiTpfNRF4+DGGWm0
	EbN/W6+AwD+H5o31ye1t4vtFG6cJ4Zz1f31GTW4ebmmmrSd7CbXeaQ==
X-Received: by 2002:a05:693c:8641:10b0:351:232c:6d79 with SMTP id
 5a478bee46e88-351232c8e7bmr5507302eec.12.1791179718926; Sun, 04 Oct 2026
 22:55:18 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 01:55:18 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Mon, 5 Oct 2026 01:55:18 -0400
In-Reply-To: <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
References: <20260929074222.11942-1-kazumasa.shigeta@kanamei.com>
 <20261001042155.33303-1-kazumasa.shigeta@kanamei.com> <xmqq7bk173qm.fsf@gitster.g>
 <CANUHOw1eO0HNjU+-PYNDOz9kHhBZYYfhiKJSX4082YSC1NKxww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6YeN55Sw5LiA6IGW?= <kazumasa.shigeta@kanamei.com>
Date: Mon, 5 Oct 2026 01:55:18 -0400
X-Gm-Features: AclHuK-ezyHPoyLyEpobqorEQSV7yUbRj5F3aYt_NdNxae80WO1ec5w5Ic1UtGo
Message-ID: <CANUHOw3gynMRGN7A-wOnL3PQtgFbMtsB2gyZxaq+0Z5bHp-H8A@mail.gmail.com>
Subject: Re: [PATCH v2] stash: expose untracked modes in create
To: gitster@pobox.com
Cc: git@vger.kernel.org, shabbir.r.bhojani@gmail.com, 
	phillip.wood@dunelm.org.uk, ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Junio,

> Why are we singling out only these two?

After looking more carefully at both the history and the current stash
code, I don't think there is a good reason to single out only `-u` and
`-a`.

Your question made me realize that I had focused too narrowly on the
untracked modes. The larger issue is not simply that `do_create_stash()`
has capabilities that `git stash create` does not expose. The existing
`git stash create <message>` grammar is a long-standing compatibility
contract that has been deliberately preserved.

Making more of those capabilities available through `create` would
therefore mean either changing that contract or designing around it.
That is a much larger interface decision than I appreciated when I sent
the patch.

I moved too quickly here and sent the patch before understanding that
constraint well enough. I am sorry about that. Thanks to you, Phillip,
Patrick, and everyone else who took the time to review it. I should
have investigated this compatibility history first.

Even so, I still think it would be useful to make more of the existing
`do_create_stash()` capabilities available through the public command
line.

So I no longer think the question is simply which additional options
`stash create` should expose. The broader question is how to make those
capabilities available through a public interface while dealing
appropriately with the existing `git stash create <message>`
compatibility contract.

From that perspective, I can see three possible directions.

1. Keep extending `stash create`.

   We could expose more of the existing `do_create_stash()`
   functionality through `stash create`, following the conventions of
   `stash push` for the creation-related options they have in common.

   This seems implementable, but even with
   `PARSE_OPT_STOP_AT_NON_OPTION` it would change the handling of
   messages that begin with an option-like argument. Those would need
   explicit disambiguation, such as `--`.

   There is also the pathspec question. If positional arguments
   continue to be joined to form the message, pathspecs need some other
   way to be distinguished from that message.

2. Add a new stash subcommand for the creation functionality.

   This would leave the existing `stash create <message>` contract
   unchanged. Because the new command would not inherit `create`'s
   positional message grammar, its creation-related options and
   pathspec handling could follow conventions similar to `stash push`.

   This preserves the existing `create` grammar while avoiding the need
   to fit additional creation capabilities into it. The trade-off is
   adding another public stash subcommand and its long-term maintenance
   cost.

3. Add something like `--create-only` to `git stash push`.

   This would reuse the existing `push` option grammar without adding
   another subcommand.

   I also read the 2019 discussion around `git stash push --snapshot`.
   One concern there was that approximately the same end state could
   already be obtained with `git stash push && git stash apply`.

   I do not think that particular concern carries over directly here.
   `git stash create` already stops at object creation, but its public
   interface does not expose more of the creation capabilities already
   available in `do_create_stash()`. There is currently no public stash
   command that exposes those capabilities while retaining that
   create-only boundary.

   That does not mean a similar result cannot be constructed by other
   means. The missing piece is a public interface to the existing stash
   creation machinery at that boundary.

   Even so, there is still the separate question of whether `push` is
   the right place for a creation-only operation in the first place.
   The push-specific work around `do_create_stash()` would also need to
   be separated carefully.

All three seem substantially broader than the original `-u` / `-a`
patch.

If this is worth pursuing further, which of these directions seems the
most plausible? Also, is this the right thread to continue that design
discussion, or would it be better to discuss it separately?

Thanks again for the guidance,
Kazumasa Shigeta

On Fri, 2 Oct 2026 05:04:26 -0400, "=E9=87=8D=E7=94=B0=E4=B8=80=E8=81=96" <=
kazumasa.shigeta@kanamei.com> wrote:
> Hi Junio,
>
> > we would prefer to hear what the user visible implication of
> > "passing 0" is more than what mechanically is happening inside a
> > program.
>
> The user-visible effect is that stash create cannot currently include
> untracked or ignored files in the stash entry. If those are the only
> changes, it creates no entry at all, while stash push and save can
> include them with -u or -a as appropriate. I should have described that
> difference directly instead of starting from the include_untracked
> implementation detail.
>
> > ... was what you wanted to say, but I am not sure.
>
> Yes, exactly. I'll explain the backward-compatibility reason rather
> than the mechanics of parse_options().
>
> > You already said that with "does not update, reset, or clean".
>
> I'll drop that paragraph.
>
> > if you did not make a breaking change to the established convention,
> > is it worth saying?
>
> I don't think it adds anything here. I'll remove the exit-status
> discussion from the commit message as well.
>
> > adding tests for comprehensive coverage is not something to boast
> > about. Is it worth saying?
>
> I'll remove the test details from the commit message.
>
> > Why are we singling out only these two?
>
> I started by looking at the missing -u and -a support in create, and I
> think that led me to focus too narrowly on those two when considering
> the scope. I need to think more about whether this patch should remain
> limited to those two.
>
> Thanks,
> Kazumasa Shigeta
>
> On Thu, 01 Oct 2026 10:03:13 -0700, Junio C Hamano <gitster@pobox.com> wr=
ote:
> > Kazumasa Shigeta <kazumasa.shigeta@kanamei.com> writes:
> >
> > > `git stash create` always passes zero for the include_untracked param=
eter
> > > of do_create_stash(), even though that helper already supports untrac=
ked
> > > and ignored files and stash push/save expose those modes as
> > > -u/--include-untracked and -a/--all.
> >
> > There may be no lies in what the above says, but we would prefer to
> > hear what the user visible implication of "passing 0" is more than
> > what mechanically is happening inside a program. For example:
> >
> > "git stash create", "git stash push", and "git stash save" are
> > commands that create a new stash entry. The latter two are also
> > responsible for storing the resulting stash entry to the reflog
> > of the "refs/stash" ref, but have options to control what is
> > included in the stash entry. Among these options, "create" only
> > supports the equivalent of "-m <message." to record in the stash
> > entry. Most notably, "-u" and "-a" options are missing.
> >
> > > Teach create to accept the same options and pass the existing mode
> > > through. Unlike push/save, create continues to only create objects: i=
t
> > > does not update refs/stash, reset the index, or clean the working tre=
e.
> >
> > Sure. It is a very concise and good description of what we want to
> > do.
> >
> > > Use parse_options() for the new options and stop parsing at the first
> > > non-option message word. This keeps option-like tokens after the mess=
age
> > > as message text, while leading option-like arguments now follow Git's
> > > normal option parsing. In particular, unknown or malformed leading
> > > options are rejected instead of silently becoming a message, short
> > > options may be combined, and `--` can be used when a message itself
> > > begins with a dash.
> >
> > Why do we need to go into such a detail in the log message? What is
> > the above paragraph designed to convey to the reader? Again, it may
> > not be telling any lies, but it misses the point by being inconsiderate
> > to your readers. What you need to tell them is _WHY_ you chose to
> > use parse_options() in such a way. What were you trying to achieve?
> >
> > I am guessing that something along this line ...
> >
> > "git stash create" traditionally treated the rest of the command
> > line as a message. For example,
> >
> > $ git stash create adding -u option
> >
> > has always been a request to create a stash entry with the
> > string "adding -u option" as its message. We should not make it
> > trigger the "-u" (include untracked) behavior for backward
> > compatibility, by using parse_options() with stop-at-the-non-option
> > mode to forbid it from reordering the command line arguments.
> >
> > ... was what you wanted to say, but I am not sure.
> >
> > How much of all these verbiage was written by AI by the way? You'd
> > need to spend effort to make it readable to humans.
> >
> > > Keep create's existing no-change behavior: detect the usual no-change
> > > case before do_create_stash() refreshes and writes the index, and ret=
urn
> > > success without printing an object name. If do_create_stash() still
> > > reports its internal "nothing to create" result, map that to create's
> > > public success status.
> >
> > You already said that with "does not update, reset, or clean".
> >
> > > This follows the stash subcommand exit-status convention established =
by
> > > 786fc390465f (stash: reserve exit status 1 for conflicts, 2026-09-03)=
:
> > > subcommands return 0 on success, negative values on failure, and stat=
us 1
> > > when applying a stash results in conflicts. cmd_stash() maps negative
> > > subcommand failures to 128.
> >
> > Again, there may not be lies in here, but if you did not make a
> > breaking change to the established convention, is it worth saying?
> >
> > > 9ca6326dff29 (stash: refactor stash_create, 2017-02-19) added the
> > > internal include-untracked path while intentionally leaving the user
> > > interface for "git stash create" unchanged. Reuse that machinery and
> > > the existing INCLUDE_ALL_FILES mode rather than adding a separate sta=
sh
> > > creation path.
> > >
> > > Add coverage for short and long aliases, combined short options, the
> > > untracked/ignored boundary including an ignored-only worktree, option
> > > parsing and dash-leading messages, no-change behavior, and preservati=
on
> > > of refs/stash, the index state, and the working tree.
> >
> > Again, adding tests for comprehensive coverage is not something to
> > boast about. Is it worth saying?
> >
> > Aren't -p/-S/-k/-q and pathspec support all about the creating half
> > of "git stash push" that are not available to "git stash create",
> > not just "-u" and "-a"? Why are we singling out only these two? It
> > may be more worthwhile to explain the rationale behind such a design
> > decision.
