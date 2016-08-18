Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB2F21F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbcHSCXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:23:42 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:34391 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753571AbcHSCXI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:23:08 -0400
Received: by mail-yw0-f196.google.com with SMTP id j12so400838ywb.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 19:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0lxqfNeWiSfhvrGKMk+nQH5ZY6JlaESfVXpQQcdH/4c=;
        b=ZXkAL/W2zX72CxMDJJL9WvH3MXrCTNVEo7aocD5JkTeI0rEefUlYySyz8EhVzIto/k
         PnVsMWkTLeFAPncImLiFIKc2WRqUdWKq4RoC8kMogJaidTNEHzOACo6FuNGVffDO98AX
         gQ9LIcANvAJbEri1Y+UB/6mAVGvgVkFyzsPpdvR5BhddVWf8KZZepDR6nkgx1SrQXy3/
         i3Tcs3P6vf5/j9NDLDxwcbnj5ghNU+BfuTJpwzpzV+Ow4qPfzgSc9j3sPAXPx3Wog7Ar
         rdWsbWUPP2tNo4j0+kjbyfga6RTK7mU+JTFGraDoTLOuawt+d5uPnMDmgQseOADzACtF
         MlmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0lxqfNeWiSfhvrGKMk+nQH5ZY6JlaESfVXpQQcdH/4c=;
        b=UDMrAbdYNKTjQudg3I516x+sRZ8yiQXba2FERcrOgP94a82YnwHGFxSyYcGCihYzqW
         QLL9l0XjB0wVdW0WIH+UykPeaXKvT2ds/Vk9i/Vyqo3pOCVJzObGn6Q4F5dtUFvbqEEw
         FNZtlsHMgY+osw2HqucOW7FwKNPNjf3Ya3p0yUCaSfa2SIa2vLAPvt17rNoy26BKb/Bu
         OdpVZhH7UBGX2IiMDUJL/DgwvQn70lv0Ki16K+9dVeAveA6K7yvR4GiWwSeq6oBgZD6F
         p5JwKfzuiYIeN2a/gpbeX1vZxjaYXJJ/+TXeIzf8B/8O9wwbyiEhoG7piE4fhG2wvYbI
         iqbQ==
X-Gm-Message-State: AEkoousn9TumFoGNb4Ey9F8bhhxR0V8Pri6yae7l7OhqM7G0+GGHVdogFTKK5ZBLkKCNDNCtwtSK8FQGnHVThQ==
X-Received: by 10.13.228.196 with SMTP id n187mr3379951ywe.83.1471551219145;
 Thu, 18 Aug 2016 13:13:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Thu, 18 Aug 2016 13:13:18 -0700 (PDT)
