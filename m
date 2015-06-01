From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] solving a bug with hunks starting at line 1 in git apply
Date: Mon, 01 Jun 2015 11:53:50 -0700
Message-ID: <xmqqeglv5kg1.fsf@gitster.dls.corp.google.com>
References: <87k2vnqrv8.fsf@ensimag.grenoble-inp.fr>
	<xmqqiob773iy.fsf@gitster.dls.corp.google.com>
	<vpqa8wj48c1.fsf@anie.imag.fr>
	<xmqqpp5f5l7v.fsf@gitster.dls.corp.google.com>
	<vpqiob7z2n7.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi LESPINET <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 01 20:53:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzUqT-0005Ob-Vc
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 20:53:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750812AbbFASxy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 14:53:54 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34045 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbFASxw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 14:53:52 -0400
Received: by igbhj9 with SMTP id hj9so68828078igb.1
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=04YZ9ckvPr+PO5EZpmrsAE47ZVJqH2uxTiGQlBp9XUo=;
        b=xFXF1skJQAwTv5Ba4KJrVtwCJ558YSGrcb9Y7B60VRfX5MvNIbjDMR4RnFGuQmzO5t
         2h7PT9dwJ7SaenCFawqZA7tFe22juiY9OCUTh1YfdLsmJfOImQj7Tu0YC6qhfz6Bnt57
         wFIf6GKI4Jut/IfmUpYYdjFCeOXFddPJj4LuKhMq8q2BJIDLmfFYB3ilcwwszfWuhvWe
         3vOKETF2o4x+wjX/mnR4Oq4if28yvW/3RiJZPPMnOCjKcdwH/xe0AXoAcgBkJ90yzdgZ
         vcNqOeHT8xTY4maQp0CqXAkIYnItp/ZB4mD4g5LT89UfkJBYI/0Nc9DnW1rnSyc/c2bi
         Eecw==
X-Received: by 10.107.8.144 with SMTP id h16mr29022938ioi.49.1433184832308;
        Mon, 01 Jun 2015 11:53:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:f9ca:66ee:8cb4:7220])
        by mx.google.com with ESMTPSA id v14sm8386828igd.12.2015.06.01.11.53.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 11:53:51 -0700 (PDT)
In-Reply-To: <vpqiob7z2n7.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	01 Jun 2015 20:47:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270459>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>> I am not sure what you are trying to do with that patch that tries
>> to touch the same line twice.  Is this the same old laziness coming
>> back to bite us, the one that we attempted to work around with
>> 933e44d3 ("add -p": work-around an old laziness that does not
>> coalesce hunks, 2011-04-06)?
>
> Indeed, "git apply" works with --allow-overlap in this case. But this is
> not sufficient to fix "git add -p" which already uses it. So, there's
> something else.

I do not have time to go back to the list archive myself at this
moment, but I suspect that in the discussion around the time back
when 0beee4c6 (git-add--interactive: remove hunk coalescing,
2008-07-02) was done, we'd find some material for me to say "I told
you so" X-< to those who added that laziness to "add--interactive".
