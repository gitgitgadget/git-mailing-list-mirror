Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C6BA203C1
	for <e@80x24.org>; Mon, 14 Nov 2016 22:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938965AbcKNWU7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Nov 2016 17:20:59 -0500
Received: from mout.gmx.net ([212.227.17.22]:64749 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938761AbcKNWU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2016 17:20:58 -0500
Received: from [192.168.178.43] ([92.76.224.96]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Ln8gj-1cjIkN3HQb-00hLs0; Mon, 14
 Nov 2016 23:20:54 +0100
Subject: Re: [PATCH v15 02/27] bisect: rewrite `check_term_format` shell
 function in C
To:     Pranit Bauva <pranit.bauva@gmail.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
 <01020157c38b1a74-ad2bcaff-0c92-4af4-9aa0-72d98f4945fc-000000@eu-west-1.amazonses.com>
Cc:     git@vger.kernel.org
From:   Stephan Beyer <s-beyer@gmx.net>
Message-ID: <61aacd44-cb6a-2bbb-7fb4-933e2505040d@gmx.net>
Date:   Mon, 14 Nov 2016 23:20:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <01020157c38b1a74-ad2bcaff-0c92-4af4-9aa0-72d98f4945fc-000000@eu-west-1.amazonses.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:yy6fiqpsiBryuFnTL3bauuY+qOi5JK9jp++/VcjW4DSv9w6qC70
 bXIH8HyU/TE5nZsedwKhVKxsUTwCt+rhqG/Jwfo74vsHz3bhQV6L/M79aAqnGtt56Xc2qPG
 S8A8VsHJN8ru71UjVHmZD4A7NGei89GWEheoHyuZvZL9j1bETJI9u+LHZMK+lOD1aSyho6g
 fANvq0JgjrWfxtSgvtWFg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:27T2bOkgoOw=:E0LUhSSVg7NXKxGYcJC36d
 JNjsu2uy5Cdd+upoTScOFMAwrq3kpXbjlVI1xA0M7FHKYlMYW7RRAWzNYvqaDcCe/aAoMaDRI
 sxE4Q6f6+E89JjBI5WTUseDQ+s34GUO5bQ9pDabtR2rzbcC+y/zlvxqc5QkRl7HQfoTwOlueo
 misIFaNYyhlgYs38R7fJt9um2I2rueRiZalCua1KbwOwCX2Yal5ATXme/MR2YjCVi1VCsa4lJ
 nq4bV7P/LlaKghy2cfKSsb/cbg571gseFC8TDz0gsCwtH0k5nb3iDFOaaKvZEY+tR+05FyJU6
 yzuKWlrEy7QLDltvl/aVaBR9U+kF4KkCrF6sG9gx7N54kOnQ0aOHR5qYQ7wEgb0FkXMi0vYf1
 Rxh3kuw1/Moz8FAKOV35WDbU7eZfIHY5VCR6l3re0V04J5qRVxRCggBVqcfFdpjRShFqKOpo/
 WF6OhhD5ygkzdBFt1TuMDUC7albLMJ0RBxwYTBJJTtmYOqYhb4shohS24apLvEodnCK2q5M3P
 gNL35DCqPyPsw6HyExEMNLUWfnSJkjyifqCHLXaiw8MUyOtti0MxyPqF5f7RmdnY89YkNPawT
 IBxRPdQjOROXoiE/KbZXBkytgtaiAKlJ6o++KyQCJAmZFisGEciabO09mbgditjuvXvvE3lVz
 FDs7wSjZ7tV7bXs3cjp3sPXxm0yy77fKI3L5csiQjvUYgIj/kAyw3PUQp/lvwWJE73m0QfSEC
 vhi5l4+VwyeUWm75JBTlWiKu9q2GX635JdKbfNrxVBhQx1zg/I+nZlSewxbjwmZ+oxv97lza1
 UhSc17A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I saw in the recent "What's cooking" mail that this is still waiting
for review, so I thought I could interfere and help reviewing it from a
non-git-developer point of view.
But only two commits for today. The first one seems fine. The second
one makes me write this mail ;-)

On 10/14/2016 04:14 PM, Pranit Bauva wrote:
> +static int check_term_format(const char *term, const char *orig_term)
> +{
[...]
> +	if (one_of(term, "help", "start", "skip", "next", "reset",
> +			"visualize", "replay", "log", "run", NULL))
[... vs ...]
> -check_term_format () {
> -	term=$1
> -	git check-ref-format refs/bisect/"$term" ||
> -	die "$(eval_gettext "'\$term' is not a valid term")"
> -	case "$term" in
> -	help|start|terms|skip|next|reset|visualize|replay|log|run)

Is there a reasons why "terms" has been dropped from the list?

Best
Stephan
