From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFC 3/3] reset: Change the default behavior to use "--merge" during a merge
Date: Wed, 26 Feb 2014 21:57:16 +0100
Message-ID: <vpqeh2pd237.fsf@anie.imag.fr>
References: <1393437985-31401-1-git-send-email-andrew.kw.w@gmail.com>
	<1393437985-31401-4-git-send-email-andrew.kw.w@gmail.com>
	<vpq8usxenul.fsf@anie.imag.fr>
	<CADgNjanavxZfuXgvEAOMzPAJr9YqAvF4+ZDq9KW9aeR_PcVo-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Wong <andrew.kw.w@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 26 21:57:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIlXo-0007bl-56
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 21:57:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753970AbaBZU5X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 15:57:23 -0500
Received: from mx1.imag.fr ([129.88.30.5]:47097 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753637AbaBZU5V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 15:57:21 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id s1QKvE4F027150
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Feb 2014 21:57:14 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id s1QKvG0S023795;
	Wed, 26 Feb 2014 21:57:16 +0100
In-Reply-To: <CADgNjanavxZfuXgvEAOMzPAJr9YqAvF4+ZDq9KW9aeR_PcVo-Q@mail.gmail.com>
	(Andrew Wong's message of "Wed, 26 Feb 2014 15:15:30 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 26 Feb 2014 21:57:14 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: s1QKvE4F027150
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1394053036.48065@zaXC/TlADumm8vL/M3/m8w
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242767>

Andrew Wong <andrew.kw.w@gmail.com> writes:

> On Wed, Feb 26, 2014 at 1:21 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> But this breaks backward compatibility.
>>
>> I sometimes run "git reset" during a merge to only reset the index and
>> then examine the changes introduced by the merge. With your changes,
>> someone doing so would abort the merge and discard the merge resolution.
>> I very rarely do this, but even rarely, I wouldn't like Git to start
>> droping data silently for me ;-).
>
> I don't think it's actually dropping data though, because your changes just
> come from "git merge". So you can also do the merge again.

But you can't repeat your merge conflicts resolution.

> To examine the changes, you're saying you'd do "git reset && git diff". But
> without doing "git reset", couldn't you do "git diff HEAD" to get the
> diff?

I could. The point is, sometimes I don't.

If you were to design "git reset"'s interface from scratch, your
proposal would make sense. But we're talking about a change, and you
can't expect that users never use the current behavior. At the very
least, there should be a warning telling the user that the behavior
changed, and I'm really afraid that the warning goes along the lines of
"I've thought you'd prefer me to discard your unsaved changes, please
rewrite them if you actually didn't want me to".

>> I'm not really convinced that this is such a good change, and if we go
>> this way, there should be a transition to let users stop using
>> argumentless "git reset" to reset the index during a merge.
>
> Yeah, this breaks compatibility, but like I said, during a merge, I don't
> see a good reason to do "git reset --mixed",

The point with backward compatibility is not to know whether users have
a good reason to, but whether you can guarantee that no one ever does
it.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
