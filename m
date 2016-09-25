Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C3A61F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 18:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757218AbcIYSju (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 14:39:50 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51831 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755902AbcIYSjt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 14:39:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C41464003A;
        Sun, 25 Sep 2016 14:39:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mH7CZEj2Wqye
        XWh5FlzQdHpZygE=; b=bf/13bEEebMTKvRN+wExWPENs6tQzpdkI19XCZYG6ppu
        ZiUlLi7Kv5TJD4DZlSECae5u6kVm+O8B58Z8ZUDSBG+sTUYmPcscZnIzz71QiU45
        +L3pkGTUjG61IZN0NzzTLPadz5x54g9uar6icgZTSVBlG6fZ8WGC2d46opK334g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=M9/gmc
        TYFDfXyf+cjmfLMpx0TFEaY5gco2v2GSA3fSNuDfA8zueEad8eE1QcId4St1pjKJ
        Y+1n8pzcD3kSz2Hkn70dgnlsUqtgeYh9u41dNy2KDJVEj/r0hjSWXh53VOzN8cMs
        y8Tde2+QQCiIy1qp7Oiq3H5NAdLJJDU78kExs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC23940039;
        Sun, 25 Sep 2016 14:39:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4F3A140038;
        Sun, 25 Sep 2016 14:39:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Pat Thoyts <patthoyts@users.sourceforge.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] git-gui: stop using deprecated merge syntax
References: <cbb1815e-0ebc-e103-927e-14d7d038245a@web.de>
        <a5b001fd-3ba2-bcc0-2104-eb630796ab09@kdbg.org>
Date:   Sun, 25 Sep 2016 11:39:45 -0700
In-Reply-To: <a5b001fd-3ba2-bcc0-2104-eb630796ab09@kdbg.org> (Johannes Sixt's
        message of "Sat, 24 Sep 2016 20:22:28 +0200")
Message-ID: <xmqqvaxjygb2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6F3E2FAE-834F-11E6-B64F-C26412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 24.09.2016 um 13:30 schrieb Ren=C3=A9 Scharfe:
>> Starting with v2.5.0 git merge can handle FETCH_HEAD internally and
>> warns when it's called like 'git merge <message> HEAD <commit>' becaus=
e
>> that syntax is deprecated.  Use this feature in git-gui and get rid of
>> that warning.
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>> Tested only _very_ lightly!
>>
>>  git-gui/lib/merge.tcl | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/git-gui/lib/merge.tcl b/git-gui/lib/merge.tcl
>> index 460d32f..5ab6f8f 100644
>> --- a/git-gui/lib/merge.tcl
>> +++ b/git-gui/lib/merge.tcl
>> @@ -112,12 +112,7 @@ method _start {} {
>>  	close $fh
>>  	set _last_merged_branch $branch
>>
>> -	set cmd [list git]
>> -	lappend cmd merge
>> -	lappend cmd --strategy=3Drecursive
>> -	lappend cmd [git fmt-merge-msg <[gitdir FETCH_HEAD]]
>> -	lappend cmd HEAD
>> -	lappend cmd $name
>> +	set cmd [list git merge --strategy=3Drecursive FETCH_HEAD]
>>
>>  	ui_status [mc "Merging %s and %s..." $current_branch $stitle]
>>  	set cons [console::new [mc "Merge"] "merge $stitle"]
>>
>
> Much better than my version. I had left fmt-merge-msg and added
> --no-log to treat merge.log config suitably. But this works too, and
> is much more obvious.
>
> Tested-by: Johannes Sixt <j6t@kdbg.org>

Thanks both.

We can finally deprecate and remove the ancient "git merge" syntax
with this, which should make me happy, but with git-gui maintainer
missing, it nudges me to be an interim maintainer one more time.

Sigh...
