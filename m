From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Added macro support to qgit
Date: Fri, 23 Jun 2006 19:44:54 +0200
Message-ID: <e5bfff550606231044j4586ea65v191f86a869237b84@mail.gmail.com>
References: <e5bfff550606220704q568d8345o1420a0a3e29544e8@mail.gmail.com>
	 <1151024452.5205.46.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 19:45:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtpiF-0007A1-3Q
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 19:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751820AbWFWRo4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 13:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751823AbWFWRo4
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 13:44:56 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:8980 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751820AbWFWRoz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 13:44:55 -0400
Received: by py-out-1112.google.com with SMTP id t32so728991pyc
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 10:44:55 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SlhTPbE5tqjwjVHQ5AavXLWpEToHxuwzOhrTJeqKxikyspqL9q2Iu1YH5CPThx1KQkbIzYMd35xioYHr9OhKlnJIkKs1qNcRsVbo4s9BmnBpTEIUCzPK5haItd6UAMdCiSuRuzY/h7KJ1JsbAaEzN0rCqGCEi3dbMWarYkko0oc=
Received: by 10.35.134.12 with SMTP id l12mr2555388pyn;
        Fri, 23 Jun 2006 10:44:54 -0700 (PDT)
Received: by 10.35.95.9 with HTTP; Fri, 23 Jun 2006 10:44:54 -0700 (PDT)
To: "Pavel Roskin" <proski@gnu.org>
In-Reply-To: <1151024452.5205.46.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22431>

Hi Pavel,

> If I understand correctly, qgit doesn't do that.  It calls external
> commands that are not implemented internally, and it doesn't aggregate
> anything.  Then why not call them "external commands"?
>

Or just "commands"? in any case I agree "macro" was not a good choice.

> The interface is quite confusing.  I see 5 buttons on top, all of which
> are enabled, plus one button labeled as "...", three checkboxes, one
> single-line entry and one multiline entry.  I have no I idea where to
> start.  Should I click "new" or white something and then click "new"?
> And where's "Cancel"?.
>
> That's what I have tried:
>
> Enter "foo bar" in the multiline entry.
> Click "New"
> Enter "foobar"
> Click "New"
> Enter "abc"
> Select "foobar"
>
> Now "Run external script" is selected and "foo bar" is gone!  I believe
> user input should not be discarded without a warning.
>

The bug is qgit lets you write the first foo bar, before you press NEW
button. It shouldn't. Also some buttons enable/disable policy could be
good.

> I also tried something more meaningful.  I create a "pull" macro as an
> external script "stg pull".  It didn't work.  Am I supposed to supply
> full path?  Does it understand arguments?  It the script supposed to be
> in a certain format?  OK, stg is written in python, but how about
> cg-status, a shell script?  It doesn't seen to work either.
>

You are not supposed to supply full path, any executable file should
be OK and yes, you could supply arguments. You don't see nothing
because of a silly bug.

> What happens to the arguments qgit is asking for if a multiline entry is
> executed?  I understand they are prepended to the first line.  This is
> not quite logical.  Wouldn't it be better to have a shell like notation
> for them?
>

I thought of commands sequence as a quick way to run some simple
commands as git pull, git push or similar without writing a bash
script, i.e. no $1 for arguments. If you need something more complex
the external script is supposed to be the proper way.

Perhaps we could remove the external script single edit line and use
only the multiline edit to let user insert commands or script.

> I see the macros are saved in the qgit configuration for the
> user .qt/qgitrc, like this:
>

Well, this file is really not meant to be view nor to be modified by
hand, it is mainly a qgit 'private' thing stuff. Being qgit a GUI tool
with a (nice ;-)  ) settings dialog, configuration file is mainly used
for persistency, not for browsing/setup.

I hope to fix the external commands interface bugs this week-end.

Thanks for your reports
Marco
