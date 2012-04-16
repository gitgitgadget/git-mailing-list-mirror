From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 17:44:11 -0500
Message-ID: <20120416224411.GU12613@burratino>
References: <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
 <7vaa2by8nj.fsf@alter.siamese.dyndns.org>
 <20120416160729.GM5813@burratino>
 <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
 <20120416200941.GD12613@burratino>
 <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
 <7v7gxftn78.fsf@alter.siamese.dyndns.org>
 <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 00:44:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJuep-0005j7-DZ
	for gcvg-git-2@plane.gmane.org; Tue, 17 Apr 2012 00:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753429Ab2DPWoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 18:44:22 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:34959 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615Ab2DPWoV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 18:44:21 -0400
Received: by iagz16 with SMTP id z16so8046509iag.19
        for <git@vger.kernel.org>; Mon, 16 Apr 2012 15:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=XZ1YOQLVAgmWLXbyCmyWmxTQN3g8xmVV9nHB51NrZm4=;
        b=XBAWBvHW4j1AKotlztPN1zQP0BGg4eWaOk3Gt/c4P6vFY1VzcmcCi9WfDcc0aPl4tI
         waOXhQc3Rf8vxMVa8gK2ZBTDUadvnnkS2vvtBn/saY3kwueZVVsTZH/Phk4jnkK0fuRV
         ES7WDD6MkT03N84V76+6/k78xj534Bn/hwz4QU/dxH1s1AsMssQdooGWqliupWlvFWbx
         foTK0K0Fi9GVbn+I8vk30QwfAZ7+IwjrhZ0LoDjzpxMSGQLLi/SuqbL3Ga85i/1BlTBO
         pt8q05JWJvIQBQOcint8lEX8zqC0LIb35anZFQeCL7UCa6F2etQeelMaZJANI+mUcoeg
         eS7g==
Received: by 10.50.51.134 with SMTP id k6mr1399698igo.47.1334616260989;
        Mon, 16 Apr 2012 15:44:20 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id vq7sm28627152igb.16.2012.04.16.15.44.18
        (version=SSLv3 cipher=OTHER);
        Mon, 16 Apr 2012 15:44:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMP44s1TkE=rd8AxbBnR4a8FwY+H9MHxYOhcks9fsnuK1iL_oA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195719>

Felipe Contreras wrote:

> Even more, I just added a foobar() function in my profile, and I also
> added a foobar() function in /etc/bash_completion.d/git. I don't see
> my function replaced in any way, even after typing and completing
> 'git' commands. I don't know how that's possible, but that's why I
> don't like to take these types of claims as face value.

What version of the bash_completion library do you use?  Lazy-loading
was introduced in version 1.90.

If you put

	foobar() {
		echo hi
	}
	. /etc/bash_completion

then is your private foobar unclobbered?

To answer your demand before for a function in the public interface of
a completion script, not library, which respects or does not respect
the bash-completion convention: see the public _rpm_installed_packages
helper from the rpm completion script[1].

If you don't like the convention or think that I have misunderstood
it, I can understand that and would recommend that you suggest a
different one and get it adopted and documented by the bash_completion
project.

Jonathan

[1] http://lists.alioth.debian.org/pipermail/bash-completion-devel/2012-March/004359.html
