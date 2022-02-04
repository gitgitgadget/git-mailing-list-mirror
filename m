Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A36BC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 17:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376829AbiBDRQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 12:16:23 -0500
Received: from mout.web.de ([212.227.17.12]:57569 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234482AbiBDRQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 12:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1643994975;
        bh=oZff7Ctmzu0AwCPaD44GcneBN84o5iInWk3fljL7esU=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=ifOr/9ORYNTUbCf3ZOoNkNDUJ723V92MDgXeK8BkK7Js2pVCgXGa8sbCqOyntfNJ1
         NYGDE7k6GcyI15W0FHeFbcBU8nL1scrbkdnk8kewLjEURChRSwmsK/7gvDNM/DVV14
         eujNbT+F3syqzMfgG13xzMupzQDi9k4SM2xGUYdo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MWzCt-1mihSo02MT-00X7GU; Fri, 04
 Feb 2022 18:16:15 +0100
Message-ID: <0d70e31e-f6d1-dca5-c0e8-e2288e3e1c4e@web.de>
Date:   Fri, 4 Feb 2022 18:16:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 4/4] bisect--helper: double-check run command on exit
 code 126 and 127
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Christian Couder <christian.couder@gmail.com>,
        "Miriam R." <mirucam@gmail.com>
References: <1edfc6ff-4db8-447f-9eb7-85843258a286@www.fastmail.com>
 <xmqqilus3ctf.fsf@gitster.g>
 <fead25d6-6f5f-487a-ad4c-0657fe9785fd@www.fastmail.com>
 <20987dc6-e0c7-6ca2-19fd-2b323b3f6d9f@web.de> <xmqqa6f7pime.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqa6f7pime.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VB6rKQWE6LjYWp1KLRGzMqMH+CYUxyEJHtsx1LxHPHn15BHpWC2
 MmAZSW18lqJ7oXyBucjZl/V14L+wEjJr0vtKDP09AvJKTRhA0G3K5ybvtbLMqauN492tyci
 wfbEs8y5Wcyqx50PQc0dEAw4riLKAp9PllCdz2czzDzE4dllN5gPY5a6chtDl1wchQJ4RAh
 mmLNxR2qdBZjMfR2ZREvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2H5lnSoE55Y=:Q3cV9v7iYEvCsGeq/j3UXK
 Ay9mmqAF8riN/4i39HZtcPSbVjyHySapIGJYrpK3vxG45vPKx4RHT9OgUWSdlQL3gMzK9FcCF
 75j03fV+Mf8xJ0Aypx01hoG5Nceka08GCBzXqOHY5ZRLRX1bfnb1GWZfVxr242c9Z49wQufNq
 IJK0bBs7x9cQHd2yFtGCMiDoA5DQrzZka+Xpvkd/LoD1WngXRVsocZIxQiQ8i2MfOapnaow28
 45NjI2gTYVlrxaeD/jWdO9W8icgwdoKE/EmWeiEeNAuvb8uY7izmquwQUGRd4EFOWfs6GqLyd
 MkxVsdpChWK+h7n4RVAqSCBwECYL6pXSDVrTs5KCpw60vW9BSqtVa83YjuaZ2+4joSLljXsBT
 eSkIRjN0dHTb6zY//ffMpzxrUA2MD5GFeY3OUSKbUU3VPI6WxB2WluXsDI5M5yydBX928hpr+
 jI7Wql+vPen/tNlZN/JnFXD+kJ+yweVPbUm8jyzXruZ124RQWZ7z+qOSymL8Zy8WH6WOrvgnC
 kLmF5WQhSHvC3aMMjJC+ICAWej77sIDrfh7C11MXYhFXgVk/yKVG2RESiQFCTa15aD95a5qmv
 3OShd8xnIujZvKhAaORHxEXLcGu095MnrhwTIDmGB9we/S8UJGRD/pZ5c3XAefYMISKiEvqY+
 kjB7FQqvaD+dnPbn/enHy46GC9mzjAQRh9oWZOdOcnoy7UQNGESSfZr9l0z6vyMarCEu1D2ZP
 pjzSPFahp1TeqHBhRaEYAZwGBOTdugsC/79kVufI4cNmagBTtCrPrHfH+ptoDnXUVyK/1FdLX
 AMI5gyrWHDUYpFkw+DVgtvonpwRVFusJt8jC4inuukI23kMhNRDTO0jMZqvIvehsGvpljrshu
 mXInlcBYRAgHr0S95cGrAJ4tH+sCseKrCb9jVaaNjgpXpCTziez3IyDr6lAmn5hr56nZfdR2G
 hEhV51ImhANA4QuxWUwgFHmigCkblMF3OfPblFqlNs0mhKFhMimCF26d0VAgYpYKiqyp5F+B7
 Oo88En72v0oKMSjBTCKur6ifyn2Q7hGiP7V56QpRiArbfk875F4Fw1V3aAFuaNjMJA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.02.22 um 01:42 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> When a run command cannot be executed or found, shells return exit code
