From: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH] init - Honour the global core.filemode setting
Date: Thu, 02 Oct 2014 13:15:45 +0200
Message-ID: <542D33E1.6080709@web.de>
References: <CAE1pOi0zhnUNNdHsrq+4H_6LiFnr-qoY-owrcJquy6dyG+Mk4g@mail.gmail.com>	<5427F68E.5030003@web.de>	<CAE1pOi1dAO7XFZtrgZyNm-eLVKQx=KpeejbGmF8khCofAppDLg@mail.gmail.com> <xmqqy4szpvfv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Users <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 13:15:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZeMX-0005P6-AY
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 13:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbaJBLPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2014 07:15:53 -0400
Received: from mout.web.de ([212.227.17.12]:51558 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbaJBLPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2014 07:15:52 -0400
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb103) with
 ESMTPSA (Nemesis) id 0MHp4r-1XW5SV0usP-003hhF; Thu, 02 Oct 2014 13:15:50
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqy4szpvfv.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:dO9v6MbLOaTfO6o5n4NdlI089XFS8SKItZshEsC/Diq131sjpnZ
 W5ZK4kY18gX5FjEdd+pQ/6RZ9P4DKNgbD8fFNGVoQLFpXqZiDHR1oVTRWETr7TjEtfiU/VU
 faw4dGLjMRBGbXyzzivmC4+GhpliMHO6MWwBsa6IEu0dJO5mjxMiWIEsZYAbE6DMpJCxQNI
 VqKyXD5LsV+CtsVaATS2A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257797>

On 2014-10-01 19.10, Junio C Hamano wrote:
> Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:
> 
>> Perhaps I completely misunderstand the meaning of core.filemode but I
>> thought it determined whether Git cared about changes in file
>> properties?
> 
> By setting it to "false", you tell Git that the filesystem you
> placed the repository does not correctly represent the filemode
> (especially the executable bit).
> 
> "core.fileMode" in "git config --help" reads:
> 
>        core.fileMode
>            If false, the executable bit differences between the
>            index and the working tree are ignored; useful on broken
>            filesystems like FAT. See git-update- index(1).

Out of my head: Could the following be a starting point:

        core.fileMode
            If false, the executable bit differences between the
            index and the working tree are ignored.
            This may be usefull when visiting a cygwin repo with a non-cygwin
            Git client. (should we mention msysgit ? should we mention JGit/EGit ?)
	    This may even be useful for a repo on a SAMBA network mount,
            which may show all file permissions as 0755.
            See git-update-index(1) for changing the executable bit in the index. 

            The default is true, except git-clone(1) or git-init(1)
            will probe and set core.fileMode false if appropriate
            when the repository is created.
> 
> Maybe our documentation is not clear enough.  A contribution from
> somebody new to Git we would appreciate would be to point out which
> part of these sentences are unclear; that way, people can work on
> improving its phrasing.
> 
> Thanks.
