From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] contrib: add 'git difftool' for launching common merge 
	tools
Date: Sun, 18 Jan 2009 16:34:43 -0800
Message-ID: <402731c90901181634u32b39c87t6e88d9efef0d3485@mail.gmail.com>
References: <1232092802-30838-1-git-send-email-davvid@gmail.com>
	 <200901182025.24045.markus.heidelberg@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: markus.heidelberg@web.de
X-From: git-owner@vger.kernel.org Mon Jan 19 01:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOi7d-00041F-HO
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 01:36:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236AbZASAeq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 19:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbZASAep
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 19:34:45 -0500
Received: from rv-out-0506.google.com ([209.85.198.228]:3359 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbZASAep (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 19:34:45 -0500
Received: by rv-out-0506.google.com with SMTP id k40so2381416rvb.1
        for <git@vger.kernel.org>; Sun, 18 Jan 2009 16:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gHm5tm+rLF883pmccXl/FaSOX5knWFRjbbVBE/vHWOw=;
        b=briQMWHdlwpHwPmjRk2Fz2l40mtfgH27mUqMUkMrwZLZlqEyaGssr/LYQv4wfqGWPv
         PV9nefYzFqC++C4fk91tIK3Q+vpjYXPjbidpz1jENmt4z8rIJvcqecOoVDt5qbxfWMl4
         PuSZUA6aEmC8y+/mOYJwgUe2VorR1jjW4brts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DySVpcs0pg8H70bQPVrFjQiCOhRKllCX1/qk3Ni3Y3+Equ2wXY2wzfDE2848FaJmUX
         yMDwRKfBHM98w/eY3GFsz00OcDRYb+DE5kgUHm6Wrc8nfO1zwxCekkM9NBKCW5fJY90C
         3mRh27Dm6eHnT4UtyqeAUyzSd7RdRYwFW+UhA=
Received: by 10.142.224.5 with SMTP id w5mr842104wfg.206.1232325283995; Sun, 
	18 Jan 2009 16:34:43 -0800 (PST)
In-Reply-To: <200901182025.24045.markus.heidelberg@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106295>

On Sun, Jan 18, 2009 at 11:25 AM, Markus Heidelberg
<markus.heidelberg@web.de> wrote:
> David Aguilar, 16.01.2009:
>
>> +# git-difftool-helper script.  This script exports
>> +# GIT_EXTERNAL_DIFF and GIT_PAGER for use by git, and
>> +# GIT_NO_PROMPT and GIT_MERGE_TOOL for use by git-difftool-helper.
>
> GIT_DIFFTOOL_NO_PROMPT

Thanks for catching that.


>> +sub usage
>> +{
>> +     print << 'USAGE';
>> +
>
> Why the leading empty line?

Fixed.


>> +usage: git difftool [--no-prompt] [--tool=tool] ["git diff" options]
>
> --tool=<tool>
>
> Swap the order of --no-prompt and --tool for consistency with
> git-difftool.txt and git-mergetool.

Done.


>> +     meld|vimdiff)
>> +             "$merge_tool_path" "$LOCAL" "$REMOTE"
>> +             ;;
>> +
>> +     gvimdiff)
>> +             "$merge_tool_path" -f "$LOCAL" "$REMOTE"
>> +             ;;
>
> Maybe use '-c "wincmd l"' for Vim as in my patch for git-mergetool to
> automatically place the cursor in the editable file? Useful for editing,
> if git-difftool is used to diff a file from the working tree.
>
> See http://thread.gmane.org/gmane.comp.version-control.git/106109


Very cool.  When you have unstaged changes git diff sends the local
filename as the 2nd argument so I changed the vim command to "wincmd
r" so that vim places the cursor on the right hand side.


> You have deleted all the '-' chars from git-command, but when using it as the
> name I think it's the preferred method, only when used as command then without
> slash.

I was wondering about that.  I think I tried to follow the lead from
the git-diff.txt documentation, but "diff" is a builtin and thus
doesn't have an actual git-diff, so I see why they should be
different.

I've changed the docs as you suggested -- 'git-difftool' is used to
name the script while 'git difftool' is used in the SYNOPSIS section.



>> +SEE ALSO
>> +--------
>> +linkgit:git-diff[7]::
>
> [1]
>
>> +      Show changes between commits, commit and working tree, etc
>> +
>> +linkgit:git-mergetool[1]::
>> +     Run merge conflict resolution tools to resolve merge conflicts
>> +
>> +linkgit:git-config[7]::
>
> [1]

Oops, I don't know how that happened.


>
> Works fine for me, thanks.
>
> Markus
>

Thanks again for your help.

-- 
    David
