From: David Rhodes Clymer <david@zettazebra.com>
Subject: Re: [PATCH] bash: support user-supplied completion scripts for user's 
	git commands
Date: Sat, 30 Jan 2010 18:34:06 -0500
Message-ID: <9b69cfcf1001301534v734f8c9ao3143854c2ca5093f@mail.gmail.com>
References: <9b69cfcf1001290457s6b7fad6cs5a915f16a11f5782@mail.gmail.com>
	 <20100129151127.GA21821@spearce.org>
	 <7v4om4kdt3.fsf@alter.siamese.dyndns.org>
	 <20100129175950.GE21821@spearce.org>
	 <7vockciyb8.fsf@alter.siamese.dyndns.org>
	 <20100129190642.GA31303@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: =?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Jan 31 00:34:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NbMpU-0000CY-R2
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jan 2010 00:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752098Ab0A3XeL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Jan 2010 18:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752067Ab0A3XeK
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 18:34:10 -0500
Received: from mail-pz0-f172.google.com ([209.85.222.172]:35558 "EHLO
	mail-pz0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751810Ab0A3XeJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jan 2010 18:34:09 -0500
Received: by pzk2 with SMTP id 2so2883330pzk.21
        for <git@vger.kernel.org>; Sat, 30 Jan 2010 15:34:08 -0800 (PST)
Received: by 10.142.2.29 with SMTP id 29mr1827480wfb.99.1264894446079; Sat, 30 
	Jan 2010 15:34:06 -0800 (PST)
In-Reply-To: <20100129190642.GA31303@neumann>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138518>

2010/1/29 SZEDER G=E1bor <szeder@ira.uka.de>:
> The bash completion script already provides support to complete
> aliases, options and refs for aliases (if the alias can be traced bac=
k
> to a supported git command by __git_aliased_command()), and the user'=
s
> custom git commands, but it does not support the options of the user'=
s
> custom git commands (of course; how could it know about the options o=
f
> a custom git command?). =A0Users of such custom git commands could
> extend git's bash completion script by writing functions to support
> their commands, but they might have issues with it: they might not
> have the rights to modify a system-wide git completion script, and
> they will need to track and merge upstream changes in the future.
>
> This patch addresses this by providing means for users to supply
> custom completion scriplets for their custom git commands without
> modifying the main git bash completion script.
>
> Instead of having a huge hard-coded list of command-completion
> function pairs (in _git()), the completion script will figure out
> which completion function to call based on the command's name. =A0Tha=
t
> is, when completing the options of 'git foo', the main completion
> script will check whether the function '_git_foo' is declared, and if
> declared, it will invoke that function to perform the completion. =A0=
If
> such a function is not declared, it will fall back to complete file
> names. =A0So, users will only need to provide this '_git_foo' complet=
ion
> function in a separate file, source that file, and it will be used th=
e
> next time they press TAB after 'git foo '.
>
> There are two git commands (stage and whatchanged), for which the
> completion functions of other commands were used, therefore they
> got their own completion function.
>

Excellent! This looks just like what I was after. Among other things,
this is much better than my use of awk. ;o)

-davidc
