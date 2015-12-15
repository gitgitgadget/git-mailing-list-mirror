From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 7/8] config: add core.untrackedCache
Date: Tue, 15 Dec 2015 17:35:51 +0100
Message-ID: <CAP8UFD1gJGASyhkks4BdVwdCdZRRcwWR8inq291ft_3dg2y6XQ@mail.gmail.com>
References: <1449594916-21167-1-git-send-email-chriscool@tuxfamily.org>
	<1449594916-21167-8-git-send-email-chriscool@tuxfamily.org>
	<xmqqsi3ckadi.fsf@gitster.mtv.corp.google.com>
	<xmqqfuzck1dp.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD3at0X9ThpXGTwyPnu_dXFj6x=YzfkCa82m+RsWwhFOOA@mail.gmail.com>
	<xmqq6100ke7v.fsf@gitster.mtv.corp.google.com>
	<xmqqa8pciuqq.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD0ex4JuU=FMDwnSnf9io16=D2_m3x1ajXtCu25OU_DLAw@mail.gmail.com>
	<CACsJy8CG6LXpUaS09CqaoqLEqzexb14JA02o4HcoxdwM05QQ=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 15 17:36:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8sa2-0007Kd-CY
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 17:36:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933543AbbLOQfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Dec 2015 11:35:55 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:35373 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753352AbbLOQfx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Dec 2015 11:35:53 -0500
Received: by mail-lf0-f50.google.com with SMTP id l133so10725521lfd.2
        for <git@vger.kernel.org>; Tue, 15 Dec 2015 08:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aofGOYSKrooYzITCO1Iad3RgKcXIeSjpbitfNaZUgZo=;
        b=ZzIPJCVJOz4nzVG2mmUXakINguFp5ZHoDwb8BICdXFt6pHbNJz863laG3R/fZAkiD+
         s5xoIhoCk9HsJzw9ZovBzzVbmlj8LVoK7QRVRWf56dze6wZ2PGNVnWKu/batTAxYn2kb
         CuTLBBSKRibu5AqQv/b1Vdf0qEdP4HJwCf+FJm3FyJmRQbQ1wd8D3i/WoR/hvK9LYTRs
         SVXABTxTnUgjP403scIzwtlB4uWesQHb3MMysiD9miG8jPdrOHqEDHc9iDXggY5tc5Vg
         1/0ePph9O/oMplcex/9f2lrEzG9RaBII/bl+8abvdXo3frPkJSptpFGv3dmbMuGdkB4D
         wTDg==
X-Received: by 10.25.142.84 with SMTP id q81mr13338781lfd.77.1450197351565;
 Tue, 15 Dec 2015 08:35:51 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Tue, 15 Dec 2015 08:35:51 -0800 (PST)
In-Reply-To: <CACsJy8CG6LXpUaS09CqaoqLEqzexb14JA02o4HcoxdwM05QQ=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282492>

On Tue, Dec 15, 2015 at 11:02 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Tue, Dec 15, 2015 at 4:34 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> On Mon, Dec 14, 2015 at 10:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>> The primary reason why I do not like your "configuration decides" is
>>> it will be a huge source of confusions and bugs.  Imagine what
>>> should happen in this sequence, and when should a stale cached
>>> information be discarded?
>>>
>>>  - the configuration is set to 'yes'.
>>>  - the index is updated and written by various commands.
>>>  - more work is done in the working tree without updating the index.
>>>  - the configuration is set to 'no'.
>>>  - more work is done in the working tree without updating the index.
>>>  - the configuration is set to 'yes'.
>>>  - more work is done in the working tree without updating the index.
>>>  - somebody asks "what untracked paths are there?"
>>
>> As far as I understand the UC just stores the mtime of the directories
>> in the working tree to avoid the need of lstat'ing all the files in
>> the directories.
>>
>> When somebody asks "what untracked paths are there", if the UC has not
>> been discarded when the configuration was set to no, then git will
>> just ask for the mtimes of the directories in the working tree and
>> compare them with what is in the UC.
>>
>> I don't see how it can create confusion and bugs, as the work done in
>> the working tree should anyway have changed the mtime of the
>> directories where work has been done.
>
> Any operation that can add or remove an entry from the index may lead
> to UC update. For example, if file "foo" is tracked, then the user
> does "git rm --cached foo", "foo" may become either untracked or
> ignored. So if you disable UC while doing this removal, then re-enable
> UC again, "git-status" may show incorrect output. So, as long as UC
> extension exists in the index, it must be updated, or it may become
> outdated and useless.

When UC is disabled, it is removed from the index, and when it is
(re-)enabled, it is recreated, so I don't think that your example
applies to the code in this patch.

Thanks anyway for this insight,
Christian.