In-Reply-To: <CAGZ79kbD=4=epNz=rMn=38ZJnd1z3ne4VsmswAqODPDH=gDotQ@mail.gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-8-jacob.e.keller@intel.com> <CAGZ79kbD=4=epNz=rMn=38ZJnd1z3ne4VsmswAqODPDH=gDotQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Aug 2016 13:13:18 -0700
Message-ID: <CA+P7+xon_r+rjUpihzJoKnowf7jAEJ-Q1E4=GGgFdSBwYo=mng@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] diff: teach diff to display submodule difference
 with an inline diff
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 12:47 PM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> =
wrote:
>
>
>
>>         if (o->submodule_format =3D=3D DIFF_SUBMODULE_LOG &&
>>             (!one->mode || S_ISGITLINK(one->mode)) &&
>>             (!two->mode || S_ISGITLINK(two->mode))) {
>> @@ -2311,6 +2322,17 @@ static void builtin_diff(const char *name_a,
>>                                 two->dirty_submodule,
>>                                 meta, del, add, reset);
>>                 return;
>> +       } else if (o->submodule_format =3D=3D DIFF_SUBMODULE_INLINE_DIFF=
 &&
>> +                  (!one->mode || S_ISGITLINK(one->mode)) &&
>> +                  (!two->mode || S_ISGITLINK(two->mode))) {
>
> The ! mode is for added and deleted submodules, I guess?
>

I think so? I don't really know, but it was there before for
show_submodule_summary so I left it this way.

>> diff --git a/diff.h b/diff.h
>> index ea5aba668eaa..192c0eedd0ff 100644
>> --- a/diff.h
>> +++ b/diff.h
>> @@ -112,6 +112,7 @@ enum diff_words_type {
>>  enum diff_submodule_format {
>>         DIFF_SUBMODULE_SHORT =3D 0,
>>         DIFF_SUBMODULE_LOG,
>> +       DIFF_SUBMODULE_INLINE_DIFF,
>>  };
>>
>>  struct diff_options {
>> diff --git a/submodule.c b/submodule.c
>> index e341ca7ffefd..e5f1138f4362 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -436,6 +436,67 @@ void show_submodule_summary(FILE *f, const char *pa=
th,
>>                 clear_commit_marks(right, ~0);
>>  }
>>
>> +void show_submodule_inline_diff(FILE *f, const char *path,
>> +               const char *line_prefix,
>> +               unsigned char one[20], unsigned char two[20],
>> +               unsigned dirty_submodule, const char *meta,
>> +               const char *del, const char *add, const char *reset,
>> +               const struct diff_options *o)
>> +{
>> +       const char *old =3D EMPTY_TREE_SHA1_BIN, *new =3D EMPTY_TREE_SHA=
1_BIN;
>
> submodule.c: In function =E2=80=98show_submodule_inline_diff=E2=80=99:
> cache.h:957:3: warning: pointer targets in initialization differ in
> signedness [-Wpointer-sign]
>    ((const unsigned char *) EMPTY_TREE_SHA1_BIN_LITERAL)
>
> submodule.c:446:20: note: in expansion of macro =E2=80=98EMPTY_TREE_SHA1_=
BIN=E2=80=99
>   const char *old =3D EMPTY_TREE_SHA1_BIN, *new =3D EMPTY_TREE_SHA1_BIN;
>

This should actually be "EMPTY_TREE_SHA1_BIN_LITERAL, and these should
be unsigned, you're right. This will be fixed differently by using
struct object_id * instead, though.

Thanks,
Jake

>
>
>> +       struct commit *left =3D NULL, *right =3D NULL;
>> +       struct strbuf submodule_dir =3D STRBUF_INIT;
>> +       struct child_process cp =3D CHILD_PROCESS_INIT;
>> +
>> +       show_submodule_header(f, path, line_prefix, one, two, dirty_subm=
odule,
>> +                             meta, reset, &left, &right);
>> +
>> +       /* We need a valid left and right commit to display a difference=
 */
>> +       if (!(left || is_null_sha1(one)) ||
>> +           !(right || is_null_sha1(two)))
>> +               goto done;
>> +
>> +       if (left)
>> +               old =3D one;
>
> submodule.c:460:7: warning: pointer targets in assignment differ in
> signedness [-Wpointer-sign]
>    old =3D one;
>
>

This will also be fixed by switching to object_id.

>
>> +       if (right)
>> +               new =3D two;
>> +
>> +       fflush(f);
>> +       cp.git_cmd =3D 1;
>> +       cp.dir =3D path;
>> +       cp.out =3D dup(fileno(f));
>> +       cp.no_stdin =3D 1;
>> +
>> +       /* TODO: other options may need to be passed here. */
>> +       argv_array_pushl(&cp.args, "diff");
>> +       argv_array_pushf(&cp.args, "--line-prefix=3D%s", line_prefix);
>> +       if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
>> +               argv_array_pushf(&cp.args, "--src-prefix=3D%s%s/",
>> +                                o->b_prefix, path);
>> +               argv_array_pushf(&cp.args, "--dst-prefix=3D%s%s/",
>> +                                o->a_prefix, path);
>> +       } else {
>> +               argv_array_pushf(&cp.args, "--src-prefix=3D%s%s/",
>> +                                o->a_prefix, path);
>> +               argv_array_pushf(&cp.args, "--dst-prefix=3D%s%s/",
>> +                                o->b_prefix, path);
>> +       }
>> +       argv_array_push(&cp.args, sha1_to_hex(old));
>
> submodule.c:484:2: warning: pointer targets in passing argument 1 of
> =E2=80=98sha1_to_hex=E2=80=99 differ in signedness [-Wpointer-sign]
>   argv_array_push(&cp.args, sha1_to_hex(old));
>
>
> /*
>  * nit: the following comment doesn't adhere to Gits way of doing comment=
s:
>  */
>

Yea, sorry. I have a habbit of the other format because the Linux
kernel networking tree requires this style, despite the rest of the
Linux kernel requiring the style used by git. So, I have to break out
of that habbit but sometimes I miss them.

>> +       /* If the submodule has modified content, we will diff against t=
he
>> +        * work tree, under the assumption that the user has asked for t=
he
>> +        * diff format and wishes to actually see all differences even i=
f they
>> +        * haven't yet been committed to the submodule yet.
>> +        */
>
> Makes sort of sense when new is HEAD.
>
> However if I have given an explicit sha1 in the superproject, e.g.:
>
>     # (in the e.g. gerrit with a dirty submodule, I'd still expect to
>     # get the dirtyness ignored, but the diff of those two states?)
>     git diff --submodule=3Ddiff  cc82b24..5222e66 plugins/
>

AFAIK it actually does, because dirty_submodule won't be set with
DIRTY_SUBMODULE_MODIFIED unless you're actually diffing against the
index or worktree directly. So if you diff two commits they never show
these flags regardless of what's in your work tree.

If you diff some commit against your work tree then you might have
this flag set.

>> +
>> +test_expect_success 'added submodule' '
>> +       git add sm1 &&
>> +       git diff-index -p --submodule=3Ddiff HEAD >actual &&
>> +       cat >expected <<-EOF &&
>> +       Submodule sm1 0000000...1beffeb (new submodule)
>
> Do we also want to make the 1beffeb a variable?
>

Sure

>> +       cat >expected <<-EOF &&
>> +       Submodule sm1 0000000...$head1 (new submodule)
>
> In the prior test we have spelled out the sha1s, here we refer to a varia=
ble?
>

I copied these from another file and modified them to use diff, but I
can work this to use variables consistently.

>
>> +       EOF
>> +       git config --unset diff.submodule &&
>
>     Use this one weird trick to make the tests more readable!
>     Use "test_config" from test-lib-functions.sh
>     (# Set git config, automatically unsetting it after the test is over.=
)
>     (I am involved in Git for 3 years now, but just recently was pointed =
at it)

Yea, this was copied directly from another test file and modified to
use "inline diff" format instead of log format, which is why some of
these are done this way. I'll switch this to test_config.

Thanks,
Jake
