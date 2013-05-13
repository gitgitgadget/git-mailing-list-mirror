From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gitk: add support for -G'regex' pickaxe variant
Date: Mon, 13 May 2013 11:55:51 -0700
Message-ID: <20130513185551.GB3657@google.com>
References: <7vipezaaig.fsf@alter.siamese.dyndns.org>
 <1339698851-15428-1-git-send-email-zbyszek@in.waw.pl>
 <CACPiFCKev9uibTa8GSH94ZaH-NaVBAWVempg4xfTdFTThE85Zw@mail.gmail.com>
 <20130511055647.GA3262@iris.ozlabs.ibm.com>
 <20130511061322.GB3394@elie>
 <20130511094119.GA6196@iris.ozlabs.ibm.com>
 <CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	Martin Langhoff <martin@laptop.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 13 20:56:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubxun-0008D8-Ix
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab3EMSz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 14:55:58 -0400
Received: from mail-pb0-f49.google.com ([209.85.160.49]:61678 "EHLO
	mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab3EMSz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 14:55:56 -0400
Received: by mail-pb0-f49.google.com with SMTP id rp2so1953266pbb.8
        for <git@vger.kernel.org>; Mon, 13 May 2013 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=wAquy5KhQ9RUhkrYtZ6SHDzfBIdPBwDtrSD4CUhaP3o=;
        b=h9z6f5KZNmSG69Afmfp+2p6ZOhgYH2k2I1S2sJpOdJDUVzYWe0Bn7LpzbxR8nlDDY+
         mPvZ3KxscqthbsUaWMjY9GTv4mJcpWWFN7DofRvhDTCVKIJyW/mguj1hIBiZm6j1onpX
         cSaAYhMDmsS2wljHzEal0Ww5V2CQM5JLNIqEGuzmgVcPxMW1k/1CkD2I6WxuBAfg6wci
         17cSwMpIAE1NUoVHekvrDKIEerghBKzPvUxZD2kWuKDD5tXXM0mKt3gCLLay5SVBkjy2
         m+47K354Eh+qRDiUuZrj1qOlrs/UKJEs+8lmNhfQw1YhuhYIltWrPJWsatDdbCO32U8K
         FZPg==
X-Received: by 10.66.227.102 with SMTP id rz6mr7204684pac.72.1368471356111;
        Mon, 13 May 2013 11:55:56 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id to7sm16032816pab.0.2013.05.13.11.55.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 13 May 2013 11:55:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACPiFCKkzSCaSfqExZggFHBAmcPBTYYhyauOa2h1dXiYqKZMxA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224191>

Martin Langhoff wrote:

> And to be honest, log -G is so much more useful that I don't care a
> s***t for log -S.

Fair enough. :)

[...]
> In other words: You find a suspicious-looking line of code and you ask
> "how did this horrid code come to be?", and the more horrendous the
> code is, the more likely it is to be the accretion of a several
> commits. In that case, which to me is the common case, log -S ain't
> your friend at all.

My experience is the opposite.  I wonder "What did the author of this
nonsense comment mean?" or "What is the purpose of this strange
condition in this if () statement?".  Then "git log -S" finds the
culprit without showing extraneous unrelated changes (such as
reindenting).  It is like "git blame", but for arbitrary chunks of
code instead of single lines.  Then, just like with "git blame", at
times the next step is to blame the parent and repeat the process
using the earlier form of the code in question.

It is especially handy for confusing code that spans multiple lines.
(Unfortunately that is not as easy to try in gitk.)

As I mentioned before, log -G and log -S are fairly dissimilar
operations.

Thanks,
Jonathan
