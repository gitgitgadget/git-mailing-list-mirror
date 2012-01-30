From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Fwd: Gitweb error
Date: Mon, 30 Jan 2012 20:08:48 +0100
Message-ID: <201201302008.48421.jnareb@gmail.com>
References: <5fa08a8b-f0a2-4796-bf0d-06a8f13bf703@b23g2000yqn.googlegroups.com> <201201290137.17556.jnareb@gmail.com> <CA+EqV8xB6vcDrqM3EY7uRfu0c7sOj6FbMXci+5w2qgi5RSWrbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
To: rajesh boyapati <boyapatisrajesh@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 30 20:08:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrwaS-00010Y-8K
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 20:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab2A3TIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jan 2012 14:08:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:45648 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab2A3TIO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jan 2012 14:08:14 -0500
Received: by eekc14 with SMTP id c14so1543535eek.19
        for <git@vger.kernel.org>; Mon, 30 Jan 2012 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        bh=hFUse/rtrNnDtH69A/sKoW7Axrnz0G0SEFQFc1MNod4=;
        b=lHNsJ+NdZgo5s8rcr17CDxT8mGa41aMzBGhYbh8I8uA0UlBTJG0+fbZvw4Ynzy9YX5
         D6R53Y0zKAlBMV6nak8pnkKCYWnKbBnkv5szs4R05gdw8C5LdGd/KVPK0lHWzUs7YAVn
         MySLCFoXs/26wKmGRBeMvQKd6sI62CmAZlXP0=
Received: by 10.14.137.204 with SMTP id y52mr53261eei.60.1327950492825;
        Mon, 30 Jan 2012 11:08:12 -0800 (PST)
Received: from [192.168.1.13] (abwi152.neoplus.adsl.tpnet.pl. [83.8.232.152])
        by mx.google.com with ESMTPS id b3sm24980058een.2.2012.01.30.11.08.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 30 Jan 2012 11:08:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <CA+EqV8xB6vcDrqM3EY7uRfu0c7sOj6FbMXci+5w2qgi5RSWrbw@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189400>

On Mon, 30 Jan 2012, rajesh boyapati wrote:
> 2012/1/28 Jakub Narebski <jnareb@gmail.com>
>> On Fri, 27 Jan 2012, rajesh boyapati wrote:

>>>     my $alternate = 1;
>>>     for (my $i = $from; $i <= $to; $i++) {
>>>         my $entry = $headlist->[$i];
>>>         my %ref = %$entry;
>>>         my $curr = $ref{'id'} eq $head;
>>>         if ($alternate) {
>>>             print "<tr class=\"dark\">\n";
>>>         } else {
>>>             print "<tr class=\"light\">\n";
>>>         }
>>>         $alternate ^= 1;
>>
>> Hmmmm... I see that we do not check if $head is defined here before using
>> it.  This can happen legitimately if we are on yet to be born orphan branch
>> (so $head, which should be named $head_at, is undefined) but there exist
>> other branches (so $headlist is not empty).
>>
>> But I don't think it is what happened in your case, is it?

tldr; It did happen.
 
> For my git projects on gerrit, our main branch name is "base".
> We don't have any code on "master" branch.
> May be the $HEAD is looking for master branch(or checked out branch in git
> project).--> In our case, "master" is an empty branch.
> Also, In the git projects, the HEAD file is pointing to "ref:
> refs/heads/master".
> So, I think that's the reason for errors.
> 
> How can I make $HEAD to point to a branch other than "master"?.
>   a) I can do this by pointing HEAD file in git projects to other branch
[...]
>   b) Is there any way, other than doing above step (a) ?.
>      I mean I don't want to have a code on "master" branch and also I
>      don't want to point HEAD file in git projects to some other branch.
>      Do I need to make any modifications to "gitweb.cgi" for this?

Now that I know the source of this error, I can write test case
for it, and fix it.  I'll try to do it soon.

So finally what you would need for (b) is just upgrade gitweb.
-- 
Jakub Narebski
Poland
