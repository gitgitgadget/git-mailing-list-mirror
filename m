From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: Re: git-submodule getting submodules from the parent repository
Date: Mon, 31 Mar 2008 11:29:56 +0200
Message-ID: <834174D1-82F4-4438-9854-762F416BB5EF@orakel.ntnu.no>
References: <32541b130803291535m317e84e6p321ebccd5dedaab3@mail.gmail.com> <47EECF1F.60908@vilain.net> <D0F821FA-AF53-4F1F-B9CC-58346828FA15@orakel.ntnu.no> <47EFD253.6020105@vilain.net> <C38585A9-F09C-4A5B-8E72-6F3127DB2BB9@orakel.ntnu.no> <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Sam Vilain" <sam@vilain.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 11:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JgGLq-0001Lm-EY
	for gcvg-git-2@gmane.org; Mon, 31 Mar 2008 11:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753638AbYCaJaH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2008 05:30:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754693AbYCaJaH
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Mar 2008 05:30:07 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:49801 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753589AbYCaJaG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2008 05:30:06 -0400
Received: from ivilhamac.dhcp.ad.fast.no (pat-gw.osl.fast.no [217.144.235.5])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id F30A6159FDC;
	Mon, 31 Mar 2008 11:30:02 +0200 (CEST)
In-Reply-To: <32541b130803301603u65d1b6b6ladac0f6200433e5f@mail.gmail.com>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78573>

On 31. mars. 2008, at 01.03, Avery Pennarun wrote:

> On Sun, Mar 30, 2008 at 3:50 PM, Eyvind Bernhardsen
> <eyvind-git@orakel.ntnu.no> wrote:
>> Pushing to a branch works except that I couldn't figure out what to  
>> do
>> if the push doesn't succeed, ie, the branch has advanced on the  
>> remote
>> end.  That's a problem if more than one module references the
>> submodule or there are multiple branches in the main module.
>
> That's easy: just error out in that case.  If the current system would
> just error out when I screwed up, I'd at least be able to deal with
> it.  Right now I silently create un-check-outable parent repositories
> because I failed silently to upload my latest checkins to the child
> repository.

As I tried to explain, all the automatic push solutions I could come  
up with were flawed, so I decided not to use submodules at all and  
just have the build tool check out every module (that's what we  
currently do with CVS, so it's the easy way out anyway).

If I understand you correctly, you want to be forced to create a  
branch and push to that?  I don't think that works well with many  
developers pushing to a shared repository (my situation), and is in  
any case not the "automagical push" solution that I want.  I agree  
that it would be an improvement, but it doesn't scratch my itch :)

>> True :)  I still have no idea how to figure out which submodules are
>> dirty, though.  Solving that will enable a safe "submodule update",
>> which I think is more important than "submodule push".
>
> What is unsafe about "submodule update"?

If you have local changes committed in a submodule that is updated by  
a pull in the main module, "submodule update" will silently overwrite  
them.  I was wrong, though, because you can fix that just by making  
"submodule update" error out when a submodule doesn't have its HEAD  
where the main module thinks it should be.
-- 
Eyvind Bernhardsen
