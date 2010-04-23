From: Goswin von Brederlow <goswin-v-b@web.de>
Subject: Re: Please default to 'commit -a' when no changes were added
Date: Fri, 23 Apr 2010 11:09:30 +0200
Message-ID: <87r5m6tu0l.fsf@frosties.localdomain>
References: <20100422151037.2310.2429.reportbug@frosties.localdomain>
	<20100422155806.GC4801@progeny.tock>
	<87wrvzs590.fsf@frosties.localdomain>
	<alpine.LFD.2.00.1004221445310.7232@xanadu.home>
	<87sk6n4426.fsf@frosties.localdomain>
	<7vsk6n2n48.fsf@alter.siamese.dyndns.org>
	<vpq7hnzcgjq.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jonathan Nieder <jrnieder@gmail.com>, 578764@bugs.debian.org,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Apr 23 11:09:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5EtI-0004Ir-0c
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 11:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206Ab0DWJJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 05:09:33 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:42077 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0DWJJc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 05:09:32 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id 13D27157685AE;
	Fri, 23 Apr 2010 11:09:31 +0200 (CEST)
Received: from [78.43.204.177] (helo=frosties.localdomain)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.110 #4)
	id 1O5Et8-0001YD-00; Fri, 23 Apr 2010 11:09:31 +0200
Received: from mrvn by frosties.localdomain with local (Exim 4.71)
	(envelope-from <goswin-v-b@web.de>)
	id 1O5Et8-0003SO-Ne; Fri, 23 Apr 2010 11:09:30 +0200
In-Reply-To: <vpq7hnzcgjq.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu,
	22 Apr 2010 23:40:09 +0200")
User-Agent: Gnus/5.110009 (No Gnus v0.9) XEmacs/21.4.22 (linux, no MULE)
X-Sender: goswin-v-b@web.de
X-Provags-ID: V01U2FsdGVkX1+UeJTOGDlGbyj0SAI03M7alXSytpz4qI6gToAM
	K1oe9+ZdDENDBBg5tdwS/enkkFM2gV8Oc4Hi/k7NZOKbFnCPw1
	z4ZSWf9vg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145597>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Think of this sequence:
>
> There's another case where it would be hard to decide what's "The
> Right Thing":
>
> vi existing-file.c # do some changes
> vi new-file.c      # create the file
> git add new-file.c
> git commit
>
> If you take the SVN semantics, the last "git commit" should commit the
> changes to existing-file.c. But keeping the current Git semantics, it
> doesn't. There are valid reasons why a user can type the above
> sequence with today's Git, and changing it would be backward
> incompatible, and would make the senario a lot more painfull.

For SVN users it gets much worse:

vi existing-file.c # do some changes
vi new-file.c      # create the file
git add new-file.c
vi new-file.c      # do some more changes
git commit

A SVN user would expect the current working copies of existing-file.c
and new-file.c to be commited. Instead only new-file.c is commited and
only the fist modification.

While this case is still highly confusing to non git users I do see that
it can't be easily changed. And my suggestion doesn't change it. The
call to "git add" creates an index so the commit would only act on the
index.

MfG
        Goswin
