From: Gelonida N <gelonida@gmail.com>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 02:24:07 +0200
Message-ID: <j8csn7$v1u$1@dough.gmane.org>
References: <j8clg9$ldh$1@dough.gmane.org> <7vfwiexe6m.fsf@alter.siamese.dyndns.org> <7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 02:24:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJaFL-0001R1-Ry
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 02:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab1J1AYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 20:24:25 -0400
Received: from lo.gmane.org ([80.91.229.12]:47694 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752284Ab1J1AYW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 20:24:22 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RJaFB-0001O7-AX
	for git@vger.kernel.org; Fri, 28 Oct 2011 02:24:21 +0200
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 02:24:21 +0200
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 02:24:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184334>

On 10/28/2011 12:50 AM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Gelonida N <gelonida@gmail.com> writes:
>>
>>> Is there any trick to get the help text of git branch without
>>> having to type
>>>
>>> git branch --help
>>
>> How about "git help branch"?
> 
> It was bad of me to write a tongue-in-cheek answer, get distracted and
> ended up sending it without the real answer.
No issues. At least I got an answer :-)
> 
> The reason why we do not do what you seem to be suggesting is because
> giving the same behaviour to "git b --help" as "git branch --help" is
> wrong.
> 
> To see why, imagine you have configured an alias that is not a simple and
> stupid substitution "b == branch", but something like "bt == branch -t",
> and then want to know what you should write after "git bt".  Giving the
> manpage for branch without giving them any hint that they configured that
> alias to produce customized behaviour that is different from plain vanilla
> "branch" is not quite acceptable.
> 
> I think you _could_ make a patch that special cases a simple and straight
> substitution and skip the "foo is aliased to bar" step, but I doubt it is
> worth it to lose consistency between "git b --help" vs "git bt --help"
> that way.


I understand the reasoning and agree, that as general case it might not
be a good idea to have the behaviour, taht I expected to be the default
behaviour

It's just, that I am lazy so I shortened  my most common commands

For example:
co=checkout
ci=commit
b=branch
sm=submodule

However I'm not smart enough to remember all options for all commands
and so I have to ask git for occasional help.


It feels so 'unlazy' to have to type the full command 'just' to get help


What I wondered though is whether there couldn't be a way to be lazy and
avoid confusion.

1.) prompt for full help
-------------------------

One option would be to display what the command is aliased to and to
prompt whether one wants to see the full help of the base command.

`git b' is aliased to `branch'
pleaset press h if you want to see the full help for git branch
or press q to quit


2.) allow copy paste by displaying the command to be typed for help.
---------------------------------------------------------------------
display sometihing like:

`git b' is aliased to `branch'
for help about the branch command type:  git --help


Then lazy people could copy paste the command instead of typing it.


3.) special alias syntax to allow 'forwarding' of --help
------------------------------------------------------------

some kind of special alias syntax, which explicitely forces that --help
is 'forwarded' to the alias and not treated by git


example:

b = branch   # --help would have the current behaviour

I tried following to see whether '--help' is now being 'forwarded'

b = ! git branch
but also  here --help is treated by git

A possibility could be another 'special' character. For the sake of the
example I used '?'
b = ?branch # 'the question mark would allow 'forwarding' the
             # --help option to the alias'

b = ?! git branch



My workaround
------------

Fort the time being I might do something like

bhlp = branch --help

I would have prefered b_hlp or b_h, but it seems underscore isn't
allowed in an alias.
