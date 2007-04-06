From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH] rename_ref(): only print a warning when config-file update fails
Date: Sat, 7 Apr 2007 01:53:43 +0200
Message-ID: <8c5c35580704061653x7e5fd149ud31a8289a4508b54@mail.gmail.com>
References: <11758483861506-git-send-email-hjemli@gmail.com>
	 <7v1wixkzpz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Geert Bosch" <bosch@gnat.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Apr 07 02:52:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZyFc-0004IU-Vt
	for gcvg-git@gmane.org; Sat, 07 Apr 2007 01:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933460AbXDFXxp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Apr 2007 19:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933490AbXDFXxp
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Apr 2007 19:53:45 -0400
Received: from nz-out-0506.google.com ([64.233.162.236]:53358 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933460AbXDFXxo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Apr 2007 19:53:44 -0400
Received: by nz-out-0506.google.com with SMTP id s1so618491nze
        for <git@vger.kernel.org>; Fri, 06 Apr 2007 16:53:43 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g9xMhsIU/evSIofy01ViZbXOesVpbJdavoRZATC97jN05NYfc/z7rUhRnn3fjodpgZ3wOhF0Ky9cX7WPjIB5BAOPJU36diU/4gR/rwHyEH2InfcoWG8KtNammsy/RBH+50yGg4QKcPzrvlg0hxLwta3PB2n+VIlrCJvXhJXpYAo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=obmu1nuvA4kiTB3Ju46JYrfDeSazT+XC9IQpgz4Z48Z485vVazG35J0oXmAZxctcmLP0nRCBW2L+NPmaQYRYA7VocjKDlNphhTJQy06CK4FFfxHxwpa0Jlw19ECLbwWMVGLNMzFh07uqwKMO354T8Y/9sENGiE1lxnAkmX0PLgM=
Received: by 10.114.168.1 with SMTP id q1mr1385463wae.1175903623335;
        Fri, 06 Apr 2007 16:53:43 -0700 (PDT)
Received: by 10.114.234.1 with HTTP; Fri, 6 Apr 2007 16:53:43 -0700 (PDT)
In-Reply-To: <7v1wixkzpz.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43947>

On 4/6/07, Junio C Hamano <junkio@cox.net> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
> > If git_config_rename_section() fails, rename_ref() used to return 1, which
> > left HEAD pointing to an absent refs/heads file (since the actual renaming
> > had already occurred).
>
> I wonder if rolling back the rename that was asked is an
> option.  We would want to keep these low-level things atomic
> whenever possible.

I was wondering the same thing, i.e. "goto rollback" as an option for
"error()". But I ended up thinking that rename_ref() shouldn't bother
with the config file at all (thus my other patch).

-- 
larsh
