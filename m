From: knittl <knittl89@googlemail.com>
Subject: Re: Git reset -p on working tree
Date: Tue, 23 Nov 2010 11:58:46 +0100
Message-ID: <AANLkTi=5w3YpYu0_WbmHud0BUkO2BqYNVezWDMkCaSj2@mail.gmail.com>
References: <AANLkTimc=Dt9YSu=J=7C-f1hZ9UODU7VHu6oD8dmFX3N@mail.gmail.com>
 <AANLkTimP9zr=wQDYeBxtvYCE1mZ1aHXQ_nLOxGFfR9YD@mail.gmail.com>
 <AANLkTimQ644C-dEoJTj8bNd9y+YzpMez7D1KLZFNEe7c@mail.gmail.com> <AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Jeenu V <jeenuv@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 11:59:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKqan-0006VP-8A
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 11:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752932Ab0KWK7J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Nov 2010 05:59:09 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:46394 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751914Ab0KWK7I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Nov 2010 05:59:08 -0500
Received: by qyk11 with SMTP id 11so1889692qyk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 02:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type;
        bh=fJ0CQebtPhk7dSQ4nw40YYUeVQPw2iSe8tJi6uxoPcc=;
        b=l3227x9jYOj6C8NCD4oTi0O35sD0i9i7jhThbVC2g810ouJ0LYjxO7tJKPBMQWo60y
         zps4AoaDVysBEiUUhH4oKI9RVVq0z6P1dXKy8VVaoVWWbM/RTvpSTJ44fANnCR4G8fEO
         wtsoiwFC8SGAtbHc8dJ6kPRiHpq8etHyCyNLo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=q9iyM4ymZlga+i74m6AtDtv714LsWxaxXLVytk7x33bU1twoFuaSyana9MPZ4yAdX+
         Z80qlZRiofa2l5B+cRNruNUY+MMxci70jKrHW86WZ88Ly/Y5EQ1pvLLNFoFGDAHHmJ26
         66E7+PthacqaYN6QxUGR8jutF6ZKJLF9KIZ0o=
Received: by 10.229.86.13 with SMTP id q13mr5937594qcl.175.1290509946666; Tue,
 23 Nov 2010 02:59:06 -0800 (PST)
Received: by 10.229.36.135 with HTTP; Tue, 23 Nov 2010 02:58:46 -0800 (PST)
In-Reply-To: <AANLkTindHnjeXEGbKWiQkWgoUBwqZbdx71sQwNr_gFp0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161942>

On Tue, Nov 23, 2010 at 11:32 AM, Jeenu V <jeenuv@gmail.com> wrote:
> On Tue, Nov 23, 2010 at 3:56 PM, Jeenu V <jeenuv@gmail.com> wrote:
>> On Tue, Nov 23, 2010 at 2:50 PM, knittl <knittl89@googlemail.com> wrote:
>>>> Right now I do this with vimdiff, by applying 'git diff' in reverse.
>>>> Wish reset supports -p on working tree operations as well because the
>>>> -p framework (of add, and reset) feels good to use.
>>>
>>>
>>> there's `git checkout -p` to selectively remove changes from your working tree.
>>> (also `git stash -p` to selectively stash changes temporarily)
>>
>> Surprised to know that checkout and stash supports it! Thanks a lot
>> for pointing out.
>
> I think Git could suggest 'checkout -p' and/or 'stash -p' when user
> tries to use -p with --{hard,soft,mixed} with reset command (in
> addition to mentioning that they're incompatible), since relatively
> new users are used to 'reset' than other commands to reset their
> working trees.

`git reset` seldomly affects the working tree, unless using `--hard`,
`--merge` or `--keep`, and those switches are potentially dangerous if
you are not aware of the implications to your worktree and index.

without options reset undoes a previous add, i.e. remove changes from
the index, but not the working tree.

git reset manpage mentions git-checkout:

> After running git reset <paths> to update the index entry, you can
> use git-checkout(1) to check the contents out of the index to the
> working tree. Alternatively, using git-checkout(1) and specifying a
> commit, you can copy the contents of a path out of a commit to the
> index and to the working tree in one go.


--
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
