From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/6] git-remote-helpers.txt: document invocation before
 input format
Date: Wed, 12 Dec 2012 17:00:52 -0600
Message-ID: <CAMP44s1xetknwdOT5EseuASQE_2WFP1e1-Ao2RWYeya+EJ9SfQ@mail.gmail.com>
References: <1354057407-83151-1-git-send-email-max@quendi.de>
	<1354057407-83151-2-git-send-email-max@quendi.de>
	<CAMP44s3vO9b4-XxqatEc2w3KJLqLGgyjPuKpQkAXHQwTJJEQTg@mail.gmail.com>
	<839EECE2-4459-4358-B7E8-5D64374A0540@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Dec 13 00:01:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TivIb-0004Zi-Ls
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 00:01:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225Ab2LLXAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 18:00:53 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44017 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013Ab2LLXAw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 18:00:52 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1415340oag.19
        for <git@vger.kernel.org>; Wed, 12 Dec 2012 15:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mF8KLgYoa6eB4tEVWu1X6QpVN/jqT6xre6q4kC7XJ80=;
        b=CEH0aW20Mu09vhM+Huf7TEtU4wr+0JINPqUndI9NKh8WExKbMxOkQQdYthS8fUshtB
         5ZUed3Ge5fbmlbHVF3TNpwSEt2dqbRNWb4tgDRLAAiU9XpdzK6HI8ABjQ4T60XcFs1iS
         QS8SDTrpENpKqDCBKA1RDBMSm346IeAzHQO7U/Rp9GhV/xQV05YIg4lWZ4i3/0XFj93x
         KPGCuI/Imhciv9A7b/oSZDRhiEtNUAAuc5941cN+XVScQCAT9BBIslRVtXEmLxJStyW3
         v3sf89CR0fE5J2AsR+dBveZ+bAmSe0Iklie5TjvwLRUTdxoQm9IsWDZysKvxzAwynqf1
         rcjw==
Received: by 10.182.98.5 with SMTP id ee5mr1445353obb.28.1355353252166; Wed,
 12 Dec 2012 15:00:52 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 12 Dec 2012 15:00:52 -0800 (PST)
In-Reply-To: <839EECE2-4459-4358-B7E8-5D64374A0540@quendi.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211409>

On Wed, Dec 12, 2012 at 4:58 PM, Max Horn <max@quendi.de> wrote:
>
> On 12.12.2012, at 23:14, Felipe Contreras wrote:
>
>> On Tue, Nov 27, 2012 at 5:03 PM, Max Horn <max@quendi.de> wrote:
>>
>>> index 5ce4cda..9a7e583 100644
>>> --- a/Documentation/git-remote-helpers.txt
>>> +++ b/Documentation/git-remote-helpers.txt
>>> @@ -35,6 +35,37 @@ transport protocols, such as 'git-remote-http', 'git-remote-https',
>>> 'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
>>> 'fetch', 'option', and 'push'.
>>>
>>> +INVOCATION
>>> +----------
>>> +
>>> +Remote helper programs are invoked with one or (optionally) two
>>> +arguments. The first argument specifies a remote repository as in git;
>>> +it is either the name of a configured remote or a URL. The second
>>> +argument specifies a URL; it is usually of the form
>>> +'<transport>://<address>', but any arbitrary string is possible.
>>> +The 'GIT_DIR' environment variable is set up for the remote helper
>>> +and can be used to determine where to store additional data or from
>>> +which directory to invoke auxiliary git commands.
>>> +
>>> +When git encounters a URL of the form '<transport>://<address>', where
>>> +'<transport>' is a protocol that it cannot handle natively, it
>>> +automatically invokes 'git remote-<transport>' with the full URL as
>>> +the second argument. If such a URL is encountered directly on the
>>> +command line, the first argument is the same as the second, and if it
>>> +is encountered in a configured remote, the first argument is the name
>>> +of that remote.
>>
>> Maybe it's worth mentioning that if the alias of the remote is not
>> specified, the URL is used instead.
>
> Worth a thought yeah -- but beyond the scope of this patch: I merely moved this text around, but did not touch it otherwise.
>
>>
>>> +A URL of the form '<transport>::<address>' explicitly instructs git to
>>> +invoke 'git remote-<transport>' with '<address>' as the second
>>> +argument. If such a URL is encountered directly on the command line,
>>> +the first argument is '<address>', and if it is encountered in a
>>> +configured remote, the first argument is the name of that remote.
>>> +
>>> +Additionally, when a configured remote has 'remote.<name>.vcs' set to
>>> +'<transport>', git explicitly invokes 'git remote-<transport>' with
>>> +'<name>' as the first argument. If set, the second argument is
>>> +'remote.<name>.url'; otherwise, the second argument is omitted.
>>
>> I find all this text a bit confusing. First argument, second argument,
>> etc. Personally, I would describe everything in the terms of alias
>> (1st arg), and URL (2nd arg).
>
> Yeah, I also thought about that, but as above, deliberately did not touch it here, but only moved it around. I'll be happy to revisit this on a future date, though.

Oh, in that case it's fine, but I would have named it "move invocation
before input format", or something that has *move*, or *shuffle*.

-- 
Felipe Contreras
