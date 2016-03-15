From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: Re: [PATCH] submodule-config: use hashmap_iter_init()
Date: Wed, 16 Mar 2016 01:10:18 +0600
Message-ID: <CANCZXo7OBe_+udjGXQbe6YpZK8Ln113J=PZ59MnwQq7E8jwYLA@mail.gmail.com>
References: <1458066330-5107-1-git-send-email-kuleshovmail@gmail.com>
 <CAPig+cR6Cy2MHvoTxNa89gZx9qJZW1Rv93N+wcwK2JRGkUBzRw@mail.gmail.com> <CAGZ79kZH_xzfvo=cP_+BdsqpthwQUKkJjo7OawkpFN9y+jm_+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 20:10:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afuMf-0002G8-RC
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 20:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965752AbcCOTKl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 15:10:41 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35695 "EHLO
	mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965698AbcCOTKk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 15:10:40 -0400
Received: by mail-lf0-f42.google.com with SMTP id l202so2896255lfl.2
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cyL1gpvLBJ6wCudCdc1oww2tDIu0ncApTP5RuMiFIBs=;
        b=D0pR61cDG7RAyHp43hflRKb4rz0T4SJzfcr8bYx6ihpYU8mmyys9KpCKmq3WrBLDaB
         3KCZN3v1RtY6LiZbXiuNzLv1dKHhy/UksZIu1gnEJpNxV4LBLEaGcxsMb0tFkWcR2Knu
         rhE5AOZXyXdvQFMdTusd13VDlvn741MOI7dNrhbYNcIzwRJv0EgGmAGxCtmVmzQxUhcu
         r1K2JuqI+nktPc3JcRRkNjEOwTh0S5oBr7P97l2qvQzh+kRClbrEvyog6hdKgojSaudi
         xD5fDqcJAD1tBeINIva3sxgxMiYGRXzYd5xggYfyvM6GyRMYBn6xnGshfL9xLvYr06zE
         EpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cyL1gpvLBJ6wCudCdc1oww2tDIu0ncApTP5RuMiFIBs=;
        b=gkxrdykX+ErbaFWkfD87y9SydUUDoWndFu5CMZA7NxMKb1KH9kAfmdVMZZeSpnHvPA
         vxauOUkg01MWwYr7zewqLzagbyu1/nhMyEqCYPDrwhfaJhbPJpJxkstg+ZOyJqEJrrU9
         LwvZ8LnxaCAvPL478hFQdJG2PiGYhkcaAffkzs9EESHhksYitG7sUUyVSkYFbmIr3kgO
         XZjZ0n6LbL5s9KIIm3LeLgK42WPuCrE+hPsWT+X0LqTPzlTLJE/GMic6WobxbVgk29Lm
         CXAMeSlJCqd7CNOb+bOj7lL91cp7d4RCCiQzxmFgxDbs58prbooUNObA0vowsPYKYqSW
         TmbA==
X-Gm-Message-State: AD7BkJILGq/ndosyrAU5df60yRp13OlTWmAk2cq2qNqPEzq3G5/Nr9MOGZ59l7b3tpB/qOIKxO3eCmHmhIVqkg==
X-Received: by 10.25.161.205 with SMTP id k196mr8395526lfe.61.1458069038296;
 Tue, 15 Mar 2016 12:10:38 -0700 (PDT)
Received: by 10.112.77.65 with HTTP; Tue, 15 Mar 2016 12:10:18 -0700 (PDT)
In-Reply-To: <CAGZ79kZH_xzfvo=cP_+BdsqpthwQUKkJjo7OawkpFN9y+jm_+w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288893>

On Wed, Mar 16, 2016 at 1:08 AM, Stefan Beller <sbeller@google.com> wrote:
> The change looks correct to me. But as Eric said, the commit message
> needs work and a sign off. With that,
> Reviewed-by: Stefan Beller <sbeller@google.com>

Ah, yes, forgot to pass `-s` to commit command. Sorry for noise guys,
will resend
the patch.
