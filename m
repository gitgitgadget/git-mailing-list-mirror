From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH RFC] parse_object: pass on the original sha1, not the replaced one
Date: Tue, 3 Aug 2010 07:00:40 +0200
Message-ID: <201008030700.40533.chriscool@tuxfamily.org>
References: <1280579802-8606-1-git-send-email-pclouds@gmail.com> <201008020942.58137.chriscool@tuxfamily.org> <AANLkTin0eymuYFv_6hamDuan0TELogtCyW3Xwjm=pAwH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 07:00:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Og9cU-0002RD-Lr
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 07:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab0HCFAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Aug 2010 01:00:49 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:51335 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754574Ab0HCFAs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Aug 2010 01:00:48 -0400
Received: from style.localnet (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1037D818082;
	Tue,  3 Aug 2010 07:00:41 +0200 (CEST)
User-Agent: KMail/1.13.2 (Linux/2.6.32-23-generic; KDE/4.4.2; x86_64; ; )
In-Reply-To: <AANLkTin0eymuYFv_6hamDuan0TELogtCyW3Xwjm=pAwH@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152485>

On Monday 02 August 2010 11:31:23 Nguyen Thai Ngoc Duy wrote:
> 2010/8/2 Christian Couder <chriscool@tuxfamily.org>:
> > 
> > I am not sure I understand what you are saying. Do you mean that git log
> > should show the original sha1 but the content of the replacement commit,
> > instead of both the sha1 and the content of the replacement commit?
> 
> "original sha1, but the content of replacement commit", yes. Isn't
> that the intention of git-replace?

I think it's better if the sha1 is replaced too. This way we keep the link 
between the sha1 and the content.

And it's easier for the user to realize that we gave him a replacement object 
if we use the replacement sha1 as the user can more easily see that the sha1 
changed.

> > I just tested your patch and indeed with it it seems to me that the
> > result shown by git log is not consistent, as for example the commit
> > message is the one of the replacement commit but the commit sha1 is the
> > one of the original commit.
> 
> The consistency is already there. Suppose I want to replace commit A
> with B. Depends on what function I call to fetch "A", I get different
> object->sha1. (the content is always from B though).
> 
> With parse_object(A), I get an object pointer whose sha1 is B.
> 
> With  lookup_commit(A), I get an object pointer whose sha1 is A.

Maybe there is a bug somewhere and you should get an object pointer whose sha1 
is B or maybe the content of the object that was inserted in the lookup table 
should have been the content from A and not from B. I will try to have a 
deeper look at that, but it would help if you could give an example of a 
command that triggers this behavior.

Best regards,
Christian.
