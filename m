Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ACBC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:31:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4561320731
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 19:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgKBTbP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 14:31:15 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:47040 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgKBTbP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 14:31:15 -0500
Received: from client3368.fritz.box (i5C7473CB.versanet.de [92.116.115.203])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id F3ACA3C451B;
        Mon,  2 Nov 2020 20:31:13 +0100 (CET)
Subject: Re: [PATCH 2/2] git-gui: Auto-rescan on activate
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
References: <20201101170505.71246-1-stefan@haller-berlin.de>
 <20201101170505.71246-3-stefan@haller-berlin.de>
 <20201102154815.4incizurpmdhhmjh@yadavpratyush.com>
From:   Stefan Haller <stefan@haller-berlin.de>
Message-ID: <9e3ceab4-319e-8766-1a7e-ddb36e8ecabb@haller-berlin.de>
Date:   Mon, 2 Nov 2020 20:31:13 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201102154815.4incizurpmdhhmjh@yadavpratyush.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.11.20 16:48, Pratyush Yadav wrote:
> Hi Stefan,
> 
> On 01/11/20 06:05PM, Stefan Haller wrote:
>> Do an automatic rescan whenever the git-gui window receives focus. Most other
>> GUI tools do this, and it's very convenient; no more pressing F5 manually.
>>
>> People who don't like this behavior can turn it off using
>> "git config gui.autorescan false".
>>
>> Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
>> ---
>>  git-gui.sh | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/git-gui.sh b/git-gui.sh
>> index 8864c14..4a4ac19 100755
>> --- a/git-gui.sh
>> +++ b/git-gui.sh
>> @@ -906,6 +906,7 @@ set font_descs {
>>  }
>>  set default_config(gui.stageuntracked) ask
>>  set default_config(gui.displayuntracked) true
>> +set default_config(gui.autorescan) true
> 
> Default to false. See my reply to the cover letter for more info.
> 
> It would also be a good idea to include an option for this in the 
> options dialog. Check do_options in lib/options.tcl for examples.

Ok, I'll see if I can add a checkbox in the dialog. Might take a few
days until I have time for doing a re-roll.


>>  
>>  ######################################################################
>>  ##
>> @@ -4020,6 +4021,10 @@ bind .   <Alt-Key-2> {focus_widget $::ui_index}
>>  bind .   <Alt-Key-3> {focus $::ui_diff}
>>  bind .   <Alt-Key-4> {focus $::ui_comm}
>>  
>> +if {[is_config_true gui.autorescan]} {
>> +	bind .   <FocusIn>  schedule_rescan
>> +}
>> +
> 
> Ok.
> 
>>  set file_lists_last_clicked($ui_index) {}
>>  set file_lists_last_clicked($ui_workdir) {}
>>  
>> -- 
>> 2.29.2
>>
> 
