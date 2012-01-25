From: "Frans Klaver" <fransklaver@gmail.com>
Subject: Re: [PATCH 3/5] run-command: Elaborate execvp error checking
Date: Wed, 25 Jan 2012 23:48:36 +0100
Message-ID: <op.v8nwbai60aolir@keputer.lokaal>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
 <20120124232239.GG8222@burratino> <op.v8motzak0aolir@keputer>
 <20120125192222.GH1824@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	"Johannes Sixt" <j6t@kdbg.org>
To: "Jonathan Nieder" <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 23:48:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqBe1-0006Q8-1M
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 23:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751382Ab2AYWsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 17:48:40 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37577 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352Ab2AYWsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 17:48:39 -0500
Received: by eekc14 with SMTP id c14so2821506eek.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 14:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=content-type:to:cc:subject:references:date:mime-version
         :content-transfer-encoding:from:message-id:in-reply-to:user-agent;
        bh=cjxSdqXZRaQI87BH++YAK19d94TrP6wgPfOpsr2bjf8=;
        b=Zj7xjVJa6kL6CZcrRE3+/vfGbG+NgGrwOn12rklNCW//xHz16ualL/rg+vlZwvj6oJ
         7r4O1G1PA9nugwfmyYWC0uZvYwtUbvj9XfyJ1y6cHpI6AzvImzwnQ9SEAiNuBze+419v
         71dKqDdBgYG+OCcm6LA/DdnWx41850v/KiuJk=
Received: by 10.14.51.18 with SMTP id a18mr6647044eec.39.1327531718588;
        Wed, 25 Jan 2012 14:48:38 -0800 (PST)
Received: from keputer.lokaal (82-136-253-149.ip.telfort.nl. [82.136.253.149])
        by mx.google.com with ESMTPS id n56sm7394622eeh.6.2012.01.25.14.48.36
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 14:48:37 -0800 (PST)
In-Reply-To: <20120125192222.GH1824@burratino>
User-Agent: Opera Mail/12.00 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189131>

On Wed, 25 Jan 2012 20:22:22 +0100, Jonathan Nieder <jrnieder@gmail.com>  
wrote:

> Frans Klaver wrote:
>> Jonathan Nieder wrote:
>
>>> Could you give an example?
>>
>> The case that triggered me to work on this. I had an incorrect entry
>> in my PATH and some aliasing tests failed. The generated command
>> output was something like
>>
>> fatal: script: Access Denied
>
> Sorry for the lack of clarity.  I meant that a (precise) "before and
> after" example could make the commit message a lot easier to
> understand.

Ah I see. I'll add something along those lines.


> [...]
>>> What happens on Windows?
>>
>> I haven't changed anything on the windows side, so that probably
>> sticks to the old behavior.
>
> This was mostly a comment on the change description --- unless I look
> at the patch, if I try this out on Windows after reading the changelog
> I would end up utterly confused.  For patch 5/5, it also brings up
> worries about consistency --- if systems are going to be relying on a
> missing #! interpreter being treated differently from a missing script
> for the sake of silent_exec_failure, do the same considerations apply
> on Windows, too?

I'm actually not sure if scripts would be relying on this. There is of  
course a good chance that people actually will rely on it, regardless of  
what we think. If there are consistency concerns on different platforms  
I'd probably have to work on that as well. Mentioning that windows isn't  
affected by these changes would be a start though.

> Perhaps it's more along the lines of "this is not supposed to happen
> in practice, and when it does, humans will find it easier to debug if
> we error out hard instead of falling back to the 'if the command does
> not exist' behavior (e.g., by trying an alias next)".  In other words,
> maybe this is intended as an optional nicety rather than something
> scripts would ever rely on.

Exactly. My concern was primarily the human interaction, so getting at  
least some pointer to the cause of the error. Would that be nice to have  
on windows as well? It probably would.
