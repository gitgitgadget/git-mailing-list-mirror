From: David Chanters <david.chanters@googlemail.com>
Subject: Re: Using git-replace in place of grafts -- and publishing
 .git/refs/replace between repos?
Date: Sat, 15 Sep 2012 22:49:30 +0100
Message-ID: <CACffvTroMt-s7X_DV9AHerzKdgz+xABXTd91aTUc2BtYO7QxCA@mail.gmail.com>
References: <CACffvTp4qnHc3RHKDotEfvshVDqGtTX6eh6Fr-bmJSMUvTFN6g@mail.gmail.com>
	<7vvcffyzfh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 15 23:49:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TD0FO-0001dF-56
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab2IOVtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:49:47 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:38342 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437Ab2IOVtb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:49:31 -0400
Received: by obbuo13 with SMTP id uo13so7719255obb.19
        for <git@vger.kernel.org>; Sat, 15 Sep 2012 14:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8O641Tp24kq7xUZ7k2R+s5PrBSDusa7aGUI4wWycoQ0=;
        b=xZG7jq/5o+mI3I+VnHnyoxn4QHViLBmjb/800KGGFG7TaAVQ0cMfLAWGSi3sxaOAP/
         x+zyYSbzT09AdHYH0rAwJVxd2NRqhc4bVrqASo9yN1gDOY8/1NEh3mozbaD3Ktr1Acc8
         4mIYXq1FeIznmKEAXDF0b/8I7QcZEWaO/ar9rnBuwHgLZNh7YsEgP79EDHgG63kor3JF
         2RVeK6aLMEX3xPEsc5DKYXKPfVomiSc7gbPT8PJojXUDMemWWqB0IIncrJi/KNsydzSN
         mmAvf2uKCJQKGvXyNf9tD7W0JIcy9Yq4N9FiZWW0rRWNa1RUUnW1Fepnt4FbAdRR0riS
         eY9Q==
Received: by 10.182.52.105 with SMTP id s9mr8296159obo.25.1347745770984; Sat,
 15 Sep 2012 14:49:30 -0700 (PDT)
Received: by 10.76.85.170 with HTTP; Sat, 15 Sep 2012 14:49:30 -0700 (PDT)
In-Reply-To: <7vvcffyzfh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205583>

Hi,

On 15 September 2012 18:21, Junio C Hamano <gitster@pobox.com> wrote:
> David Chanters <david.chanters@googlemail.com> writes:
>> 2.  If I do publish it, are there any caveats with that?  i.e.,
>> because the replace data will likely point to a repo which in my
>> working checkout I added with "git-remote", is that going to be a
>> problem?
>
> That is between you and other project participants.  They may not
> want to see replacement in their project in the first place.
>
> Assuming that they do, pushing the replacement ref makes the
> replacing object available in the pushed-into repository, so
> they will *not* rely on your repository.

This makes sense.  But it is more the mechanics of what happens with
needing to update the "fetch" line for the remote in .git/config I am
more puzzled by.

For example, if I have two repos -- repoA and repoB, where repoA
contains the replace refs for repoB -- if I clone both repos with the
intent of wanting to look at the two histories, what must I do in
repoA to fetch the replace refs in the first place?

I've tried:

[remote "origin"]
        fetch =
+refs/replace/*:+refs/heads/*:refs/remotes/origin/*:refs/replace/*

But this results in:

% git pull
fatal: Invalid refspec
'+refs/replace/*:+refs/heads/*:refs/remotes/origin/*:refs/replace/*'

So I'm clearly not understanding something here, and even then, I'm
assuming that I can manipulate the correct "fetch" line via "git
config", it's just that I'm not sure which one to use.

I keep meaning to read up on refspec stuff because it looks so useful.

Kindly,

David
