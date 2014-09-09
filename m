From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] fsck: exit with non-zero status upon error from
 fsck_obj()
Date: Tue, 9 Sep 2014 15:29:36 -0700
Message-ID: <20140909222936.GA701@google.com>
References: <1409177412.15185.3.camel@leckie>
 <20140829185325.GC29456@peff.net>
 <xmqqha0v5cgn.fsf@gitster.dls.corp.google.com>
 <1409343480.19256.2.camel@leckie>
 <20140829203145.GA510@peff.net>
 <xmqq4mwgjvt6.fsf_-_@gitster.dls.corp.google.com>
 <xmqqvbowigeh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>,
	Thomas Rast <tr@thomasrast.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 10 00:29:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRTv1-0002CS-2k
	for gcvg-git-2@plane.gmane.org; Wed, 10 Sep 2014 00:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099AbaIIW3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 18:29:43 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:49164 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980AbaIIW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 18:29:42 -0400
Received: by mail-pd0-f171.google.com with SMTP id p10so6887442pdj.16
        for <git@vger.kernel.org>; Tue, 09 Sep 2014 15:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=SqeLOg81G6fPeWbrQVY6GtHIR97w14LvH7oPFckUcoc=;
        b=IlE/G84Yb/19/RJoz6scVOPphPS5oM2R9J5tZt15X7kIZKsol5glwjUGoJkn16PsZA
         pZQAEtFrXa7HX9JcaZhwUBPCq/HrTBHL+qOanoVa/yH4eOo9twa86GbbPb2azMezn4Jk
         0fgqNsQtaoCDnDgHlUbAAkA/6pEVpKe+7G1D6IF5Gww7Ibt9d8SR8cGbwvFZoxzeashK
         uRKCVw4SPBuSakMwHwtavVjZQlo8BWayQGH0CTNkqoNE0SPX+Wob7cBaLHxE7ZfcS3oV
         i098aSlVLR8l9NjQ66RglWO0YSbG32K4EyvEsHzSBvhN2ZL3+X6rIoiR4SGGnDVs0kfo
         l6ug==
X-Received: by 10.70.96.233 with SMTP id dv9mr20068275pdb.146.1410301782249;
        Tue, 09 Sep 2014 15:29:42 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id kp6sm12523568pbc.67.2014.09.09.15.29.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Sep 2014 15:29:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqvbowigeh.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256718>

Junio C Hamano wrote:

> By the way, Jonathan, with dbedf8bf (t1450 (fsck): remove dangling
> objects, 2010-09-06) you added a 'test_might_fail git fsck' to the
> 1450 test that catches an object corruption.  Do you remember if
> there was some flakiness in this test that necessitated it, or is it
> merely "I think this should fail, but it does not, and we may fix it
> some day but I am not doing that in this patch?"

Thomas is the person to ask. :)  See v1.6.3-rc0~176^2~3 (Test fsck a
bit harder, 2009-02-19):

> +	(git fsck 2>out; true) &&

which that cleanup tightened to test_might_fail.

But yes, I'm pretty sure it was for futureproofing, not for hiding
flakiness.  I think your patch does the right thing in changing it to
test_must_fail now that fsck exits nonzero.

Thanks,
Jonathan
