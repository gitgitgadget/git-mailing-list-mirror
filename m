Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225111F461
	for <e@80x24.org>; Tue,  2 Jul 2019 17:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfGBRgV (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 13:36:21 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54693 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBRgU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 13:36:20 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C893776010;
        Tue,  2 Jul 2019 13:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y8rg20O9hE89FhDhnV9o9XQiDR0=; b=JlBT6O
        1mAW7JZSkZ9VRVJGSLt0goDmGruxHyFRcS4AiuZhSC20+aT4nQL4o9lFeo7xkcO1
        jTxEvFX6aJVPzFbq6MheX1GuLwVKbhmiHinzLC3pdzcgep4zUDR/5Vy5Y+w8vl6Y
        4JAf0cdq4Gavpn0/n75lf1eQBeS4Zdeh/hBIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qAvCl2Y5pg3W/Uw3dxs4FgFI1wiEA6QT
        mx0VU08PgCcED+w1gZJcS8Al2ZhwEFLE52zXiTSim9GfZyzKgnfOqQ8OK8IVtBvx
        rANsKkc0vWLnN68g8fVJfsObU6xDchPTfAvLm2e4sxOQB3PitTxamsH8UD25eD38
        dzxRO9A7et8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AA45F7600F;
        Tue,  2 Jul 2019 13:36:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D3B457600E;
        Tue,  2 Jul 2019 13:36:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     rsbecker@nexbridge.com, 'Bryan Turner' <bturner@atlassian.com>,
        'Eric Kulcyk' <Eric.kulcyk@microsoft.com>, git@vger.kernel.org
Subject: Re: Tracking parent branches in Git
References: <DM5PR00MB040845755401A07E5C90251CF1F90@DM5PR00MB0408.namprd00.prod.outlook.com>
        <xmqqpnmt5z19.fsf@gitster-ct.c.googlers.com>
        <CAGyf7-EBs_cRB5R7RyQhX0ZDNqLZWVJEYEtqkGRGJykRqKKTvA@mail.gmail.com>
        <007d01d53049$4db5bec0$e9213c40$@nexbridge.com>
        <77a2b000-f1dc-6f3e-54db-abd227ce6163@iee.org>
Date:   Tue, 02 Jul 2019 10:36:13 -0700
In-Reply-To: <77a2b000-f1dc-6f3e-54db-abd227ce6163@iee.org> (Philip Oakley's
        message of "Tue, 2 Jul 2019 10:23:50 +0100")
Message-ID: <xmqqef3849v6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E4A82026-9CEF-11E9-A483-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

>> I suspect the question is in regards to "What branch did I create
>> my local branch from?", especially given the pull request
>> reference.
>>
>> In other words, when I locally do:
>> git checkout --no-track -b bturner-some-bugfix origin/release/5.16
>>
>> release/5.16 is the "parent branch" of my bugfix branch...
>> ...
> From the Git side, maybe one could simply populate the branch
> description with the commit oid and branched-from name at the time of
> branch creation (no doubt set as a core.option).
> The field is already there and almost never used - there's no easy way
> (via git command) to populate the description anyway. Plus its a local
> field, keeping Git distributed.

I do not think you want branch.description to get mixed-up in this.

In this whole thread, I have been wondering if I am missing
something crucial, but now I am deeply puzzled why after many people
made comments, nobody raises a question about the "--no-track" thing
in the early message in the thread.

If you do not add that, i.e.

	$ git checout -t -b bturner-some-bugfix origin/release/5.16
        
(note that I added '-t' for illustration, but it should be on by
default when starting from origin/<whatever>), then you'd get in
your configuration file these recorded:

	$ git config --get-regexp 'branch\.bturner-some-bugfix\..*'
	branch.bturner-some-bugfix.remote origin
	branch.bturner-some-bugfix.merge refs/heads/release/5.16

You created 'bturner-some-bugfix' branch out of the 'release/5.16'
branch taken from the remote whose name is 'origin'.  

Is that different from the answer to the question being sought?
What am I missing???

