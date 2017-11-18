Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20EB4201C8
	for <e@80x24.org>; Sat, 18 Nov 2017 14:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761627AbdKROdN (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 09:33:13 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:56965 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761617AbdKROdL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 09:33:11 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id G4BAeETMMbjdZG4BAe9AbQ; Sat, 18 Nov 2017 14:33:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511015589;
        bh=kuvqH41VgEowgQBqcKTegDN9X2yzmKokuaKqrWEUDQ0=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oGL4AhvO5SAC0Jd2+F3Er7q89Dxfyk6XslqdG7A143UluJd8SoA3QaeLjI9FnVT8C
         MSRxG/ZNbgCJEKhVIdIv4HL4fxyM96DaOyLGI2X3qjNBIzonap0dcFX5YBmLN9ExGk
         UfhmKrI7zSmWAQjnyEauv4swVVEjxWbS+hICofXY=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ONFX5WSB c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=nN7BH9HXAAAA:8 a=evINK-nbAAAA:8 a=76gDm7sPX0GWPsWyqZcA:9 a=QEXdDO2ut3YA:10
 a=UF-tvkePCJwA:10 a=SHUmGpGg8TAA:10 a=0RhZnL1DYvcuLYC8JZ5M:22
 a=RfR_gqz1fSpA9VikTjo0:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/8] sequencer: don't fork git commit
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20170925101041.18344-1-phillip.wood@talktalk.net>
 <20171117113452.26597-1-phillip.wood@talktalk.net>
 <xmqq4lpsqmm5.fsf@gitster.mtv.corp.google.com>
 <xmqqvai8p7c7.fsf@gitster.mtv.corp.google.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <50555a22-3b48-ce67-5deb-9bd76aa7a10e@talktalk.net>
Date:   Sat, 18 Nov 2017 14:33:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqvai8p7c7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGw5GhPsui1eE16MF/C6oh+/iy6OrtN5Ll0bMxP+NcVxCSmgVHUS3BEWC61eTUfF2fCzXr7nA2O3LW4CIFD2pmxc2OMTkE074Bx7b9SkTO4mMNHOcFLj
 JegibN546AkVdGMYQe4CB5HpRqKYP2JZRWxysruGmvurLbMjXmYJSK9/PpMBusAwDPenC89NA7iFPBltQpUatC8Bv1p4c16St8z2cIuu2/9KF6OLKNlxHaZv
 Xdz3JyO1g+3dFYDoP5U9OE8pwNF9sALuBM7mWZ4K/rfv/8qLI2J1L568XgVnWMM6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/11/17 03:57, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Phillip Wood <phillip.wood@talktalk.net> writes:
>>
>>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>>
>>> I've updated these based on the feedback for v2. I've dropped the
>>> patch that stopped print_commit_summary() from dying as I think it is
>>> better to die than return an error (see the commit message of the
>>> patch that adds print_commit_summary() for the reasoning). Apart from
>>> that they're minor changes - style fixes and a reworded a commit message.
>>
>> Thanks for further polishing this topic; I found nothing in the
>> update that was questionable.  Will replace.
>>
>> With this, perhaps it is ready for 'next'?
> 
> Not really.  I needed at least this to get it even compile, which
> hints that I do not yet know what _else_ I missed by skimming this
> round of the series.

My apologies, it seems that I was half alseep yesterday morning and in
my haste to update these patches I wasn't paying proper attention to
what I was doing. For some reason after I dropped the patch that
converted print_commit_summary() to return an error rather than die I
forgot to amend the last patch to match and then compounded the mistake
by forgetting to compile and test properly before sending them. I think
they're okay now but I'll double check the changes before sending again
in case there are any other embarrassing mistakes lurking.

As the white rabbit said "The hurrier I go the behinder I get"

Phillip


>  sequencer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 37460db6b1..63cfb6ddd9 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1139,8 +1139,8 @@ static int do_commit(const char *msg_file, const char *author,
>  			unlink(git_path_cherry_pick_head());
>  			unlink(git_path_merge_msg());
>  			if (!is_rebase_i(opts))
> -				res = print_commit_summary(NULL, &oid,
> -						SUMMARY_SHOW_AUTHOR_DATE);
> +				print_commit_summary(NULL, &oid,
> +						     SUMMARY_SHOW_AUTHOR_DATE);
>  			return res;
>  		}
>  	}
> 

