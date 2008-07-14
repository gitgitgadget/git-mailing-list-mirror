From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] bash completion: Fix the . -> .. revision range	completion
Date: Mon, 14 Jul 2008 14:39:44 +0200
Message-ID: <487B4910.5030509@op5.se>
References: <20080713111847.29801.8969.stgit@localhost> <7vskudpiqq.fsf@gitster.siamese.dyndns.org> <20080713230724.GJ10151@machine.or.cz> <7vhcatnz80.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807131649380.3305@woody.linux-foundation.org> <20080714000021.GB13066@spearce.org> <alpine.LFD.1.10.0807132210430.3305@woody.linux-foundation.org> <20080714062755.GA15992@spearce.org> <20080714064719.GA26446@atjola.homenet> <20080714065018.GB26446@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 14 14:42:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KINN3-0002sk-Uf
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 14:41:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753297AbYGNMkm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Jul 2008 08:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbYGNMkm
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 08:40:42 -0400
Received: from mail.op5.se ([193.201.96.20]:58671 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753271AbYGNMkk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 08:40:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 7EA9E1B80082;
	Mon, 14 Jul 2008 14:40:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wbrXlanTUVk6; Mon, 14 Jul 2008 14:40:35 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.188])
	by mail.op5.se (Postfix) with ESMTP id EEE4D1B80048;
	Mon, 14 Jul 2008 14:40:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080714065018.GB26446@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88422>

Bj=F6rn Steinbrink wrote:
> On 2008.07.14 08:47:19 +0200, Bj=F6rn Steinbrink wrote:
>> On 2008.07.14 06:27:55 +0000, Shawn O. Pearce wrote:
>>> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>> On Mon, 14 Jul 2008, Shawn O. Pearce wrote:
>>>>>> Does it fix this one too:
>>>>>>
>>>>>> 	git show origin/pu:Makef<tab>
>>>>>>
>>>>>> which totally screws up and becomes
>>>>>>
>>>>>> 	git show Makefile
>>>>>>
>>>>>> dropping the version specifier?
>>> What is $COMP_WORDBREAKS set to in your shell?  In mine it
>>> appears to be:
>>>
>>> 	" \"'@><=3D;|&(:"
>>>
>>> which is the I believe the shell default.
>>>
>>> Bj=F6rn Steinbrink (doener on #git) is running bash 3.2.39 from
>>> Debian and has the same setting, and the completion works correctly
>>> there too.  He reports that removing : from COMP_WORDBREAKS will
>>> get the behavior you are reporting as broken.
>>>
>>> I have to say, this sounds to me like you (or some package on your
>>> system) modified COMP_WORDBREAKS away from the default that other
>>> distributions use and that is what is breaking us here.  Since we
>>> can have only one setting for this variable in the shell I do not
>>> thing it would be a good idea for our completion package to force
>>> a specific setting upon the user.
>> Seems that gvfs comes with a completion script that deliberately dro=
ps
>> the : from COMP_WORDBREAKS. Do you have that installed Linus?
>=20
> Ah crap, I should have mentioned which file I'm talking about... It's
> /etc/profile.d/gvfs-bash-completion.sh
>=20

I have that file, and I'm seeing the same issue as Linus.

E13 at http://tiswww.case.edu/php/chet/bash/FAQ mentions it, but
doesn't (imo) give a strong reason why it drops colon from
COMP_WORDBREAKS, as filenames with colons in them aren't exactly
common.

--=20
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
