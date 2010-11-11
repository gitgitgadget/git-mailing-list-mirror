From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v3 2/3] Add the 'fetch.recurseSubmodules' config setting
Date: Thu, 11 Nov 2010 09:14:53 +0100
Message-ID: <4CDBA5FD.20802@web.de>
References: <4CDB3063.5010801@web.de> <4CDB30D6.5040302@web.de> <20101111000216.GA14189@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>,
	Jon Seymour <jon.seymour@gmail.com>,
	Chris Packham <judge.packham@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 09:16:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGSKH-0003qn-8v
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 09:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757750Ab0KKIPx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 03:15:53 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:51376 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757717Ab0KKIPw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 03:15:52 -0500
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 87C8C1775DC39;
	Thu, 11 Nov 2010 09:14:59 +0100 (CET)
Received: from [93.240.103.159] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1PGSJ9-0006f1-00; Thu, 11 Nov 2010 09:14:59 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
In-Reply-To: <20101111000216.GA14189@burratino>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/t0QQd3KLg4qG8KfnjJPT5VKJn1yeCtWk1K2hb
	qn1sa/bItsm2MdKnRUPXCQ4uNixB0mayQGmC21Hk8/yzSN5rz3
	dARW+b7sMcflGE8a7uSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161215>

Am 11.11.2010 01:02, schrieb Jonathan Nieder:
> Jens Lehmann wrote:
> 
>> --- a/t/t5526-fetch-submodules.sh
>> +++ b/t/t5526-fetch-submodules.sh
>> @@ -106,4 +106,40 @@ test_expect_success "--dry-run propagates to submodules" '
>>  	test_cmp expect.err actual.err
>>  '
>>
>> +test_expect_success "recurseSubmodules=true propagates into submodules" '
>> +	add_upstream_commit &&
>> +	(
>> +		cd downstream &&
>> +		git config fetch.recurseSubmodules true
>> +		git fetch >../actual.out 2>../actual.err
>> +	) &&
>> +	test_cmp expect.out actual.out &&
>> +	test_cmp expect.err actual.err
>> +'
> 
> This configuration item is read from .gitmodules, too, right?  Would
> it be easy (or desirable) to make it not read from there?  Either way,
> it would be nice to have a test so the behavior doesn't change without
> anyone noticing.

"fetch.recurseSubmodules" is only read from .git/config. The one read
first from .gitmodules and then from .git/config is the per-submodule
setting "submodule.<name>.fetchRecurseSubmodules" added in 3/3. But
maybe I should add a test that "fetch.recurseSubmodules" also works
when set in the global config ...
