From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/3] submodule add: allow relative repository path even
 when no url is set
Date: Tue, 07 Jun 2011 23:03:58 +0200
Message-ID: <4DEE923E.9030208@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vipskb0br.fsf@alter.siamese.dyndns.org> <4DED30E0.6090608@web.de> <7vei368ylj.fsf@alter.siamese.dyndns.org> <4DED454B.1050105@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>,
	Phil Hord <hordp@cisco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:04:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU3RY-0002Pt-Kn
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 23:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310Ab1FGVEB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 17:04:01 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:32787 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688Ab1FGVEB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 17:04:01 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate02.web.de (Postfix) with ESMTP id 18E711A293E8A;
	Tue,  7 Jun 2011 23:03:59 +0200 (CEST)
Received: from [93.240.108.50] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QU3RP-0007tn-00; Tue, 07 Jun 2011 23:03:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <4DED454B.1050105@xiplink.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18W7s2txGNz3j7Ak18U/MbJrUOLAuoqAQekn+SF
	6VN4xCx8qqe1R0OPay/nP/7z9hsM4C49Au08SbeKLPdOTN2WLq
	K+292iyUH6kxamve5jWg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175268>

Am 06.06.2011 23:23, schrieb Marc Branchaud:
> On 11-06-06 05:00 PM, Junio C Hamano wrote:
>> I actually still have a feeling that I may be missing something from the
>> discussion.  While I do like a solution that lifts existing limitation to
>> allow workflows that were hitherto impossible, that only makes sense when
>> the newly allowed workflow makes sense and useful, and when the lifted
>> limitation was not protecting some silly mistakes from getting made.
>>
>> I _think_ our last exchange gave me a fuzzy confirmation that we are not
>> lifting a useful limitation, but I still do not know if the new workflow
>> matches the workflow Marc (who kicked off this thread) wanted to use. I
>> think it does match the set-up Phil Hord mentioned in an earlier message,
>> though.

After thinking about this issue some more I think the change is good. We
only affect relative urls and obviously don't change the case where the
url is already set in the superproject (that case stays like it is and
users like Phil seem to like it that way).

For the case where the url is not set I see two use cases: The first for
people who would like to keep their submodules local (like me and Marc):
the new behavior enables us to use a relative path too, so we are happy.
Then there are those who want to have a submodule relative to the super-
projects url: they won't get an error anymore when using a relative url
without having a default remote in the superproject. But that is easily
fixed later by doing a "submodule sync" when they recognize that fact,
just like Junio explained.

> There may still be a lingering niggle where git might do something the user
> doesn't expect.  For example, git might create a submodule out of
> git://origin/foo.git instead of the local ../foo.git.  You have to be paying
> attention to git's output to notice that difference, and I could see where a
> user might get tripped up.  But IMO improving this can be done independently
> of Jens's patches.

This behavior exists for some time and is not changed by the patches in
question. But maybe when this patch is applied and people get used to
relative paths for local submodules that might become an issue when they
run into it. But I surely won't have an upstream defined for a superproject
I want to add a local submodule too, so I doubt that.

Or am I still missing something?
