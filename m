From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Why does 'submodule add' stage the relevant portions?
Date: Tue, 26 Mar 2013 17:57:30 +0100
Message-ID: <5151D37A.6000708@web.de>
References: <CALkWK0=PHNmT5zfjEaWh_5=aV7wcPdGgyCWFhjaeVrrWhL0OBw@mail.gmail.com> <51500C67.9040308@web.de> <CALkWK0kJ2QVA6is85Sdwn1mnGVbuNUSGqg_37WBxPYrepHz9ow@mail.gmail.com> <51509ABA.3040804@web.de> <CALkWK0mAkabTNrBjvv4s_YfTN9j2_Aros=7ZcF7j=KAjJE-yaw@mail.gmail.com> <5150D655.8000204@web.de> <CALkWK0mXOHGJHQ85mMuoUyzti6b2QoijN1EEFzpJ+TKm3tWnXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 26 17:58:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKXCP-0002LM-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 17:58:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986Ab3CZQ5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 12:57:36 -0400
Received: from mout.web.de ([212.227.15.4]:63728 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751923Ab3CZQ5f (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 12:57:35 -0400
Received: from [192.168.178.41] ([79.193.84.33]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0MKa6N-1ULuV00fI7-001SmI; Tue, 26 Mar 2013 17:57:33
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CALkWK0mXOHGJHQ85mMuoUyzti6b2QoijN1EEFzpJ+TKm3tWnXg@mail.gmail.com>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:+yTHBZWp5WFPkU0tIkQ98kfRBTgRunMwozSoiYeeV5u
 GzXKGA+zMZWJ3I46bQ770nfFAi3gk2Oz14vIt6xSIWqu61kp7X
 opX0bLOgxP5r8nxq6nj57SG08Z0mfR9IC0mBqWxYaWuFZdXJTh
 bqFFzft09frW0Yy5J919kDXOhMkIhw7BsIYHB17MInvwv76Kqf
 39HKJDVOXxCJ59ubGGP+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219170>

Am 26.03.2013 08:57, schrieb Ramkumar Ramachandra:
> Jens Lehmann wrote:
>> And leaving aside 'add', there are tons of submodules out there
>> which were cloned with older Git who have their .git directory
>> inside the work tree. So a new subcommand (or at least a helper
>> script in contrib) to relocate the .git directory would really help
>> here to migrate these legacy submodules without users having to
>> worry about data loss.
> 
> The question is: after using a "non-relocated submodule" for some
> time, will the user suddenly decide to make it a "relocated submodule"
> one day?

I think quite some users - and definitely myself - will do that as
soon as the full recursive checkout materialized, as that allows to
remove submodules without any directory remaining and even to replace
a submodule with a directory containing other files. And even with
current Git you already get a clean work tree when using "git rm" or
"git submodule deinit" (in current master) on a submodule iff it has
its .git directory stored in the .git directory of the superproject.
It is definitely not a Must Have right now, but I expect it to be
that in the near future.

>>> I meant a variant of add that would clone, but not stage.  I was
>>> arguing for a new subcommand so that I don't have to touch 'submodule
>>> add', not for a rename.
>>
>> Ah, now I get it, I was confused by your reference to 'git submodule
>> add <repository> <path>'. I have to admit I still don't understand
>> the use case you have for adding a submodule without staging it, but
>> maybe it is just too late here.
> 
> I usually reset after running 'git submodule add', because I rarely
> commit the added submodule immediately after adding it.

I'm not sure many submodule users do the same, but even then the
normal ways of unstaging the submodule and .gitmodules should be
sufficient here, no? I'd rather avoid adding a new command to git
submodule for that.
