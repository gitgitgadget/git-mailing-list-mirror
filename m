From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 30 Jul 2008 18:14:38 -0400
Message-ID: <32541b130807301514j43e98003gf1da1b61dbee499@mail.gmail.com>
References: <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
	 <20080725140142.GB2925@dpotapov.dyndns.org>
	 <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
	 <20080729134619.GB7008@dpotapov.dyndns.org>
	 <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
	 <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de>
	 <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com>
	 <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de>
	 <32541b130807301407m59eef936m5e07dd33a4eb5b04@mail.gmail.com>
	 <20080730220236.GD7008@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steffen Prohaska" <prohaska@zib.de>,
	"Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Joshua Jensen" <jjensen@workspacewhiz.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 31 00:15:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOJxM-0006rh-Fz
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 00:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758126AbYG3WOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 18:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbYG3WOk
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 18:14:40 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:40719 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867AbYG3WOj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 18:14:39 -0400
Received: by yw-out-2324.google.com with SMTP id 9so146334ywe.1
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 15:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=OPMqGkCNIUjhKyNwvD8n4b+4o2EFDaGjn1wVErYXmqY=;
        b=HCKujd7NaszOFNO3W9+ETlXJQqX86/9fH7MjrGHW6DeiPsgnvKUzgtISGuUmmECqV+
         uL9os8eFVCorW027qUuKzs6lXvJc2fgnHhFy42te3b59DmV8VAojSt6qAkhKhJrMrVHY
         7InAwLx71XcupRYTRDQ3vOoMu30XUtHZGocTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=WThMn/sEbcPSfa8bkPzHxJwJ58bwUe83duHjDsKK8ewHS5hh0x+8wg7VKIWSU4fdPY
         9MSkXdUH/8Gt+mOiDFudeqx5iJcCnb4xDNhWHTZJVroG5wuQA8ZbU70/FIdKA3jd97re
         t3Kj2xEKvl4YJxYda54DqY1SZhEVJm1XdkeCQ=
Received: by 10.150.58.17 with SMTP id g17mr79241yba.175.1217456078301;
        Wed, 30 Jul 2008 15:14:38 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 30 Jul 2008 15:14:38 -0700 (PDT)
In-Reply-To: <20080730220236.GD7008@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90865>

On 7/30/08, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Wed, Jul 30, 2008 at 05:07:49PM -0400, Avery Pennarun wrote:
>  > FWIW, this problem would apply to any system that incrementally
>  > imports into git from another system using binary deltas.
>
> Not necessary. It depends on how import is done. You should not apply
>  this binary deltas to your working tree, but to files in the repo. And
>  obviously those files that are imported should be stored as is without
>  any conversion. In the same way as if you clone some git repo, you do
>  not apply any commit conversion to any existing commit. This conversion
>  should be done for *new* commits that you create locally.
>
>  So, the problem with git-svn is mostly due to how the import is done. Of
>  course, the other part of that problem is that conversion setting in Git
>  and SVN for text files specified very differently.

Hmm, if your first paragraphis true (do not apply any commit
conversion to any existing commit), then in fact SVN's method for
specifying text files doesn't really matter, right?  It's just a bug
in git-svn.

Is it possible to have git-svn override core.autocrlf temporarily?  If
someone can give me a hint how to do that, I don't mind working up a
patch for that. I can't see any situation where *not* doing so would
even work (unless core.autocrlf=false already, of course).

Have fun,

Avery
