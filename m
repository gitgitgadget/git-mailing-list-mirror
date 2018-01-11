Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5873B1FADF
	for <e@80x24.org>; Thu, 11 Jan 2018 18:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965187AbeAKS6G (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 13:58:06 -0500
Received: from mout.web.de ([212.227.17.11]:56283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933141AbeAKS6E (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 13:58:04 -0500
Received: from [192.168.178.36] ([91.20.48.24]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Laky4-1fJk6L0BQm-00kQDA; Thu, 11
 Jan 2018 19:57:53 +0100
Subject: Re: [PATCH v2 5/9] bisect: avoid using the rev_info flag leak_pending
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <6ace4f8f-824b-2825-ef18-1fccebb9fb5c@web.de>
 <ac4c77a1-6403-ca20-2021-50c99201915a@web.de>
 <07d0e0c6-d023-bd28-511b-78092cb35b4f@web.de>
 <20180110080754.GE16315@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b0fbedea-77d8-5571-6042-03b512c0680d@web.de>
Date:   Thu, 11 Jan 2018 19:57:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180110080754.GE16315@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:c34kF7QeFF2CPooyqZZgBHdSN6n0ZgB41thd+15CigXh7m8FDHr
 OHMBaLmHkkH4KmFVr/kCQ8aatiRwH97kjM2qfvPlXBEgHkC+5N8vpmxhJ7QRRRLkubBGZ+J
 2x52JtP5TS8UKFuXO6tMuq+bq8DmNiTF9v57UEPvcpxDY7aJb0KL4kE1X0yNUuQGLtq8uGZ
 mZNrSfl27/Egg7QtnIDQA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:I5rZ2+wpWS0=:2TPqyJScR4GFeKKNC43cdz
 2fk/tn1EH8Td5pGRRrzJv9Z0PBPrX/su9z2DiVVpXd9vleZeBr76j52yPuNxOjdb3Z8dQ3Uuo
 KpdAaTzXPgX+egbAAlK//aS94GObW8tKgiG0ceHPCcM2ux1ciJ/WykJqUAxAXxGfWksKO826/
 hs3RuAh77wM6UNQ5qs7HRIRn8uzjKf6J6LmWCeBVKrWzo+Hiwzigi6EVNOEDGTCsbmS5oOzJE
 gos76jaSuteqMkq81hSyM9p5Ug1YPCB0NNYRKtssXr2WgpdaF71I8PuAMUr3G1JtrzVutRmZx
 KGEiszGdbQ08Q+nl0kJ+1IApe/+NAw75/Q9TM4zAjYPftvTbwTkt7xL22CIf3P4iizv1zDkjb
 Aj0zfZTf6GqWbOtqH3tup4RculmftZiNpwCrDjj+q1e+AD0rIsagd1PDCD7yUzocC1LSIn3/U
 8OYEjcZTIWN6JBda3u5V9+7FygYKfldo/ro1S8Ft/heEzJyQXIBgL2O5uXris1q6xwpyJqA2J
 7yIKFunzmXRlymQi1XcK7CKDZwSg60eD4vb+FAqWI/RKR2bcdwI+nb1pFGZZtQayg2UoZxn83
 cT2y9NtRE48oPGIRBoL+LQJ25NbKjk/YfxROEuQaEctNJAJ2jnBd41+j2uKTJluRBBOa7vV2Z
 CKuM9jmnlpnO4hcjLb5u0fuNO2t1kdwbyD8rn7J6OoyFqdx3Cpbs7Zt2hZ1Qx5xk81XdtissI
 Hk6C2qQwifvfP00lxCdDNzxkhfCGpy9FQXJQp3jXHbtRxDPO9fQJ/Lw5aSJfyyb3C7T+ZucYW
 3fTbOH7clQ3NYtFbdaZYJRQDkjan7bQtFYBzz5U7HpyCjktPqs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.01.2018 um 09:07 schrieb Jeff King:
> On Mon, Dec 25, 2017 at 06:45:36PM +0100, René Scharfe wrote:
> 
>> The leak_pending flag is so awkward to use that multiple comments had to
>> be added around each occurrence.  We only use it for remembering the
>> commits whose marks we have to clear after checking if all of the good
>> ones are ancestors of the bad one.  This is easy, though: We need to do
>> that for the bad and good commits, of course.
> 
> Are we sure that our list is the same as what is traversed? I won't be
> surprised if it is true, but it doesn't seem immediately obvious from
> the code:
> 
>> -static int check_ancestors(const char *prefix)
>> +static int check_ancestors(int rev_nr, struct commit **rev, const char *prefix)
>>   {
> 
> So now we take in a set of objects...
> 
>>   	struct rev_info revs;
>> -	struct object_array pending_copy;
>>   	int res;
>>   
>>   	bisect_rev_setup(&revs, prefix, "^%s", "%s", 0);
> 
> But those objects aren't provided here. bisect_rev_setup() puts its own
> set of objects into the pending list...

Yes, namely from the global variables current_bad_oid and good_revs.

>> -	/* Save pending objects, so they can be cleaned up later. */
>> -	pending_copy = revs.pending;
>> -	revs.leak_pending = 1;
>> -
>> -	/*
>> -	 * bisect_common calls prepare_revision_walk right away, which
>> -	 * (together with .leak_pending = 1) makes us the sole owner of
>> -	 * the list of pending objects.
>> -	 */
>>   	bisect_common(&revs);
>>   	res = (revs.commits != NULL);
> 
> And then we traverse, and then...
> 
>>   
>>   	/* Clean up objects used, as they will be reused. */
>> -	clear_commit_marks_for_object_array(&pending_copy, ALL_REV_FLAGS);
>> -
>> -	object_array_clear(&pending_copy);
>> +	clear_commit_marks_many(rev_nr, rev, ALL_REV_FLAGS);
> 
> ...this is the first time we look at "rev".

... which is populated by get_bad_and_good_commits() using the global
variables current_bad_oid and good_revs.

> If we already have the list of tips, could we just feed it ourselves to
> bisect_rev_setup (I think that would require us remembering which were
> "good" and "bad", but that doesn't seem like a big deal).

That's done already under the covers.  De-globalizing these variables
would make this visible.

Another way would be to store the bad and good revs in a format that
allows them to be used everywhere, thus avoiding confusing
duplication/conversions.  Commit pointers and arrays thereof should
work everywhere we currently use object_ids and oid_arrays for bad
and good revs, right?

René
