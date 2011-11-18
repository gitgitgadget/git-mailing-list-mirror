From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Makefile: add option to disable automatic dependency
 generation
Date: Fri, 18 Nov 2011 00:21:51 -0600
Message-ID: <20111118062150.GC25145@elie.hsd1.il.comcast.net>
References: <CACsJy8BZMDyf4MCiKxPJ5Z+XS+C-MC82SpMFyWgiXmb9xCnScw@mail.gmail.com>
 <20111118034142.GA25228@elie.hsd1.il.comcast.net>
 <CACsJy8A44PFtYrm8NQU+48sVkOe8mjJyO9opO5-TwRtAd-TKsQ@mail.gmail.com>
 <20111118045742.GA25145@elie.hsd1.il.comcast.net>
 <7vty62klg9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Fredrik Kuivinen <frekui@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 18 07:22:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRHpv-0000nL-A2
	for gcvg-git-2@lo.gmane.org; Fri, 18 Nov 2011 07:22:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756853Ab1KRGWB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Nov 2011 01:22:01 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:55702 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756757Ab1KRGWA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2011 01:22:00 -0500
Received: by ggnb2 with SMTP id b2so2093798ggn.19
        for <git@vger.kernel.org>; Thu, 17 Nov 2011 22:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qdJsdvWJh8IPWfNguFOho8mD82xczxlDjUlzayelvk4=;
        b=OdUPs3sKzYfBXYeugECgzaH+oagjlr7xi2HP/Jm61NfY62BjXfWMWp04LhSgrXE76/
         nWskOeFpoQTEsl4kN64ZPVt3VrK0ZkVul9cB+4g7M+5IeqzPuGWv+offZBx5Sqafy43i
         0FlxBo8+uJxe/o/U2CKLpA8G1dOKPTySL/E64=
Received: by 10.236.124.66 with SMTP id w42mr2571323yhh.32.1321597320271;
        Thu, 17 Nov 2011 22:22:00 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id t62sm9640360yht.0.2011.11.17.22.21.58
        (version=SSLv3 cipher=OTHER);
        Thu, 17 Nov 2011 22:21:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vty62klg9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185637>

Junio C Hamano wrote:

> Eek. At least at the end user UI level, couldn't we do this as a tristate?
> E.g. "YesPlease" (or anything that begins with Y if you are ambitious) to
> explicitly enable, empty (or "auto") to autodetect, and anything else to
> decline?

Ah, I didn't mind the UI so much.  Handling

	COMPUTE_HEADER_DEPENDENCIES_FORCE = (yes | no | auto)

should be doable.  I'd suggest making any other value error out, so
typos don't result in mysterious behavior.

> Even better, couldn't we either (1) rearrange .dep/ files somehow, so that
> compiler difference does not matter

Yes, I'm working on an incantation all the compilers like (it
shouldn't be hard --- adding an -MQ option should be enough, but I
want to understand the bug first).  But even with such a fix, I think
it will be important to have a way to turn the feature off.  When
someone using a compiler without -MMD support reports a bug, wouldn't
it be nice to be able to reproduce it?
