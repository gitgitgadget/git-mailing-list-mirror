From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFCv2 05/16] remote.h: Change get_remote_heads return to void
Date: Tue, 02 Jun 2015 14:41:11 -0700
Message-ID: <xmqq4mmp23go.fsf@gitster.dls.corp.google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-6-git-send-email-sbeller@google.com>
	<xmqqlhg124ji.fsf@gitster.dls.corp.google.com>
	<CAGZ79kbuwT_Wd099fys7Dz8y3ckC7pXk-qV4xe=1w4rXhMwRQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:41:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yztvy-0000jg-4z
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556AbbFBVlO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:41:14 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35672 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbFBVlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:41:12 -0400
Received: by iesa3 with SMTP id a3so143606120ies.2
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=mSb8tJZuqUt3SNZjVN+dbrVejJqybRKjXkS4jkFR20U=;
        b=XID7sIX09MuQACIYrSSkOC9qkKpa02euEjvTQGLlzy8TMpRzmJo9YkZhtAjR7dv+DR
         dzwoORkI47RbOtGC1C6ZfiD9BT+mUNZuiTLHnI4SayEN+5sp94qmXl7ADiI5DSSrjjwC
         RY2r8R40cRFyBfBn86ykBi/eu/bHVyXmqm8fWaKUy++GnWg5D6885zNCML0gzcqwxYWY
         5QYLrSmS+dzFeGZsqPGsILSnBlhV4HYKL5HkMyl5uqDFFz65VFB2vtP5pMjbdAtQPtqV
         WMyMYz7e2Duagpa2Neh6X1uaMPnm/30ujjSrajmOlqteg7eUVHqYpCbGMoJsxC/NOiR+
         nNNw==
X-Received: by 10.43.92.199 with SMTP id br7mr37536384icc.43.1433281272357;
        Tue, 02 Jun 2015 14:41:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3140:53f3:e8c0:89b0])
        by mx.google.com with ESMTPSA id n14sm13362897ion.5.2015.06.02.14.41.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Jun 2015 14:41:11 -0700 (PDT)
In-Reply-To: <CAGZ79kbuwT_Wd099fys7Dz8y3ckC7pXk-qV4xe=1w4rXhMwRQg@mail.gmail.com>
	(Stefan Beller's message of "Tue, 2 Jun 2015 14:25:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270607>

Stefan Beller <sbeller@google.com> writes:

> On Tue, Jun 2, 2015 at 2:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> No function uses the return value of get_remote_heads, so we don't want
>>> to confuse readers by it.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>
>> This is somewhat a sad change, as the returned value is designed to
>> be useful if caller wants to continue appending to the list.
>
> But there are no callers since like 2005. ;)

That is not a good excuse when it comes to the API design to deal
with linked lists in a bog-standard way, though.  Many callers of
commit_list_insert() may ignore its return values, but even when the
last caller stopped caring it, that does not necessarily mean the
feature can be removed.
