Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10525EB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 11:26:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjFYL0R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 07:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjFYL0O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 07:26:14 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DB1133
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 04:26:12 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-3fddb0bd9e2so28613561cf.0
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 04:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687692372; x=1690284372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ca6ha2AV4r4+Ea75PGgKbDNN+M1oLRcsZelSKvcbttA=;
        b=dpai3a7LgCQiAC87q7d2SZo4/D7ZlWblkX0tW6/GAJ2195Y9UP3EQOqYcp64DmALVE
         CbzHcqb7LB1ejr+QekaWkYZfC7S8FHnfG4xDLDwVQW2QcmIliIceb0FB3vYlfyMveHOw
         s4KDsL75oMW/Mg6MOa9kC1QwzhPd++yDVIt03a8g0e2MMI8pxDU07IuKMCnF1/UFnT8o
         88U0l8FLR1S0zLXqcyLioJuaUQm+g25GitQjxMxbfWo6ttPDUXnxvWAIsEZWjz5U22NW
         OGeV+F2OTU2G0reIBmMMpCwfacD1hqopT8rctHTg4biICZpQ08rZDy3n0XnTD8oJGVMu
         PGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687692372; x=1690284372;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ca6ha2AV4r4+Ea75PGgKbDNN+M1oLRcsZelSKvcbttA=;
        b=fFqZ5VsxL+I3PcALM74OxxvGm4odexcri7b375/hndXHWCxE3A4DsBXwatuFSBLIjG
         2RpJVtpwJ1EW1XbouCNBMKttWLA/JwpZbdjmTJoIl5tMxeOHhsBI2kaMduAQiB7Xi33D
         d7gMij3vLPEB3pf3hDHOnD/OlqVygDulwAHwzTiNS1gYUWLhxKTKTs+OI2IO33TwZi/7
         vpydjcqNIPkAhmr371ovCjwyiY6k11QA8e84qp9OlOMM02XVoRP/JalJVPq3KBKdvB91
         QdwMSljLPIQcBjJGbbCASlCMMRlHWRkwzyuKisjhoG9PSwv1JnwgHXOsgYmd3e3Sjr75
         w+CA==
X-Gm-Message-State: AC+VfDwfcWDR50y8j74a74vHi1j3sTIbZjpBwG6nyPbYPIOtaEP8K5wq
        DfVsRsBVdeoyoAjg7fk1xYA=
X-Google-Smtp-Source: ACHHUZ5PTRvUsMN9kJVjSLPHXd6lyS8W64wye2J6Q8eN2o7gH+sSg9JoAicAb8jYbRXl5wt6XAiljg==
X-Received: by 2002:a05:622a:215:b0:3f6:910a:aace with SMTP id b21-20020a05622a021500b003f6910aaacemr37007615qtx.23.1687692371786;
        Sun, 25 Jun 2023 04:26:11 -0700 (PDT)
Received: from ?IPV6:2600:4040:266e:4d00::387? ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id bv11-20020a05622a0a0b00b0040091d8e63fsm1785350qtb.73.2023.06.25.04.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 04:26:11 -0700 (PDT)
Message-ID: <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com>
Date:   Sun, 25 Jun 2023 07:26:11 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <xmqq8rc8781p.fsf@gitster.g>
Content-Language: en-US
From:   Mark Levedahl <mlevedahl@gmail.com>
In-Reply-To: <xmqq8rc8781p.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/24/23 19:30, Junio C Hamano wrote:
> Mark Levedahl <mlevedahl@gmail.com> writes:
>
>> git-gui has many snippets of code guarded by an is_Cygwin test, all of
>> which target a problematic hybrid Cygwin/Windows 8.4.1 Tcl/Tk removed in
>> March 2012. That is when Cygwin switched to a well-supported unix/X11
>> Tcl/Tk package.  64-bit Cygwin was released later so has always had the
>> unix/X11 package. git-gui runs as-is on more recent Cygwin, treating it
>> as a Linux variant, though two functions are disabled.
>>
>> The old Tcl/Tk understood Windows pathnames, so git-gui's Cygwin
>> specific code uses Windows pathnames. The unix/X11 code requires use of
>> unix pathnames, so none of the Cygwin specific code is compatible, and
>> all should be removed.
>>
>> Fortunately, the is_Cygwin funcion in git-gui (on the git master branch)
>> relies upon the old Tcl/Tk and doesn't detect Cygwin. But, commit
>> c5766eae6f2b002396b6cd4f85b62317b707174e on the git-gui master branch
>> "fixed" is_Cygwin, enabling the incompatible code, so upstream git-gui
>> is now broken on Cygwin.
> Here I presume "upstream git-gui master" refers to a5005ded (Merge
> branch 'ab/makeflags', 2023-01-25) sitting at 'master' in Pratyush's
> https://github.com/prati0100/git-gui/ repository.
Yes.
>
>> There is Cygwin specific code in the Makefile, intended to allow a
>> completely unsupported configuration with a Windows TclTk.  This code
>> misdetects the configuration, creating a non-portable installation. The
>> Cygwin git maintainer comments this code out. The code should be
>> removed.
>>
>> ...
>>
>> patch 1 removes the obsolete Makefile code
>> patch 2 removes all obsolete git-gui.sh code, wrapped in is_Cygwin...
> As it has been quite a while since I had access to any Windows box
> or Cygwin, but the earlier two patches look obviously correct to me.
>
>> The existing code for file browsing and creating a desktop icon is
>> shared with Git For Windows support, and uses Windows pathnames. This
>> code does not work on Cygwin, and needs replacement.  These functions
>> have not worked since 2012.
>> ...
>> patch 3 implements Cygwin specific file browsing support
>> patch 4 implemetns Cygwin specific desktop icon support
> Both of these two patches do
>
> 	if {[is_Windows]} {
> 		... do Windows thing ...
> +	} elseif {[is_Cygwin]} {
> +		... do Cygwin thing ...
> 	} elseif {[is_MacOSX]} {
> 		... do macOS thing ...
> 	} else {
> 		... do it for others ...
> 	}
>
> which I do not quite understand how the existing code meshes with
> your "is shared with Git For Windows support", though.  If "is
> shared with GfW" is to be trusted, on a modern Cygwin box,
> "is_Windows" would be yielding true (that is the only way the "do
> Windows thing" block will be entered on Cygwin box, sharing the
> support with GfW.  But then, adding elseif _after_ we check for
> Windows would be pointless.  Puzzled...
>
> Thanks.
>
git-gui has three independent functions (is_Cygwin, is_Windows, and 
is_MaxOSX), each determine if running on that platform, and "generic 
Unix/Linux" can be considered the result if all three functions return 
false. In Pratyush's tree, those three functions essentially are:

is_Cygwin: $::tcl_platform(os) startswith("CYGWIN")

is_MaxOSX: [tk windowingsystem] == "AQUA"

is_Windows: $::tcl_platform(platform) == "Windows"

It turns out, only one of the . is ever true, and none are true on 
Linux. So, the if/else tree above is not confused by Windows / Cygwin.

But, different Tcl/Tk signatures as platforms evolve could cause 
problems. A better design might be to just have a $HOSTTYPE variable set 
once, perhaps in startup, perhaps even by the makefile, to assure 
exactly one hosttype is ever active and make this clear to others. 
Normal configuration checking in the makefile could have uncovered this 
whole problem in 2012. But, this is a possible cleanup topic for another 
day.

So, the code under the is_Windows and is_Cygwin branches of the if/else 
trees are now completely independent, and the is_Windows branch is never 
entered on Cygwin.


Thank you,

Mark

