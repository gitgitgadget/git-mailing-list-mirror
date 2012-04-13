From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCHv2] fetch: Only call a new ref a "branch" if it's under
 refs/heads/.
Date: Fri, 13 Apr 2012 16:53:16 -0500
Message-ID: <20120413215316.GA19826@burratino>
References: <1334336904-18649-1-git-send-email-marcnarc@xiplink.com>
 <20120413211350.GD7919@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: marcnarc@xiplink.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 23:53:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIoQs-0003Qq-F7
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 23:53:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340Ab2DMVxZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 17:53:25 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:41102 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217Ab2DMVxZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 17:53:25 -0400
Received: by iagz16 with SMTP id z16so4791887iag.19
        for <git@vger.kernel.org>; Fri, 13 Apr 2012 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=rRwRTlqD9AR/MWiQ8kJMQuhK8rWBNdVBaQbTy76ipnY=;
        b=hCK3rSFZ0qDwlAHGOJD1J8vuf8U6H4bc5GT/JaeewhQQoOYcos5CZ3/xVYV+jKelF4
         Yg1knqCbnlNK1Tc2N1cBJU4uqlbXrS1JwH1qJW4R6lB2ywDkkFjEyTJlYnCZ01MknItd
         s4jPC4MRa8lag/k2zUORL1KujG1ROXbxt23Olurz3+0NDJerNMzLoRUqev3wsx2Yj6nr
         4+PfdabeKrL37m/PGk3JUjSL3Bxjfis4NEogj2kscai7plC+NsFwZHoG9VTu5d4gqT0J
         3f67r6+x6kj7sJkPUzZqmYjZ8SXRbHlsdeA5RnPcbQMtp1PWsxBsB2WpLJ7auf5xAUP3
         YYTw==
Received: by 10.50.203.99 with SMTP id kp3mr2871686igc.16.1334354004502;
        Fri, 13 Apr 2012 14:53:24 -0700 (PDT)
Received: from burratino (adsl-99-24-202-99.dsl.chcgil.sbcglobal.net. [99.24.202.99])
        by mx.google.com with ESMTPS id vq7sm9734467igb.16.2012.04.13.14.53.23
        (version=SSLv3 cipher=OTHER);
        Fri, 13 Apr 2012 14:53:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120413211350.GD7919@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195448>

Jeff King wrote:

> Hmm. The ref->name we are comparing here is the local side. So if I am
> fetching a new branch "foo" from the remote into a local
> "refs/remotes/origin/foo" tracking ref, it used to say:
>
>     From ../parent
>      * [new branch]      master     -> origin/master
>
> Now it says:
>
>     From ../parent
>      * [new ref]         master     -> origin/master
>
> while refs/remotes/* are not technically branches in our side, I think
> from the user's perspective, it is true that we have fetched a branch.
> Should we be calling refs/remotes/* branches, too? Should we be checking
> the remote's name for the item instead of the local one?

The former sounds sensible.  Then once the default refspec learns to
fetch into separate refs/remotes/origin/heads/* and
refs/remotes/origin/notes/* namespaces the logic could be updated to
write [new branch] or [new note collection] according to the
situation.

Jonathan
