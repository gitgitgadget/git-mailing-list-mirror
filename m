From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 03 Jul 2013 14:06:18 +0200
Message-ID: <51D413BA.6080709@viscovery.net>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org> <CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com> <CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com> <7vli5ogh8r.fsf@alter.siamese.dyndns.org> <CALKQrge_REZKfds0T-owJOn2BvfLmHpk7yQeSog=yvofE_zKJQ@mail.gmail.com> <CAF5DW8++sc2VYmdJEjbD_ue_wtDFj21vcyFzNWU0M+rAm2X0sQ@mail.gmail.com> <CALKQrgfQhVVC1NxizjCQdDmNfihfyEgypYddWB0CMTPqW9Mxtg@mail.gmail.com> <51D40203.1010100@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Jonathan del Strother <maillist@steelskies.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jul 03 14:06:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuLpP-0008LR-MJ
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 14:06:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755844Ab3GCMG2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 08:06:28 -0400
Received: from so.liwest.at ([212.33.55.13]:29169 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755129Ab3GCMG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 08:06:27 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1UuLpE-0001e7-2T; Wed, 03 Jul 2013 14:06:20 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 3BB0C1660F;
	Wed,  3 Jul 2013 14:06:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <51D40203.1010100@alum.mit.edu>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229494>

Am 7/3/2013 12:50, schrieb Michael Haggerty:
> On 07/03/2013 12:11 PM, Johan Herland wrote:
>> On Wed, Jul 3, 2013 at 12:06 PM, Jonathan del Strother
>> <maillist@steelskies.com> wrote:
>>> I'm struggling to think of instances where I wouldn't want this
>>> CAS-like behaviour.  Wouldn't it be better to make it the default when
>>> pushing, and allowing the current behaviour with "git push
>>> --blind-force" or something?
>>
>> I believe I agree with you. I guess the reason this hasn't come up
>> before is that by far most of the pushes we do are either
>> fast-forwarding, or pushing into a non-shared repo (e.g. my own public
>> repo),  and this safety only really applies when we're forcing a
>> non-fast-forward push into a shared repo...
> 
> I didn't see Jonathan's original email but I was having exactly the same
> though as him (and was even going to propose the same option name).
> 
> Non-ff pushing without knowing what you are going to overwrite is
> irresponsible in most scenarios, and (if backwards-compatibility
> concerns can be overcome) I think it would be quite prudent to forbid a
> non-ff push if there is no local remote-tracking branch that is
> up-to-date at the time of the push.  Circumventing that check should
> require some extra-super-force option.

I don't think that is necessary. We already have *two* options to
force-push a ref: the + in front of refspec, and --force.

IMO, the meaning of + should be changed to "force-push with safety", and
--force can then be used to override if the safety triggers (i.e., --force
is your extra-super-force option).

-- Hannes
