From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: status of libgit.a
Date: Sun, 7 Mar 2010 16:26:10 +0300
Message-ID: <20100307132610.GE31105@dpotapov.dyndns.org>
References: <499B3F65.8010109@synapse.com>
 <20090218091617.7805.qmail@2684cdd72f0ee9.315fe32.mid.smarden.org>
 <499C40EA.6050108@synapse.com>
 <20090219092446.23272.qmail@3b5a9fa637f270.315fe32.mid.smarden.org>
 <1267957655.3759.29.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Marc Oscar Singer <elf@synapse.com>,
	407722@bugs.debian.org
To: Paul Menzel <pm.debian@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 14:26:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoGV1-0007qp-Ti
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 14:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753137Ab0CGN0P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 08:26:15 -0500
Received: from mail-fx0-f219.google.com ([209.85.220.219]:59690 "EHLO
	mail-fx0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab0CGN0O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 08:26:14 -0500
Received: by fxm19 with SMTP id 19so5546693fxm.21
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 05:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=C2U+2J7E5EYV1Up8gcMBRo5Hvzvuf6E1GUVIslPzlZA=;
        b=dQk4Kk62e1Axdrn4u6Aw+9yaLZ2dhBr22b6BsX62VK9ZIBidF2vYvrkPFlkAoYbkxc
         EzvLWidiW2GmzaBUdu7QBnczdxgtFbM+8Ms8usu8/omnA/+y8J2v+BWlurLUiUVR9XIl
         c0mMXPAu8HnAfym/saYfACOi56K4kSMSwqQNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Nwk4tgOBbH5ZYDFq/tIRyySZ6/fMbAelvV1A7fY6TsJTvrH6TMEpNS9tKWLR8PyIci
         MQm2xXdtI4c27q4TfMl27aU23tHac5xEAHxiPb++5nkjQnQant5bw7++ADYznRabJLlD
         ey/MPaokQQwEaQdEEiG6W/0D4XgmFAlyqJCXE=
Received: by 10.87.39.4 with SMTP id r4mr379924fgj.26.1267968372888;
        Sun, 07 Mar 2010 05:26:12 -0800 (PST)
Received: from localhost (ppp91-77-225-63.pppoe.mtu-net.ru [91.77.225.63])
        by mx.google.com with ESMTPS id e3sm2990033fga.28.2010.03.07.05.26.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Mar 2010 05:26:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1267957655.3759.29.camel@mattotaupa>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141714>

On Sun, Mar 07, 2010 at 11:27:35AM +0100, Paul Menzel wrote:
> 
> could you please give an update on the status of libgit.a. For example
> cgit still could not be packaged yet for Debian [1] because of this bug
> [2].
> 
> cgit is used by a lot of projects out there, so I am wondering if the
> current libgit.a can be released in its current state.
> 
> By the way, is there a web site/page for libgit.a?

libgit.a has never been meant to use outside of Git. It was created just
to assist with the building process, and there is no clear defined API.
So, using libgit.a outside of Git is no different than copying source
files and using them in another project.

AFAIK, there is no plan to create a stable API for the existing libgit.a
Another project (libgit2) started some time ago to create a Git library
with a stable API, but it does not share much code with Git, and so far
it provides only basic functionality and has very few contributors, who
are also busy with other projects. So, in no way it can be considered as
a replacement of existing libgit.a.

On the other hand, libgit.a includes plumbing functions, which may be
considered as stable API. So, if cgit uses only those functions just to
avoid fork(), it makes sense; but it should be done carefully, because
libgit.a can call exit() on error. It may be not a problem for cgit, but
it is just another reason why libgit.a cannot be considered as a general
purpose library that provides Git functionality...


Dmitry
