From: "Nathan W. Panike" <nathan.panike@gmail.com>
Subject: Re: help with git query
Date: Mon, 13 Apr 2009 17:33:25 -0500
Message-ID: <d77df1110904131533y46234255qc0ec533ee583df95@mail.gmail.com>
References: <3a69fa7c0904131151p35945ed3y58cba069bd801337@mail.gmail.com>
	 <d77df1110904131331p24f52220o74c401c97fbb904d@mail.gmail.com>
	 <3a69fa7c0904131357w5ef6b8feu7aac503fdcc4486c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: E R <pc88mxer@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 00:35:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtUk1-0006yw-F0
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 00:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752274AbZDMWd2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2009 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751827AbZDMWd1
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Apr 2009 18:33:27 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:11441 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbZDMWd0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Apr 2009 18:33:26 -0400
Received: by yx-out-2324.google.com with SMTP id 31so2390948yxl.1
        for <git@vger.kernel.org>; Mon, 13 Apr 2009 15:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=iU71Bf8SgtlBW34A29ftP5+mV+P3wF5lerbQgS2CMgk=;
        b=YEfrhmi59n+JsKK1IJg30vSAe1lsVJc8d6yUrGKTkbUNA4QjeN+D1k340HpAW4l9+v
         /ICPX3oGc3gsj3kdPPV0ubZrb5cJLx78jugmGqjBy+zQdLJEfsi+vR9vs1iiz14o2ioN
         s/uVS1wzx/tY9uTIJQFx5uKYuooGeBj8OppyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WMvh782L0LWMI7cDMamDx0HPM0WqSK9FR/tVJyZQaaupUxvwioamvi4ni9eSe4Dzl/
         j6DJO8ZuAGcJiMXjcijccz6DqpCXRaCBI5XZjqiZFyK3tRhkDG8i1MPM0BUE6Iyn8o8D
         OpT9SlFZhlUvgTg6QYX8wpZZtWV0NJ1jJ8/0Y=
Received: by 10.231.19.204 with SMTP id c12mr1656516ibb.55.1239662005545; Mon, 
	13 Apr 2009 15:33:25 -0700 (PDT)
In-Reply-To: <3a69fa7c0904131357w5ef6b8feu7aac503fdcc4486c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116494>

On Mon, Apr 13, 2009 at 3:57 PM, E R <pc88mxer@gmail.com> wrote:
> Thanks - that's very helpful.
>
> For the second question, is it possible to find the commit that
> represents the merge in the master branch?

There might not be an actual commit, if the merge was a fast forward.

>
> i.e.
>
> =A0 git merge-base XXX master
>
> returns the commit in branch XXX that got merged into master. I'd lik=
e
> to also find the commit that represents the merge in master.

If one exists, I think this might do what you want:

git log --pretty=3Doneline master --not $(git merge-base XXX master) | =
tail -1

> On Mon, Apr 13, 2009 at 3:31 PM, Nathan W. Panike
> <nathan.panike@gmail.com> wrote:
>> On Mon, Apr 13, 2009 at 1:51 PM, E R <pc88mxer@gmail.com> wrote:
>>> Hi,
>>>
>>> I'd like to generate the following report from git:
>>>
>>> for each branch:
>>> =A0- info about the latest commit on that branch (date and time, me=
ssage, etc.)
>>
>> Depending on what you want to do---from a bash shell, you could do:
>>
>> for i in $(git branch -a | cut -b3-); do echo $i; git show -s $i; ec=
ho; done
>>
>>> =A0- info about the last time it was merged into master
>>
>> for i in $(git branch -a | cut -b3-); do echo $i; git show -s $(git
>> merge-base $i master); echo; done
>>>
>>> What commands can I run to figure this out? I think I can figure ou=
t
>>> the first one - it's the second one I'm having trouble with.
>>>
>>> And if it would easier to do it from the C API (or something like t=
he
>>> perl Git::PurePerl module) I'd be interested in knowing that, too.
>>>
>>> Thanks,
>>> ER
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>
