From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GIT get corrupted on lustre
Date: Wed, 23 Jan 2013 09:23:16 -0800
Message-ID: <20130123172316.GA3238@elie.Belkin>
References: <CABPQNSbJr4dR9mq+kCwGe-RKb9PA7q=SKzbFW+=md_PLzZh=nQ@mail.gmail.com>
 <87a9s2o6ri.fsf@pctrast.inf.ethz.ch>
 <kdk2ss$498$1@ger.gmane.org>
 <87r4lejpx8.fsf@pctrast.inf.ethz.ch>
 <50FF051D.5090804@giref.ulaval.ca>
 <878v7keuh3.fsf@pctrast.inf.ethz.ch>
 <CABPQNSad1EKbmt3Gjs+uB9fud4YBqmk++5GMqF2s047Lcc8GwQ@mail.gmail.com>
 <87d2wvc3v0.fsf@pctrast.inf.ethz.ch>
 <CABPQNSb89h28O_a3uVoVrNisZqPcHHVFm8nP7GdFGCb=PVdcsQ@mail.gmail.com>
 <871udbc3af.fsf@pctrast.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kusmabite@gmail.com, Thomas Rast <trast@student.ethz.ch>,
	Eric Chamberland <Eric.Chamberland@giref.ulaval.ca>,
	"Brian J. Murrell" <brian@interlinx.bc.ca>, git@vger.kernel.org,
	"Pyeron, Jason J CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Maxime Boissonneault <maxime.boissonneault@calculquebec.ca>,
	Philippe Vaucher <philippe.vaucher@gmail.com>,
	=?utf-8?Q?S=C3=A9bastien?= Boisvert 
	<sebastien.boisvert@calculquebec.ca>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 23 18:24:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty43M-00030w-Il
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 18:24:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756658Ab3AWRXc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 12:23:32 -0500
Received: from mail-pb0-f45.google.com ([209.85.160.45]:63882 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755735Ab3AWRXa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 12:23:30 -0500
Received: by mail-pb0-f45.google.com with SMTP id mc8so4799693pbc.18
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 09:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Ny7wFh3BXPoRL5mn7fgz5BMN905OI8CG6te64RbK6to=;
        b=qfJwdHqedwm+GEkI+jO68WaWAdYkaUNQWIIULxTHnyC4HJE5VhPiLNtyIUQ8CeCYcU
         oWr6wGhgEIZsibMtubjmejBKZCmqSTz2ZvDgIqiZhaLeAsRyudJ3MgXDc0Zyd+b1jO2v
         vwxupSV3Wi8+VuSk4HVH7J2/TnQOLhtS2udQGZaoLVusZZ96zlj9B1r6LJ1aqH4HBwAq
         P9yOjGfEUwhRTITqNREuWuMDnyg5Y2wbTkaVCtNLIZtz96W1mNNiPs+9G3xev5Rfmqq6
         qY6i+8OmaP4ri0i35BimqEbzv2WM5DnfTnvs4vCUoLAAXnOqhSuYbXCQQh0fbMpRk+OV
         ITnQ==
X-Received: by 10.68.130.225 with SMTP id oh1mr5284335pbb.147.1358961809610;
        Wed, 23 Jan 2013 09:23:29 -0800 (PST)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPS id tq4sm13140102pbc.50.2013.01.23.09.23.26
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 09:23:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <871udbc3af.fsf@pctrast.inf.ethz.ch>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214338>

Thomas Rast wrote:

> Taken together this should mean that the bug is in fact simply that the
> calls do not *restart*.  They are (like you say) allowed to return EINTR
> despite not being specified to, *but* SA_RESTART should restart it.
>
> Now, does that make it a lustre bug or a glibc bug? :-)

The kernel takes care of SA_RESTART, if I remember correctly.  (See
arch/x86/kernel/signal.c::handle_signal() case -ERESTARTSYS.)
