From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/2] relative future date
Date: Thu, 16 Aug 2012 16:02:01 -0700
Message-ID: <1345158123-22189-1-git-send-email-gitster@pobox.com>
References: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
Cc: Tom Xue <tomxue0126@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:02:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T295X-000867-CX
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:02:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317Ab2HPXCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46135 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab2HPXCI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:02:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B31208A38;
	Thu, 16 Aug 2012 19:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=DnIZ
	iHUopERBUYZY+QFZHilByEs=; b=vJhhDRpPXrQ1k3PSvplfD3t4M1p5bbSJGssR
	8yU2v/Wk06G9PHKFvqtyquU+eFWIlcRa45RYUOF1tDBQ+LaIYpVyR7AexG88OjjC
	ApHH1vkRXQKTWsar7tx1oV2zbOrteFpFSnLnb0ZPMFKyl/UUcGdaFBPlyN0EjLx6
	rfunnsg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	HUV79xAAvBPcfmVxcni91Sg5QVI0fBDRdBiPNTS0j1mBhNWjTj/krDxkO4b+SHN6
	9EFp82tGzXE/LvFTMO4ElGMfOALdytEU12U4J2HNFgptFm2I8yzj9WMqp2jscbh5
	LChzhgQJbNBH1Vd2GRzTKKBxbzXVjT/rrgh+0i/XRUs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A03CE8A37;
	Thu, 16 Aug 2012 19:02:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 062C48A36; Thu, 16 Aug 2012
 19:02:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc3
In-Reply-To: <1341505087-13632-1-git-send-email-tomxue0126@gmail.com>
X-Pobox-Relay-ID: 65990C88-E7F6-11E1-BC43-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jundong Xue <tomxue0126@gmail.com> writes:

> tomxue@ubuntu:~/mycode/life$ git todo
> * d768da9 - (in the future: 3 hours later) Meeting with vendor
> * 5fcd556 - (in the future: 12 days later) Take my personal ho
> * 9dd280b - (in the future: 11 months later)
> * 4680099 - (in the future: 9 months later)
> * 59d5266 - (in the future: 8 months later)
> * b5308da - (in the future: 7 months later)
> ...

I was re-reading the backlog and after looking at it again, I do not
think what the patch tries to do is a bad thing per-se.  There are
changes I want to see _how_ it is done, though.

Especially, the duplication of the exact same logic in the future
and in the past was an unmaintainable mess.

Here is an attempt to clean it up.

Opinions?  If the list finds this is a worthwhile thing to do (I am
neutral), it needs help from i18n people to mark format messages up
properly again.

Thanks.

Junio C Hamano (2):
  date: refactor the relative date logic from presentation
  date: show relative dates in the future

 date.c          | 187 +++++++++++++++++++++++++++++++++++++++++++-------------
 t/t0006-date.sh |   2 +
 2 files changed, 146 insertions(+), 43 deletions(-)

-- 
1.7.12.rc3.69.gaf0166d
