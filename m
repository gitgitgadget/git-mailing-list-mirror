Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2708420193
	for <e@80x24.org>; Sat, 13 Aug 2016 07:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778AbcHMHeF (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 03:34:05 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35390 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbcHMHeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 03:34:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so1289710wmg.2
        for <git@vger.kernel.org>; Sat, 13 Aug 2016 00:34:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=xuN5yH5WYloRveutJtTb6c24NiH0TGVYdx0EDbftVsM=;
        b=iQ3I6eSxqU7mN3DdAwf8eb4PXTXS0TksN1UO7SCYK0RCYvRSvkQQSPh2Mms4y5Yjg7
         P5lKybpgqYVuas1QeH2mO6x6SmascIsWunRVYZZJ1oimLB4c2pNN09Z6VrLfH8QcjKZY
         ot4IJ7pRi8lKGDr24/2t6nVlCqZCmaBmr6knxINDUBeJwSHaerK7OLVg4i2IKUvp015y
         hELWNiXwI20suhh4XPMuejxLr7ap/hdOtvGX6QCFCrjzjTv4WNmYqhmDolauXOS0hvuf
         9CS/NjHkvq6Z9/J1Yd0SOSbGuJayIhxIbsMjiJ8iaKKtrAK315cKA1TtWxsOAG4+ZiM7
         Z2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=xuN5yH5WYloRveutJtTb6c24NiH0TGVYdx0EDbftVsM=;
        b=GIwFMMFgUkVilPyEk6mqNrf76JCshu0xjGc6JGR/N75AJFqPkcEzCXYCBY8Gk6gzlD
         d3ps1MHglhYXm2ltdbJlIdwI+xqqnOOX/s+wsmBxUf5fDRvWazm0WM1Qi2pURhGEjZ0q
         c2wpj9GuTtOCg87pogYeiKkhaK8fMgP75bRGyTdDd+kK24y422vKSFqXeeXMLN+gpcTI
         f9xBsIXlhbK+X0zbaJuWzG5MvFBdXAyFerHypa25L37asx5i4Hy1gj8Yw0JRKn0jWRZC
         6c9oX/MKQTmsRQdKPFUPlTwELNGEy9MydI2apFpDWJsATWB/nXOM6+m/Rz78JVEjoNm3
         T0ww==
X-Gm-Message-State: AEkoouuEQgUJIREUaG4141rufA2n7kwqKuKZeKN4SV+w0ylEbhMAznekqF/+dIlRyL4BYpqaX9+loBSyKdcnog==
X-Received: by 10.194.87.101 with SMTP id w5mr22615270wjz.94.1471073642664;
 Sat, 13 Aug 2016 00:34:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.70.167 with HTTP; Sat, 13 Aug 2016 00:34:02 -0700 (PDT)
In-Reply-To: <010201567675ae72-0e0eeb11-e488-4562-8837-2443cbfe0792-000000@eu-west-1.amazonses.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
 <010201567675ae72-0e0eeb11-e488-4562-8837-2443cbfe0792-000000@eu-west-1.amazonses.com>
From:	Christian Couder <christian.couder@gmail.com>
Date:	Sat, 13 Aug 2016 09:34:02 +0200
Message-ID: <CAP8UFD1pUOUKKMQLsyTMtSBUG3s340vOjrGqRpC-CGzuyQXwzA@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] bisect--helper: `bisect_start` shell function
 partially in C
To:	Pranit Bauva <pranit.bauva@gmail.com>
Cc:	git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 10, 2016 at 11:57 PM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
>
> @@ -431,6 +434,244 @@ static int bisect_terms(struct bisect_terms *terms, const char **argv, int argc)
>         return 0;
>  }
>
> +static int bisect_start(struct bisect_terms *terms, int no_checkout,
> +                       const char **argv, int argc)
> +{
> +       int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
> +       int flags, pathspec_pos;
> +       struct string_list revs = STRING_LIST_INIT_DUP;
> +       struct string_list states = STRING_LIST_INIT_DUP;
> +       struct strbuf start_head = STRBUF_INIT;
> +       struct strbuf bisect_names = STRBUF_INIT;
> +       struct strbuf orig_args = STRBUF_INIT;
> +       const char *head;
> +       unsigned char sha1[20];
> +       FILE *fp;
> +       struct object_id oid;
> +
> +       if (is_bare_repository())
> +               no_checkout = 1;
> +
> +       for (i = 0; i < argc; i++) {
> +               char *commit_id = xstrfmt("%s^{commit}", argv[i]);
> +               if (!strcmp(argv[i], "--")) {
> +                       has_double_dash = 1;
> +                       break;
> +               }

In the shell code there is a loop dedicated to checking if there is a
double dash in the arguments before the real argument parsing loop.
There is a reason for that.
If you do it in the same loop, has_double_dash will not be set when
the arguments that are before the double dash will be parsed.

> +               else if (!strcmp(argv[i], "--no-checkout"))
> +                       no_checkout = 1;
> +               else if (!strcmp(argv[i], "--term-good") ||
> +                        !strcmp(argv[i], "--term-old")) {
> +                       must_write_terms = 1;
> +                       strbuf_reset(&terms->term_good);
> +                       strbuf_addstr(&terms->term_good, argv[++i]);
> +               }
> +               else if (skip_prefix(argv[i], "--term-good=", &argv[i])) {

(Maybe you could put the "else if (...) {" on the same line as the "}" above.)

> +                       must_write_terms = 1;
> +                       strbuf_reset(&terms->term_good);
> +                       strbuf_addstr(&terms->term_good, argv[i]);
> +               }
> +               else if (skip_prefix(argv[i], "--term-old=", &argv[i])) {
> +                       must_write_terms = 1;
> +                       strbuf_reset(&terms->term_good);
> +                       strbuf_addstr(&terms->term_good, argv[i]);
> +               }
> +               else if (!strcmp(argv[i], "--term-bad") ||
> +                        !strcmp(argv[i], "--term-new")) {
> +                       must_write_terms = 1;
> +                       strbuf_reset(&terms->term_bad);
> +                       strbuf_addstr(&terms->term_bad, argv[++i]);
> +               }
> +               else if (skip_prefix(argv[i], "--term-bad=", &argv[i])) {
> +                       must_write_terms = 1;
> +                       strbuf_reset(&terms->term_bad);
> +                       strbuf_addstr(&terms->term_bad, argv[i]);
> +               }
> +               else if (skip_prefix(argv[i], "--term-new=", &argv[i])) {
> +                       must_write_terms = 1;
> +                       strbuf_reset(&terms->term_good);
> +                       strbuf_addstr(&terms->term_good, argv[i]);
> +               }
> +               else if (starts_with(argv[i], "--") &&
> +                        !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
> +                       string_list_clear(&revs, 0);
> +                       string_list_clear(&states, 0);
> +                       die(_("unrecognised option: '%s'"), argv[i]);
> +               }
> +               else if (get_oid(argv[i], &oid) && !has_double_dash) {

And here checking "!has_double_dash" has no meaning if you check for a
double dash in the same loop, because there is a "break" after
has_double_dash is set above.

> +                       string_list_clear(&revs, 0);
> +                       string_list_clear(&states, 0);
> +                       free(commit_id);
> +                       die(_("'%s' does not appear to be a valid revision"), argv[i]);
> +               }
> +               else {
> +                       free(commit_id);
> +                       string_list_append(&revs, oid_to_hex(&oid));
> +               }
> +       }
> +       pathspec_pos = i;
> +
