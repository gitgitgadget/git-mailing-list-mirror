From: Justin Collum <jcollum@gmail.com>
Subject: Re: git status resets permissions on index file -- Ubuntu 12.04 64b
Date: Thu, 8 Aug 2013 16:58:20 -0700
Message-ID: <CACO0oR7tJNKWA=cynBA8R2kaGr2iKNCiCmXKLur9nub6pnBG0g@mail.gmail.com>
References: <CACO0oR7a1-fUASQ+SJVbH1CU8d=NbHrK0MuMu+9Pr4_=7q85Vw@mail.gmail.com>
	<52040F27.4050908@googlemail.com>
	<20130808221807.GA8518@gmail.com>
	<C525FA0D-D22C-4C78-8C97-45819FD58DD7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Andrew Ruder <andy@aeruder.net>, Git List <git@vger.kernel.org>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 01:58:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7a65-0003vM-M8
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 01:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966814Ab3HHX6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 19:58:21 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:55547 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966520Ab3HHX6V (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 19:58:21 -0400
Received: by mail-ie0-f171.google.com with SMTP id 10so3038493ied.2
        for <git@vger.kernel.org>; Thu, 08 Aug 2013 16:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HWdG0ghyOghDd7OhjeFTj1U7ZbQ7sC8A/D39e1U/OXE=;
        b=eVjxqNAVI/h8rnPnPoKS8HMVXBZsSNDU604thu1Pp1G4/1BWLbxPnRaosy6Nxv7Xxe
         WRR58GIZVfENmX+K4XS2/3sssRZc58/+h8JPAv0MDdZQJzGkHtoqA7dvl1ou+cgN89cf
         4CCLhAYI+eKECaqEUCPMaqzAzGVcsXj8XTbnUvtnuc7SzIlAyvP5ieLuvxG8XtMRJVc5
         wOcBkd9Gs8l1+64swnFEJogHknDAKPTcIO/0BOCyguSNSjko8WuocDXD5g0es2WtvXN1
         9oHiP3Ghli8OrGXvg1jcL72MLgPED/gXRfzQMzn9rhp6NX6A9rouYcYOlLj5f7/tOZk+
         bCvg==
X-Received: by 10.50.112.69 with SMTP id io5mr813494igb.27.1376006300546; Thu,
 08 Aug 2013 16:58:20 -0700 (PDT)
Received: by 10.43.146.70 with HTTP; Thu, 8 Aug 2013 16:58:20 -0700 (PDT)
In-Reply-To: <C525FA0D-D22C-4C78-8C97-45819FD58DD7@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231951>

doing

     sudo chmod 644 ./.git/index

instead of 777 resulted in the same result a bit later:

    $ gs
    fatal: index file open failed: Permission denied


On Thu, Aug 8, 2013 at 3:37 PM, Kyle J. McKay <mackyle@gmail.com> wrote:
> On Aug 8, 2013, at 15:18, Andrew Ruder wrote:
>>
>> On Thu, Aug 08, 2013 at 11:35:35PM +0200, Stefan Beller wrote:
>>>
>>> On 08/08/2013 10:27 PM, Justin Collum wrote:
>>>>
>>>> [...]
>>>> -rwxrwxrwx   1 dev dev  17K Aug  8 13:12 index
>>>> [...]
>>>> -rw-rw-r--   1 dev dev  17K Aug  8 13:16 index   # <---------------
>>>
>>>
>>> The permissions are set to reading for all and writing for you(r user)
>>> and your group. This should be no problem with standard git commands.
>>> Before you had the index file executable, why would you need that?
>>
>>
>> I'm about 90% sure the issue he's having is that the write bit for
>> other/world goes away and he is neither the user dev or the group dev
>> and the reason for all the executable bits is that he is regularly
>> running
>>
>>    chmod -R 777 .
>>
>> Justin, if this is true, I will tell you that git respects your umask
>> but I just can't bring myself to really suggest someone type umask 000
>> ever. :(
>
>
>
> Justin,
>
> If you really want a repository that's writable by everyone, why not just do
> "git config core.sharedRepository 0666" ?
>
> If you just want them to be group-writable you may be happier with "git
> config core.sharedRepository true" or possibly "git config
> core.sharedRepository all".  The setting is described fully in "git help
> config".
