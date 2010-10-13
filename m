From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Wed, 13 Oct 2010 17:27:16 -0400
Message-ID: <4CB62434.3070204@xiplink.com>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org> <4CB0BFDB.7010503@web.de> <4CB5C6D8.1070108@xiplink.com> <4CB6093F.3040800@web.de> <1691DBFD-6075-479E-8847-EB4595BB9E10@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Oct 13 23:26:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P68qb-0003zF-B3
	for gcvg-git-2@lo.gmane.org; Wed, 13 Oct 2010 23:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab0JMV0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Oct 2010 17:26:33 -0400
Received: from smtp172.iad.emailsrvr.com ([207.97.245.172]:55183 "EHLO
	smtp172.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab0JMV0c (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Oct 2010 17:26:32 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp37.relay.iad1a.emailsrvr.com (SMTP Server) with ESMTP id DC42F3B0696;
	Wed, 13 Oct 2010 17:26:31 -0400 (EDT)
X-Orig-To: gitster@pobox.com
X-Orig-To: kevin@sb.org
X-Orig-To: git@vger.kernel.org
X-Orig-To: Jens.Lehmann@web.de
X-Orig-To: mbranchaud@xiplink.com
X-Virus-Scanned: OK
Received: by smtp37.relay.iad1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 9E1983B0691;
	Wed, 13 Oct 2010 17:26:31 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100915 Thunderbird/3.0.8
In-Reply-To: <1691DBFD-6075-479E-8847-EB4595BB9E10@sb.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158978>

On 10-10-13 03:34 PM, Kevin Ballard wrote:
> On Oct 13, 2010, at 12:32 PM, Jens Lehmann wrote:
> 
>>>> There are use cases like mine where automatic recursion is just the
>>>> right thing to do. But I would be fine with having to turn the
>>>> recursion on explicitly in the configuration if most people think
>>>> recursion is not a desirable default. It would be really nice to
>>>> hear from other submodule users what they think about that ...
>>> 
>>> I tend to think that the right default for fetch is to employ the same
>>> level of recursion that was used for the initial clone.  So if the
>>> clone was made with --recursive then fetch should default to using
>>> --recursive.
>> 
>> That's a very interesting idea.
> 
> I'm not sure it's correct though. For example, with my scenario every
> single submodule is required for a correct build, but most submodules
> should definitely not be updated unless their parent submodule updates its
> gitlink. So --recursive is recommended for `git clone`, but a
> non-recursive fetch would be the correct behavior going forward.

What about a "smart" recursive fetch?  One where if *any* new ref in the
superproject changes the superproject's submodule ref, *and* that submodule
ref isn't already in the submodule repo, then fetch updates the submodule.
Recurse as needed.

That way I don't think there'd be any missing commits when checking out
different branches in the superproject, and submodule fetches are minimized.

Not sure how easy that would be to implement though, or what the performance
would be like.

		M.
