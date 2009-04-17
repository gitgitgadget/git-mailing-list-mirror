From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Allow git-shell to be used as a ssh forced-command
Date: Sat, 18 Apr 2009 01:00:35 +0400
Message-ID: <37fcd2780904171400uf9d1f36g4d24e02aebf6ac3f@mail.gmail.com>
References: <1239916256-10878-1-git-send-email-mh@glandium.org>
	 <37fcd2780904170924t61168a49uf1800098cdb1d730@mail.gmail.com>
	 <20090417194919.GA7611@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Apr 17 23:02:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuvCR-0000Uc-LR
	for gcvg-git-2@gmane.org; Fri, 17 Apr 2009 23:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbZDQVAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 17:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752043AbZDQVAj
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 17:00:39 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:26033 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbZDQVAi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2009 17:00:38 -0400
Received: by fg-out-1718.google.com with SMTP id 16so165918fgg.17
        for <git@vger.kernel.org>; Fri, 17 Apr 2009 14:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qgc40vxt8GzDXOHhwbVBTN64Q0+EnuhiwJAIoTaZr14=;
        b=pZqMIhrgFi82ffet4SD05yE3sxJtSmttIFb1aq1wmrR4sOlyFkvTbkH52/JSLNXMwL
         DvYZISl6jDc75q+fT5zw44uPwQy2zx+VbZSs0gCWgRygYpZZyE6yoFKkBBRWtqaewWHb
         pQT38sgg3Sa0M3h6SptMYrH7UGMFmPLKj+9nU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ADa5IfCVbQB2spy2450qCkat2xJMYQlLAi6c2tVnVtaO1aSSJYV/i6lAS4gs/j3M5c
         c2JTqb/enkHuTtUvTqB62qJ0nX54E+JCMcmmQ1lMY6VGegAoQL1qctHbSEyAc/YU+c5/
         0TNc79/dxmYXIdwYAK18r70ZPc6VoIjLraSVY=
Received: by 10.86.82.6 with SMTP id f6mr2268709fgb.77.1240002036014; Fri, 17 
	Apr 2009 14:00:36 -0700 (PDT)
In-Reply-To: <20090417194919.GA7611@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116788>

On Fri, Apr 17, 2009 at 09:49:19PM +0200, Mike Hommey wrote:
> On Fri, Apr 17, 2009 at 08:24:35PM +0400, Dmitry Potapov wrote:
> > On Thu, Apr 16, 2009 at 11:10:56PM +0200, Mike Hommey wrote:
> > > When using a forced-command, OpenSSH sets the SSH_ORIGINAL_COMMAND
> > > variable to what would otherwise be passed to $SHELL -c. When this
> > > variable is set, we use it instead of the contents of argv.
> >_
> > It would be nice to provide some justification where it can be used.
> > IOW, why do you want to have the force command where essentially
> > you execute the original command as it were no force-command?
>_
> You're not executing any command, but only what git-shell allows.
> This allows git-shell to be set as a forced-command for a specific
> ssh key, for example.

Would it better to set git-shell as the login shell for this account?
IMHO, that provides better security than using a forced-command, and
that is how git-shell is intended to use. So, I am not sure what are
benefits of using a forced-command when it just executes the original
command using git-shell.

Besides, you made SSH_ORIGINAL_COMMAND to take precedent over explicitly
specified parameters given to git-shell. Maybe it should be the other
way around?

Dmitry
