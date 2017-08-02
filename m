Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A13120899
	for <e@80x24.org>; Wed,  2 Aug 2017 18:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751699AbdHBSVb (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 14:21:31 -0400
Received: from mail.gooeysoftware.com ([208.100.15.213]:48468 "EHLO
        mail.gooeysoftware.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751154AbdHBSVa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 14:21:30 -0400
X-Greylist: delayed 493 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Aug 2017 14:21:30 EDT
Received: from [192.168.1.3] (82-69-83-224.dsl.in-addr.zen.co.uk [82.69.83.224])
        by mail.gooeysoftware.com (Postfix) with ESMTPSA id 4519B18A079B;
        Wed,  2 Aug 2017 13:21:49 -0500 (CDT)
Message-ID: <598215C8.4000100@game-point.net>
Date:   Wed, 02 Aug 2017 19:11:20 +0100
From:   Jeremy Morton <admin@game-point.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.18) Gecko/20110616 Thunderbird/3.1.11
MIME-Version: 1.0
To:     Heiko Voigt <hvoigt@hvoigt.net>
CC:     Junio C Hamano <gitster@pobox.com>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Chris Packham <judge.packham@gmail.com>, git@vger.kernel.org,
        mara.kim@vanderbilt.edu, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH] clone: add clone.recursesubmodules config      option
References: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com> <1401874256-13332-1-git-send-email-judge.packham@gmail.com> <xmqqvbsgvb9l.fsf@gitster.dls.corp.google.com> <538F6E52.9000009@web.de> <xmqq4mzzte2z.fsf@gitster.dls.corp.google.com> <20140606052601.GB77405@book.hvoigt.net>
In-Reply-To: <20140606052601.GB77405@book.hvoigt.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Did this ever get anywhere?  If not why not?  It would be very useful 
to me to be able to clone recursively by default, especially 
considering you can't use 'alias' to override the existing 'clone' 
command.

-- 
Best regards,
Jeremy Morton (Jez)

On 06/06/2014 06:26, Heiko Voigt wrote:
> On Thu, Jun 05, 2014 at 11:18:28AM -0700, Junio C Hamano wrote:
>> Jens Lehmann<Jens.Lehmann@web.de>  writes:
>>> We had two settings in mind,...
>>> So what if clone would just do an "git submodule init" for now when
>>> "submodule.autoinit" is set but "submodule.autoupdate" isn't [?]
>>> ... and a single "submodule.auto" setting would be what users really want?
>>
>> I do not offhand think of a sensible scenario where you want to init
>> a submodule once but do not want to update it when the superproject
>> changes.  Even if the user uses the mode to detach the submodule
>> HEAD, i.e. the branches in submodules do not matter and the whole
>> tree is described by the superproject's commit and gitlinks recorded
>> in it, the user would want the new objects necessary for the updated
>> superproject, which means a submodule that is init'ed (whether it is
>> via "git submodule init" or the submodule.autoinit variable) must be
>> updated.
>>
>> So I am not sure why a user wants to disable autoupdate in the first
>> place.  For the same reason, setting submodule.*.update to none
>> would not make much sense, either.  Perhaps I am missing something.
>>
>> Unless the user is very conservative and suspects that these
>> recursive behaviour we are going to bolt on to various commands
>> could be buggy and untrustworthy, in which case the user might want
>> to manually run "git submodule update", or even run "git fetch"
>> after going there while bypassing the whole "git submodule".  But I
>> do not think that is healthy in the longer run.
>
> I think autoupdate is mainly there for the transition phase. Since
> submodule can e.g. contain a lot of files a checkout would take much
> longer. Similar to when Jens implemented the recursive diff, many people
> were annoyed by the new files showing up and some with the impact on
> performance (thats why we have the --ignore-submodules option).
>
> In case of very big submodules and people already ignore their diff it
> might even be necessary that the update is only done manually. E.g. for
> a big media repository.
>
> Cheers Heiko
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
