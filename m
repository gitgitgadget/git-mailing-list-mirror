Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A09851F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 20:17:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbfDWURs (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Apr 2019 16:17:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43757 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbfDWURr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Apr 2019 16:17:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so8147081pgu.10
        for <git@vger.kernel.org>; Tue, 23 Apr 2019 13:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=68TEOlAXeW8ScAWNSMaVMlU0CYbgXkSOfe6sGUkuDGw=;
        b=BMicSfPWOl4BEMesw59OSGy8j9IZrA4I5KShEcTZ+bvuMVrSQow56wqHAqmszzq7p7
         wtZV4RIQVq+9Aes0QnRyinvrJ/iIe1/pY/AWShQSSbqrZB8/LVqKa/YwityQITg9FvWc
         NDkKWRBkJir2VK84KRJBYLB36L1rObQpWHCLarYasiTSRlNgtaDdUdusPosvo381gfR2
         4HILl15ZwRoJuyS15q0F6RFDaexzDIL8OuqEb+hiuztiNWweQpyd1zbuAOWrZglkf+ZT
         OlGiAcAwsBQq6McsVodfapWG9aT8+pyHgEGhsq4blAcNsJ6DIoFRM1dllk1wdguVEdQO
         jJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=68TEOlAXeW8ScAWNSMaVMlU0CYbgXkSOfe6sGUkuDGw=;
        b=BjMbQaWSeQOOw1TEAZJ2ZgTAn4C5UXnrzmK3FiwHSEzvh7n0tCn0WFX3JlobHUNKQh
         Etg5r8gsethRyC0Lb5AGyncf4M/yxii5c+ELI1mwMZgCdjMnIzpgTrCM8ePnTIft1gj/
         Y3yaNpNPOJWllPHKu56RMyBTKNrftyWcJ1rpc5+HO1Of3eWVkiDoTlQ89xBfLzWfVyu5
         RkHUalg9WF2hZEDiSHyBplFVqKvocKgya2/daXWGmUKvTW0zVAkqI0LHNUGAbuB/hYnO
         wnY/TCfFuaufSvYxEmFmgaXyItG+CtvpczdK35T4TyVulZPpUkHBtniQgeUgfRyQyvpF
         Ux5w==
X-Gm-Message-State: APjAAAV9seA1sj/88Xwd9IGr2kKMA0S5cPsWtwxl8Eb3oP4o0Ux0GtMd
        6BojsFr0dLMm52NSkucZG7lhrQ==
X-Google-Smtp-Source: APXvYqxE26NLMlXv4Go500Mdo9MVzScK5KyrwZrky2JTUpvN00JaRepEAWMrgR3277rI+D5weqbjqA==
X-Received: by 2002:a62:6807:: with SMTP id d7mr28216144pfc.75.1556050666351;
        Tue, 23 Apr 2019 13:17:46 -0700 (PDT)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.googlemail.com with ESMTPSA id x66sm42607814pfb.78.2019.04.23.13.17.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Apr 2019 13:17:45 -0700 (PDT)
Subject: Re: [PATCH v6 0/6] blame: add the ability to ignore commits
To:     michael@platin.gs, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Stefan Beller <stefanbeller@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <[PATCH v6 0/6] blame: add the ability to ignore commits>
 <20190422222647.48628-1-michael@platin.gs>
From:   Barret Rhoden <brho@google.com>
Message-ID: <04385e9f-f0e1-240e-4473-df87076ae630@google.com>
Date:   Tue, 23 Apr 2019 16:17:43 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190422222647.48628-1-michael@platin.gs>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Michael -

FYI, here are a few style nits that I changed in my version, based on a 
quick scan.  Not sure if these are all Git's style, but I think it's 
mostly linux-kernel style.

I mention this mostly for future reference - specifically if we keep 
separate versions of this code.  Hopefully we won't.  =)

I also did all the fingerprint prep in fill_origin_blob, which you can 
see in an upcoming patch.

On 4/22/19 6:26 PM, michael@platin.gs wrote:
> diff --git a/fuzzy.c b/fuzzy.c
> new file mode 100644
> index 0000000000..c5b09a0eb7
> --- /dev/null
> +++ b/fuzzy.c
> @@ -0,0 +1,434 @@
> +#include "fuzzy.h"
> +#include <ctype.h>
> +#include <stdint.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "git-compat-util.h"
> +#include "hashmap.h"
> +
> +struct fingerprint_entry {
> +	struct hashmap_entry entry;
> +	int count;
> +};
> +struct fingerprint {
> +	struct hashmap map;
> +	struct fingerprint_entry *entries;
> +};
> +
> +static void get_fingerprint(struct fingerprint *result,
> +			    const char *line_begin,
> +			    const char *line_end) {
                                                  ^newline here, so { is 
at the start of a line.  (on all of the functions)

> +	unsigned hash;
                 ^int

> +	char c0, c1;
> +	int map_entry_count = line_end - line_begin - 1;
> +	struct fingerprint_entry *entry = xcalloc(map_entry_count,
> +		sizeof(struct fingerprint_entry));
> +	struct fingerprint_entry *found_entry;

Blank line here, between declarations and code.  Did this for all of the 
functions.

> +	hashmap_init(&result->map, NULL, NULL, map_entry_count);
> +	result->entries = entry;
> +	for (const char *p = line_begin; p + 1 < line_end; ++p, ++entry) {
              ^moved this declaration outside the for loop

> +		c0 = *p;
> +		c1 = *(p + 1);
> +		/* Ignore whitespace pairs */
> +		if (isspace(c0) && isspace(c1))
> +			continue;
> +		hash = tolower(c0) | (tolower(c1) << 8);
> +		hashmap_entry_init(entry, hash);
> +
> +		if ((found_entry = hashmap_get(&result->map, entry, NULL))) {
                     ^moved this assignment outside the if ()
> +			found_entry->count += 1;
> +		}
> +		else {
                 ^ made this } else {.

Also in a couple other places below.

> +			entry->count = 1;
> +			hashmap_add(&result->map, entry);
> +		}
> +	}
> +}
> +
> +static void free_fingerprint(struct fingerprint *f) {
> +	hashmap_free(&f->map, 0);
> +	free(f->entries);
> +}
> +
> +static int fingerprint_similarity(struct fingerprint *a,
> +				  struct fingerprint *b) {

put fingerprint b on the same line as a (within 80 chars).  made similar 
changes wherever that was possible and looked nice.

> +	int intersection = 0;
> +	struct hashmap_iter iter;
> +	const struct fingerprint_entry *entry_a, *entry_b;
> +	hashmap_iter_init(&b->map, &iter);
> +
> +	while ((entry_b = hashmap_iter_next(&iter))) {
> +		if ((entry_a = hashmap_get(&a->map, entry_b, NULL))) {
> +			intersection += entry_a->count < entry_b->count ?
> +					entry_a->count : entry_b->count;
> +		}
> +	}
> +	return intersection;
> +}
> +
> +static void fingerprint_subtract(struct fingerprint *a,
> +				 struct fingerprint *b) {
> +	struct hashmap_iter iter;
> +	struct fingerprint_entry *entry_a;
> +	const struct fingerprint_entry *entry_b;
> +	hashmap_iter_init(&b->map, &iter);
> +
> +	while ((entry_b = hashmap_iter_next(&iter))) {
> +		if ((entry_a = hashmap_get(&a->map, entry_b, NULL))) {
> +			if (entry_a->count <= entry_b->count) {
> +				hashmap_remove(&a->map, entry_b, NULL);
> +			}
> +			else {
> +				entry_a->count -= entry_b->count;
> +			}
> +		}
> +	}
> +}
> +
> +static void get_line_fingerprints(struct fingerprint *fingerprints,
> +				  const char *content,
> +				  const int *line_starts,
> +				  long chunk_start,
> +				  long chunk_length) {
> +	int i;
> +	const char *linestart, *lineend;
> +	line_starts += chunk_start;
> +	for (i = 0; i != chunk_length; ++i) {
                       ^ any reason for '!=' versus '<'  ?

> +		linestart = content + line_starts[i];
> +		lineend = content + line_starts[i + 1];
> +		get_fingerprint(fingerprints + i, linestart, lineend);
> +	}
> +}
> +
> +static int get_closest_local_line(int start_a,
> +			    int local_line_b,
> +			    int closest_line_calc_offset1,
> +			    int closest_line_calc_offset2,
> +			    int closest_line_calc_numerator,
> +			    int closest_line_calc_denominator) {
> +	return ((local_line_b + closest_line_calc_offset1) * 2 + 1) *
> +		closest_line_calc_numerator /
> +		(closest_line_calc_denominator * 2) +
> +		closest_line_calc_offset2 - start_a;
                ^ i moved these three lines one space left, so that they 
don't line up with the open paren.  o/w it looked like they may be 
inside the '('.


> +}
> +
> +static int *get_similarity(int *similarities, int max_search_distance_a,
> +			   int local_line_a, int local_line_b,
> +			   int closest_local_line_a) {
> +	assert(abs(local_line_a - closest_local_line_a) <= max_search_distance_a);
> +	return similarities + local_line_a - closest_local_line_a +
> +		max_search_distance_a +
> +		local_line_b * (max_search_distance_a * 2 + 1);
> +}
> +
> +#define CERTAIN_NOTHING_MATCHES -2
> +#define CERTAINTY_NOT_CALCULATED -1
> +
> +static void find_best_line_matches(const int max_search_distance_a,
> +				   int start_a,
> +				   int length_a,
> +				   int local_line_b,
> +				   struct fingerprint *fingerprints_a,
> +				   struct fingerprint *fingerprints_b,
> +				   int *similarities,
> +				   int *certainties,
> +				   int *second_best_result,
> +				   int *result,
> +				   int closest_line_calc_offset1,
> +				   int closest_line_calc_offset2,
> +				   int closest_line_calc_numerator,
> +				   int closest_line_calc_denominator) {

                                    ^intense number of arguments.  =)

Not sure if there's much to do about that.  It does make some of the 
callsites busier.

> +
> +	int i, search_start, search_end, closest_local_line_a, *similarity,
> +		best_similarity = 0, second_best_similarity = 0,
> +		best_similarity_index = 0, second_best_similarity_index = 0;
> +
> +	if (certainties[local_line_b] != CERTAINTY_NOT_CALCULATED)
> +		return;
> +
> +	closest_local_line_a = get_closest_local_line(start_a,
> +					  local_line_b,
> +					  closest_line_calc_offset1,
> +					  closest_line_calc_offset2,
> +					  closest_line_calc_numerator,
> +					  closest_line_calc_denominator);
> +
> +	search_start = closest_local_line_a - max_search_distance_a;
> +	if (search_start < 0)
> +		search_start = 0;
> +
> +	search_end = closest_local_line_a + max_search_distance_a + 1;
> +	if (search_end > length_a)
> +		search_end = length_a;
> +
> +	for (i = search_start; i < search_end; ++i) {
> +		similarity = get_similarity(similarities, max_search_distance_a,
> +					    i, local_line_b,
> +					    closest_local_line_a);
> +		if (*similarity == -1) {
> +			*similarity = fingerprint_similarity(
> +				fingerprints_b + local_line_b,
> +				fingerprints_a + i) *
> +				(1000 - abs(i - closest_local_line_a));
> +		}
> +		if (*similarity > best_similarity) {
> +			second_best_similarity = best_similarity;
> +			second_best_similarity_index = best_similarity_index;
> +			best_similarity = *similarity;
> +			best_similarity_index = i;
> +		}
> +		else if (*similarity > second_best_similarity) {
> +			second_best_similarity = *similarity;
> +			second_best_similarity_index = i;
> +		}
> +	}
> +
> +	if (best_similarity == 0) {
> +		certainties[local_line_b] = CERTAIN_NOTHING_MATCHES;
> +		result[local_line_b] = -1;
> +	}
> +	else {
> +		certainties[local_line_b] = best_similarity * 2 -
> +			second_best_similarity;
> +		result[local_line_b] = start_a + best_similarity_index;
> +		second_best_result[local_line_b] =
> +			start_a + second_best_similarity_index;
> +	}
> +}
> +
> +/*
> + * This finds the line that we can match with the most confidence, and
> + * uses it as a partition. It then calls itself on the lines on either side of
> + * that partition. In this way we avoid lines appearing out of order, and
> + * retain a sensible line ordering.
> + */
> +static void fuzzy_find_matching_lines_recurse(
> +	int max_search_distance_a,
> +	int max_search_distance_b,
> +	int start_a, int start_b,
> +	int length_a, int length_b,
> +	struct fingerprint *fingerprints_a,
> +	struct fingerprint *fingerprints_b,
> +	int *similarities,
> +	int *certainties,
> +	int *second_best_result,
> +	int *result,
> +	int closest_line_calc_offset1,
> +	int closest_line_calc_offset2,
> +	int closest_line_calc_numerator,
> +	int closest_line_calc_denominator) {
> +
> +	int i, barrier, invalidate_min, invalidate_max, offset_b,
> +		second_half_start_a, second_half_start_b,
> +		second_half_length_a, second_half_length_b,
> +		most_certain_line_a, most_certain_local_line_b = -1,
> +		most_certain_line_certainty = -1,
> +		closest_local_line_a;
> +
> +	for (i = 0; i < length_b; ++i) {
> +		find_best_line_matches(max_search_distance_a,
> +				       start_a,
> +				       length_a,
> +				       i,
> +				       fingerprints_a,
> +				       fingerprints_b,
> +				       similarities,
> +				       certainties,
> +				       second_best_result,
> +				       result,
> +				       closest_line_calc_offset1,
> +				       closest_line_calc_offset2,
> +				       closest_line_calc_numerator,
> +				       closest_line_calc_denominator);
> +
> +		if (certainties[i] > most_certain_line_certainty) {
> +			most_certain_line_certainty = certainties[i];
> +			most_certain_local_line_b = i;
> +		}
> +	}
> +
> +	if (most_certain_local_line_b == -1) {
> +		return;
> +	}
         ^ removed the {} for a single-line if block.

> +
> +	most_certain_line_a = result[most_certain_local_line_b];
> +
> +	/* Subtract the most certain line's fingerprint in b from the
> +	 matched fingerprint in a. This means that other lines in b can't also
> +	 match the same parts of the line in a. */
         ^ multiline block commits as such:
         /*
          * foo
          * bar
          */
> +	fingerprint_subtract(fingerprints_a + most_certain_line_a - start_a,
> +			     fingerprints_b + most_certain_local_line_b);
> +
> +
> +	/* Invalidate results that may be affected by the choice of pivot. */
> +	invalidate_min = most_certain_local_line_b - max_search_distance_b;
> +	invalidate_max = most_certain_local_line_b + max_search_distance_b + 1;
> +	if (invalidate_min < 0)
> +		invalidate_min = 0;
> +	if (invalidate_max > length_b)
> +		invalidate_max = length_b;
> +
> +	for (i = invalidate_min; i < invalidate_max; ++i) {
> +		closest_local_line_a = get_closest_local_line(
> +			start_a, i,
> +			closest_line_calc_offset1,
> +			closest_line_calc_offset2,
> +			closest_line_calc_numerator,
> +			closest_line_calc_denominator);
> +		*get_similarity(similarities, max_search_distance_a,
> +				most_certain_line_a - start_a, i,
> +				closest_local_line_a) = -1;
> +	}
> +
> +	barrier = most_certain_line_a;
> +
> +	for (i = most_certain_local_line_b - 1; i >= invalidate_min; --i) {
> +		if (certainties[i] >= 0 &&
> +		    (result[i] >= barrier || second_best_result[i] >= barrier)) {

over 80 chars (same below)

> +			    certainties[i] = CERTAINTY_NOT_CALCULATED;
> +			    barrier = result[i];
> +			    invalidate_min = i - max_search_distance_b;
> +			    if (invalidate_min < 0)
> +				    invalidate_min = 0;
> +		    }
> +	}
> +
> +	barrier = most_certain_line_a;
> +
> +	for (i = most_certain_local_line_b + 1; i < invalidate_max; ++i) {
> +		if (certainties[i] >= 0 &&
> +		    (result[i] <= barrier || second_best_result[i] <= barrier)) {
> +			    certainties[i] = CERTAINTY_NOT_CALCULATED;
> +			    barrier = result[i];
> +			    invalidate_max = i + max_search_distance_b + 1;
> +			    if (invalidate_max > length_b)
> +				    invalidate_max = length_b;
> +		    }
> +	}
> +
> +
> +	if (most_certain_local_line_b > 0) {
> +		fuzzy_find_matching_lines_recurse(
> +			max_search_distance_a,
> +			max_search_distance_b,
> +			start_a, start_b,
> +			most_certain_line_a + 1 - start_a,
> +			most_certain_local_line_b,
> +			fingerprints_a, fingerprints_b, similarities,
> +			certainties, second_best_result, result,
> +			closest_line_calc_offset1, closest_line_calc_offset2,
> +			closest_line_calc_numerator,
> +			closest_line_calc_denominator);
> +	}
> +	if (most_certain_local_line_b + 1 < length_b) {
> +		second_half_start_a = most_certain_line_a;
> +		offset_b = most_certain_local_line_b + 1;
> +		second_half_start_b = start_b + offset_b;
> +		second_half_length_a =
> +			length_a + start_a - second_half_start_a;
> +		second_half_length_b =
> +			length_b + start_b - second_half_start_b;
> +		fuzzy_find_matching_lines_recurse(
> +			max_search_distance_a,
> +			max_search_distance_b,
> +			second_half_start_a, second_half_start_b,
> +			second_half_length_a, second_half_length_b,
> +			fingerprints_a + second_half_start_a - start_a,
> +			fingerprints_b + offset_b,
> +			similarities +
> +				offset_b * (max_search_distance_a * 2 + 1),
> +			certainties + offset_b,
> +			second_best_result + offset_b, result + offset_b,
> +			closest_line_calc_offset1 + offset_b,
> +			closest_line_calc_offset2,
> +			closest_line_calc_numerator,
> +			closest_line_calc_denominator);
> +	}
> +}
> +
> +int *fuzzy_find_matching_lines(const char *content_a,
> +			       const char *content_b,
> +			       const int *line_starts_a,
> +			       const int *line_starts_b,
> +			       int start_a,
> +			       int start_b,
> +			       int length_a,
> +			       int length_b) {
> +
> +	int i, *result, *second_best_result,
> +		*certainties, *similarities, similarity_count;
> +	struct fingerprint *fingerprints_a, *fingerprints_b;
> +
> +	/* max_search_distance_a means that given a line in `b`, compare it to
> +	the line in `a` that is closest to its position, and the lines in `a`
> +	that are no greater than max_search_distance_a lines away from the
> +	closest line in `a`.
> +	max_search_distance_b is an upper bound on the greatest possible
> +	distance between lines in `b` such that they will both be compared with
> +	the same line in `a` according to max_search_distance_a. */
> +	int max_search_distance_a = 10, max_search_distance_b;
> +
> +	if (max_search_distance_a >= length_a)
> +		max_search_distance_a = length_a ? length_a - 1 : 0;
> +
> +	if (length_a == 0) {
> +		max_search_distance_b = 0;
> +	}
> +	else {
> +		max_search_distance_b = ((2 * max_search_distance_a + 1) *
> +			length_b - 1) / length_a;
> +	}
> +
> +	result = malloc(sizeof(int) * length_b);
> +	second_best_result = malloc(sizeof(int) * length_b);
> +	certainties = malloc(sizeof(int) * length_b);
> +	similarity_count = length_b * (max_search_distance_a * 2 + 1);
> +	similarities = malloc(sizeof(int) * similarity_count);

xcalloc(x, y) instead of malloc (x * y).  or at least xmalloc.

> +
> +	for (i = 0; i < length_b; ++i) {
> +		result[i] = -1;
> +		second_best_result[i] = -1;
> +		certainties[i] = CERTAINTY_NOT_CALCULATED;
> +	}
> +
> +	for (i = 0; i < similarity_count; ++i) {
> +		similarities[i] = -1;
> +	}
	^ removed {}, as as with the 'if' statements


Barret



> +
> +	fingerprints_a = xmalloc(sizeof(struct fingerprint) * length_a);
> +	fingerprints_b = xmalloc(sizeof(struct fingerprint) * length_b);
> +
> +	get_line_fingerprints(fingerprints_a, content_a,
> +			      line_starts_a,
> +			      start_a, length_a);
> +	get_line_fingerprints(fingerprints_b, content_b,
> +			      line_starts_b,
> +			      start_b, length_b);
> +
> +	fuzzy_find_matching_lines_recurse(max_search_distance_a,
> +					  max_search_distance_b,
> +					  start_a, start_b,
> +					  length_a, length_b,
> +					  fingerprints_a,
> +					  fingerprints_b,
> +					  similarities,
> +					  certainties,
> +					  second_best_result,
> +					  result,
> +					  0, start_a, length_a, length_b);
> +
> +	for (i = 0; i < length_b; ++i) {
> +		free_fingerprint(fingerprints_b + i);
> +	}
> +	for (i = 0; i < length_a; ++i) {
> +		free_fingerprint(fingerprints_a + i);
> +	}
> +	free(fingerprints_b);
> +	free(fingerprints_a);
> +	free(similarities);
> +	free(certainties);
> +	free(second_best_result);
> +
> +	return result;
> +}
> +
