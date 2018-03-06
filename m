Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2531F404
	for <e@80x24.org>; Tue,  6 Mar 2018 18:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753071AbeCFS0C (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Mar 2018 13:26:02 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52682 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753308AbeCFS0B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Mar 2018 13:26:01 -0500
Received: by mail-wm0-f67.google.com with SMTP id t3so28273wmc.2
        for <git@vger.kernel.org>; Tue, 06 Mar 2018 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=S2kcdgoBP3bfNsINxmAccWab4blIPTGa299e1B6fu0o=;
        b=oEAGmFcpdIs6GHLMWjTMdRA0HP3XllgoG04mOjBhypiLauWvA8n3jLr+eE1B6XDtY9
         wo8bZA9KNI8gXMX92VDEIoH0AWL+dUZo8bZVdHKlM1BUAPTIOQ3qFBCawB4G3NlBtzTP
         vAHpDGakpo9ilUrAldeACQplECCqZ4v3B/y4rVU32UESGpIGbMAHO6TMMwrSKwHVOQB+
         Js2PNH2Dm3Nmknvx2J8uFSd4nImZdeugOxw1qrO0KiR47cahkt1rAGAu7Br6ujVo+CrI
         9nFr1NxXokf/MP3eEoGVKf4fRxSg674yot/tTrNv7tt+OT+uTuZqAwig4PL7SWjua4Uy
         wa2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=S2kcdgoBP3bfNsINxmAccWab4blIPTGa299e1B6fu0o=;
        b=Ln92JcKlDhz/pK032mx1Cecazn4LRjMLwevt1G6K/gnFOk7T3tnS4j3kOWVFrqU/e+
         ppQ6y3iXhgFVzVL4lCqX6ETwL7TPpxM5ciJ1943kWUqPS1/65HUb0wIXAxTytj+k1bcL
         s1iN/F8YjdJsp1YIh+eMbudGqqZ0nH7N/PjQGxcKWwmKW1i5NcMtQKhR40ELtf0WZnDT
         6Jx1mDBA5bEeMaLu3JFhr7hHpI30cAFmtwPVk9Y0xyBjKGovC+Z97xZm60DL8SZAkLLQ
         jA91+jqhnL7eep0Q/dh7uEKwRUUVM8KceRXHHfZrsflO9PwgL8QmA8lXfHm7SYZ0O4+S
         2KXw==
X-Gm-Message-State: AElRT7H7qM5EFZNhxFMMwVT4gUTpuUQlBY06eDcCZSZMp1C0GCpCrJDn
        qQBiGOcTGCWQLM5OeXgZgPY=
X-Google-Smtp-Source: AG47ELsEHvcof8vP+w8PI4JUo6Dm4hBYQu2TUzC4tN8WnDMjMTwLwsmuAW6CJnelAnOmSgDkWlikkg==
X-Received: by 10.28.1.208 with SMTP id 199mr12009876wmb.26.1520360759672;
        Tue, 06 Mar 2018 10:25:59 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l22sm19699645wre.52.2018.03.06.10.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Mar 2018 10:25:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, peff@peff.net,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH v2 2/5] repack: add --keep-pack option
References: <20180301092046.2769-1-pclouds@gmail.com>
        <20180306104158.6541-1-pclouds@gmail.com>
        <20180306104158.6541-3-pclouds@gmail.com>
Date:   Tue, 06 Mar 2018 10:25:58 -0800
In-Reply-To: <20180306104158.6541-3-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 6 Mar 2018 17:41:55 +0700")
Message-ID: <xmqq1sgx5adl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +--keep-pack=<pack name>::
> +	Ignore the given pack. This is the equivalent of having
> +	`.keep` file on the pack. Implies `--honor-pack-keep`.
> +

