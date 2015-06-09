From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/13] Improve "refs" module encapsulation
Date: Tue, 09 Jun 2015 11:47:50 -0700
Message-ID: <xmqqa8w87m7d.fsf@gitster.dls.corp.google.com>
References: <cover.1433763494.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 09 21:02:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2Omp-0002wS-3K
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 21:02:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752335AbbFITCG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 15:02:06 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:32834 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbbFITCF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2015 15:02:05 -0400
Received: by igbpi8 with SMTP id pi8so19555555igb.0
        for <git@vger.kernel.org>; Tue, 09 Jun 2015 12:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:message-id:user-agent
         :mime-version:content-type;
        bh=IVljvjxjybpxNLlGMopUMqcsFkecFcjnCanw19NzA3c=;
        b=qq9hbsSJw1tFejgp/rUiUuAIziJzHHibY+TbWpyBRfA3xPhGh8uDVyrQCxSfuwxLzs
         eoT1gCTa2xkHvQQhbGQX/X6741qM3o8RXHYOQ/rAKeegTbsofQ4kWncn8AL/D0nPbjYv
         NaFH+jx9yGG1YoZTZWXokDcX+bL5rdczFtdpaSyU0mjpHDqxXS5EnGIoIJ2SyELAXRs8
         3QNHASdjA58FCqMk78MB2caTPcHN+YP+Kn+QNGfZS25jqiWK8Sd8BfkmLO5FPwhh1U+J
         njt8If9i0A3TVoRlf5FxSPo0ablpzAxl6qCSIq2DyBOrZSAW/mxXhPpssFImNGpBm7fG
         x0Bw==
X-Received: by 10.107.11.38 with SMTP id v38mr28700981ioi.83.1433875672507;
        Tue, 09 Jun 2015 11:47:52 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id qt1sm1679378igb.5.2015.06.09.11.47.51
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 09 Jun 2015 11:47:51 -0700 (PDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271231>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Add functions to the reference API to
>
> * Delete a bunch of references at once, but *without* failing the
>   whole transaction if one of the deletions fails. This functionality
>   is used by `git remote remove` and `git remote prune`.
>
> * Create initial references during `git clone`. (During clone,
>   references are written directly to the `packed-refs` file without
>   any locking.)
>
> Also move the remaining "refs" function declarations from `cache.h` to
> `refs.h`.
>
> This improves the encapsulation of the refs module. Especially, it
> means that code outside of the refs module should no longer need to
> care about the distinction between loose and packed references.

Yay.  The subject of the series matches this "primary value" of the
topic, even though the cover text makes it sound as if it was just a
"while we are at adding two functions" with "Also move..." ;-)
