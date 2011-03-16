From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Wed, 16 Mar 2011 21:40:51 +0700
Message-ID: <AANLkTintr3szKMhbegeUgu+KHGtBGTRyQ3Y4pOwfwhEr@mail.gmail.com>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net> <20110123141417.GA6133@mew.padd.com>
 <4D793C7D.1000502@miseler.de> <20110310222443.GC15828@sigill.intra.peff.net>
 <AANLkTimpbhaGEfxW1wwRc14tpV6qnPDiZYnXp_tvA3Ft@mail.gmail.com>
 <20110313025258.GA10452@sigill.intra.peff.net> <4D7D1BFE.2030008@miseler.de> <20110314193254.GA21581@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Alexander Miseler <alexander@miseler.de>,
	Eric Montellese <emontellese@gmail.com>,
	Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	schacon@gmail.com, joey@kitenet.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 16 15:41:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzrui-0001JQ-4x
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 15:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752967Ab1CPOlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 10:41:24 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44436 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab1CPOlW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 10:41:22 -0400
Received: by wwa36 with SMTP id 36so2221471wwa.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2011 07:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=CwmXIwmWAKgte93yHRu2mElRlWJvHx81MX1t7spTXe8=;
        b=spPv1FaXLyo8hZVncOs4I6pwZzEJdbScsUMYi79wmjlGy+Iyv+iiSmhDNjaJBj/mvi
         WLJbuoAyFOw1VXpWiMfEchktXovO99Mag4u5fiHmqET8HpuS1Px+xBs0C6j5eCHMvYzd
         3blJF+NwsjMWh/ADFj0E3zgprdSjn1UKCtBYs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=kicinPLn1+izjkTXCnOJnSC+kSALjKv6mWv95MpHndjN8daQZtv+uQIJfU2st9HgQW
         jw2/vVxDRwdfKKoMNlLvU2OecxPcS0JszpbORiMq3zn7r6lUatDOjxSyhljnzXUEulc3
         cmT8u06GXy37K6xrBCcRp7vdw5BKuymqcyfIM=
Received: by 10.216.157.68 with SMTP id n46mr161532wek.111.1300286481372; Wed,
 16 Mar 2011 07:41:21 -0700 (PDT)
Received: by 10.216.163.202 with HTTP; Wed, 16 Mar 2011 07:40:51 -0700 (PDT)
In-Reply-To: <20110314193254.GA21581@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169158>

On Tue, Mar 15, 2011 at 2:32 AM, Jeff King <peff@peff.net> wrote:
> That being said, I'm not sure how much this optimization will buy us.
> There are times when being able to mmap() the file directly, or point an
> external program directly at the original blob will be helpful. But we
> will still have to copy, for example on checkout.

Sparse checkout code may help. If those large files are not always
needed, they can be marked skip-checkout based on
core.bigFileThreshold and won't be checked out until explictly
requested. This use may conflict with sparse checkout because it sets
skip-checkout bits automatically from $GIT_DIR/info/sparsecheckout
though.
-- 
Duy
