From: Pavel Roskin <proski@gnu.org>
Subject: Re: Added macro support to qgit
Date: Thu, 22 Jun 2006 21:00:52 -0400
Message-ID: <1151024452.5205.46.camel@dv>
References: <e5bfff550606220704q568d8345o1420a0a3e29544e8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 03:01:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fta2e-0003KL-6b
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 03:01:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471AbWFWBA4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 21:00:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161472AbWFWBA4
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 21:00:56 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:39840 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1161471AbWFWBAz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jun 2006 21:00:55 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fta2Y-00005S-Lq
	for git@vger.kernel.org; Thu, 22 Jun 2006 21:00:54 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fta2W-0001yW-RK; Thu, 22 Jun 2006 21:00:52 -0400
To: Marco Costalba <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606220704q568d8345o1420a0a3e29544e8@mail.gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22390>

Hello, Marco!

On Thu, 2006-06-22 at 16:04 +0200, Marco Costalba wrote:
> I have pushed some patches that add macros to qgit.
> 
> From menu bar it is possible to  run a macro created by a fancy new
> dialog invoked by 'Macros->Setup macros...' menu.

I'm not sure they can be called macros.  Macro is something consisting
of several commands that are already implemented.  So, a macro-assembler
is a program that allows to combine several supported instructions into
one macro.  Macros in editors record actions already implemented by the
editors.  You may also want to read this:
http://en.wikipedia.org/wiki/Macro

If I understand correctly, qgit doesn't do that.  It calls external
commands that are not implemented internally, and it doesn't aggregate
anything.  Then why not call them "external commands"?

The interface is quite confusing.  I see 5 buttons on top, all of which
are enabled, plus one button labeled as "...", three checkboxes, one
single-line entry and one multiline entry.  I have no I idea where to
start.  Should I click "new" or white something and then click "new"?
And where's "Cancel"?.

That's what I have tried:

Enter "foo bar" in the multiline entry.
Click "New"
Enter "foobar"
Click "New"
Enter "abc"
Select "foobar"

Now "Run external script" is selected and "foo bar" is gone!  I believe
user input should not be discarded without a warning.

I also tried something more meaningful.  I create a "pull" macro as an
external script "stg pull".  It didn't work.  Am I supposed to supply
full path?  Does it understand arguments?  It the script supposed to be
in a certain format?  OK, stg is written in python, but how about
cg-status, a shell script?  It doesn't seen to work either.

I could make macros work when I entered the under "Insert commands to
run".  The output window looks nice.  But I see no indication whether
the script is running or it has finished.  I don't see how to terminate
the script "gently", an equivalent of Ctrl-C.

As far as I understand, the text entries should not be enabled at the
same time.  But it saw it happening when there were no macros at all.
And if I delete all macros, "Insert commands to run" doesn't work at
all.

What happens to the arguments qgit is asking for if a multiline entry is
executed?  I understand they are prepended to the first line.  This is
not quite logical.  Wouldn't it be better to have a shell like notation
for them?

I see the macros are saved in the qgit configuration for the
user .qt/qgitrc, like this:

[Macro reset]
commands=echo\nstg pull\necho 123\nsleep 5
patch_flags=9040
script_path=/home/proski/bin/cg-reset

Shouldn't only one of commands and script_path be saved?  Whouldn't it
be better to save meaningful boolean options instead of the opaque
binary "patch_flags"

And what is "macro_name=New macro" in [General]?

I think I should write you what I would like to see in qgit, but that
would be a separate e-mail.

-- 
Regards,
Pavel Roskin
