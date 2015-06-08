From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 5/5] send-email: refactor address list process
Date: Mon, 08 Jun 2015 11:36:05 -0700
Message-ID: <xmqq8ubuavze.fsf@gitster.dls.corp.google.com>
References: <1433609976-1868-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433609976-1868-5-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqk2ve9tfm.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Jun 08 20:36:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z21uI-0004k0-Cq
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jun 2015 20:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753241AbbFHSgP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2015 14:36:15 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34341 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753098AbbFHSgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2015 14:36:07 -0400
Received: by igbhj9 with SMTP id hj9so66219619igb.1
        for <git@vger.kernel.org>; Mon, 08 Jun 2015 11:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AmRlmQqiiUiiaqhG6HIG5U72XVCtpEwfYwuUv3DJfbc=;
        b=Nv8bx+CEuZv3O0UxFl6Jyk5q+hk/JuCsRmZWsCtI/XSthdLlnKmO7/gBb3+SL1K+HF
         rurq4Qe0ZLdlaV6tRCmv+EUe+bRddSWfNcIokDhCZPo3vH7rvP0YfFJOnmq8JM5Xyfsa
         xezsjv4pSQW0n0s5l25tfTUuHpq+2YAfCRe19Xfo/C/gVTNjuSTP7X0/OCY/qrFliviJ
         Aj5QD4A5pMOAZZlwKyis0M/TUjiXkoPNkEuwgioWzsCEQ4TWg4tv0QArVDyjDtj7K8nh
         EiMTAzIbHhEBdO88g8BLJ/g/1OyaxCrCMWRvovq/3/hXyEQDhj09wMe8HAMxcKFs/wZl
         YPDw==
X-Received: by 10.43.8.4 with SMTP id oq4mr24300546icb.64.1433788566957;
        Mon, 08 Jun 2015 11:36:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:498e:2bf8:6933:5b2b])
        by mx.google.com with ESMTPSA id d8sm874762igl.19.2015.06.08.11.36.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Jun 2015 11:36:06 -0700 (PDT)
In-Reply-To: <vpqk2ve9tfm.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	08 Jun 2015 16:16:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271104>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:
>
>> Simplify code by creating a function to transform list of email lists
>> (comma separated, with aliases ...)  into a simple list of valid email
>> addresses.
>
> I would have found the series easier to read if this refactoring came
> earlier (and then PATCH 2/5 would fix the bug as a positive side effect
> of the refactoring).

I agree that doing 5/5 sooner would make 4/5 a lot clearer.  

Introducing the helper of 5/5 before 2/5 happens, and then replacing
two calls to validate-address-list with process-address-list would
hide the nature of the change, i.e. fixing a bug, so it is better to
see it done before the refactoring of 5/5, provided if it is indeed
a bug that these were not expanded.
