From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] sha1_name: reorganize get_sha1_basic()
Date: Thu, 2 May 2013 12:52:38 -0500
Message-ID: <CAMP44s2HPRpbot2YhTmRNRmGj_1-+BdnjW9kTVXwq3Ni0YiObA@mail.gmail.com>
References: <1367455791-30091-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8CWGJZByedxhzuU8OkPPBc0XmfZqE_e_ehmt55t-tHmsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxgT-0005Wr-W1
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760312Ab3EBRwl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:52:41 -0400
Received: from mail-lb0-f176.google.com ([209.85.217.176]:34973 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758400Ab3EBRwk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:52:40 -0400
Received: by mail-lb0-f176.google.com with SMTP id v20so793267lbc.21
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ATod/ABhwX2v9AU0s8XhrgJwtydOUQMTQTr1RFzMYAM=;
        b=s1v0sRuMM4Xg/lS8v9COCra022GXse4YwscHdyObduv8oTbmMDF8JxCOrqgni8wpll
         +/JyWVtdPhgM2xkA77KYmWy4kERZU5zglwxS39KRgkrUVMsEzES/BklEDbDCzBj0PljX
         Y6gLl0rm1Uy4f0a3mZbOeT8NW/tSoCDfZrr9zOVvBhgHSnL4aDAN92UA320nL9cWtO4c
         22CwCBSF+HB2kSCKsPUur5fIVZiLqZJNpdoXMxd+kLyvmjAKc8rsZUsLcMz0vSNGLbda
         EiIRb4QcuxiuUNlzko6NxWkMeWRMiJmgFLvr51nd+91Ea7SQQDwihpsoTxcyUEs4bV8m
         nNXw==
X-Received: by 10.112.135.70 with SMTP id pq6mr3121475lbb.82.1367517159015;
 Thu, 02 May 2013 10:52:39 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:52:38 -0700 (PDT)
In-Reply-To: <CACsJy8CWGJZByedxhzuU8OkPPBc0XmfZqE_e_ehmt55t-tHmsQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223241>

On Thu, May 2, 2013 at 5:19 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, May 2, 2013 at 7:49 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> Through the years the functionality to handle @{-N} and @{u} has moved
>> around the code, and as a result, code that once made sense, doesn't any
>> more.
>>
>> There is no need to call this function recursively with the branch of
>> @{-N} substituted because dwim_{ref,log} already replaces it.
>>
>> However, there's one corner-case where @{-N} resolves to a detached
>> HEAD, in which case we wouldn't get any ref back.
>>
>> So we parse the nth-prior manually, and deal with it depending on
>> weather it's a SHA-1, or a ref.
>
> If you are brave, reorganize the whole extended sha-1 parsing code. I
> think the right-to-left parsing is confusing, not to mention it has to
> treat ":path" differently. But may be that's too big work for little
> gain.

Yeah, it took me a while to figure it was the other way around to what
I thought was natural. Maybe after the dust with '@' is settled.

FTR. This doesn't work @{u}@{u}.

-- 
Felipe Contreras
