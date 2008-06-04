From: David <wizzardx@gmail.com>
Subject: Re: User's mailing list? And multiple cherry pick
Date: Wed, 4 Jun 2008 10:11:33 +0200
Message-ID: <18c1e6480806040111s606701dfwc8a2ae5f742307b5@mail.gmail.com>
References: <18c1e6480806032355q2002fe0ej1f37dbd7dbd4802b@mail.gmail.com>
	 <m3r6bdzm22.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 10:12:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3o6f-0002UG-Po
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 10:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbYFDILg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 04:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752530AbYFDILf
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 04:11:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:49492 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752444AbYFDILe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 04:11:34 -0400
Received: by rv-out-0506.google.com with SMTP id l9so2024716rvb.1
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 01:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Clv7Z519WjhaWFjVk3zpbUmfxngsryXM0XJyWDj8EmA=;
        b=WpDCTsWptXw9gGvoXPcHTRRSSRtz5cdanazwsDL/i+nP/GY83uU1N6dtNbMqZop8O73J80tmIZqSNHcj69AkFItWysX6x1rJVCFZo6NiMNIPpZqEKZT0RKEMi1/0aMjg4ABfd+umrzSwSo0ydqM/KlP0sHlLh66mnCY3FOiK7hI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qy5j+eP9/n1TfBmqtw1klbVNjBqf5V0j125f6BNSjKBl/C5PKzqz1a0jJJiF7rPZj/rsibYGEXnZ1JZO+PdfqJDZaa3eAPeE9U2I6TJITLBe2FnNcuuwq/qGmHf4HTkKEpV2ZBz+tgjmh//hsJ4ppY0yrx7nSldSl+txsT2wLuM=
Received: by 10.141.33.21 with SMTP id l21mr6459557rvj.140.1212567093565;
        Wed, 04 Jun 2008 01:11:33 -0700 (PDT)
Received: by 10.140.194.15 with HTTP; Wed, 4 Jun 2008 01:11:33 -0700 (PDT)
In-Reply-To: <m3r6bdzm22.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83758>

> There is Git User's mailing list ("Git for human beings", heh)
>  git-users@googlegroups.com
>  http://groups.google.com/group/git-users
>  nntp://news.gmane.org/gmane.comp.version-control.git.user
>
> There is GitFaq at Git Wiki:
>  http://git.or.cz/gitwiki/GitFaq
>

Thanks for the links.

>> Is there an easier syntax for doing this?
>
>  $ git rebase --onto
>  $ git rebase --onto --interactive
>
> (if you want to copy, just create new branch using "git branch", or
> something).

Thanks, but this doesn't quite solve the problem. I'm on the verge of
figuring it out, and would appreciate any further tips :-)

Here is an example:

o--o--O master
       \
        o--o--X--X--X--X--o--o topic

I want to copy the "X" patches from the topic branch over to master.
The other patches aren't appropriate for master for whatever reason.
eg, temporary debugging hacks, but I fixed a few problems in master in
the X patches and now want to apply them on top of master, and keep
working on "topic"

I want to end up with a tree like this:


o--o--O--X'--X'--X'--X' master
       \
        o--o--X--X--X--X--o--o topic

After getting the branches like this, I would then (try to) rebase
topic like this:

o--o--O--X'--X'--X'--X' master
                      \
                       o'--o'--o'--o' topic

I say try to, because rebase sometimes gets a lot of dumb (to me,
maybe I'm not using git correctly) conflicts in cases like this, so I
end up manually rebasing, by making a new topic branch off master,
cherry picking into it off the old topic branch, and then removing the
old branch. Another case where multiple cherry picks would be nice :-)

>
> Why can't you simply use merge, BTW?

Because the topic branch has some 'dirty' commits that I don't want in master.

David.
