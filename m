From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "Medium" log format: change proposal for author != committer
Date: Wed, 16 Sep 2015 15:25:32 -0700
Message-ID: <xmqq4mium277.fsf@gitster.mtv.corp.google.com>
References: <robbat2-20150915T214920-375711965Z@orbis-terrarum.net>
	<xmqq8u87t9jb.fsf@gitster.mtv.corp.google.com>
	<CA+P7+xqhJKGmxC=35bRvdKSj=nKRhfH9SqhR9ryrcBDknH-Y=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:26:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcL9L-0006NG-Px
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:26:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577AbbIPWZl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:25:41 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33077 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752498AbbIPWZf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:25:35 -0400
Received: by pacex6 with SMTP id ex6so480053pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ie4PsPwgAE4lg0vssbA9tWO4hD/XyzduYUMY2uWCChk=;
        b=DbhqDrXK8YsEaU5iP7jOgSjLHZ9gaDKmudroNKJ6fsft0Iygw8VPqi37jHWq15tp8O
         hORQiY8jMBBnGTZrAEyWWYIwH9+rR2/EKPMov3pRNQ6ilCPSOUHBYOj5BJY1CeU132i7
         9yWDS4oUUyZt6fG1bS2Tyr2KLL1MGE0mPyzbSnu4dEg3wbYTOnIB9fpD4bh0S3xLhmwO
         v+hG8Be120BT2yWS7NYNBdRq+wrNKr+WjssSP75enKqPhsNE8jLLXNuzgGoPRTwHedNA
         fklkAguiNg7NjAxPCOpQUdsAnz3F+CnxF2Z4EOpJOmle/RUuY3qSbB4hLeWL82KxNzJB
         2eVw==
X-Received: by 10.68.69.79 with SMTP id c15mr12045163pbu.90.1442442334506;
        Wed, 16 Sep 2015 15:25:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id qy5sm134275pbb.16.2015.09.16.15.25.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 15:25:33 -0700 (PDT)
In-Reply-To: <CA+P7+xqhJKGmxC=35bRvdKSj=nKRhfH9SqhR9ryrcBDknH-Y=w@mail.gmail.com>
	(Jacob Keller's message of "Tue, 15 Sep 2015 23:54:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278080>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Tue, Sep 15, 2015 at 6:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>  * Enhance the "--pretty=format:" thing so that the current set of
>>    hardcoded --pretty=medium,short,... formats and your modified
>>    "medium" can be expressed as a custom format string.
>>
>>  * Introduce a configuration mechanism to allow users to define new
>>    short-hand, e.g. if you have this in your $HOME/.gitconfig:
>>
>>         [pretty "robin"]
>>                 format = "commit %H%nAuthor: %an <%ae>%n..."
>>
>
> Afiak there is already support for this.. from "git help config":

Yup.  But before the first bullet item is done, it cannot be used to
replace the built-in hardcoded formats with a built-in set of default
configurations.

>>  * (optional) Replace the hardcoded implementations of pretty
>>    formats with short-hand names like "medium", "short", etc. with a
>>    built-in set of pretty.$name.format using the configuration
>>    mechanism.  But we need to make sure this does not hurt
>>    performance for common cases.
>
> This part obviously hasn't been done, I don't know if any particular
> format is not expressable today by the pretty syntax or not..

One that we know we cannot is the nice conditional one Robin wants.
I do think it is a reasonable thing to have.
