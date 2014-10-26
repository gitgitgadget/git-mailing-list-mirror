From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH] fetch-pack: don't resend known-common refs in find_common
Date: Sun, 26 Oct 2014 16:42:42 +0100
Message-ID: <20141026154241.GB28288@spirit>
References: <1413884908.4175.49.camel@seahawk>
 <20141021144838.GA11589@seahawk>
 <xmqqd29l1f3p.fsf@gitster.dls.corp.google.com>
 <1413963706.11656.5.camel@seahawk>
 <CACsJy8B7nOZCjdF_hki5amv-uCY17hz59oPDvx-ufbRrdvTweQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 26 16:42:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XiPy4-0000Qa-Kk
	for gcvg-git-2@plane.gmane.org; Sun, 26 Oct 2014 16:42:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbaJZPmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Oct 2014 11:42:47 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35294 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751360AbaJZPmr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Oct 2014 11:42:47 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so937782wib.10
        for <git@vger.kernel.org>; Sun, 26 Oct 2014 08:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=P550hLKXTSckcgxUoe4vVtLdqDuHnYkOIZi6d3yqFJE=;
        b=eXx3VDyNmeKJ3U2VsddB5MU0/By5Br06S7ETn8FUSExSoKlkLy8s16gj6RAEKIUWR0
         Al52y0bI9T02v1zXhX5qW1DjmBHYeXj2mesq495U4q1cRvkxIGGqatoiEssCnoouxBDR
         37PBKX8Ndg1mm5tZsrOZhEmmICmVr5lTp2mxHf8bn1X4Vq/wNZZ9ttv4SnnjVNgW4Pmx
         Ki5Yd9Ib9oJi0Zyw2GVTTlhEtKtwk/vZFbjJ4oS/MELE3l+BMGccB1+6wUiyJxbXZLNK
         H9ePCSRI9RH6jWQjJnCecgCsOV2Gga52+FIyFXGBJg0IT2q+Z/FtDp38mSspwFiNmpqJ
         wf6Q==
X-Gm-Message-State: ALoCoQk+++Zl6TDYHIbb8rCTJyZEc7FvCB67FuSVeKlBz9xJ16VhNrTIT6JtUhCfiA94Lsatg8EZ
X-Received: by 10.194.82.104 with SMTP id h8mr17450065wjy.44.1414338165979;
        Sun, 26 Oct 2014 08:42:45 -0700 (PDT)
Received: from spirit (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id c5sm12380562wje.30.2014.10.26.08.42.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 26 Oct 2014 08:42:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8B7nOZCjdF_hki5amv-uCY17hz59oPDvx-ufbRrdvTweQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 22, 2014 at 05:07:31PM +0700, Duy Nguyen wrote:
> On Wed, Oct 22, 2014 at 2:41 PM, Dennis Kaarsemaker
> <dennis@kaarsemaker.net> wrote:
> > I see two options:
> >
> > * Turning that interaction into a more cooperative process, with a
> >   select/poll loop
> > * Make upload-pack buffer its entire response when run in stateless_rpc
> >   mode until it has consumed all of the request
> 
> Or add a helper daemon and support stateful smart http. Or maybe
> that's what you meant in the first option.

No, I meant that get-http-backend should have a select/poll loop that
can read from and write to git-upload-pack at the same time, but option
two was easier to implement :)

Stateful smart http seems to be against the design goals of smart http if I
interpret Documentation/technical/http-protocol.txt correctly though, so
that doesn't seem to be the right approach.
-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
