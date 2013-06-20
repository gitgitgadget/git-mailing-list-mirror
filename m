From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Splitting a rev list into 2 sets
Date: Thu, 20 Jun 2013 15:12:09 +0200
Message-ID: <CAC9WiBgmswSqDHS3XOubvkY6GhBqrQ3YdwgKR4npqHM-kLJuMA@mail.gmail.com>
References: <CAC9WiBi-E+LN4hKGeu0mG7ihJWCaTg-W1Dx_PWmX_vsx-uLOaw@mail.gmail.com>
	<CALkWK0=6ZofURGvC-FtS81765yDsA9+0wW94riPZUPudc_nDyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 20 15:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Upeeu-00032H-GO
	for gcvg-git-2@plane.gmane.org; Thu, 20 Jun 2013 15:12:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965459Ab3FTNML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Jun 2013 09:12:11 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44629 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965398Ab3FTNMK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Jun 2013 09:12:10 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so8038203oag.0
        for <git@vger.kernel.org>; Thu, 20 Jun 2013 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=2DkTw2LYEsPiY07zeGjNtRYLrlK9YxrkWWqV9txL5x8=;
        b=YqFqu+eUcyHv5+bINlnxPzKQmvO6g6kFXbg+xok/jKiFW7O44mkbRCefbFf0fdT5CT
         wHtef69n40gVEp9utSuNlIMzsYrV3g73DrclfCLxRzj1F3gEyHODVwiZ5GhZIU7tYaSX
         H7Bq9RZRmQy0wF2g/aoTSU4b2Rq/JBa8VsFbwlR+pTh9b3EGrUnO9GcwAjRYJz5wticd
         q2cQKN9xcqm6Wazd6JeymRCG+15cBBMh01TD1IGf1cswQWru96eIBGKt4ffZjUcQ2lGU
         A00O7HUIcb+PLUBTYcMswMZchge+HGxnKwSbGEC3QJ/RySp5/4zahMmO6zV0/j0I2s+z
         XNRw==
X-Received: by 10.182.33.103 with SMTP id q7mr1459609obi.77.1371733929737;
 Thu, 20 Jun 2013 06:12:09 -0700 (PDT)
Received: by 10.182.200.169 with HTTP; Thu, 20 Jun 2013 06:12:09 -0700 (PDT)
In-Reply-To: <CALkWK0=6ZofURGvC-FtS81765yDsA9+0wW94riPZUPudc_nDyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228495>

On Thu, Jun 20, 2013 at 1:26 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Francis Moreau wrote:
>> To get the commit set which can't be reached by master (ie commits
>> which are specific to branches other than master) I would do:
>>
>>   # "$@" is the range spec passed to the script
>>   git rev-list "$@" ^master | check_other_commit
>>
>> But I don't know if it's possible to use a different git-rev-list
>> command to get the rest of the commits, ie the ones that are reachable
>> by the specified range and master.
>>
>> One way to do that is to record the first commit set got by the first
>> rev-list command and check that the ones returned by "git rev-list $@"
>> are not in the record.
>
> I don't fully understand your query, because almost anything is
> possible with rev-list:
>
>   $ git rev-list foo..bar master # reachable from master, bar, not foo
>
> What I _suspect_ you're asking is for help when you can't construct
> this "foo..bar master" programmatically (or when you cannot express
> your criterion as arguments to rev-list).  You want an initial commit
> set, and filter it at various points in your program using various
> criteria, right?

Yes, I would like to be sure that I haven't missed some magic syntax
for rev-list before going further in my poor man solution :)

Basically I have an initial set (or can be several different sets)
expressed as a revision specification described by git-rev-list man
page. I just want to find the common set of commit which are part of
the initial sets *and* is reachable by master.

I would write it:

     git rev-list "$@" --and master

> In that case, I'd suggest something like this:

Thanks for the details example.

--
Francis
