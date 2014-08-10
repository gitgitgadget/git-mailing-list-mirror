From: Stefan Beller <stefanbeller@gmail.com>
Subject: Re: Unify subcommand structure; introduce double dashes for all subcommands?
Date: Sun, 10 Aug 2014 23:08:03 +0200
Message-ID: <53E7DF33.50508@gmail.com>
References: <53CFBA1A.8040600@gmail.com>	<xmqqiomodkt9.fsf@gitster.dls.corp.google.com>	<53E78F26.3000701@gmail.com> <xmqqha1k8b6v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 10 23:08:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGaLj-00047f-4z
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 23:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbaHJVIG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 17:08:06 -0400
Received: from mail-wg0-f50.google.com ([74.125.82.50]:46998 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751224AbaHJVIF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 17:08:05 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so7673532wgh.33
        for <git@vger.kernel.org>; Sun, 10 Aug 2014 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8gqqHG0o08gDQBUpgVeJD6hat8y6ZpHjWqUSq3Iq6ro=;
        b=L1WaULlFmOqeZJ1W3eiv7zMrGZh/mrd4KqFth20QxkSxbohmVcaUYDtL3DoJdUSY1y
         sF7UQ92b2Xd1/wf0dz1l4l1n/9dzqtLmFi2gkGpDFK81eAI0WS3nNEMsqkXiaNzISxlN
         mq/TUdNe+NWZUFYr+wbrkD3E4uSSlLvdl9KIZDxXpOUBX0I6Ohaw5ko939flTsopNVYi
         c5rln0V5A610pIS6qkIKvlUubHyAIvg8eRTedoaYQG0eQGxCMBsGC/G4SxMm9mvnWfaa
         L9RCfOwxxjtKnDRoUFC1As27k1ft7lzQ7osAcVYMUr3RdLcsQCj77wia5N8Ff5DqXbRG
         o/zA==
X-Received: by 10.194.59.42 with SMTP id w10mr49200984wjq.15.1407704883163;
        Sun, 10 Aug 2014 14:08:03 -0700 (PDT)
Received: from [192.168.1.7] (ip-109-91-30-58.hsi12.unitymediagroup.de. [109.91.30.58])
        by mx.google.com with ESMTPSA id u3sm35288931wif.12.2014.08.10.14.08.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2014 14:08:02 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.0
In-Reply-To: <xmqqha1k8b6v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255104>

On 10.08.2014 20:13, Junio C Hamano wrote:
> Stefan Beller <stefanbeller@gmail.com> writes:
> 
>> On 23.07.2014 19:52, Junio C Hamano wrote:
>>
>>> Sounds familiar.  E.g. here is a similar thread about a year ago.
>>>
>>>   http://thread.gmane.org/gmane.comp.version-control.git/231376/focus=231478
>>>
>>> Further discussions to make the plan more concrete is very much
>>> welcomed.
>>>
>>> Thanks.
>>>
>>
>> So I'd want to add have the subcommands without double dashes ideally.
> 
> That is not ideal at all, I am afraid.  A command that started only
> with its "primary operating mode", e.g. "git tag [-s|-a] tagname
> [object]", may have to gain "I do not want to create, I just want to
> list" and the way to signal that has to be an option that cannot be
> mistaken as its valid first argument (to avoid "git tag list" that
> cannot create a tag called "list", we use "git tag --list").  You
> could add an entirely new command "git foo" that always takes the
> command-mode word, i.e. "git foo mode$n args", but you will be
> typing the operating mode name all the time only to save --mode$n
> for 2<=$n, which may not be a good economy in the end.
> 
> Please do not go there.
> 

I see your point.
However how often do you really want to create a tag called list?
As of now it's easy:
	git tag list
and for listing all tags you'd need to type:
	git tag --list
and if you want to create a tag called --list, I'd assume you'd go
	git tag -- --list
	# However:
	fatal: '--list' is not a valid tag name.

So even as of now certain tag names cannot be done easily.
Also you have to type two more dashes for an action you'd probably want
to perform more often (as opposed to creating a tag 'list')

In my (ideal) world we'd rather have this behavior:
 	git tag list
	# behaves the same as
	git tag

Now creating a tag called 'list' is not as easy, because 'list' is a
primary operating mode name, so we need to tell git we're actually
meaning the name as opposed to the operating mode:
	git tag create -- list
	# or even
	git tag create -- --list



----
Anyways despite my arguing, it seems you rather want to rather have the
leading double dashes everywhere for the operating modes?
So the plan is to not touch the parsing, but to adjust notes and stash ?

Thanks,
Stefan
