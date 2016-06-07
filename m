From: Erwan Mathoniere <erwan.mathoniere@grenoble-inp.org>
Subject: Re: [RFC/PATCH v2] pull: add --set-upstream
Date: Tue, 7 Jun 2016 15:15:02 +0200
Message-ID: <af8762b1-3865-5d10-296c-db9bf9e8aa53@grenoble-inp.org>
References: <20160525152528.22202-1-erwan.mathoniere@grenoble-inp.org>
 <20160606093437.1992-1-erwan.mathoniere@grenoble-inp.org>
 <vpqvb1mgvn5.fsf@anie.imag.fr> <xmqqoa7ew319.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.de-gea@grenoble-inp.org,
	samuel.groot@grenoble-inp.org, tom.russello@grenoble-inp.org
To: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Jun 07 15:15:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAGqq-0003yD-MU
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 15:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932711AbcFGNPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 09:15:08 -0400
Received: from zm-smtpout-1.grenet.fr ([130.190.244.97]:51632 "EHLO
	zm-smtpout-1.grenet.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbcFGNPF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 09:15:05 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id BC09D256B;
	Tue,  7 Jun 2016 15:15:02 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Pn7JXz30Nzlu; Tue,  7 Jun 2016 15:15:02 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr (zm-smtpauth-2.grenet.fr [130.190.244.123])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id A84442561;
	Tue,  7 Jun 2016 15:15:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTP id A50902066;
	Tue,  7 Jun 2016 15:15:02 +0200 (CEST)
Received: from zm-smtpauth-2.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpauth-2.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CcjRNtD7WNXx; Tue,  7 Jun 2016 15:15:02 +0200 (CEST)
Received: from [130.190.32.141] (eduroam-032141.grenet.fr [130.190.32.141])
	by zm-smtpauth-2.grenet.fr (Postfix) with ESMTPSA id 7E5F12064;
	Tue,  7 Jun 2016 15:15:02 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
In-Reply-To: <xmqqoa7ew319.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296677>



On 06/06/2016 21:06, Junio C Hamano wrote:
>
> But I am unhappy with a more serious problem with the tests in this
> patch.  They assume that "-u" option will forever be the only thing
> that is allowed to modify the configuration during "git pull -u".
> It should never make such an assumption.
>
> The only thing these additional tests later in the patch (ommitted)
> want to check, if I understand them correctly, is that when -u is
> used on a ref that shouldn't be tracked from the given remote then
> remote.<that remote>.merge etc. are not updated.  Make a list of the
> configuration variables the feature cares about, and check them and
> ignore changes to any other variable.  Somebody else's feature that
> will be added to "git pull" may have legitimate reason to update
> configuration variables that are not releated to this feature, and
> you shouldn't be writing your test for your feature in such a way
> to forbid such a new feature by others from being added.

I asked myself these questions but I came to the wrong conclusion since 
I considered that testing if `--set-upstream` doesn't alter any 
configuration var it shouldn't was also important. But there is no 
reason "git pull -u" modify the configuration in such a chaotic way.

I'll apply your suggestions, thanks.
