Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E721C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036B2214AF
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 23:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=corrigendum.ru header.i=@corrigendum.ru header.b="Et11w+hT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgD2XSr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726871AbgD2XSq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Apr 2020 19:18:46 -0400
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Apr 2020 16:18:46 PDT
Received: from forward101j.mail.yandex.net (forward101j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A79C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 16:18:46 -0700 (PDT)
Received: from mxback18g.mail.yandex.net (mxback18g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:318])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 2F89A1BE0170;
        Thu, 30 Apr 2020 02:11:05 +0300 (MSK)
Received: from sas1-5ebd8269dbc4.qloud-c.yandex.net (sas1-5ebd8269dbc4.qloud-c.yandex.net [2a02:6b8:c14:3611:0:640:5ebd:8269])
        by mxback18g.mail.yandex.net (mxback/Yandex) with ESMTP id s13VAWYzSY-B5C0O8An;
        Thu, 30 Apr 2020 02:11:05 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=corrigendum.ru; s=mail;
        t=1588201865; bh=0oIEWDcQ2fR42a6DNE9wNv2OX8aPBb7Xb6SGk66sRvw=;
        h=In-Reply-To:From:To:Subject:Cc:Date:References:Message-ID;
        b=Et11w+hT8dFk3Vyr9/b31k/zLpPyB0SI7OiSrO2VH7WqtSNyGMbnKJYJn3AjPMp+i
         lBtPH7YQuRWAmeGrFBoBkanfUkY4KO+AtcmorctLkiPQpqOwySKTPiWtnHlr/JGYJc
         AkUa4SoeM/HzkSpXIWKNH+2sYgf4HBktcu27fA5A=
Authentication-Results: mxback18g.mail.yandex.net; dkim=pass header.i=@corrigendum.ru
Received: by sas1-5ebd8269dbc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id t6bvx6cTr6-B4Xqtr6h;
        Thu, 30 Apr 2020 02:11:04 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] gitk: fix the context menu not appearing in the presence
 of submodule diffs
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     git@vger.kernel.org
References: <20191215182550.397-1-dpb@corrigendum.ru>
 <20200413051151.GB14888@blackberry>
From:   =?UTF-8?B?0KDQvtC80LDQvSDQlNC+0L3Rh9C10L3QutC+?= 
        <dpb@corrigendum.ru>
Message-ID: <58d9c60c-1b0c-ef59-0355-da6edcbc8cdf@corrigendum.ru>
Date:   Thu, 30 Apr 2020 02:11:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413051151.GB14888@blackberry>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I just checked the repository, and it doesn't seem like it's actually 
applied...

-Roman.

13.04.2020 8:11, Paul Mackerras пишет:
> On Sun, Dec 15, 2019 at 09:25:50PM +0300, Роман Донченко wrote:
>> Currently, submodule diffs can cause the diff context menu to fail
>> to appear because of a couple bugs in parseblobdiffline:
>>
>> * it appends the submodule name to ctext_file_lines instead of
>>    a line number, which breaks the binary search in find_ctext_fileinfo;
>>
>> * it can desynchronize ctext_file_names and ctext_file_lines
>>    by appending to the former but not the latter, which also breaks
>>    find_ctext_fileinfo.
>>
>> Fix both of these.
>>
>> Note: a side effect of this patch is that the context menu also
>> starts appearing when you right-click on submodule diffs (and not just
>> regular diffs). The menu is non-functional in this case, though,
>> since you can't run blame on submodules.
>>
>> Signed-off-by: Роман Донченко <dpb@corrigendum.ru>
> 
> Thanks, applied.
> 
> Paul.
> 
