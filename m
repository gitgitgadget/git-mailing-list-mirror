From: David Jeske <jeske@google.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 03:24:00 -0700
Message-ID: <e80d075a0806240324j79f872d3t1db9dfb87dc2d37c@mail.gmail.com>
References: <20080624081601.GA2692@sigill.intra.peff.net>
	 <willow-jeske-01l5PFjPFEDjCfzf-01l5kv6TFEDjCj8S@brm-avmta-1.central.sun.com>
	 <willow-jeske-01l5lTEoFEDjCVta@brm-avmta-1.central.sun.com>
	 <alpine.WNT.1.10.0806241343170.3824@theodor>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fedor Sergeev <Fedor.Sergeev@sun.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 12:25:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB5hy-0005og-9A
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 12:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752186AbYFXKYJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 06:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752136AbYFXKYI
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 06:24:08 -0400
Received: from smtp-out.google.com ([216.239.33.17]:14657 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbYFXKYH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 06:24:07 -0400
Received: from zps75.corp.google.com (zps75.corp.google.com [172.25.146.75])
	by smtp-out.google.com with ESMTP id m5OAO2SH011110
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 11:24:02 +0100
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1214303043; bh=bv0QAeDLUq5lOJkDx1/HV6dN6pY=;
	h=DomainKey-Signature:MIME-Version:In-Reply-To:References:Date:
	 Message-ID:Subject:From:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=UUtfMll3kIC768afovxn2f/2mw3FjNMKpg+BN
	r0Bgsug5ndAE76j8JnpYwcT49VcpEV+ryAWx1LYbCMwxTATNQ==
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:mime-version:in-reply-to:references:date:
	message-id:subject:from:to:cc:content-type:content-transfer-encoding;
	b=uoCOenwaLiN8ECOgZWJlP10tWastID6Si2gEerLrqhJObZ+ib3WbLnMeut/c1qQBV
	tFf9NrmKAMxGwKhLpMfPQ==
Received: from an-out-0708.google.com (andd30.prod.google.com [10.100.30.30])
	by zps75.corp.google.com with ESMTP id m5OAO1mY014121
	for <git@vger.kernel.org>; Tue, 24 Jun 2008 03:24:01 -0700
Received: by an-out-0708.google.com with SMTP id d30so707084and.94
        for <git@vger.kernel.org>; Tue, 24 Jun 2008 03:24:01 -0700 (PDT)
Received: by 10.100.110.16 with SMTP id i16mr15598194anc.40.1214303040931; 
	Tue, 24 Jun 2008 03:24:00 -0700 (PDT)
In-Reply-To: <alpine.WNT.1.10.0806241343170.3824@theodor>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86030>

On Tue, Jun 24, 2008 at 3:01 AM, Fedor Sergeev <Fedor.Sergeev@sun.com> wrote:
> It looks like you are severely restricting your own way of thinking about
> a source code management as a source code backup system only.
>
> While this might be a valid mindset for a gatekeeper on a public repository
> it way way restrictive for a developer that wants to have a system that
> helps him doing a job.

Odd. I've never been a gatekeeper. I'm just a developer who has burned
himself enough times that I want a tool (i.e. source control) to help
prevent me from ever destroying anything I create. I like that git is
doing nicer things with merge tracking than older systems, and that
it's easier for distributed teams to move changes around in more
interesting ways than "up to the server" and "down from the server".
However, I also want it to provide the guarantee that "if I don't
touch the files in .git, it'll never lose my commits", which sadly
isn't true by default. I'm glad I can easily change the GC policy, but
I question why this isn't the default.

In another discussion about this, one of my coworkers pointed out that
making the GC default "never" would be much safer for new users, and
new users don't really need to worry about collecting things until
their repositories get bigger anyhow.

I also think that it would be simpler to understand for everyone if
every operation which can cause a dangling graph node require the
exact same override method (i.e. -f is fine, the capitalization as in
-d -> -D is fine, some --force or --hard is fine, but currently the
system is using three different methods in three different places)
