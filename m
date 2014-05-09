From: David Turner <dturner@twopensource.com>
Subject: Re: Watchman support for git
Date: Fri, 09 May 2014 11:47:53 -0700
Organization: Twitter
Message-ID: <1399661273.11843.133.camel@stross>
References: <1399072451-15561-1-git-send-email-dturner@twopensource.com>
	   <536428224adfb_200c12912f010@nysa.notmuch>
	  <1399083897.5310.0.camel@stross>
	   <5364654088dc4_4d2010fb2ec7d@nysa.notmuch> <536BD864.5090804@gmail.com>
	   <alpine.DEB.2.02.1405090002000.17457@nftneq.ynat.uz>
	 <1399655858.11843.119.camel@stross>
	  <alpine.DEB.2.02.1405091103200.5876@nftneq.ynat.uz>
	 <1399659442.11843.125.camel@stross>
	 <alpine.DEB.2.02.1405091124150.5876@nftneq.ynat.uz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: David Lang <david@lang.hm>
X-From: git-owner@vger.kernel.org Fri May 09 20:48:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wippx-0006LZ-AE
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 20:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756860AbaEISr5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 14:47:57 -0400
Received: from mail-qc0-f176.google.com ([209.85.216.176]:33180 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbaEISr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 14:47:57 -0400
Received: by mail-qc0-f176.google.com with SMTP id r5so5031372qcx.21
        for <git@vger.kernel.org>; Fri, 09 May 2014 11:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:content-transfer-encoding
         :mime-version;
        bh=X4YQ1IQOMNwUiihkuT2nK2xTW24AXP/DLCOetv/6pI0=;
        b=HYHNGRjft0/2mdRM8LOp5tWgcZd6mBv8kawjlnSuKcKKiHHZhANggnKHYNQ9HyKE4Z
         WrEEJ4tzoICWZK6U9L0cKOkMubJ356gHu+EPlmwqaqzHHU5p51zF+gMFql3+SMPj2chY
         cwSrp+zWO74l7/t0ciMHvk1bvbnspRFMTjT00IXCMtAp5x0gD/wugtryK/saSIWP6NB7
         mCrQ6rWmwwXt7A481SPQbbFQJb2ePZftj5zuFRta2i8vU2e8lMtoJs3b0Ue5IRJ2Zl8e
         Q7RuL8utl+5CeCeQ2UfYwdwAIG6f6h6uEt0xX8jn3HHWxyTrlOF+M2jViJqpM91/c42T
         jigg==
X-Gm-Message-State: ALoCoQmMX0mZ7w9cKoD/GMQ+LHLcdMpHpDG0k+LPAZ9bEzNd01aQqR7vt0J9vZ/tgWDCIu3ZNEdF
X-Received: by 10.224.72.12 with SMTP id k12mr17403541qaj.81.1399661276527;
        Fri, 09 May 2014 11:47:56 -0700 (PDT)
Received: from [172.25.144.67] ([8.25.197.27])
        by mx.google.com with ESMTPSA id h68sm1845317qgf.34.2014.05.09.11.47.54
        for <multiple recipients>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 09 May 2014 11:47:55 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1405091124150.5876@nftneq.ynat.uz>
X-Mailer: Evolution 3.2.3-0ubuntu6 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248611>

On Fri, 2014-05-09 at 11:27 -0700, David Lang wrote:
> >
> > That's not my understanding from Durham Goode's talk in January.  Yes,
> > operations involving history go to the server.  But the client also
> > maintains a copy of the working tree, and it is for this that watchman
> > is used.  Otherwise, why bother with watchman at all?  The server knows
> > when it changes files and could simply maintain its own index of what's
> > changed.  Watchman is built on inotify/fsevents -- it doesn't have
> > anything to do with any sort of storage device beyond a vanilla hard
> > drive.
> 
> When you have such a massive repo, your clients aren't storing the data on their 
> local drives, they are accessing the data on a network attached storage (via NFS 
> or through a fuse mount). So they can have their watchman send queries to the 
> storage server to find out what has changed in this massive repo rather than 
> having to walk the directory tree (or try to monitor it for changes on the 
> client machine)

Yes, you could do that.  But I repeat: that is not what Facebook is
actually doing.  If it were, they would have no need for inotify or
FSEvents, since neither even works with NFS (and a FUSE-based solution
would need special support at which point it might as well just
implement watchman itself). 

Please see this section of Durham Goode's talk for evidence that
Facebook is not doing that:
http://www.youtube.com/watch?v=Dlguc63cRXg&t=10m40s

(it's at 10:40 in case that link doesn't work)

Maybe things have changed since at Facebook since Durham gave that talk
in January and you have knowledge of that. If so, say so.  But from what
Facebook has said publicly, this is simply not what's going on.