A few questions I am not sure how I would answer:

 - Do we want to have this listed in the SYNOPSIS section, too?

 - We would want to make the SP in "<pack name>" consistent with
   the dash in "<missing-action>" in the same document; which way do
   we make it uniform?

 - Is this description clear enough to convey that we allow more
   than one instance of this option specified, and the pack names
   accumulate?

 - Are there use cases where we want to _ignore_ on-disk ".keep" and
   only honor the ones given via the "--keep-pack" options?

 - Is this description clear enough to convey that <pack name> is
   just the filename part (i.e. "pack-[0-9a-f]{40}.pack") in our
   local $GIT_OBJECT_DIRECTORY/pack/ and not a full path to the
   packfile?  I think that design is sensible, simplifies the
   implementation and reduces mistakes.

> +static void add_extra_kept_packs(const struct string_list *names)
> +{
> +	struct packed_git *p;
> +
> +	if (!names->nr)
> +		return;
> +
> +	prepare_packed_git();
> +	for (p = packed_git; p; p = p->next) {
> +		const char *name = basename(p->pack_name);
> +		int i;
> +
> +		if (!p->pack_local)
> +			continue;
> +
> +		for (i = 0; i < names->nr; i++) {
> +			if (fspathcmp(name, names->items[i].string))
> +				continue;
> +
> +			p->pack_keep = 1;
> +			ignore_packed_keep = 1;
> +			break;
> +		}
> +	}
> +}

OK.

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 7bdb40142f..6a1dade0e1 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -86,7 +86,8 @@ static void remove_pack_on_signal(int signo)
>   * have a corresponding .keep or .promisor file. These packs are not to
>   * be kept if we are going to pack everything into one file.
>   */
> -static void get_non_kept_pack_filenames(struct string_list *fname_list)
> +static void get_non_kept_pack_filenames(struct string_list *fname_list,
> +					const struct string_list *extra_keep)
>  {
>  	DIR *dir;
>  	struct dirent *e;
> @@ -97,6 +98,14 @@ static void get_non_kept_pack_filenames(struct string_list *fname_list)
>  
>  	while ((e = readdir(dir)) != NULL) {
>  		size_t len;
> +		int i;
> +
> +		for (i = 0;i < extra_keep->nr; i++)

Style: SP after ';' before 'i'.

> +			if (!fspathcmp(e->d_name, extra_keep->items[i].string))
> +				break;
> +		if (extra_keep->nr > 0 && i < extra_keep->nr)
> +			continue;
> +
>  		if (!strip_suffix(e->d_name, ".pack", &len))
>  			continue;

> diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> index 38247afbec..553d907d34 100755
> --- a/t/t7700-repack.sh
> +++ b/t/t7700-repack.sh
> @@ -196,5 +196,24 @@ test_expect_success 'objects made unreachable by grafts only are kept' '
>  	git cat-file -t $H1
>  '
>  
> +test_expect_success 'repack --keep-pack' '
> +	test_create_repo keep-pack &&
> +	(
> +		cd keep-pack &&
> +		for cmit in one two three four; do
> +			test_commit $cmit &&
> +			git repack -d
> +		done &&

Style: replace "; " before do with LF followed by a few HT.

This 'for' loop would not exit and report error if an early
test_commit or "git repack -d" fails, would it?

> +		( cd .git/objects/pack && ls *.pack ) >pack-list &&
> +		test_line_count = 4 pack-list &&
> +		KEEP1=`head -n1 pack-list` &&
> +		KEEP4=`tail -n1 pack-list` &&

Style: $()

> +		git repack -a -d --keep-pack $KEEP1 --keep-pack $KEEP4 &&
> +		ls .git/objects/pack/*.pack >new-counts &&
> +		test_line_count = 3 new-counts &&
> +		git fsck

One important invariant for this new feature is that $KEEP1 and
$KEEP4 will both appear in new-counts file, no?  Rename new-counts
to new-pack-list and inspect the contents, not just line count,
perhaps?

> +	)
> +'
> +
>  test_done
