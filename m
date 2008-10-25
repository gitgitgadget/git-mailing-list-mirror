From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFC] Zit: the git-based single file content tracker
Date: Sat, 25 Oct 2008 12:30:40 +0200
Message-ID: <cb7bb73a0810250330w39811a29g7b497ec70a3b9085@mail.gmail.com>
References: <gdok16$vh2$1@ger.gmane.org> <200810242230.49238.jnareb@gmail.com>
	 <cb7bb73a0810250048q7ad8595bt565de05ec2ec37cb@mail.gmail.com>
	 <200810251110.25704.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Lang" <david@lang.hm>, "Junio C Hamano" <gitster@pobox.com>,
	"Jean-Luc Herren" <jlh@gmx.ch>, git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 12:32:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtgRC-0004wX-FN
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 12:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbYJYKam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Oct 2008 06:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbYJYKam
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Oct 2008 06:30:42 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:54568 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbYJYKal (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Oct 2008 06:30:41 -0400
Received: by gxk9 with SMTP id 9so661859gxk.13
        for <git@vger.kernel.org>; Sat, 25 Oct 2008 03:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xKypv9h7xzfRjhFBO1XiwbeNdbw15AJbcsS7c2P4nFE=;
        b=cl0BfH/RAE6X6eq+bXb52f+Lg/VLfrq6yG9DYC4iNBNW1siQNdiObSHl3v/vVDSbla
         Sbg65+5iIxpegcS4KzYhVuMYH4EPjnKJwD2Y5nkmkGdU2v0wtqLETYSMo+zMXOd0H6jW
         QpArOBNrEB93dzCRHNvQ69zqBKppE+qOeWd6U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=qTkbTUdszLA5Y5YuR895W701/xjhKopJ2RgW4ppD2ZQ4sPFBI2i63r7OmVPvKiO64R
         44ecl530AUT9pgKYgiV9o1ZtenKJMn9k+VRaDirBOpS8HT0AV9M2JtO8CGJWgVX0KqKf
         tygOF9PSvENCPLP0FxfJpetI6sxCIEwn6t0dc=
Received: by 10.150.155.4 with SMTP id c4mr3485991ybe.106.1224930640557;
        Sat, 25 Oct 2008 03:30:40 -0700 (PDT)
Received: by 10.150.145.2 with HTTP; Sat, 25 Oct 2008 03:30:40 -0700 (PDT)
In-Reply-To: <200810251110.25704.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99102>

On Sat, Oct 25, 2008 at 11:10 AM, Jakub Narebski <jnareb@gmail.com> wrote:
> On Sat, 25 Oct 2008, Giuseppe Bilotta wrote:
>
>> The user .zitignore file is probably the best approach: we can create
>> it ourselves (usually), and even if Git doesn't expand the pathname
>> itself, we can just use an absolute path. I'll go that way.
>
> First, absolute path to ~/.zitignore is a bit fragile: what if layout
> of home directories for users change, for example because of increasing
> number of users some fan-out is required (/home/nick -> /home/2/nick)?
> Second, ~/.zitignore looks like something that user can change; if
> you install zit, it can install libexec/zitignore somewhere... or just
> use ./zit/excludes (with 'do not edit' comment perhaps...).

(Actually, I just found another interesting thing about the config, in
that it stores the path to the work tree. This is not a problem,
though, because zit_setup() sets GIT_WORK_TREE.)

As I said, I don't like depending on stuff that needs to be installed.
For example, what about user (non-system) installs? the libexec (or
whatever) solution would have the same problem as the ~/.zitignore
solution, with the moving $HOME.

I guess this leaves the .zit/ solution as the most robust one,
although it's not the most space-effective, especially if you have
many directories, each with a single tracked file. On the plus side,
going for the .zit/ solution and dropping support for .somefile.git/
means some significant code semplification.

-- 
Giuseppe "Oblomov" Bilotta
