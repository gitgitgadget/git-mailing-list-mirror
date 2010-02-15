From: Gabriel Filion <lelutin@gmail.com>
Subject: Re: [PATCH] require_work_tree broken with NONGIT_OK
Date: Mon, 15 Feb 2010 02:24:59 -0500
Message-ID: <4B78F6CB.2070304@gmail.com>
References: <4B78C4D3.90407@gmail.com> <7vzl3bj95l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 08:25:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgvKS-0008JH-Jx
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 08:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043Ab0BOHZE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 02:25:04 -0500
Received: from mail001.aei.ca ([206.123.6.130]:36623 "EHLO mail001.aei.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754544Ab0BOHZD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 02:25:03 -0500
Received: (qmail 4241 invoked by uid 89); 15 Feb 2010 07:25:00 -0000
Received: by simscan 1.2.0 ppid: 4235, pid: 4236, t: 0.0413s
         scanners: regex: 1.2.0 attach: 1.2.0
Received: from mail002.aei.ca (HELO mail002.contact.net) (206.123.6.132)
  by mail001.aei.ca with (DHE-RSA-AES256-SHA encrypted) SMTP; 15 Feb 2010 07:25:00 -0000
Received: (qmail 14622 invoked by uid 89); 15 Feb 2010 07:25:00 -0000
Received: by simscan 1.2.0 ppid: 14616, pid: 14617, t: 0.4871s
         scanners: regex: 1.2.0 attach: 1.2.0 clamav: 0.95.3/m:51 spam: 3.3.0
X-Spam-Checker-Version: SpamAssassin 3.3.0 (2010-01-18)
X-Spam-Level: 
X-Spam-Status: No, hits=-3.0 required=5.0 tests=ALL_TRUSTED,BAYES_00,
	FREEMAIL_FROM autolearn=ham version=3.3.0
Received: from dsl-152-38.aei.ca (HELO ?192.168.2.202?) (66.36.152.38)
  by mail.aei.ca with SMTP; 15 Feb 2010 07:24:59 -0000
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.5) Gecko/20100108 Lightning/1.0b1 Icedove/3.0
In-Reply-To: <7vzl3bj95l.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139991>

On 2010-02-15 01:38, Junio C Hamano wrote:
> Gabriel Filion <lelutin@gmail.com> writes:
> 
>> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
>> index d56426d..8de2f03 100755
>> --- a/git-sh-setup.sh
>> +++ b/git-sh-setup.sh
>> @@ -128,7 +128,7 @@ cd_to_toplevel () {
>>  }
>>   require_work_tree () {
>> -	test $(git rev-parse --is-inside-work-tree) = true ||
> 
> This needs to have dq around it, as "Not a git repository" case we fatal
> out without any output, like this:
> 
> 	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
> 
>> +	test git rev-parse --is-inside-work-tree >/dev/null 2>&1 ||
> 
> I don't think this would ever work with "test" at the beginning.
> 
Well, it would seem you are right! my bad for thinking that "test" was
actually evaluating any command given in the expression :\

Your implementation seems to be working better and fixes the problem.
Thanks for reviewing the patch.

-- 
Gabriel Filion
