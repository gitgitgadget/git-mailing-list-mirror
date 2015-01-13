From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: git rerere forget isn't working?
Date: Tue, 13 Jan 2015 07:39:01 -0600
Message-ID: <CAHd499AS4q4wvSDAnaiZ9qo2C7Br3rmnrTBtDv-YgQn_=zJPnA@mail.gmail.com>
References: <CAHd499C6opP_0RBGDS=h+1qhrr=7sD0w0hf_bpGWT-wPP4iJoQ@mail.gmail.com>
	<xmqq7fwrambo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 14:39:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB1ga-0007kV-Uj
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 14:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbbAMNjD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 08:39:03 -0500
Received: from mail-oi0-f41.google.com ([209.85.218.41]:37910 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbbAMNjC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 08:39:02 -0500
Received: by mail-oi0-f41.google.com with SMTP id i138so2322864oig.0
        for <git@vger.kernel.org>; Tue, 13 Jan 2015 05:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MmI9hNkRifI6GWzbWuCMEe8cadCEMs//QvK5drl7ACg=;
        b=y7G+W5vYVaur8YSOI7SZQBJEdgOsFBLE98VP+MqQMgjHZpgkaMhULXhbfb3+IiwFfh
         OlLj2ceK/+C+7aPK2CXnVz10bm5qosW5brS5PN5LmuxegOrz7aSRQWE3cLafvN5I/uSP
         TTEWYdvCn85gBwPIhRBeWJRA1s5a2zreoWKBHloe3+zlKZ4H1c6GZLucWBLI+cTORJch
         pCePFXQBcrKD7/zNrNjcmVnffTrc67dv1ezee38N1Xba6B7kkr5p54yHr37xLVTmeUxF
         BfzGFufKCyN39X6Bn45K9rs9gAfwyuaVTn2jNE3ShMiIx/jPc2+E2oa79tbrRsWgPc0M
         WSsg==
X-Received: by 10.202.196.206 with SMTP id u197mr19652871oif.21.1421156341248;
 Tue, 13 Jan 2015 05:39:01 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.202.215.131 with HTTP; Tue, 13 Jan 2015 05:39:01 -0800 (PST)
In-Reply-To: <xmqq7fwrambo.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: -H3upCsxE82pfKpM4RYDKdC4rSk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262337>

On Mon, Jan 12, 2015 at 12:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> So I want a way to clear out the whole rerere cache (i.e. every
>> remembered conflict resolution). So I try this command:
>>
>> $ git rerere forget .
>
> The forget subcommand is to tell Git that you screwed up in this
> sequence:
>
>     $ git merge other ;# or any "mergy" operation that leaves conflict
>     $ edit foo ;# help Git resolve conflicts
>     $ git rerere foo ;# and tell it to remember
>     ... and then later find that your earlier resolution was wrong
>     $ git rerere forget foo
>
> The "dot" there may mean "all paths", but it is still "all paths I
> resolved for this particular set of conflicts the "mergy" operation
> produced.  There is no "I do not care if there are good resolutions
> remembered that do not have anything to do with the current merge,
> just remove all of them"---that is what "rm -fr .git/rr-cache" is
> for.

So to be clear, `rerere forget` is for use prior to `merge --abort`
then? I have the global config option set to make rebase and merge
automatically record to rr cache (forgetting the name ATM but you
should know what I'm talking about). I didn't see it documented that
it's safe/recommended to manually delete rr-cache directory, so I
wasn't sure if that was a valid solution.

Thanks for the information it has been helpful.
