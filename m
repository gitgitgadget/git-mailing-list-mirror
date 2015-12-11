From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCHv2] Makefile: add missing phony target
Date: Fri, 11 Dec 2015 16:43:18 +0100
Message-ID: <vpqsi392dpl.fsf@anie.imag.fr>
References: <1449843766-41658-1-git-send-email-gitter.spiros@gmail.com>
	<vpq7fkl3v66.fsf@anie.imag.fr>
	<CA+EOSB=a-qWP2-UfYJjPjSr8DD1ER39_rJPc8HAxV5qr+gw1qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 16:43:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7Pqx-0002JJ-Ts
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 16:43:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755301AbbLKPnX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 10:43:23 -0500
Received: from mx2.imag.fr ([129.88.30.17]:40419 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753585AbbLKPnW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Dec 2015 10:43:22 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id tBBFhGNR023808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 11 Dec 2015 16:43:16 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tBBFhISJ015180;
	Fri, 11 Dec 2015 16:43:18 +0100
In-Reply-To: <CA+EOSB=a-qWP2-UfYJjPjSr8DD1ER39_rJPc8HAxV5qr+gw1qw@mail.gmail.com>
	(Elia Pinto's message of "Fri, 11 Dec 2015 16:13:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 11 Dec 2015 16:43:17 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tBBFhGNR023808
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1450453398.37094@X8fRYjgy+lDpU1xJ0QvUUw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282261>

Elia Pinto <gitter.spiros@gmail.com> writes:

> 2015-12-11 15:40 GMT+01:00 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:
>> Elia Pinto <gitter.spiros@gmail.com> writes:
>>
>>> This is the second version of this patch.
>>> Added the corrections suggested by Matthieu Moy ($gmane/282221)
>>
>> Sorry, but my main concern was that the patch could not be reviewed in
>> good conditions as-is, and I think it still cannot be. It's very hard to
>> spot which .PHONY rules you're adding and which are just code movement.
>> You should really split this into one "code movement" patch and one
>> "actual bugfix" patch. Or someone with better eyes than me should review
>> the patch ;-).
>
> Ok. No problem. I thought there was no need for a patch so simple. But ok.

The point is: once a tricky bug was found in a patch (and I did on v1),
you cannot claim anymore that it is "so simple". If it was that simple,
you would have cought it before sending.

>>> @@ -2215,6 +2221,7 @@ test-svn-fe$X: vcs-svn/lib.a
>>>  test-%$X: test-%.o GIT-LDFLAGS $(GITLIBS)
>>>       $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
>>>
>>> +.PHONY: check_sha1 $(SP_OBJ) sparse check check-sha1
>>>  check-sha1:: test-sha1$X
>>>       ./test-sha1.sh
>>>
>>> @@ -2224,7 +2231,6 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>>>       $(QUIET_SP)cgcc -no-compile $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) \
>>>               $(SPARSE_FLAGS) $<
>>>
>>> -.PHONY: sparse $(SP_OBJ)
>>>  sparse: $(SP_OBJ)
>>
>> This "sparse" movement looks again contradictory with the goal announced
>> in the commit message.
> The idea was to group all the phony before all the target, not to put
> the phony necessarily before the closest target. but ok

I personally prefer the old way. I have no strong objection to changing,
but currently your commit message says "Also put the .PHONY declaration
immediately before the target declaration", which is clearly not a
justification to do this change.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
