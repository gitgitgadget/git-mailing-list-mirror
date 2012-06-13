From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 22:59:17 +0200
Message-ID: <4FD8FF25.6030908@kdbg.org>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org> <4FD89DD6.1070705@in.waw.pl> <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr> <7vipevgjhp.fsf@alter.siamese.dyndns.org> <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Zbigniew J?drzejewski-Szmek <zbyszek@in.waw.pl>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Wed Jun 13 22:59:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seuf0-0005Vj-Lu
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 22:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754589Ab2FMU7W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 16:59:22 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:26030 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754489Ab2FMU7W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 16:59:22 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 96DE32C4006;
	Wed, 13 Jun 2012 22:59:18 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id E6CEB19F682;
	Wed, 13 Jun 2012 22:59:17 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120421 Thunderbird/12.0
In-Reply-To: <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199945>

Am 13.06.2012 21:38, schrieb konglu@minatec.inpg.fr:
>=20
> Junio C Hamano <gitster@pobox.com> a =E9crit :
>=20
>> It looks that editing
>>
>>     pick foo            pick foo
>>     exec cmd1           exec cmd1 && cmd2
>>     exec cmd2
>>     pick bar            pick bar
>>     exec cmd1           exec cmd1 && cmd2
>>     exec cmd2
>>
>> to
>>
>>     pick foo            pick foo
>>                         exec         cmd2
>>     exec cmd2
>>     pick bar            pick bar
>>     exec cmd1           exec cmd1
>>
>> would take exactly the same effort, at least to me.  And more
>> importantly, without editing don't they do *exactly* the same thing?
>> If cmd1 fails, the sequencing stops at that step without running cmd=
2.
>=20
> True. I was thinking under the fact that the user would edit the comm=
ands
> by himself but the purpose of the "--exec" option is to avoid that (o=
r at
> least that the user won't have to type all by himself). Forget what I=
 said
> then :).

Not so fast.

	exec cmd1 && cmd2
and
	exec cmd1
	exec cmd2

are far from equivalent: If cmd1 fails, the first version never runs
cmd2, but the second version runs cmd2 upon rebase --continue.

The updated documentation should not say that the two are "equivalent".

-- Hannes
