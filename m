From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] pretty.c: make git_pretty_formats_config return -1 on git_config_string failure
Date: Mon, 04 Aug 2014 21:49:51 +0200
Message-ID: <vpqy4v4avc0.fsf@anie.imag.fr>
References: <1407163275-3006-1-git-send-email-tanayabh@gmail.com>
	<vpqmwbki7h3.fsf@anie.imag.fr>
	<CAPig+cRo05mG9yeU61VSjAvXWRHU9soaaH-Cv7MKoxZ=it15Rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Aug 04 21:50:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEOGr-0007eO-Ob
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 21:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752553AbaHDTuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 15:50:07 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52323 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752296AbaHDTuF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 15:50:05 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id s74JnnMf012073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 4 Aug 2014 21:49:49 +0200
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s74JnpJW005019;
	Mon, 4 Aug 2014 21:49:51 +0200
In-Reply-To: <CAPig+cRo05mG9yeU61VSjAvXWRHU9soaaH-Cv7MKoxZ=it15Rw@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 4 Aug 2014 14:56:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Mon, 04 Aug 2014 21:49:49 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s74JnnMf012073
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1407786590.73449@UJ9IG+q7nx4uAaTt7UmjOQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254771>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Aug 4, 2014 at 11:45 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>>
>>> `git_pretty_formats_config()` continues without checking git_config_string's
>>> return value which can lead to a SEGFAULT.
>>
>> Indeed, without the patch:
>>
>> $ git -c pretty.my= log --pretty=my
>> error: Missing value for 'pretty.my'
>> zsh: segmentation fault  git -c pretty.my= log --pretty=my
>
> This probably should be formalized as a proper test and included with
> Tanay's patch.

Not sure it's worth the trouble: the bug corresponds to a
mis-application of a pattern used in tens of places in Git's code
(basically, each call to git_config_string, 50 callsites). Testing this
particular case does not ensure non-regression, and testing all
occurences of the pattern would be overkill IMHO.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
