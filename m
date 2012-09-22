From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: How do I run tests under Valgrind?
Date: Sat, 22 Sep 2012 20:20:41 +0200
Message-ID: <505E0179.1070106@gmail.com>
References: <20120917173531.GB1179@sigill.intra.peff.net> <CALkWK0kDPGY_3v5SLPtyf+azUwA7msvQOvA+MaCgueZ71i2yGw@mail.gmail.com> <20120917174439.GD1179@sigill.intra.peff.net> <CALkWK0mkBbY7dUyaZAqqKE3ZMfE_xU6em_KCOKM9nsTjUP-9pA@mail.gmail.com> <20120917182957.GF1179@sigill.intra.peff.net> <CALkWK0=nMxNfmAaBTmXeADQubTayC_2_ut5Nq3QXba9yfQr9yA@mail.gmail.com> <CALkWK0kWvrirPjXXzBBBQxKDcwpd_+nQ2eeT6SE8gDFW5T7WFQ@mail.gmail.com> <505CCA55.6030609@gmail.com> <20120921204907.GA22977@sigill.intra.peff.net> <505DB73E.2020108@gmail.com> <20120922174741.GA6722@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 22 20:20:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFUK1-000502-4q
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 20:20:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab2IVSUs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 14:20:48 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44317 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751407Ab2IVSUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 14:20:47 -0400
Received: by bkcjk13 with SMTP id jk13so244184bkc.19
        for <git@vger.kernel.org>; Sat, 22 Sep 2012 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=xoMZQZFGgon2252CmKw0F0J/qKVfEpykijQ2WtjMzdU=;
        b=E3EVzalUS9eLoh6d3Ox7GXxeXTuM6OwgPCZWTeeLje6++oj9v1wMpY34pFUxsxxd8V
         o0gaDK8jL0pn7RBMjklSawz8i47J//rCsNZrPBm1Jfra9rxECWaZir/00drzpB2ZUqNY
         /YYuhkr7PQC9FMTqsZP37kqxuYeCAkB8Rs7zlFfSIeyP6PPQk0zYvcGBgGUjUpC7OTeb
         SPx/ghspYHHM26+dDu1pymQcJY1pfxLldy2FB5BHHk86vwSj4Fx7pXrvwmxbNkRDY2kY
         YvUxE2wSdVdV58gDABEVzHp3zCPNm8IN+5s5u6QfcocIR9W2MnJs+d9cHKpfTjR3paUu
         Py0Q==
Received: by 10.204.152.211 with SMTP id h19mr3460053bkw.45.1348338046198;
        Sat, 22 Sep 2012 11:20:46 -0700 (PDT)
Received: from [192.168.178.21] (host194-94-dynamic.2-87-r.retail.telecomitalia.it. [87.2.94.194])
        by mx.google.com with ESMTPS id m26sm2486479bkw.11.2012.09.22.11.20.44
        (version=SSLv3 cipher=OTHER);
        Sat, 22 Sep 2012 11:20:45 -0700 (PDT)
In-Reply-To: <20120922174741.GA6722@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206210>

On 09/22/2012 07:47 PM, Jeff King wrote:
> On Sat, Sep 22, 2012 at 03:03:58PM +0200, Stefano Lattarini wrote:
> 
>> On 09/21/2012 10:49 PM, Jeff King wrote:
>>>
>>> Oh. It sounds like setting $SHELL to zsh is really the problem, then. If
>>> it is not Bourne-compatible when called as "zsh", then it really should
>>> be called in a way that turns on compatibility mode (bash will do this
>>> when called as "sh", but you can also do it with "bash --posix").
>>>
>> AFAIK, if Zsh is called as "sh", it too will run in Bourne compatibility
>> mode; not sure how to force this compatibility from the command line though
>> (albeit I'd guess there is some way to do so).
>> [...]
> 
> Thanks for digging. I think this case, though, is that we were simply
> using the wrong variable ($SHELL instead of $SHELL_PATH). Your
> workarounds would help if somebody put zsh into $SHELL_PATH, but
> fundamentally that is not a sane thing to be doing, so I think we can
> just consider doing so user error and not bother working around it.
> 
FWIW, I agree.

Best regards,
  Stefano
