From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] `git submodule update --init --recursive` stores gitdir in full path into `.git` of nested submodules
Date: Wed, 30 Mar 2016 13:54:48 -0700
Message-ID: <xmqqpoubsn3b.fsf@gitster.mtv.corp.google.com>
References: <F89ED33B-E33D-4693-8559-4255727B78B8@gmail.com>
	<CAGZ79kaa2uBmRZ_OPG9hVkrc29uj8Lx9b-6fgbcDNE0OGvJ+cg@mail.gmail.com>
	<CAGZ79kZwSFjADYYC=FBFr8cWv08mv+H7E=Bx3N=J2Q_o8sK9qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Norio Nomura <norio.nomura@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 22:54:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alN8i-0000lB-HE
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 22:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489AbcC3Uyw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 30 Mar 2016 16:54:52 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54888 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751778AbcC3Uyv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Mar 2016 16:54:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 80F9651537;
	Wed, 30 Mar 2016 16:54:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=10nOAQ1k84dm
	T1TtuTOUu5UgNNY=; b=v6c2ta12En/Q/6cid+A1WG5ks0Og/kW/wfNFdSuiud4A
	oWUZzGKZgHfVqud5JJToMM4M31mtYwmw958RJ7x+u2lK1XiUT5xj/e1Hi7w+4sEK
	OuckbKqaZNI9NMDxfydOkINOngHfTpXXp1/a4o1fCAWci7jVglbrfaahWvUNE6E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=pWipcf
	gNR6RRoj+BaZGUQaMdXoYOwm3TrW5Xl+Ipw8smyaH2H1oMLu0LTC8GPWkqA+1Cln
	POzX2xMBNqwGB1r/FfdpfXcGKpTi8u1b+G7/+R/we7TZUd61RH5drg/jC2LJwyxb
	diZlKUGZiHWBOZRhtt/PKydRNPdEEinBMkjw0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7892251536;
	Wed, 30 Mar 2016 16:54:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E6A1A51535;
	Wed, 30 Mar 2016 16:54:49 -0400 (EDT)
In-Reply-To: <CAGZ79kZwSFjADYYC=FBFr8cWv08mv+H7E=Bx3N=J2Q_o8sK9qw@mail.gmail.com>
	(Stefan Beller's message of "Wed, 30 Mar 2016 10:24:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A4D66D34-F6B9-11E5-B828-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290346>

Stefan Beller <sbeller@google.com> writes:

> On Wed, Mar 30, 2016 at 9:05 AM, Stefan Beller <sbeller@google.com> w=
rote:
>> On Wed, Mar 30, 2016 at 2:03 AM, Norio Nomura <norio.nomura@gmail.co=
m> wrote:
>>> Hi,
>>>
>>> `git submodule update --init --recursive` stores `gitdir` in full p=
ath into `.git` of nested submodules.
>>> So, working directory is not portable to another directory.
>>
>> Are you reporting a regression bug? (Is that a new thing or has it
>> always been that way and you just discover that it is unfortunate?)
>> Which versions did you test with?
>
> =E2=9E=9C  15:34:32 git:(master) git --version
> git version 2.8.0
>
> at the end of your gist.
> The same happens when using 2.7.4, it doesn't happen when using 2.6.6=
 though.
>
> It turns out ee8838d (2015-09-08, submodule: rewrite `module_clone`
> shell function in C)
> broke it.
>
> I'll look into fixing it.

Thanks.

This may be an unrelated tangent, but somewhere in "submodule init"
codepath seem to turn paths into absolute too aggressively.  Merging
your recent "path related fix" to 'pu' seems to break some test by
showing absolute paths when the test expects to see relative ones.