>> 126 or 127, respectively.  Valid run commands are allowed to return
>> these codes as well to indicate bad revisions, though, for historical
>> reasons.  This means typos can cause bogus bisect runs that go over the
>> full distance and end up reporting invalid results.
>>
>> The best solution would be to reserve exit codes 126 and 127, like
>> 71b0251cdd (Bisect run: "skip" current commit if script exit code is
>> 125., 2007-10-26) did for 125, and abort bisect run when we get them.
>> That might be inconvenient for those who relied on the documentation
>> stating that 126 and 127 can be used for bad revisions, though.
>
> I think the basic idea is sound and useful.  How happy are we who
> was involved in the discussion with this result?
>
>> +static int get_first_good(const char *refname, const struct object_id =
*oid,
>> +			  int flag, void *cb_data)
>> +{
>> +	oidcpy(cb_data, oid);
>> +	return 1;
>> +}
>
> OK, this iterates and stops at the first one.
>
>> +static int verify_good(const struct bisect_terms *terms,
>> +		       const char **quoted_argv)
>> +{
>> +	int rc;
>> +	enum bisect_error res;
>> +	struct object_id good_rev;
>> +	struct object_id current_rev;
>> +	char *good_glob =3D xstrfmt("%s-*", terms->term_good);
>> +	int no_checkout =3D ref_exists("BISECT_HEAD");
>> +
>> +	for_each_glob_ref_in(get_first_good, good_glob, "refs/bisect/",
>> +			     &good_rev);
>> +	free(good_glob);
>> +
>> +	if (read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
>> +		return -1;
>
>  * Could the current_rev already be marked as "good", in which case
>    we can avoid cost of rewriting working tree files to a
>    potentially distant revision?  I often do manual tests to mark
>    "bisect good" or "bisect bad" before using "bisect run".
>
>  * Can we have *no* rev that is marked as "good"?  I think we made
>    it possible to say "my time is more valuable than machine cycles,
>    so I'll only tell you that this revision is broken and give you
>    no limit on the bottom side of the history.  still assume that
>    there was only one good-to-bad transition in the history and find
>    it" by supplying only one "bad" and no "good" when starting to
>    bisect.  And in such a case, ...
>
>> +	res =3D bisect_checkout(&good_rev, no_checkout);
>
> ... this would feed an uninitialized object_id to bisect_checkout.

bisect_run() starts by calling bisect_next_check() with a current_term
parameter value of NULL.  It checks if the good rev is missing and calls
decide_next(), which returns -1 if current_term is NULL unless both good
and bad revs are present.  bisect_next_check() passes this value along.
bisect_run() exits if it's non-zero.

So AFAICS the uninitialized access would only happen if the good rev ref
was deleted between the bisect_next_check() call and the verify_good()
call.  I considered this scenario to be practically impossible with the
current code.  We can handle it more gracefully by doing something like
in the patch below.

Supporting a bad-only git bisect run would take more work -- perhaps by
making verify_good() pick a root commit to check as an assumed good rev
(plus fix whatever else caused the current code to pass NULL as
current_term).

Ren=C3=A9


=2D--
 builtin/bisect--helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 50783a586c..e1e58de3b2 100644
=2D-- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1106,9 +1106,12 @@ static int verify_good(const struct bisect_terms *t=
erms,
 	char *good_glob =3D xstrfmt("%s-*", terms->term_good);
 	int no_checkout =3D ref_exists("BISECT_HEAD");

+	oidcpy(&good_rev, null_oid());
 	for_each_glob_ref_in(get_first_good, good_glob, "refs/bisect/",
 			     &good_rev);
 	free(good_glob);
+	if (is_null_oid(&good_rev))
+		return -1;

 	if (read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &current_rev))
 		return -1;
=2D-
2.35.0

