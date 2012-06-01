From: konglu@minatec.inpg.fr
Subject: Re: [PATCHv5 1/3] wt-status.*: better advices for git status added
Date: Fri, 01 Jun 2012 13:27:10 +0200
Message-ID: <20120601132710.Horde.j1U5UHwdC4BPyKcOgc8zbbA@webmail.minatec.grenoble-inp.fr>
References: <1338384216-18782-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <vpq8vg7jue4.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=";";
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 01 13:27:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaQ17-0001Q8-8n
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 13:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759466Ab2FAL1O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Jun 2012 07:27:14 -0400
Received: from v-smtp.minatec.grenoble-inp.fr ([147.173.216.28]:53358 "EHLO
	v-smtp.minatec.grenoble-inp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754521Ab2FAL1N (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Jun 2012 07:27:13 -0400
Received: from localhost (www02.minatec.grenoble-inp.fr [147.173.216.15])
	by v-smtp.minatec.grenoble-inp.fr (Postfix) with ESMTP id DA3A61A025C;
	Fri,  1 Jun 2012 13:27:10 +0200 (CEST)
Received: from wifi-030054.grenet.fr (wifi-030054.grenet.fr [130.190.30.54])
 by webmail.minatec.grenoble-inp.fr (Horde Framework) with HTTP; Fri, 01 Jun
 2012 13:27:10 +0200
In-Reply-To: <vpq8vg7jue4.fsf@bauges.imag.fr>
User-Agent: Internet Messaging Program (IMP) H4 (5.0.17)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198978>


Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> a =C3=A9crit=C2=A0:

>> +	if (state->merge_in_progress)
>> +		merge_in_progress_show(s, state, state_color);
>> +	else if (state->am_in_progress)
>> +		am_in_progress_show(s, state, state_color);
>> +	else if (state->rebase_in_progress || =20
>> state->rebase_interactive_in_progress)
>> +		rebase_in_progress_show(s, state, state_color);
>> +	else if (state->cherry_pick_in_progress)
>> +		cherry_pick_in_progress_show(s, state, state_color);
>> +	if (state->bisect_in_progress)
>> +		bisect_in_progress_show(s, state, state_color);
>
> I still disagree with the "else if" logic here. If the user started t=
wo
> operations, I think we should show both messages.

We show both messages in the case of bisect. However, we decided to
implement a priority for the other cases because of how the code figure=
s
out the current state.
The cases in which you're in 'am' AND 'rebase' or only in 'am' is hard =
to
handle. Thus The priority is given to the 'am' because running 'am' dur=
ing
a 'rebase' is possible (and the other way is not).
On top of that, I think that the user only needs to know his "most rece=
nt"
current state. Given that he's running 'am' during a 'rebase', knowing =
that
he's in am progress is enough. If he finishes the 'am', then he will st=
ill
know that he's in a 'rebase' with 'git status'.
