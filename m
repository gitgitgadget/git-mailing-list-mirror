From: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [PATCH for-maint] apply: gitdiff_verify_name(): accept "/dev/null\r"
Date: Tue, 23 Sep 2014 22:32:04 +0200
Message-ID: <5421D8C4.2080009@redhat.com>
References: <1411434583-27692-1-git-send-email-lersek@redhat.com>	<xmqq1tr2jhg2.fsf@gitster.dls.corp.google.com>	<5421CAA6.3040107@redhat.com> <xmqqsijihzrb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, jordan.l.justen@intel.com,
	matt.fleming@intel.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 22:32:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWWl2-0005Gb-6w
	for gcvg-git-2@plane.gmane.org; Tue, 23 Sep 2014 22:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932205AbaIWUcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 16:32:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11704 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189AbaIWUcL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2014 16:32:11 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKW8gI023250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Sep 2014 16:32:08 -0400
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-33.ams2.redhat.com [10.36.116.33])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s8NKW4iJ026197;
	Tue, 23 Sep 2014 16:32:06 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.1.1
In-Reply-To: <xmqqsijihzrb.fsf@gitster.dls.corp.google.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.27
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257439>

On 09/23/14 22:02, Junio C Hamano wrote:
> Laszlo Ersek <lersek@redhat.com> writes:
> 
>> On 09/23/14 20:54, Junio C Hamano wrote:
>> ...
>>> SMTP transport may be CRLF-unsafe, so I have a suspicion that it may
>>> turn out that what you are trying to do might be an equilvalent of
>>>
>>> 	git format-patch ... |
>>>         # first lose all \r\n
>>>         dos2unix | 
>>> 	# then make everything \r\n
>>>         unix2dos |
>>>         # and apply
>>>         git am
>>>
>>> which is not workable in the first place.  I dunno.
>>
>> I agree with your analysis. It is indeed the MTA...
>>>    - CR and LF MUST only occur together as CRLF; they MUST NOT appear
>>>      independently in the body.
>>
>> But why is this situation "not workable"? The same happens with *all*
>> patches that people mail around, it's just not visible to them, because
>> git-am strips all CRs indiscriminately.
> 
> It is not "git am" or "git apply" that "strips all CRs
> indiscriminately".  I just tried to apply 0001-add-f2 without
> letting your MTA/MUA corrupt it on "master" branch in the repository
> you prepared that patch from, i.e.
> 
> 	git checkout master^0 ;# go back
>         git am 0001-add-f2* ;# apply that "+hello world\r\n" patch
>         git diff branch ;# nothing

When you did this, was am.keepcr=true in effect?

Thanks
Laszlo
