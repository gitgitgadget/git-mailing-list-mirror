Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEC2C001B0
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 01:10:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjHKBKH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHKBKG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 21:10:06 -0400
Received: from lxh-heta-043.node.capitar.com (lxh-heta-043.node.capitar.com [159.69.137.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372B8273E
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 18:10:01 -0700 (PDT)
Received: from lxh-heta-043.node.capitar.com (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPS id 0290637DEE;
        Fri, 11 Aug 2023 03:09:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTP id 80BF7105C7;
        Fri, 11 Aug 2023 03:09:58 +0200 (CEST)
Received: from lxh-heta-043.node.capitar.com ([127.0.0.1])
        by localhost (eur-mail-proxy-p02.zt.capitar.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 41YLQuHS8_V5; Fri, 11 Aug 2023 03:09:58 +0200 (CEST)
Received: from [192.168.0.42] (unknown [186.189.151.69])
        by eur-mail-proxy-p02.zt.capitar.com (Postfix) with ESMTPSA id 06424105FF;
        Fri, 11 Aug 2023 03:09:56 +0200 (CEST)
Message-ID: <8d683835-31d4-41f0-9d4e-90c95acbea28@opperschaap.net>
Date:   Thu, 10 Aug 2023 21:09:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [[PATCH v2]] Fix bug when more than one readline instance is used
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20230810004956.GA816605@coredump.intra.peff.net>
 <20230810011831.1423208-1-wesleys@opperschaap.net>
 <xmqqcyzupf3b.fsf@gitster.g>
Content-Language: en-US
From:   Wesley <wesleys@opperschaap.net>
In-Reply-To: <xmqqcyzupf3b.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=GP927dFK c=1 sm=1 tr=0
        a=WkljmVdYkabdwxfqvArNOQ==:117 a=Hb/lXKkKiutk7skFILyYNg==:17
        a=IkcTkHD0fZMA:10 a=UttIx32zK-AA:10 a=N3miCFJ7AAAA:8 a=NEAV23lmAAAA:8
        a=X25-WREHGy68TV4kgyUA:9 a=QEXdDO2ut3YA:10 a=VlZU0XKO32wA:10
        a=V5H4rQgsk92nlYCD-KPC:22
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/23 21:01, Junio C Hamano wrote:
> Wesley Schwengle <wesleys@opperschaap.net> writes:
> 
> This line with "};" on it should not be added, I think.
> 
> cf. https://github.com/git/git/actions/runs/5827208598/job/15802787783#step:5:74
> 
>> +		return $term;
>>   	}
>>   }
> 
>   git-svn.perl | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 93f6538d61..e919c3f172 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -307,7 +307,6 @@ package main;
>   		$term = $ENV{"GIT_SVN_NOTTY"}
>   				? new Term::ReadLine 'git-svn', \*STDIN, \*STDOUT
>   				: new Term::ReadLine 'git-svn';
> -		};
>   		return $term;
>   	}
>   }

You are 100% correct.

Cheers,
Wesley

-- 
Wesley

Why not both?

