From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 0/3] Teach fetch and pull to recursively fetch submodules
 too
Date: Sat, 09 Oct 2010 21:17:47 +0200
Message-ID: <4CB0BFDB.7010503@web.de>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org> <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org> <4C9221B6.7070807@web.de> <AF9B7F7E-0956-4814-A3A8-BAD7619A043D@sb.org> <4C9351A7.7050609@web.de> <4C9359D4.2030109@viscovery.net> <4C935D77.3080008@web.de> <329A2E43-ADE3-467C-A2A6-24ACB9DF641E@sb.org> <4C953DE5.6020900@web.de> <DD3654D9-46B9-4980-9138-38FDC33A383C@sb.org> <4C963D00.9050207@web.de> <28BC3A45-D3CF-4A8C-A818-B92A9827C8FB@sb.org> <4CAB8DDF.8080004@web.de> <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Sat Oct 09 21:18:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4evc-0005OG-KP
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 21:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760396Ab0JITRw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 15:17:52 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:44001 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756388Ab0JITRv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 15:17:51 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id DE2A216DB5884;
	Sat,  9 Oct 2010 21:17:49 +0200 (CEST)
Received: from [93.246.43.182] (helo=[192.168.178.29])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #24)
	id 1P4evV-0004SR-00; Sat, 09 Oct 2010 21:17:49 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <FB03A7DB-67D2-4EAE-A0F0-2F3E3CEA9878@sb.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/v3uo9tuCH1g9N0zYjsryfJUx4AqMWBFPxrpK9
	4NfqPMw1Boze6toFLidRyxIM3Jes/uBF63nlJScAyAp8azDQ3x
	Cb+cL/OWDCBDyz44l+fg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158598>

Am 07.10.2010 00:52, schrieb Kevin Ballard:
> On Oct 5, 2010, at 2:06 PM, Junio C Hamano wrote:
>> I dunno.  I've never been a fan of automatically recursing into submodules
>> (iow, treating the nested structure as if there is no nesting), so...
> 
> I agree with this as well.

There are use cases like mine where automatic recursion is just the right
thing to do. But I would be fine with having to turn the recursion on
explicitly in the configuration if most people think recursion is not a
desirable default. It would be really nice to hear from other submodule
users what they think about that ...


> After thinking on it a bit, I think the best solution is to add a switch
> --submodules to fetch which will also fetch all submodules, but otherwise
> fetch will fetch no submodules. This will avoid the problem of detecting
> changed submodules, while still allowing users to explicitly request all
> submodules in case they're about to get on a plane flight.
> And of course we can use a config switch to turn --submodules on or off
> by default.

And apart from the default setting and the name of the option this is
exactly what this patch series does, or am I missing something? I could
rename the option from '--recursive' to '--submodules' if that is
requested (I chose the former for consistency reasons as it is already
used by "git clone" for the same purpose; and IMO we should then use
the same option name for recursive checkout and grep too).


> We should also give some thought to automatically updating submodules
> when `git pull` is performed. I could imagine `git pull --submodules`
> effectively doing `git pull && git submodule update --init --recursive`,
> though this implies submodule updating behavior as part of merge, and
> it seems harder to justify that.

This is the goal of my recursive checkout effort ("update" being the
easier part, "--init" the harder). And if you have recursive checkout
enabled, I think it is justified to update the submodules as part of
the merge.
