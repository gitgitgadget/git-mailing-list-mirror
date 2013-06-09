From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:29:50 -0500
Message-ID: <CAMP44s21=gMH9wPXN9-dXxM6=jR68ctBXQZzi_G9PL-gMPGN+Q@mail.gmail.com>
References: <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
	<CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
	<CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
	<CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
	<CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
	<CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
	<20130609043444.GA561@sigill.intra.peff.net>
	<CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
	<20130609175554.GA810@sigill.intra.peff.net>
	<CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
	<20130609182246.GE810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:30:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkNK-0004uc-Cc
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814Ab3FIS3y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:29:54 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:60895 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab3FIS3x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:29:53 -0400
Received: by mail-lb0-f181.google.com with SMTP id w10so2915453lbi.40
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=hF4zUS861z0SXSly/11HNvUuTKC6J5rggGHrucIAue8=;
        b=bmN4m8FDOyiuSz5IJZ84m16xNkFnaZsxjIBFWHpwzb5aEp/tLjNqbr07UTwSb5mOWf
         ZcrHY6DDFoX7eO3L446PDJEnunsk2nR9tcBuiDZBAnfsPdZ+iSytgWdIBisswKr83mZk
         a9HYJawPJqAyDaTdd/+wLc6NbGTJUmTxJVPXX+olxQrR6AN+9dGrylmelHjUlZp3STNg
         c0+Dbxm/9tum18B7BsR4BhtEI3rJ9QgP+5jepT37qJzI3ZP9vpdD8lL1b6+q+F9Qwxzh
         tlqgyRXkyrjhCdVoE133JMncEWNDqaZqGnE/Vqf9HVIkJoYEK9lrVcjNXDlp4eMIYdBM
         ERkw==
X-Received: by 10.152.27.170 with SMTP id u10mr3380160lag.45.1370802591000;
 Sun, 09 Jun 2013 11:29:51 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 11:29:50 -0700 (PDT)
In-Reply-To: <20130609182246.GE810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227087>

On Sun, Jun 9, 2013 at 1:22 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Jun 09, 2013 at 11:36:42PM +0530, Ramkumar Ramachandra wrote:
>
>> Jeff King wrote:
>> > I already mentioned elsewhere that I think it would be fine to massage
>> > libgit.a in that direction. I even joined the conversation pointing out
>> > some cases where Felipe's ruby module would break. But I do not think
>> > that moving code in and out of libgit.a is an important first step at
>> > all. That is simply code that no library users would want to call, and
>> > is easy to deal with: move it out. The hard part is code that users
>> > _would_ want to call, and is totally broken. Patches dealing with that
>> > are the hard obstacle that people working in this direction would need
>> > to overcome. But I do not see any such patches under discussion.
>>
>> Forget the rest; this makes it clear.  Thanks, and sorry for all the confusion.
>>
>> So, reorganization is not the first step.  Can you please post an
>> example patch illustrating what needs to be done, so we can follow?
>
> Sorry, I don't have patches. It is a hard problem for which I do not
> have the solution, which is kind of my point.

Wouldn't it make sense then to concentrate on the patches that we do have?

> For the record, I am not _against_ any code organization that might be
> useful for lib-ification later. I just do not see it as an interesting
> step to be discussing if you want to know whether such a lib-ification
> effort is feasible.

If you don't find it interesting, don't do it. I already did this step
(Move sequencer to builtin), the question is; does it go forward, or
should it be rejected?

-- 
Felipe Contreras
