From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH 5/8] push, send-pack: support pushing HEAD to real ref name
Date: Sun, 28 Oct 2007 17:30:44 +0100
Message-ID: <55CCFD12-C10F-46A6-8D65-544231DEBF3F@zib.de>
References: <119350380778-git-send-email-prohaska@zib.de> <11935038081211-git-send-email-prohaska@zib.de> <11935038081650-git-send-email-prohaska@zib.de> <1193503808519-git-send-email-prohaska@zib.de> <11935038083369-git-send-email-prohaska@zib.de> <11935038084055-git-send-email-prohaska@zib.de> <7vwst7wvdr.fsf@gitster.siamese.dyndns.org> <722152C5-299C-435E-B720-D2D331D16249@zib.de> <7vd4uzuu1g.fsf@gitster.siamese.dyndns.org> <7v7il7usyx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 28 17:29:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImB1E-0004Td-81
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 17:29:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752051AbXJ1Q3X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 12:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbXJ1Q3W
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 12:29:22 -0400
Received: from mailer.zib.de ([130.73.108.11]:58406 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751283AbXJ1Q3W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 12:29:22 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9SGTHCF010839;
	Sun, 28 Oct 2007 17:29:17 +0100 (CET)
Received: from [192.168.178.21] (brln-4db1072b.pool.einsundeins.de [77.177.7.43])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9SGTGAK003569
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 28 Oct 2007 17:29:17 +0100 (MET)
In-Reply-To: <7v7il7usyx.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62570>


On Oct 28, 2007, at 5:03 PM, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Steffen Prohaska <prohaska@zib.de> writes:
>>
>>> On Oct 28, 2007, at 8:28 AM, Junio C Hamano wrote:
>>>
>>>> Steffen Prohaska <prohaska@zib.de> writes:
>>>>
>>>>> This teaches "push <remote> HEAD" to resolve HEAD on the local
>>>>> side to its real ref name, e.g. refs/heads/master, and then
>>>>> use the real ref name on the remote side to search a matching
>>>>> remote ref.
>>>>
>>>> This probably is a good idea.
>>>
>>> I'll add an even shorter shorthand: "git push HEAD" will push
>>> the current branch to its default remote.
>>
>> Ugh, that looks way too magicky.  The first parameter to push if
>> one ever exists has _always_ been the remote, and the above
>> breaks it.
>>
>> Please don't.
>
> An alternative, just to let me keep my nicer public image by
> pretending to be constructive ;-)
>
> Introduce a configuration "remote.$name.push_default" whose
> value can be a list of refs.  Teach the push command without
> refspecs:
>
> 	$ git push
> 	$ git push $remote
>
> to pretend as if the listed refspecs are given, instead of the
> traditional "matching branches" behaviour.
>
> Then, introduce another option
>
> 	$ git push --matching
> 	$ git push --matching $remote
>
> to override that configuration, if set, so that the user who
> usually pushes only the selected branches can use the "matching
> branches" behaviour when needed.
>
> Along with your earlier "git push $remote HEAD" patch, this will
> allow you to say:
>
> 	[remote "origin"]
>         	push_default = HEAD
>
> and your
>
> 	$ git push
>
> will push only the current branch.

Sounds reasonable; but it is more work. I'm not starting to
implement this today.

	Steffen
