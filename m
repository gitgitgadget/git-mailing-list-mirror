From: Stefan Beller <sbeller@google.com>
Subject: Re: Selectively clone Git submodules -- a useful feature?
Date: Wed, 16 Mar 2016 13:47:00 -0700
Message-ID: <CAGZ79kbu0JHbk8_CeY+2hDATMJ_QkYBhMbyh78jqKyf+h+vpdA@mail.gmail.com>
References: <162A5ADF-1FDD-432B-B5F8-672DF5B50EEC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 21:47:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agILU-00023P-0A
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 21:47:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755709AbcCPUrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 16:47:04 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35830 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810AbcCPUrB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Mar 2016 16:47:01 -0400
Received: by mail-io0-f175.google.com with SMTP id g203so74510262iof.2
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 13:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=+rooOmLrfg7Gk3R2DSs/AJUgD8LivvEi1egbXYVwikg=;
        b=o8Ra6pj/cSLVHAbsGhtSuAPEMniS9Z+DKaX78RNiM0fZvKuH0p8Z32LvCaRLHBU6KW
         v09uSFfaPqatdJe85yHgUt0jG3zAw8Mi1LdSOv369/SWgyvfVTfXc4Pzgp2oGAZEuQVm
         WIRkR8CxIs8EP3B5Wv4+0q1Y+Fu5ygsVvAegeDPlqcebQrE/I5ow1tix2Y5cy1vm/eHK
         w1J5yeh4ZAK64ITyOGvtIvtUEMWF6ak0Dk4VjBLbV9JxlxEG3tX34JpBN+I/MOc/tqyu
         6bfedcPjZEz2A/BR8k7+l58jSDNq88or/gWD2JCJCd91SJsYkEc7eKHjtoyfNQKqlFKU
         ZD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=+rooOmLrfg7Gk3R2DSs/AJUgD8LivvEi1egbXYVwikg=;
        b=Trx3c/HxAwf7orf/mFY7YpUVOjaYyq98mBOlLk4/Loo9TYsUvYmxqyds7/P5NxeC/S
         2HZnUb83tcSRB74d7FUpO17SE28EhutpL7eei/wwMFC0D3P5Ga0LqCCfKkzwSId4iNJ1
         +DkVzlSIV/RCgRWn5QXjn6t6xVK4fH4Y0UUgjd3mteXlpbiQfuvAmp7p6pmfWz2M9aPd
         XJ58MetFurwK1kqHMFhcij1nsHglOV99Pym4mXWXFyHz8s+s7X+V8wwOQy3IBIMaK4OS
         KWth5lfBTDswqliTg/F/o6hXPT5381FQMih2NDarKk7WJbsJUY5b+m++NRbPPVePGwv3
         A1cA==
X-Gm-Message-State: AD7BkJKHHuO8ey8BG+vRNOG+B/shIjHhDU/e9IPRYebNcr1mkmp76/BVZtbG0sj8gP6W76dgxdu5Z8CrfHsX63CL
X-Received: by 10.107.167.80 with SMTP id q77mr6808968ioe.110.1458161220330;
 Wed, 16 Mar 2016 13:47:00 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 16 Mar 2016 13:47:00 -0700 (PDT)
In-Reply-To: <162A5ADF-1FDD-432B-B5F8-672DF5B50EEC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289031>

On Thu, Jun 18, 2015 at 1:55 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:
> Hi,

Hi,

sorry for a real late answer to this,

>
> AFAIK Git has two ways to clone a repository with respect to submodules:
>
> (1) Plain clone of just the repository itself:
> git clone git://github.com/foo/bar.git
>
> (2) Recursive clone of the repository including all its submodules:
> git clone --recursive git://github.com/foo/bar.git
>
> I am working on a big cross platform project and on certain platforms I don't need certain submodules. AFAIK there is no way to selectively clone only a subset of the submodules with the standard command line interface. I wonder if something like an exclude pattern for submodules would be of general interest. I imagine a call like this after a plain "clone" operation:
>
> git submodule update --init --recursive --exclude 3rdParty/Windows/*
>
> or even:
>
> git clone --recursive --exclude 3rdParty/Windows/* git://github.com/foo/bar.git
>
> Please let me know what you think.

I am looking forward for exactly that feature, I even proposed exactly this
(in form of RFC patches, see
http://thread.gmane.org/gmane.comp.version-control.git/281670)

I plan on reviving this soon. Did you solve this problem as Jens proposed
or are you still looking for a solution?

Thanks,
Stefan

>
>
> Thanks,
> Lars
>
>
> PS: I posted this question already on the Google Git group here:
> https://groups.google.com/forum/?fromgroups=#!topic/git-users/jyKsd45d2MA
>
> I am sorry, but I discovered this mailing list afterwards and I am not sure which one is the appropriate one. Please advise.
>
>
> ---
> https://larsxschneider.github.io/--
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
