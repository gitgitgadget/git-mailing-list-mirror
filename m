Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D51D4202A0
	for <e@80x24.org>; Sat, 18 Nov 2017 11:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030727AbdKRLcl (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Nov 2017 06:32:41 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:58349 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030723AbdKRLck (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Nov 2017 06:32:40 -0500
Received: from [192.168.2.201] ([92.22.34.132])
        by smtp.talktalk.net with SMTP
        id G1MUeSMXtpb8rG1MVeyXRZ; Sat, 18 Nov 2017 11:32:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1511004759;
        bh=ZOOztKL33PBk+V6aT/6akwfhSlYAdscSBadOFzCwE2c=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=WBs0z19N+Ycj3LD/RdJxaqREAlWfs8nlYApgEPkCYOPLFi2u0VjP2kLfPw5TnVunI
         LVQEVC1ESRf5evTVcVMo6hVNjXWT/HzSGtyFDx7xTE9f9WCeVUs7mOHKwUL/Q+cs5q
         kPROioXZMfpd4oKNGbWVd2C3GZfhIS6MvV+OWpMg=
X-Originating-IP: [92.22.34.132]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=2gYdyS03q/cwff7SV6P5Ng==:117
 a=2gYdyS03q/cwff7SV6P5Ng==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=nN7BH9HXAAAA:8 a=evINK-nbAAAA:8 a=hRX2jeQqJ8wSOPg4QCQA:9 a=QEXdDO2ut3YA:10
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
Message-ID: <61d0e704-b6f3-19de-b1cc-90f56b04229f@talktalk.net>
Date:   Sat, 18 Nov 2017 11:32:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqvai8p7c7.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGyHphWtcVZ3XLetsnDYNj+ESqLurhyTA4ZYMjlwjdwGLHm4teyPc9vx6ytHipKNMOhCX6JJxytNZrJbmfSNxZ3TikHdJgqkyoBa4Ynt+1xMcg+y67On
 mM3JaWXCayfFqcsx3nd+2doh6sxgkumBbtX9iwieunxaImeRodI1TXoT7wvpRWo1mgMvGLPoI+yP9hnCNuVQCxMGsDrBoJXlFl9BL9EZ2ICMnebIUEDdz9Y8
 RSAP2oPXZz5Qp6A7KE8LLFxXWVETCg83XaVCzH+1ajewVxXNgVTbjFaDsk/MaAM7
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

Sorry I'm not sure what happened there, by branch has the missing 'res =
' something must have happened to the patches. I'll sort it out and resend

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

