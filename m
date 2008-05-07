From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Sort of a feature proposal
Date: Wed, 7 May 2008 12:03:58 -0400
Message-ID: <32541b130805070903l195d84bn2ec22e97c81c42df@mail.gmail.com>
References: <86fxsutbke.fsf@lola.quinscape.zz>
	 <alpine.LFD.1.10.0805071139010.23581@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "David Kastrup" <dak@gnu.org>, git@vger.kernel.org
To: "Nicolas Pitre" <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed May 07 18:05:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jtm8U-0005rL-0Z
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 18:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757970AbYEGQED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 12:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757153AbYEGQEC
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 12:04:02 -0400
Received: from fk-out-0910.google.com ([209.85.128.191]:26165 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757238AbYEGQEA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 12:04:00 -0400
Received: by fk-out-0910.google.com with SMTP id 18so375620fkq.5
        for <git@vger.kernel.org>; Wed, 07 May 2008 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=yBvdPxcvjqGiTF5umRqTW2PvWoJ2r9VyV8LcHPsOTgo=;
        b=qc0rXUmv0mHTcPvrmKmg7Sbqz0Db0aZZ+GwJF407hOazt9ycagdBHdrZpwohiycM3MZFGK9T0dAzHfUFvJo5+Ink4ixIHjImQNbpeaUcDkKWNnLCdsi8838yG/pJ0VVnFURVovdkFn3SKLYcncsQUkDrtJ42ObAJ7ueNRnl+dIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=SWtWhkipod9qV7oTpo33Dnsgal8WfJCN0Fm81GZIIjcTmPNa9xB3l4AM2k5zwKqNuCnfMMmtec7mwwKAzrdWNkL1yatIgGMKiLIiTkkXiUg7bkhAXySTUqqJRWKaAI8Hk66pKjRBVMlcEy0Z6vFhyFu2r3DktqrRX79+HUnsaHo=
Received: by 10.82.151.14 with SMTP id y14mr241359bud.83.1210176238176;
        Wed, 07 May 2008 09:03:58 -0700 (PDT)
Received: by 10.82.166.12 with HTTP; Wed, 7 May 2008 09:03:58 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805071139010.23581@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81455>

On 5/7/08, Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 7 May 2008, David Kastrup wrote:
>  > Hi, I have some large git repositories on a USB drive (ext3 file
>  > system).  That means that when replugging the drive, the recorded st_dev
>  > data in the index is off, meaning that the whole repo directory
>  > structure gets reread as the stat data of all directories has changed.
>  >
>  > That's a nuisance.  Can't we have some heuristic or configuration option
>  > where we, say, record the st_dev of the _index_ file, and if that has
>  > changed, we propagate that change to the st_dev of its contents?  I'd
>  > like to see something that works more efficiently than rescanning the
>  > whole disk every time I hibernate my computer.
>
> Maybe simply ignoring st_dev is the solution?  I hardly can see what
>  value it had to the other stat fields.

If I understand correctly, you can be sure a file hasn't changed if it
has exactly the same (dev,inode,ctime,length) attributes.  If you
don't track the dev, you can't be certain whether file attributes look
identical but it was actually on another disk, and therefore might
have different content after all.

It's obviously a pretty rare case, but nobody likes a version control
system that works properly "almost" all the time :)

Have fun,

Avery
