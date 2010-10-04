From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: branch versioning
Date: Mon, 04 Oct 2010 15:44:24 +0200
Message-ID: <4CA9DA38.3070103@drmicha.warpmail.net>
References: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 04 15:44:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2lL1-0001Az-QC
	for gcvg-git-2@lo.gmane.org; Mon, 04 Oct 2010 15:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755939Ab0JDNoO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 09:44:14 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:53093 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755351Ab0JDNoN (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Oct 2010 09:44:13 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8FBC595;
	Mon,  4 Oct 2010 09:44:12 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 04 Oct 2010 09:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=RgCGYUvivYRXuZm+knskZwMmJLw=; b=OnBV/qekm6rEmXRNKZkHBhYzz8o6DhTFt2ep1IVvoheXZWlcj4EFxyB1Zq8CGtpG2hR6++0O5/tVqlyvQOJ303KpjoF4tTG7LD2nM6rZI4MIf/mHyQTR4mVMlN1Tf49fv7a6N4NSfe6xs1ekBtYDzQbTyRXIFU+lenyxZQAnbnc=
X-Sasl-enc: V+8Lr93DIlioOJ4iuSY4ha1NLcSCZ2JpkISyAmRbf5Qi 1286199852
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F13745E60AA;
	Mon,  4 Oct 2010 09:44:11 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.9) Gecko/20100921 Fedora/3.1.4-1.fc13 Lightning/1.0b3pre Thunderbird/3.1.4
In-Reply-To: <AANLkTimWxPPi_hHuato+hHePaEja=66GzLEpDUVcZV0i@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158048>

Nguyen Thai Ngoc Duy venit, vidit, dixit 04.10.2010 15:18:
> Hi,
> 
> How do you guys manage versions of a topic branch? I usually end up
> saving format-patch series somewhere or forget all old versions.
> Although I really want to keep old versions around. reflog to me   is
> polluted with every kind of branch updates. And it's local
> information. It can't be transferred to another repo (or can it?)
> 
> On the same subject, I have quite a few old topic branches that I
> rarely touch. I don't want to remove them. I just want to hide them
> away from "git branch". I've been thinking of "attic/" namespace that
> "git branch" by default will not show. Just wondering if other people
> face the same problem..

Same problem, without a perfect solution. I have a branch mjg/foo for a
topic in flight. If I need to submit v2, I tag the old tip mjg/foo-v1
and rebase -i, etc. Once a patch gets accepted, I do:

- Merge the git.git commit with the applied patch to mjg/foo (with a
message like "Applied as commit deadbeef on next). The merge diff shows
the differences between my patch and the actual commit on git.git.
- Tag the tip as mjg/applied/foo.
- Delete the branch.
- Delete the branch on my repos if it has been pushed out already (this
point sucks).

That way my branch namespace is reasonably clean, and the graph view on
github, e.g., is somewhat meaningful. My tag name space is a bit crowded...

I also keep the commit notes (post ---) in a note ;)

Michael
