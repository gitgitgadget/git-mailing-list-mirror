From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] merge-file: let conflict markers match end-of-line
 style of the context
Date: Tue, 26 Jan 2016 09:22:38 -0800
Message-ID: <CAPc5daVc9nQ+V5itEKMHOzBiHzEoTw1-aoA+rr2n+X1w-1yCnw@mail.gmail.com>
References: <cover.1453632296.git.johannes.schindelin@gmx.de>
 <cover.1453709205.git.johannes.schindelin@gmx.de> <26c973eb3414a8634d515f3621c0ded77cf030ed.1453709205.git.johannes.schindelin@gmx.de>
 <xmqqr3h5fmf4.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1601260955320.2964@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Beat Bolli <dev+git@drbeat.li>, Jeff King <peff@peff.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 26 18:23:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO7Kb-00051W-My
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 18:23:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966969AbcAZRXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 12:23:01 -0500
Received: from mail-ig0-f193.google.com ([209.85.213.193]:33837 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966830AbcAZRW6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 12:22:58 -0500
Received: by mail-ig0-f193.google.com with SMTP id ik10so7882179igb.1
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 09:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ip9JHK5EdsFMlxi/AkgWu9lHy/Xjbj7/lkMMsIALOpY=;
        b=TY4o7CUUUSQHRDpo51aawZk9kfPCpWU41wKu3OVfruEzrmVsGevgOH+NS04aSzLHK8
         Z+fWeO2a3XtwnJ5tFliu9AqMQ7XnlABBvrPB/S68qguD5qrmXwDsgRk3hS3xxAZMiEkl
         p/3GnBrvaDl34uERzRiUoer2bx6ghLq7Thc41fdAXnfr/RtQu1Xr7CQcovOtYom1Qvb2
         9zWv285ZmGILiEJUAAoudGGpFebB07f0X9jdWd9T4sngiYlF3VgXXcwm0knh5cxwY/nd
         L8Eh5gGWRDPPANrVcIi6qfOnAyVvSfUB+yGQokFLlmIKX0+RhubOOVzmcckPVk9IOg3C
         hfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-type;
        bh=ip9JHK5EdsFMlxi/AkgWu9lHy/Xjbj7/lkMMsIALOpY=;
        b=iYJwX8g2Q+g/8Wf8McEV9yvMTx8TnxrGtUA/x7naOYKBZEnyenyAnRYJSYbZmFRDb2
         4b8WgFuvMHNZBqLcM8PyJR1zR7YW65Vo0YmfTqjxf4Rz3JCBR7g03cVJe+zaLvryBhzP
         ge975MQlgf/prG4HC25OUCLY0Jzs5OhhX8W3iWd8vBDNfoVTr+wchBeyEKSaKsCSyAzc
         OoIRL1x8HNOV2IALCmJw9p1F8ieLUHtn7Z13Hjv8HasA9xpzXBnQAoLaeZ7pJ4Lcxxf/
         WxLnFwGbCtUy4AFoUw/Muj/csab64rxljm2Y8sVwRvAafI9sm+/lA5yk0cxbH4MaKTWN
         IekA==
X-Gm-Message-State: AG10YORbxUX5ung11c/hXS2psKrl+VczEMcOVUcv9mG8bqD8dAJDEW/NMatycshDyhMeLAdo+KruUMoBaoetzg==
X-Received: by 10.50.178.178 with SMTP id cz18mr25081145igc.37.1453828977705;
 Tue, 26 Jan 2016 09:22:57 -0800 (PST)
Received: by 10.36.144.133 with HTTP; Tue, 26 Jan 2016 09:22:38 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1601260955320.2964@virtualbox>
X-Google-Sender-Auth: ZZSS5JlBH7PxIfKjiKBGT6nrYrM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284843>

On Tue, Jan 26, 2016 at 1:04 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Not sure. You might end up with a very long line (containing plenty of LF
> "characters") and the conflict marker *at the end* of said line, with a
> CR/LF after it. I would not call that particularly helpful.
>
> Seeing as we really cannot do anything in this case, I thought it would be
> a good idea to avoid trying (and failing) to be smart here.

Nicely and clearly explained; thanks, and I agree with your reasoning.
