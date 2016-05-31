From: Stefan Beller <sbeller@google.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Tue, 31 May 2016 16:16:20 -0700
Message-ID: <CAGZ79kYoZfwWfigUZJM9ryTSNv-WE-0owxF=iUSHsc_nQ9rWVA@mail.gmail.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 01:16:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7ste-0005SL-W2
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 01:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbcEaXQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 May 2016 19:16:22 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:34136 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750730AbcEaXQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2016 19:16:22 -0400
Received: by mail-qg0-f50.google.com with SMTP id p34so30053321qgp.1
        for <git@vger.kernel.org>; Tue, 31 May 2016 16:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KJ0eUw6JQHpsF/IhJmazKWNdgaUrklYSukfdXlnXMSY=;
        b=HUheBpjebkOJ0gLz6ULYlCZSgWive90rsPKIFt5hviYo3QPThUzqhBEQJDzHG/8grG
         ef3gpdxaaXsKuHiOH6PcI90X/XU9Q4w+iANJk58tW/BPUXI47O+RRyejhjkNuVzNFGvf
         D82GPu5q6BaEOhH5Breuno6k3bay2URvqsYvgWnwR9XoCtmqeDT7Ril3sJJq3h3zki4Q
         r+iqgusIbwPTrSCvfL0iSp1foO54tQXt0ynTjCqfdVG8eiyL/GQn9Fdxg5qykE3ZzOUh
         mp9c0LYFWDdxpCBHGjHXLvnIrpzW2lBNw01LKxxdiKlOf7dRMUy1n4FZHVyZ6mr1VoXm
         yUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KJ0eUw6JQHpsF/IhJmazKWNdgaUrklYSukfdXlnXMSY=;
        b=JMClhmw9X7cDMMTTwnTZhBURPDzJ0O9DrPE6MRz7mlarigLSGiY0gDM898AGGD6+kf
         8m4IDawLsxxmyTDbsVJAti8rN5R3ghABSWqAMw5/wlDTKC5DoFNMfVtdpRJgacoB8ewP
         2TllvrGjNvAF1h1Fbq9QFRb3LevBOTRjssyhetmsXjdOqy2jNGsHo9WsL3yx1MpnKbKx
         AlLfF0O5WQ+/mDqkZmS6ayNwCibO8M1jb2UEprYQFEJv1rycIxhM/Wi/Q7IEp+SwV0Fx
         pdHfBUw5XP9ug3VnOXdeD3quARGPecQ726fd3Y7A3Rk8Rnwst0hbJp4tKeQ8moFIIg0N
         WDUg==
X-Gm-Message-State: ALyK8tJg09vFWJKgM2GapIQfAIEfvope38/YyQ7RmAUzkXLyrwNGppFcSw0XJmcvaOh/LrmVEyvOc43+HrNf9b+B
X-Received: by 10.140.23.180 with SMTP id 49mr33910511qgp.9.1464736581095;
 Tue, 31 May 2016 16:16:21 -0700 (PDT)
Received: by 10.200.55.212 with HTTP; Tue, 31 May 2016 16:16:20 -0700 (PDT)
In-Reply-To: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296035>

On Tue, May 31, 2016 at 4:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> relative_path ()
> {
>         local target curdir result
>         target=$1
>         curdir=${2-$wt_prefix}
>
> I am hoping that Stefan's "gradually rewrite things in C" will make
> it unnecessary to worry about this one.  "git submodule" would not
> work correctly on posixly correct shells in the meantime.

noted.

Maybe as a smaller step we can expose the relative_path from the
submodule--helper
instead of rewriting all actual users first.

Thanks for pointing out,
Stefan


>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
