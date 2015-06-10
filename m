From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] bisect: add the terms old/new
Date: Wed, 10 Jun 2015 08:24:48 -0700
Message-ID: <xmqqwpzbmvr3.fsf@gitster.dls.corp.google.com>
References: <1839018688.331427.1433920317370.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	<vpq7frcast5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	remi lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	louis--alexandre stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	remi galan-alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	guillaume pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:25:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hsK-0005me-TY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933724AbbFJPY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:24:58 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37666 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933382AbbFJPYv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:24:51 -0400
Received: by igbsb11 with SMTP id sb11so36003226igb.0
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=8HcisCTfyhtEbiRBaS3eltJ1nPPo8nBgHaKmlP/kNvY=;
        b=vQmqNTRtQHhTtI1950fsFXmyxEizmDd3zKu03GX4fk9OT+TB6N8B4mK8CswWgOiJUn
         JHy87wjySyLlV/6MPAoKtf4v7xcQF9/KzfxXihCxSiHes2DnlNMwTgNqcZ3EBvZl4I6x
         jzwWmmN2CTtakg+OnxQZjE2uyZb0zn6Yid6XwfSezmdVtGS1ti1w1LKp7JcoWiEUirqK
         Q9soUAeFZVAwVqKywRqNX4orhEJOZH2/+vJi0Q+Nvvi9UV6Nc3Kgzo/6KIa8TkGOuY8U
         QWx5Msb8d+jKwF73nNLHXM00qv0beOCstSbmVD7YchcmW4XZo/tnjW/4gDCbJgbfIwze
         7X+Q==
X-Received: by 10.43.148.72 with SMTP id kf8mr5659497icc.76.1433949890667;
        Wed, 10 Jun 2015 08:24:50 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id c63sm6200324ioe.42.2015.06.10.08.24.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 08:24:49 -0700 (PDT)
In-Reply-To: <vpq7frcast5.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	10 Jun 2015 10:09:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271304>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> "Somebody else did it like that" is not a good justification. Especially
> when the previous code was not merged: the code wasn't finished.
>
> But I actually disagree with the fact that it was not the idea. The
> point of having the terms in BISECT_TERMS was precisely to be generic
> enough. Had the goal been just to distinguish good/bad and old/new, we
> would have needed only one bit of information, and encoding it with the
> existance/non-existance of a file would have been sufficient (as you
> tried to do in addition to BISECT_TERMS).
>
>> For now we just rebased, corrected and finishing to implement
>> functionalities.
>
> functionalities is one thing, but the code should be maintainable to be
> merged in git.git. Git would not be where it is if Junio was merging
> patches based on "it works, we'll see if the code is good enough later"
> kinds of judgments ;-).
>
> Moving from "one hardcoded pair of terms" to "two hardcoded pairs of
> terms" is a nice feature, but hardly a step in the right direction wrt
> maintainability.

Nicely put.  From that point of view, the variable names and the
underlying machinery in general should call these two "new" vs
"old".  I.e. name_new=bad name_old=good would be the default, not
name_bad=bad name_good=good.
