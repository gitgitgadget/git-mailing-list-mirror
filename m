From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] WAS: [PATCH] mv: allow moving nested submodules
Date: Tue, 19 Apr 2016 09:56:07 -0700
Message-ID: <CAGZ79kYEjRSpet-5EQibJJ-57EkefQZm+zZr-d1K8Y9-=-fAmQ@mail.gmail.com>
References: <1461022884-30819-1-git-send-email-sbeller@google.com>
	<xmqqwpnu31qu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	=?UTF-8?Q?Albin_Otterh=C3=A4ll?= <gmane@otterhall.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 18:56:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asYwi-0004hM-3n
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 18:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933670AbcDSQ4J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2016 12:56:09 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:37516 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054AbcDSQ4I (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2016 12:56:08 -0400
Received: by mail-ig0-f180.google.com with SMTP id g8so22694901igr.0
        for <git@vger.kernel.org>; Tue, 19 Apr 2016 09:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=gjdJJDX5UXdCk247QlPHbJrj4dPFnJVyXmX1fsOwhtM=;
        b=hHBbxN4Qrd+Q4wNrqhmBovX94d2ic76TsXxocYL3ypQzC9Wfl0PIpMegDw1rohSvM/
         OdGTWg3aLWVkEthHzKGbdJvuqWt1Nl5fXpD+0C0rYQ4UrFy7tY6A1FeMwIukcRF/68KE
         jEQkRyqaqR6f9mWBSUwB8y8HtGZbLMd+7QhGRbnoqjdc5tSotBtv/8FqzWlEY0cCegpT
         M+ikCGZCdxRxiDxGF/Aoj0tQDG3TH+DSKaJ8TnE+gTTF4H648yaKeejf6STeXr+Egu8n
         k6baN49S0p4Bvqd44s/p8CiKbMKBqnz1qz1rXcLmYnufwJW3Dg8APxroiMWorYr75IQY
         qMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=gjdJJDX5UXdCk247QlPHbJrj4dPFnJVyXmX1fsOwhtM=;
        b=BdivsiEbBsVkevwhWArzHOY1Ef2yRgsmEeL4aMipM7zE0I88iAgP8oAndNwe0lGHWd
         xx5yH3sY208nokqonwXUmr59B1HAdKRiYu1UUMhDCVCPupZ1tvwicybpdDarFftzkCJJ
         x/mp/wa9bNLJeUJriQ9FeqEu7miPlsfFWIoEj+WFTSeP1l45v3kwCm66i80j493Lsf/p
         RRm+PaD+DbEy46D4bMXDQ2o2idLr81Dp31KphA4krrjttpuALRvB4s5WLxsNC7pbquFn
         y7atRddXhsO2vDVVmf3NyD9pEsbfTgnYyOw5pzqyqiOO00g2yb9Gcmv0nLa7BeBwtXCV
         lewg==
X-Gm-Message-State: AOPr4FXsi9Gfvr328aLGGIiq8HwMAQ5HT6xnwH86dCY8qQU48djIimMRrfQdLU43pqyFZ4iQ5c2o/RYSBTJk+Rlt
X-Received: by 10.50.72.107 with SMTP id c11mr5016618igv.85.1461084967483;
 Tue, 19 Apr 2016 09:56:07 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Tue, 19 Apr 2016 09:56:07 -0700 (PDT)
In-Reply-To: <xmqqwpnu31qu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291881>

On Mon, Apr 18, 2016 at 5:01 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> A single patch evolves into a series.
>
> Power of code inspection to see bugs that are not reported, perhaps
> ;-)?
>
> I wonder if we can come up with test cases to cover these potential
> issues that are addressed in [1/2]?

I think we can do a chmod a-w on the .git file and then updating that file
fails. (renaming is fine, but putting the new, possibly different link
to the git dir
in there fails.)

I do not quite know what we'd expect from a "git mv -k" on that.
It is documented as "skip move/rename errors", so maybe we need
to undo the rename to actually skip it once an error occurs?

That said I think I know how to write a test for that, but I am unsure
if patch 1 is a good idea.

Thanks,
Stefan


>
> Thanks.
>
