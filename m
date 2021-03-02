Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C4EC433E9
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D353864EBA
	for <git@archiver.kernel.org>; Wed,  3 Mar 2021 06:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348032AbhCCGbu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Mar 2021 01:31:50 -0500
Received: from mout.web.de ([212.227.15.14]:55649 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1448984AbhCBQD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 11:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1614700832;
        bh=9jkbUrQ0EK/xEm1d2usSpNcuJUUY1tLKzItnSgSDr2k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=V5/JiZ+D2hLweqiLC4NfjqaQMfFBW/4oVISP6sYUHCqJHrHaM1Zbgu1OymyRSSby5
         tsqWftX9nGsHM7L8AMVYGPDXSs9y/2WL2mXh3NBkKJwO3XCzKz9xvxAi67LyXHe89h
         o1UARxOignsU6CzGGac4KjqTt5sxgtyN0X7jR0Ew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M5j1q-1l9ztt3Nv8-007Ozo; Tue, 02 Mar 2021 17:00:31 +0100
Subject: Re: [PATCH 2/2] pretty: add merge and exclude options to %(describe)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Eli Schwartz <eschwartz@archlinux.org>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
 <b7bd37c4-ab13-0297-da46-716e26de10d6@web.de>
 <YC1hHYeCmC6+heWZ@coredump.intra.peff.net>
 <b7e1f6c0-6b13-efe4-74b5-ec8249855644@web.de>
 <87blc4kxo3.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <30f78fce-fe1a-0a50-fa8c-e6fe14a03bf3@web.de>
Date:   Tue, 2 Mar 2021 17:00:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <87blc4kxo3.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gGw1ARUnJQzSkWLis9PUxp8Kjslv0bWN7yAEiYFsGhl979hpZd0
 EiGCF++r9HMEsPPVwRGrLST3kdGE98RO8/koJYNnac9jeZ46lR1gg3MF45wFHNJHcLPFbqD
 nN7w5AUTOUIHNQ7EwWdG7z/ZrLj6/KE+g75dnT9yEppCHHhjnxEOVDxo8V/exjwLORvBCKF
 MeGUHgIroC9X6EVYmb/PA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KlQyRx5jV8A=:1LfW7rsyX1V4WNHB50xLuK
 YmeTtaPdaoR3X7e5SU2QI0Zxg168RGSWguhPSzDBiipHSSiUxR6xn5X+n3vDUmYVvPxPLLIgm
 um55GH37p4aoj5GXPmeEqd6Gx/kH6qK2NQnf4fCUDYDwEzgOWSdTbpKy0JPuZEZRk5aPobBk4
 sIvc9L8SKS+PRTBW/lAvanJ/1stiJ+aO6of2SDAbmBDoV/yDQxAN8GqSCtfT4TLx2PsNvh9K/
 yrBBnIvaYuZNbnD5Uj1LWWhfTe6bDqrBvTi+6va4KFWS28I3UTxNFNSiUK9f5yPugF72XNDXZ
 4G0mnBPXFYZsJ009pgmTBGAqnKyCXud/S4WsUPPgLETQ7B6hIFFxesnDmqBJug4VAeIEyYV8+
 Yh4YRohat1xeAHLGMoJRBaXsBuHk/kZfLxxHZF011deVukbQmBRsmQVdfivi2D5MGMBz50LQy
 6X75RBECeaujgRYXU2La6avu5k0DecxMLVyyPSP3pwF0d5JPGVK8+z6zTQusLIE+WprnZVT4l
 zrRSmCioKucxDZr/brNmKmhWM33ouLXSvY1pCF+tpRw8+6nFTUQJTlgMPivD6sntVIyzOmoRo
 TesTDXwOCXIYVHvPsQXRVuJ0vUB/+v/qICVGVqZ4GLCSFp8KPiyjXqUGFEgddUlSPWlFKp+yp
 HXYAFD2BnQyH/cRE9L9qxYvuhjkgqL8hFZUrEXhTIhsSiGA79FZiXL7MS6RdnJOZZ/fo2XEWe
 Khc+xcoWChfHqW6wCUx8xm6r6lf6owqRqbEnQqH4w0qP8y4Cs4cxfp3WoMOIqK7cLY1xY32v4
 2A/vs2VDsFnc3j5z8RWY3YU/jK54RwKXmpQ8DQetQ98u/sMd4XicTcvch8xbMZr5aMUPogll6
 GjRv1TNFMBCnoATIus2Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 28.02.21 um 16:41 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Sun, Feb 28 2021, Ren=C3=A9 Scharfe. wrote:
>
>> Am 17.02.21 um 19:31 schrieb Jeff King:
>>> On Sun, Feb 14, 2021 at 11:10:57AM +0100, Ren=C3=A9 Scharfe. wrote:
>>>
>>>> Allow restricting the tags used by the placeholder %(describe) with t=
he
>>>> options match and exclude.  E.g. the following command describes the
>>>> current commit using official version tags, without those for release
>>>> candidates:
>>>>
>>>>    $ git log -1 --format=3D'%(describe:match=3Dv[0-9]*,exclude=3D*rc*=
)'
>>>
>>> An interesting side effect of this series is that it allows remote use=
rs
>>> asking for archives to fill in this data, too (by using export-subst
>>> placeholders). That includes servers allowing "git archive --remote",
>>> but also services like GitHub that will run git-archive on behalf of
>>> clients.
>>>
>>> I wonder what avenues for mischief this provides. Certainly using extr=
a
>>> CPU to run git-describe.
>>
>> A repository can contain millions of files, each file can contain
>> millions of $Format:...$ sequences and each of them can contain million=
s
>> of %(describe) placeholders.  Each of them could have different match o=
r
>> exclude args to prevent caching.  Allowing a single request to cause
>> trillions of calls of git describe sounds excessive.  Let's limit this.
>>
>> -- >8 --
>> Subject: [PATCH] archive: expand only a single %(describe) per archive
>>
>> Every %(describe) placeholder in $Format:...$ strings in files with the
>> attribute export-subst is expanded by calling git describe.  This can
>> potentially result in a lot of such calls per archive.  That's OK for
>> local repositories under control of the user of git archive, but could
>> be a problem for hosted repositories.
>>
>> Expand only a single %(describe) placeholder per archive for now to
>> avoid denial-of-service attacks.  We can make this limit configurable
>> later if needed, but let's start out simple.
>>
>> Reported-by: Jeff King <peff@peff.net>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  Documentation/gitattributes.txt |  3 ++-
>>  archive.c                       | 16 ++++++++++------
>>  archive.h                       |  2 ++
>>  pretty.c                        |  8 ++++++++
>>  pretty.h                        |  5 +++++
>>  t/t5001-archive-attr.sh         | 14 ++++++++++++++
>>  6 files changed, 41 insertions(+), 7 deletions(-)
>>
>> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattribu=
tes.txt
>> index e84e104f93..0a60472bb5 100644
>> --- a/Documentation/gitattributes.txt
>> +++ b/Documentation/gitattributes.txt
>> @@ -1174,7 +1174,8 @@ tag then no replacement will be done.  The placeh=
olders are the same
>>  as those for the option `--pretty=3Dformat:` of linkgit:git-log[1],
>>  except that they need to be wrapped like this: `$Format:PLACEHOLDERS$`
>>  in the file.  E.g. the string `$Format:%H$` will be replaced by the
>> -commit hash.
>> +commit hash.  However, only one `%(describe)` placeholder is expanded
>> +per archive to avoid denial-of-service attacks.
>>
>>
>>  Packing objects
>> diff --git a/archive.c b/archive.c
>> index 5919d9e505..2dd2236ae0 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -37,13 +37,10 @@ void init_archivers(void)
>>
>>  static void format_subst(const struct commit *commit,
>>  			 const char *src, size_t len,
>> -			 struct strbuf *buf)
>> +			 struct strbuf *buf, struct pretty_print_context *ctx)
>>  {
>>  	char *to_free =3D NULL;
>>  	struct strbuf fmt =3D STRBUF_INIT;
>> -	struct pretty_print_context ctx =3D {0};
>> -	ctx.date_mode.type =3D DATE_NORMAL;
>> -	ctx.abbrev =3D DEFAULT_ABBREV;
>>
>>  	if (src =3D=3D buf->buf)
>>  		to_free =3D strbuf_detach(buf, NULL);
>> @@ -61,7 +58,7 @@ static void format_subst(const struct commit *commit,
>>  		strbuf_add(&fmt, b + 8, c - b - 8);
>>
>>  		strbuf_add(buf, src, b - src);
>> -		format_commit_message(commit, fmt.buf, buf, &ctx);
>> +		format_commit_message(commit, fmt.buf, buf, ctx);
>>  		len -=3D c + 1 - src;
>>  		src  =3D c + 1;
>>  	}
>> @@ -94,7 +91,7 @@ static void *object_file_to_archive(const struct arch=
iver_args *args,
>>  		strbuf_attach(&buf, buffer, *sizep, *sizep + 1);
>>  		convert_to_working_tree(args->repo->index, path, buf.buf, buf.len, &=
buf, &meta);
>>  		if (commit)
>> -			format_subst(commit, buf.buf, buf.len, &buf);
>> +			format_subst(commit, buf.buf, buf.len, &buf, args->pretty_ctx);
>>  		buffer =3D strbuf_detach(&buf, &size);
>>  		*sizep =3D size;
>>  	}
>> @@ -633,12 +630,19 @@ int write_archive(int argc, const char **argv, co=
nst char *prefix,
>>  		  const char *name_hint, int remote)
>>  {
>>  	const struct archiver *ar =3D NULL;
>> +	struct pretty_print_describe_status describe_status =3D {0};
>> +	struct pretty_print_context ctx =3D {0};
>>  	struct archiver_args args;
>>  	int rc;
>>
>>  	git_config_get_bool("uploadarchive.allowunreachable", &remote_allow_u=
nreachable);
>>  	git_config(git_default_config, NULL);
>>
>> +	describe_status.max_invocations =3D 1;
>> +	ctx.date_mode.type =3D DATE_NORMAL;
>> +	ctx.abbrev =3D DEFAULT_ABBREV;
>> +	ctx.describe_status =3D &describe_status;
>> +	args.pretty_ctx =3D &ctx;
>>  	args.repo =3D repo;
>>  	args.prefix =3D prefix;
>>  	string_list_init(&args.extra_files, 1);
>> diff --git a/archive.h b/archive.h
>> index 33551b7ee1..49fab71aaf 100644
>> --- a/archive.h
>> +++ b/archive.h
>> @@ -5,6 +5,7 @@
>>  #include "pathspec.h"
>>
>>  struct repository;
>> +struct pretty_print_context;
>>
>>  struct archiver_args {
>>  	struct repository *repo;
>> @@ -22,6 +23,7 @@ struct archiver_args {
>>  	unsigned int convert : 1;
>>  	int compression_level;
>>  	struct string_list extra_files;
>> +	struct pretty_print_context *pretty_ctx;
>>  };
>>
>>  /* main api */
>> diff --git a/pretty.c b/pretty.c
>> index c612d2ac9b..032e89cd4e 100644
>> --- a/pretty.c
>> +++ b/pretty.c
>> @@ -1247,6 +1247,14 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
>>  		struct child_process cmd =3D CHILD_PROCESS_INIT;
>>  		struct strbuf out =3D STRBUF_INIT;
>>  		struct strbuf err =3D STRBUF_INIT;
>> +		struct pretty_print_describe_status *describe_status;
>> +
>> +		describe_status =3D c->pretty_ctx->describe_status;
>> +		if (describe_status) {
>> +			if (!describe_status->max_invocations)
>> +				return 0;
>> +			describe_status->max_invocations--;
>> +		}
>>
>>  		cmd.git_cmd =3D 1;
>>  		strvec_push(&cmd.args, "describe");
>> diff --git a/pretty.h b/pretty.h
>> index 7ce6c0b437..27b15947ff 100644
>> --- a/pretty.h
>> +++ b/pretty.h
>> @@ -23,6 +23,10 @@ enum cmit_fmt {
>>  	CMIT_FMT_UNSPECIFIED
>>  };
>>
>> +struct pretty_print_describe_status {
>> +	unsigned int max_invocations;
>> +};
>> +
>>  struct pretty_print_context {
>>  	/*
>>  	 * Callers should tweak these to change the behavior of pp_* function=
s.
>> @@ -44,6 +48,7 @@ struct pretty_print_context {
>>  	int color;
>>  	struct ident_split *from_ident;
>>  	unsigned encode_email_headers:1;
>> +	struct pretty_print_describe_status *describe_status;
>>
>>  	/*
>>  	 * Fields below here are manipulated internally by pp_* functions and
>> diff --git a/t/t5001-archive-attr.sh b/t/t5001-archive-attr.sh
>> index e9aa97117a..1c9ce3956b 100755
>> --- a/t/t5001-archive-attr.sh
>> +++ b/t/t5001-archive-attr.sh
>> @@ -128,4 +128,18 @@ test_expect_success 'export-subst' '
>>  	test_cmp substfile2 archive/substfile2
>>  '
>>
>> +test_expect_success 'export-subst expands %(describe) once' '
>> +	echo "\$Format:%(describe)\$" >substfile3 &&
>> +	echo "\$Format:%(describe)\$" >>substfile3 &&
>> +	echo "\$Format:%(describe)${LF}%(describe)\$" >substfile4 &&
>> +	git add substfile[34] &&
>> +	git commit -m export-subst-describe &&
>> +	git tag -m export-subst-describe export-subst-describe &&
>> +	git archive HEAD >archive-describe.tar &&
>> +	extract_tar_to_dir archive-describe &&
>> +	desc=3D$(git describe) &&
>> +	grep -F "$desc" archive-describe/substfile[34] >substituted &&
>> +	test_line_count =3D 1 substituted
>> +'
>> +
>>  test_done
>
> This whole thing seems rather backwards as a solution to the "we run it
> N times" problem I mentioned in <87k0r7a4sr.fsf@evledraar.gmail.com>.

In the referenced message you pointed out that using %(describe) more
than once incurs the cost of a call to "git describe" each time and
asked for a way to avoid that.

This patch here prevents the second and later calls for "git archive".
It's not intended to speed up expanding repeated placeholders, but
rather to reject maliciously crafted placeholders even if they are not
the same.

So does that mean you have the requirement to use %(describe) more
than once in the same archive, and this DoS protection would be too
strict for you?  In that case we'd need a way to increase the limit,
e.g. a configuration variable or command line option.  Otherwise I
don't see the connection between your message and this patch.

Side note: Keeping the "git describe" running and feeding it commits
one by one through a pipe (with a new --stdin option, I suppose) as
mentioned in <66720982-04d6-3096-9ea2-ea5bc3fcd121@web.de> would
speed up expanding repeated placeholders as well.

> Instead of taking the trouble of putting a limit in the
> pretty_print_context so we don't call it N times for the same commit,
> why not just put the strbuf with the result in that same struct?
>
> Then you can have it millions of times, and it won't be any more
> expensive than the other existing %(format) specifiers (actually cheaper
> than most).

Each %(describe) placeholder can have a unique set of match or exclude
arguments.  Caching them all would increase the strength of a DoS
attack.  Caching a few of them would be OK, but is ineffective in
reducing the strength of the attack.

> Or is there some edge case I'm missing here where "git archive" can
> either be fed N commits and we share the context, or we share the
> context across formatting different revisions in some cases?

git archive currently works only on a single commit.

Ren=C3=A9
