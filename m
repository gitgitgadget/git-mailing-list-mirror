From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 1/2] refs.c: write updates to packed refs when a
 transaction has more than one ref
Date: Mon, 9 Jun 2014 09:20:26 -0700
Message-ID: <CAL=YDWk+KsctVnLMFv6tWC-=Z6uAaTbYLnJJUyBaY+yxwmM7Mw@mail.gmail.com>
References: <1402010788-8236-1-git-send-email-sahlberg@google.com>
	<1402010788-8236-2-git-send-email-sahlberg@google.com>
	<CAPig+cTQocaZBHciFkP591A11w9qcKAvG5a2H+R=7QHVvxU4EQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:20:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu2JD-0000bg-SY
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 18:20:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933684AbaFIQU2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 12:20:28 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:43235 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933184AbaFIQU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 12:20:27 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so2849523vcb.9
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 09:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vD2sL2cmO8Fdcj7GSweWSinknwx23k+uaK6UqBoW76E=;
        b=pd0rx9T841bOPm7bVDGS04Ua4Sw9f8k1ABPmF1uTpPM4210fvMQinCbnfIxpSF+Mc3
         IZJHfiFWjY/vE+NTABuK+wYhZH/zuu3Y3DXT2q3CEP5mmsJGOJe+iduw7+kJgy/nL9qw
         vQ+vXcn/5qUEGtmDeAw57uLWlcoEo0/JjiNHcetgVpCLYZJm2t1EWY2sCPzEuYi6LZVd
         IPpghJJ95UQvAxhGikarQFMAIfiQpNducRwacQMI1I6fIgskM97enGclTOeXtxK0qC1N
         R7A8A4dqJVJxfzanOUgl/hHNqZtgcDc6T1QmW/LXHg9ZIX8q/BdvIlIH3EgzVUffg4eN
         RS2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vD2sL2cmO8Fdcj7GSweWSinknwx23k+uaK6UqBoW76E=;
        b=Osv4ghgpbbTz3J30t2sTL0fnDyDdRrR/K+xeGxPRWTAjbHvBR0Btnrvna+TF8aItii
         Hl74e3ZSXGRpUX35jjLlaXAhris2rscONuzmz6MHvQFPW0+REnTSXgP+Y4GbB2zhskLK
         vgTyp8QjQXxhTVr9FLe4DWvNQgMGjayK/eHFKGxieDkXjvUt8HsRkymm0UN4/PhTpYTt
         +zxic6pBXP9VhhypNrJJtwK9Rj5BR7VUVa3+9wnyzshv3uhtIH3ueCdetIqonH1Lzk2p
         tX4mVfQ0/mB6Zh5M7traH6DFLjY35xva9M/k9ajuujzSRqc/Yc11lHq9Wi0EGN4NotNz
         ke0w==
X-Gm-Message-State: ALoCoQl/nbwNKMmKMNTpIBpOgtth851poi2F4bMODDYedUWLPiYRkuEeSOgNGYN+MTudZH1ZLmDO
X-Received: by 10.58.67.198 with SMTP id p6mr1508211vet.65.1402330826444; Mon,
 09 Jun 2014 09:20:26 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Mon, 9 Jun 2014 09:20:26 -0700 (PDT)
In-Reply-To: <CAPig+cTQocaZBHciFkP591A11w9qcKAvG5a2H+R=7QHVvxU4EQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251082>

thanks

On Sun, Jun 8, 2014 at 2:03 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Jun 5, 2014 at 7:26 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
>> When we are updating more than one single ref, i.e. not a commit, then
>> write the updated refs directly to the packed refs file instead of writing
>> them as loose refs.
>>
>> Change clone to use a transaction instead of using the pacekd refs api.
>
> s/pacekd/packed/
>
>> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
