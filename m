From: Omar Othman <omar.othman@booking.com>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 08:28:58 +0100
Message-ID: <530D97BA.1080107@booking.com>
References: <530B0395.5030407@booking.com>	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 08:29:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIYvZ-0004lh-7n
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 08:29:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbaBZH3H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 02:29:07 -0500
Received: from mail-out5.booking.com ([5.57.20.182]:49179 "EHLO
	mail-out5.booking.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751075AbaBZH3D (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 02:29:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=booking.com; s=bk;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=AXHr2nCiO+LYyFZZPXLsFDcrZMVy8FzemdB0uNS2FPw=;
	b=dln5iUVhmhqgeIDz3owB3+O+DHsIpkuyCHKCUM8s3clcYNVAqGRECMkdMcQr6/GsjxJiFxoJKMkadKcsqaruZjOeGrntBHvorbvIb0Eg8sli7zI96zjMPowbQjbgZKHRjnqdah3MJpPUmXTJ4QWE0PGc8DkhwfTnS569SJMcpQI=;
Received: from corpds-202.lhr4.corp.booking.com ([10.186.68.14]:56806)
	by mtx-201.lhr4.prod.booking.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIYvM-000CWl-1m; Wed, 26 Feb 2014 08:29:00 +0100
Received: from [10.155.74.57] (port=32976)
	by corpds-202.lhr4.corp.booking.com with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
	(Exim 4.80.1)
	(envelope-from <omar.othman@booking.com>)
	id 1WIYvL-0005iw-Sc; Wed, 26 Feb 2014 08:28:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <vpqeh2r43kx.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242698>


>> [omar_othman main (trunk|MERGING*)]$ git add path/to/file.txt
>> [omar_othman main (trunk*)]$
>>
>> Note how the status message has changed to show that git is now happy.
>> It is at that moment that the stash reference should be dropped
> Dropping the stash on a "git add" operation would be really, really
> weird...
>
>> (or the user (somehow) is notified to do that herself if desired),
>> because this means that the popping operation has succeeded.
> But how would you expect to "be notified"?
Answering the last question, your previous comments are fine with me:
>> If there's any change that should be made it should be purely
>> providing more detailed instructions to the user about how to deal
>> with it.
> Yes, there may be room for improvement, but that does not seem so easy.
> Today, we have:
>
> $ git stash pop
> Auto-merging foo.txt
> CONFLICT (content): Merge conflict in foo.txt
>
> $ git status
> On branch master
> Unmerged paths:
>    (use "git reset HEAD <file>..." to unstage)
>    (use "git add <file>..." to mark resolution)
>
>          both modified:      foo.txt
>
> => The advices shown here are OK. Then:
>
> $ git add foo.txt
> $ git status
> On branch master
> Changes to be committed:
>    (use "git reset HEAD <file>..." to unstage)
>
>          modified:   foo.txt
>
> => here, "git status" could have hinted the user "you may now run 'git
> stash drop' if you are satisfied with your merge".
Though I don't know why you think this is important:
> Now, the real question is: when would Git stop showing this advice. I
> don't see a real way to answer this, and I'd rather avoid doing just a
> guess.
If it is really annoying for the user, we can just have a configuration 
parameter to switch this message on/off. I don't know whether git has 
such customizations (in general) currently.

This is very useful (maybe we can agree on wording later):
> One easy thing to do OTOH would be to show a hint at the end of "git
> stash pop"'s output, like
>
> $ git stash pop
> Auto-merging foo.txt
> CONFLICT (content): Merge conflict in foo.txt
> 'stash pop' failed. Please resolve the conflicts manually. The stash
> was not dropped in case you need to restart the operation. When you are
> done resolving the merge, you may run the following to drop the stash reference:
>
>    git stash drop
